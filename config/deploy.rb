require 'torquebox-capistrano-support'
require 'bundler/capistrano'
# SCM
# Update this part to match your server and location of your application code.
set :ssh_options, {:forward_agent => true}
server       "ec2-user@ec2-54-205-184-71.compute-1.amazonaws.com", :web, :app, :primary => true
set :repository,  "https://github.com/tomdepplito/pickemup_api.git"
set :branch,            "master"
set :user,              "torquebox"
set :scm,               :git
set :scm_verbose,       true
set :use_sudo,          true
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:keys] = ["/Users/tomdepplito/Desktop/pickemup-api-east-key-pair.pem"]

set :deploy_to,         "/opt/apps/pickemup-api"
set :torquebox_home,    "/opt/torquebox/current"
set :jboss_init_script, "/etc/init.d/jboss-as-standalone"
set :rails_env, 'production'
set :app_context,       "/"
set :app_ruby_version, '1.9'
set :application, "pickemup-api"

default_environment['JRUBY_OPTS'] = '--1.9'
default_environment['PATH'] = '/opt/torquebox/current/jboss/bin:/opt/torquebox/current/jruby/bin:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/root/bin:/root/bin'

after 'deploy:update_code', 'deploy:assets:precompile'
after 'deploy:update', 'deploy:resymlink'
before 'deploy:finalize_update', 'deploy:assets:symlink'

namespace :deploy do
  desc "relink db directory"
   #if you use sqlite
   task :resymlink, :roles => :app do
     run "mkdir -p #{shared_path}/db; rm -rf #{current_path}/db && ln -s #{shared_path}/db #{current_path}/db && chown -R torquebox:torquebox  #{current_path}/db"
   end


   # This is a weird part. I've found that asset complation with JRuby can really hog up the memory, which can cause the application to crash
   # when doing a deploy. So, I like to compile the assets locally and SCP them to the server instead.
   # Just make sure you've commented out the load deploy/assets in your Capfile.
  namespace :assets do
    # If you want to force the compilation of assets, just set the ENV['COMPILE_ASSETS']
     task :precompile, :roles => :web do
       force_compile = ENV['COMPILE_ASSETS']
       begin # on first deploys, there is no current_revision so an error gets raised. in this case we want to just compile assets and upload them.
         from = source.next_revision(current_revision)
       rescue
         force_compile = true
       end
       if ( force_compile) or (capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0 )
         run_locally("rake assets:clean && rake assets:precompile")
         run_locally "cd public && tar -jcf assets.tar.bz2 assets"
         top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
         run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
         run_locally "rm public/assets.tar.bz2"
         run_locally("rake assets:clean")
       else
        logger.info "Skipping asset precompilation because there were no asset changes"
       end
     end

     task :symlink, roles: :web do
       run ("rm -rf #{latest_release}/public/assets &&
             mkdir -p #{latest_release}/public &&
             mkdir -p #{shared_path}/assets &&
             ln -s #{shared_path}/assets #{latest_release}/public/assets")
     end
  end
end
