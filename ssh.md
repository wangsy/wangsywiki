# regenerate id_dsa.pub from id_dsa

```sh
$ ssh-keygen -t dsa -y > id_dsa.pub
```

# ssh 파일 복사

ssh 에서 폴더를 옮길때, scp -r 보다는, tar로 묶어서, zip 으로 압축한 것을 pipe 로 보내서, 다시 그쪽에서 풀어주는 것이 효율이 좋다고 한다.

```sh
$ tar zcf - from_dir | ssh user@host "cd to_dir; tar zxf -"
```