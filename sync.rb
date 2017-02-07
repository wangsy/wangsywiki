require 'rubygems'
require 'sshkit'
require 'sshkit/dsl'

on %w{ubuntu@wiki.wangsy.com}, in: :sequence, wait: 5 do
  within "/home/ubuntu/wangsywiki" do
    execute "git", "pull"
    execute "git", "push"
  end
end
