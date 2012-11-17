분명히 램이 넉넉한 서버에서는 이런일이 발생하지 않았는데, 램이 부족한 서버에서는 

```
2012/11/16 16:59:53 [error] 10689#0: *25307 upstream timed out (110: Connection timed out) while reading response header from upstream, client: 211.106.111.108, server: o.mintech.kr, request: "GET / HTTP/1.1", upstream: "http://unix:/home/wangsy/www/mintoffice/current/tmp/sockets/unicorn.sock:/", host: "o.mintech.kr"
```

에러가 마구 발생. 그리고, 서비스가 안됨.

인터넷을 뒤져서 방법을 찾았으나, 확실히 무엇이 해결책인지는 모르겠지만, 일단은

`/etc/sysctl.conf` 파일에 아래 내용을 추가
```
net.core.rmem_max = 16777216
net.core.rmem_default = 16777216
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 4096
```

`/etc/nginx/nginx.conf` 파일에 아래 내용을 추가
```
user www-data;
worker_processes 4;
worker_rlimit_nofile 10240;
pid /var/run/nginx.pid;
```

아마도 위 `worker_rlimit_nofile` 값이 가장 유력한 원인으로 추정됨.