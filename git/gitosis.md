# gitosis

## 설치

설치는 리눅스의 경우 배포판마다 조금씩 차이가 있으니, 해당 배포판에 따라 설치한다.

## 관리자 입장

관리자 입장에서는 먼저, 설치를 마치고, 서버로 부터 gitosis-admin.git 리포지토리를 clone 해 준다.

```sh
$ git clone git@gitserver:gitosis-admin.git
```

`gitosis.conf` 파일을 편집해 준다. 그리고, 서버로 push 해 주면, 해당 내용이 반영된다.

### 새로운 프로젝트 추가

새로운 리포지토리가 추가되면, `gitosis.conf` 파일을 아래와 같이 추가해 준다.

```
[group committer]
members = member1 member2 member3
[group mobile_project]
readonly = second_project
members = member1 member2
[group web_project]
writable = third_project fourth_project fifth_project
readonly = sixth_project
members = @committer member4
```

그리고, 기존의 프로젝트를 올린다.

```sh
$ git remote add origin git@gitserver:repository.git
$ git push origin master
```

### 새로운 사용자 추가

첫째, 사용자로부터, public key 파일을 받아서, `keydir` 디렉토리에 복사해 준다. 이때, public 키 파일의 이름이 중요하다. public key 파일의 이름을 <사용자이름>.pub 형식으로 써 주고, 이때 사용한 <사용자이름>을 `gitosis.conf` 파일의 members 필드에 들어가는 이름과 반드시 일치해야 한다.

## 사용자 입장

먼저 ssh-keygen 을 이용해서, private key, public key 를 만들어 준다.

```sh
$ ssh-keygen -t rsa
```

이미 있을 경우도 있다. 아래 폴더를 확인해 본다.

```sh
$ cd ~/.ssh
$ ls
```

`id_rsa` 파일(private key)과 `id_rsa.pub` 파일(public key)이 있으면 된다. 혹시 둘 중 하나만 있다면, 아래 명령을 통해서 나머지를 만들어 낼 수 있다.

```sh
$ ssh-keygen -e
```

여기서 public key 파일을 열었을 때, 마지막 부분이 사용자의 이메일 주소이다. 이 부분을 git 에서 사용하는 이메일 주소로 수정해 준다.관리자에게 이 public key 파일을 전달해 주면, 관리자가, 특정 리포지토리에 권한을 등록해 주면, 그 다음부터는 접근이 가능하다.