# [ssh](https://help.ubuntu.com/12.10/serverguide/openssh-server.html)

## SSH Key

### Generate

```
$ ssh-keygen -t dsa
```

### 리모트 서버에 pub 파일 올리기

```
$ ssh-copy-id username@remotehost
```

위 명령은
```
$ scp ~/.ssh/id.pub username@remotehost:.ssh/authorized_keys
```
를 수행해 준다.

