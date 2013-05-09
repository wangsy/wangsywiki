# regenerate id_dsa.pub from id_dsa

<pre>
$ ssh-keygen -t dsa -y > id_dsa.pub
</pre>

# private key 를 가지고, public key 다시 만들기

<pre>
$ ssh-keygen -e
</pre>

# ssh 파일 복사

ssh 에서 폴더를 옮길때, scp -r 보다는, tar로 묶어서, zip 으로 압축한 것을 pipe 로 보내서, 다시 그쪽에서 풀어주는 것이 효율이 좋다고 한다.

<pre>
$ tar zcf - from_dir | ssh user@host "cd to_dir; tar zxf -"
</pre>

# ssh host alias

`.ssh/config` 파일을 아래와 같이 만들어 주면, host alias 기능을 사용할 수 있다.

<pre>
host servername
  user username
  hostname server.example.com
  port 22
  IdentityFile /path/to/id_rsa
</pre>

위 파일이 만들어 진 상태에서

<pre>
$ ssh servername
</pre>

으로 하면, 위 정보를 이용해서, 계정, 주소, 포트, 인증서 파일까지 사용하게 된다.