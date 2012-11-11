# apt-get

Advanced Pakckage Tool

## Install

```
$ sudo apt-get install nmap
```

## Removing

```
$ sudo apt-get remove nmap apache
$ sudo apt-get remove --purge nmap # also remove config file
```

# Update

`/etc/apt/sources.list` `/etc/apt/sources.list.d`에 등록된 리모트 리포지토리 에 있는 패키지를을 로컬에서 보관하고 있는데, 이 DB 를 업데이트 해 준다.

```
$ sudo apt-get update
```

# Upgrade

현재 설치된 패키지의 업데이트 버젼이 존재하면, 새롭게 업그레이드 해 준다.

```
$sudo apt-get upgrade
```