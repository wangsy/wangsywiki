# [Automatic Updates](https://help.ubuntu.com/12.10/serverguide/automatic-updates.html)

```
$ sudo apt-get install unattended-upgrades
```

edit `/etc/apt/apt.conf.d/50unattended-upgrades`

```
Unattended-Upgrade::Allowed-Origins {
        "Ubuntu quantal-security";
//      "Ubuntu quantal-updates";
};
```
edit `/etc/apt/apt.conf.d/10periodic`

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

- 매일 패키지 DB 업데이트
- 매일 업그레이드 가능한 패키지 다운로드
- 일주일후, 패키지 클린
- 매일 자동 업그레이드

자세한 사항은 ` /etc/cron.daily/apt` 헤더 부분을 읽어보시오.

## Notification

`/etc/apt/apt.conf.d/50unattended-upgrades` 파일에 `Unattended-Upgrade::Mail` 부분을 설정해 줘도 메일 받을 수 있음.

또다른 옵션으로

```
$ sudo apt-get install apticron
```

그리고 `/etc/apticron/apticron.conf` 설정

```
EMAIL="root@example.com"
```

