# 문제 : perl을 실행하면, locale error 가 발생한다.

```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
LANGUAGE = (unset),
LC_ALL = (unset),
LC_CTYPE = "UTF-8",
LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
```

# 해결책

http://stackoverflow.com/questions/2499794/how-to-fix-a-locale-setting-warning-from-perl

먼저 접속하는 client 의 세팅이 문제 
client 쪽 .bash_profile 에 아래 추가

```
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```
혹은 접속하는 서버쪽에 /etc/environment 파일을 수정

```
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
```
