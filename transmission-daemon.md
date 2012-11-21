Torrent 클라이언트로 Transmission 을 써 오던 Ubuntu가 모니터가 잡히지 않아서, 부득이하게 headless 로 쓰이게 되었다. 이에 Transmission-gtk 를 써 오다가, Transmission-daemon 버젼을 써야 하는 상황이 왔다.

# [Ubutu에서 설치](https://trac.transmissionbt.com/wiki/UnixServer/Debian)

```sh
$ sudo apt-get install transmission-daemon
```

설치 후에는 `debian-transmission` 계정이 생기고, 해당 계정으로 실행이 되다.

```sh
$ sudo service transmission-daemon start # 시작
$ sudo service transmission-daemon stop # 종료
```

# [셋업](https://trac.transmissionbt.com/wiki/EditConfigFiles)

`/etc/transmission-daemon/settings.json` 파일을 수정하면 된다. 수정에 관해서는 [링크](https://trac.transmissionbt.com/wiki/EditConfigFiles) 참조.

# 웹으로 접속

`/etc/init.d/transmission-daemon` 파일을 아래와 같이 설정

```json
"rpc-authentication-required": true,
"rpc-bind-address": "0.0.0.0",
"rpc-enabled": true,
"rpc-password": "{1c94e5b124d1ff038ed0bc73fcca1c5d2185ce3czc8LqK0Q",
"rpc-port": 9091,
"rpc-url": "/transmission/",
"rpc-username": "transmission",
"rpc-whitelist": "127.0.0.1,192.168.0.*",
"rpc-whitelist-enabled": true,
```

그리고, 웹브라우저에서 해당 주소로 연결해서 사용가능!