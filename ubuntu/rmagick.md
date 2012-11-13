# Ubuntu 12.10에 RMagick 설치하기

이미 이전에 설치 된 것이 있었다면,
```sh
$ gem uninstall rmagick
```
그리고 설치
```sh
$ sudo apt-get install graphicsmagick-libmagick-dev-compat
$ sudo apt-get install libmagickwand-dev
$ gem install rmagick
```