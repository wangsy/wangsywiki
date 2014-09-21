자세한 내용은

https://github.com/sstephenson/rbenv

# 설치

### Mac + HomeBrew

    $ brew update
    $ brew install rbenv ruby-build

    $ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

    $ type rbenv
    #=> "rbenv is a function"

### Ubuntu

    $ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    $ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    $ type rbenv
    #=> "rbenv is a function"

    $ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Update

### Mac

    $ brew update
    $ brew upgrade rbenv ruby-build

### Ubuntu

    $ cd ~/.rbenv
    $ git pull

# Install Ruby

    $ rbenv install -l
    $ rbenv install 2.0.0-p247
    $ rbenv uninstall

# Set Version
    $ rbenv local 1.9.3-p327
    $ rbenv global 1.8.7-p352
    $ rbenv shell jruby-1.7.1
    $ rbenv versions
    $ rbenv version
    $ rbenv rehash
    $ rbenv which irb
    $ rbenv whence rackup

# Fix

### Ubuntu에서 2.1.0 설치되지 않는 문제

https://github.com/sstephenson/ruby-build/issues/526

    $ curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch 2.1.1