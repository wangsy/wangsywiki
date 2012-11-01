https://help.ubuntu.com/community/PostfixCompleteVirtualMailSystemHowto

Setting Virtual Mail

# Postfix 설치
```
sudo apt-get install postfix
```

Postfix Configuration 에서 "Internet Site" 선택

# MySQL map support for Postfix

```
sudo apt-get install postfix-mysql
sudo apt-get install mysql-client
sudo apt-get install mysql-server
```

```
sudo apt-get install courier-authdaemon

sudo apt-get install courier-authlib-mysql

sudo apt-get install courier-pop

sudo apt-get install courier-pop-ssl

sudo apt-get install courier-imap

sudo apt-get install courier-imap-ssl

```

# SMTP 인증

```
sudo apt-get install postfix-tls

sudo apt-get install libsasl2

sudo apt-get install libsasl2-modules

sudo apt-get install libsasl2-modules-sql

sudo apt-get install openssl

```