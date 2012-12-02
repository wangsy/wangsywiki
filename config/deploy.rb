set :application, "wangsywiki"
set :repository,  "git@g.mintech.kr:wangsywiki.git"

role :web, "woz"                          # Your HTTP server, Apache/etc
set :ssh_options, { :forward_agent => true }

#namespace :wiki do
	task :sync do
		run "cd /home/wangsy/www/wangsywiki/; git pull 2>&1"
		run "cd /home/wangsy/www/wangsywiki/; git push 2>&1"
	end
#end