```
connection failed for: ServerName (ArgumentError: Could not parse PKey: no start line)
```

위 에러가 발생할 경우, net-ssh 를 2.6.x 에서 2.5.2 로 내려라 (현재 net-ssh 2.6.0, 2.6.1 동작에 문제 있음)
