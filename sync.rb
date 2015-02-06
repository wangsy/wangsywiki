require 'rubygems'
require 'sshkit'
require 'sshkit/dsl'

on %w{wangsy@wangsy.com}, in: :sequence, wait: 5 do
  within "/home/wangsy/www/wangsywiki" do
    execute "git", "pull"
    execute "git", "push"
  end
end
