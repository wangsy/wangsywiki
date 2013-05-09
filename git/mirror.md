git repository mirror 시키기
=============================

`hook/post-receive` 파일을 만든다. 내용은 아래와 같이 채운다.

<pre>
git push --mirror server:/path/to/repositories.git
</pre>

여기서 어려운 문제가 자동화를 시키기 위해서는 접속할 서버의 인증 문제가 있다.이를 해결하기 위해서 [ssh host alias](ssh#ssh-host-alias)에서 host alias 기법을 쓰면 된다.

이를 이용해서, 해당 서버에 접속하기 위한 비밀번호 없는 인증서 파일을 만들어서, host alias 를 통해서 연결해 주면 된다.