# encoding: utf-8
#
# Tasks:
#
#   - vlad:custom_permissions:fix # run after update

namespace :vlad do
  namespace :custom_permissions do

    # Should be of the form { path => perm_spec }
    # perm_spec should follow chmod syntax
    # permissions are applied recursively on directories
    # if path does not exists, the directory will be created
    set :custom_permissions, {}

    desc 'Fix permissions'
    remote_task :fix, :roles => :app do
      ops = custom_permissions.map do | path, perm_spec |

        [
         %(if [ ! -e "#{path}" ] ; then mkdir -p "#{path}" ; fi),
         %(if [ -d "#{path}" ] ; then chmod -R "#{perm_spec}" "#{path}" ; else chmod "#{perm_spec}" "#{path}" ; fi)
        ]
      end

      run ops.flatten.join(' && ') unless ops.empty?
    end
  end
end
