set :application, "wangsywiki"
set :repository,  "git@mintech.kr:wangsywiki.git"

role :web, "woz"                          # Your HTTP server, Apache/etc
set :ssh_options, { :forward_agent => true }

namespace :wiki do
	task :update do
		run "cd /home/wangsy/www/wangsywiki/; git pull"
	end
end