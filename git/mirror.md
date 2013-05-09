git repository mirror 시키기
=============================

`hook/post-receive` 파일을 만든다. 내용은 아래와 같이 채운다.

<pre>
git push --mirror server:/path/to/repositories.git
</pre>

여기서 계정 문제가 있다. `server` 라는 서버의 주소, 포트, 인증서 등이 명기 되어야 하는데, 이는 [ssh host alias](ssh#ssh-host-alias)에서 host alias 기법을 쓰면 된다.

이를 이용해서, 해당 서버에 접속하기 위한 비밀번호 없는 인증서 파일을 만들어서, host alias 를 통해서 연결해 주면 된다.