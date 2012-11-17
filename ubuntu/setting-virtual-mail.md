# [Setting Virtual Mail](https://help.ubuntu.com/community/PostfixCompleteVirtualMailSystemHowto)

[[_TOC_]]

## Postfix 설치
```sh
$ sudo apt-get install postfix
```

Postfix Configuration 에서 "Internet Site" 선택

## MySQL map support for Postfix

```sh
$ sudo apt-get install postfix-mysql
$ sudo apt-get install mysql-client
$ sudo apt-get install mysql-server
```

```sh
$ sudo apt-get install courier-authdaemon
$ sudo apt-get install courier-authlib-mysql
$ sudo apt-get install courier-pop
$ sudo apt-get install courier-pop-ssl
$ sudo apt-get install courier-imap
$ sudo apt-get install courier-imap-ssl
```

## SMTP 인증

```sh
$ sudo apt-get install postfix-tls
$ sudo apt-get install libsasl2-2
$ sudo apt-get install libsasl2-modules
$ sudo apt-get install libsasl2-modules-sql
$ sudo apt-get install openssl
```

## MySQL Setting

```sh
$ sudo mysqladmin -u root password rootpassword
```

postfixadmin-sql.sql

```sql
#------------------------------------Start copy-------------------------------------
#
# Postfix Admin
# by Mischa Peters <mischa at high5 dot net>
# Copyright (c) 2002 - 2005 High5!
# License Info: http://www.postfixadmin.com/?file=LICENSE.TXT
#

# This is the complete MySQL database structure for Postfix Admin.
# If you are installing from scratch you can use this file otherwise you
# need to use the TABLE_CHANGES.TXT or TABLE_BACKUP_MX.TXT that comes with Postfix Admin.
#
# There are 2 entries for a database user in the file.
# One you can use for Postfix and one for Postfix Admin.
#
# If you run this file twice (2x) you will get an error on the user creation in MySQL.
# To go around this you can either comment the lines below "USE MySQL" until "USE postfix".
# Or you can remove the users from the database and run it again.
#
# You can create the database from the shell with:
#
# mysql -u root [-p] < DATABASE_MYSQL.TXT

#
# Postfix / MySQL
#
CREATE DATABASE postfix;

GRANT SELECT ON postfix.* TO postfix@localhost IDENTIFIED BY 'postfixpassword';
GRANT SELECT, INSERT, DELETE, UPDATE ON postfix.* TO postfixadmin@localhost IDENTIFIED BY 'postfixadmin';

USE postfix;
#
# Table structure for table admin
#
CREATE TABLE admin (
  username varchar(255) NOT NULL default '',
  password varchar(255) NOT NULL default '',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (username),
  KEY username (username)
) COMMENT='Postfix Admin - Virtual Admins';

#
# Table structure for table alias
#
CREATE TABLE alias (
  address varchar(255) NOT NULL default '',
  goto text NOT NULL,
  domain varchar(255) NOT NULL default '',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (address),
  KEY address (address)
) COMMENT='Postfix Admin - Virtual Aliases';

#
# Table structure for table domain
#
CREATE TABLE domain (
  domain varchar(255) NOT NULL default '',
  description varchar(255) NOT NULL default '',
  aliases int(10) NOT NULL default '0',
  mailboxes int(10) NOT NULL default '0',
  maxquota int(10) NOT NULL default '0',
  transport varchar(255) default NULL,
  backupmx tinyint(1) NOT NULL default '0',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (domain),
  KEY domain (domain)
) COMMENT='Postfix Admin - Virtual Domains';

#
# Table structure for table domain_admins
#
CREATE TABLE domain_admins (
  username varchar(255) NOT NULL default '',
  domain varchar(255) NOT NULL default '',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  KEY username (username)
) COMMENT='Postfix Admin - Domain Admins';

#
# Table structure for table log
#
CREATE TABLE log (
  timestamp datetime NOT NULL default '0000-00-00 00:00:00',
  username varchar(255) NOT NULL default '',
  domain varchar(255) NOT NULL default '',
  action varchar(255) NOT NULL default '',
  data varchar(255) NOT NULL default '',
  KEY timestamp (timestamp)
) COMMENT='Postfix Admin - Log';

#
# Table structure for table mailbox
#
CREATE TABLE mailbox (
  username varchar(255) NOT NULL default '',
  password varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  maildir varchar(255) NOT NULL default '',
  quota int(10) NOT NULL default '0',
  domain varchar(255) NOT NULL default '',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (username),
  KEY username (username)
) COMMENT='Postfix Admin - Virtual Mailboxes';

#
# Table structure for table vacation
#
CREATE TABLE vacation (
  email varchar(255) NOT NULL default '',
  subject varchar(255) NOT NULL default '',
  body text NOT NULL,
  cache text NOT NULL,
  domain varchar(255) NOT NULL default '',
  created datetime NOT NULL default '0000-00-00 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (email),
  KEY email (email)
) COMMENT='Postfix Admin - Virtual Vacation';
#------------------------------------End copy-------------------------------------
```

```sh
$ mysql -u root -p < postfixadmin-mysql.sql
```

## Setting Postfix Map

/etc/postfix/mysql_virtual_alias_maps.cf

```
user = postfix
password = postfixpassword
hosts = 127.0.0.1
dbname = postfix
table = alias
select_field = goto
where_field = address
```

/etc/postfix/mysql_virtual_domains_maps.cf

```
user = postfix
password = postfixpassword
hosts = 127.0.0.1
dbname = postfix
table = domain
select_field = domain
where_field = domain
#additional_conditions = and backupmx = '0' and active = '1'
```

/etc/postfix/mysql_virtual_mailbox_maps.cf

```
user = postfix
password = postfixpassword
hosts = 127.0.0.1
dbname = postfix
table = mailbox
select_field = maildir
where_field = username
#additional_conditions = and active = '1'
```

/etc/postfix/mysql_virtual_mailbox_limit_maps.cf

```
user = postfix
password = postfixpassword
hosts = 127.0.0.1
dbname = postfix
table = mailbox
select_field = quota
where_field = username
#additional_conditions = and active = '1'
```

/etc/postfix/mysql_relay_domains_maps.cf

```
user = postfix
password = postfixpassword
hosts = 127.0.0.1
dbname = postfix
table = domain
select_field = domain
where_field = domain
additional_conditions = and backupmx = '1'
```

```sh
$ sudo chgrp postfix /etc/postfix/mysql_*.cf
$ sudo chmod 640 /etc/postfix/mysql_*.cf
```

## Create vmail user

```sh
$ sudo groupadd -g 5000 vmail
$ sudo useradd -m -g vmail -u 5000 -d /home/vmail -s /bin/bash vmail
```

## Configuring Postfix with MySQL maps

```sh
$ sudo editor /etc/postfix/main.cf
```

```
## Virtual Mailbox Domain Settings

virtual_alias_maps = mysql:/etc/postfix/mysql_virtual_alias_maps.cf
virtual_mailbox_domains = mysql:/etc/postfix/mysql_virtual_domains_maps.cf
virtual_mailbox_maps = mysql:/etc/postfix/mysql_virtual_mailbox_maps.cf
virtual_mailbox_limit = 51200000
virtual_minimum_uid = 5000
virtual_uid_maps = static:5000
virtual_gid_maps = static:5000
virtual_mailbox_base = /home/vmail
virtual_transport = virtual

## Additional for quota support

virtual_create_maildirsize = yes
virtual_mailbox_extended = yes
virtual_mailbox_limit_maps = mysql:/etc/postfix/mysql_virtual_mailbox_limit_maps.cf
virtual_mailbox_limit_override = yes
virtual_maildir_limit_message = Sorry, the your maildir has overdrawn your diskspace quota, please free up some of spaces of your mailbox try again.
virtual_overquota_bounce = yes
```

```sh
$ usermod -G sasl postfix
```

download postfixadmin's debian package: http://postfixadmin.sourceforge.net/

```sh
$ dpkg -i postfixadmin_*_all.deb  
```

## Courier-IMAP and Authentication Services

/etc/courier/authdaemonrc

```
authmodulelist="authmysql"
DEBUG_LOGIN=2
```

/etc/courier/authmysqlrc

```
MYSQL_SERVER 127.0.0.1
MYSQL_USERNAME postfix
MYSQL_PASSWORD thepassword
MYSQL_DATABASE postfix
MYSQL_USER_TABLE mailbox
MYSQL_LOGIN_FIELD username
MYSQL_NAME_FIELD name
MYSQL_CRYPT_PWFIELD password
#MYSQL_CLEAR_PWFIELD     password
MYSQL_MAILDIR_FIELD maildir
MYSQL_QUOTA_FIELD concat(quota,'S')
MYSQL_HOME_FIELD        '/home/vmail'
MYSQL_UID_FIELD '5000'
MYSQL_GID_FIELD '5000'
```

```sh
$ /etc/init.d/courier-authdaemon restart ; /etc/init.d/courier-imap restart; /etc/init.d/courier-pop restart
$ tail -f /var/log/mail*
```

If you are still having issues, try these troubleshooting tips: http://www.courier-mta.org/authlib/README.authdebug.html

## SMTP Authentication

/etc/postfix/main.cf add

```
smtpd_recipient_restrictions = reject_unauth_pipelining, permit_mynetworks, permit_sasl_authenticated, reject_non_fqdn_recipient, reject_unknown_recipient_domain reject_unauth_destination, check_policy_service inet:127.0.0.1:10023, permit
# modify the existing smtpd_sender_restrictions
smtpd_sender_restrictions = permit_sasl_authenticated, permit_mynetworks, reject_non_fqdn_sender, reject_unknown_sender_domain, reject_unauth_pipelining, permit
# then add these
smtpd_sasl_auth_enable = yes
broken_sasl_auth_clients = yes
smtpd_sasl_security_options = noanonymous
smtpd_sasl_local_domain =
```

/etc/postfix/sasl/smtpd.conf


```
pwcheck_method: auxprop
auxprop_plugin: sql
mech_list: plain login cram-md5 digest-md5
sql_engine: mysql
sql_hostnames: 127.0.0.1
sql_user: postfix
sql_passwd: yourpassword
sql_database: postfix
sql_select: select password from mailbox where username='%u@%r' and active = 1
```