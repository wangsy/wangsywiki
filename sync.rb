require 'rubygems'
require 'sshkit'
require 'sshkit/dsl'

on %w{scott-dev}, in: :sequence, wait: 5 do
  within "/home/rails/www/wangsywiki" do
    execute "git", "pull"
    execute "git", "push"
  end
end
