# 개요

git 를 시작하기 전, 알면 좋은 몇가지 개념을 소개한다.

## git 는 분산형

git 가 기존의 svn 과 구분되는 가장 큰 특징은 분산형이라는 것이다. 이것이 무슨 뜻이냐 하면, svn 의 경우 중앙 리포지토리에서 관리된다. 그래서, 모든 커밋이 중앙에 집중이 되고, 이것이 revision 번호로 관리가 된다. 중앙의 특정 revision 번호가 특정한 소스의 상태를 대변할 수 있는 것이다.

반대로, git 의 경우, 각각 분산된 곳에서 따로 따로 리포지토리가 관리된다. 그래서, 특정 revision 번호라는 것이 존재할 수 없다. 나는 나대로, 너는 너대로 따로 리포지토리가 관리된 상태에서 서로 머지를 할 수도 있고, 다시 분리할 수도 있다. revision 번호라는 것은 엄격한 순서가 관리되는데, 이 같은 분산형에서는 불가능한 일이다.서

그래서, git 에서는 40자의 HEX CODE 를 commit ID 값으로 쓴다. 즉, 완전히 고유한 (동일한 값이 나올 확율이 거의 없는) 값을 각 커밋마다 부여한다. 그리고, 그 코드 값으로 각 커밋 단위를 부른다. 순서는 상관없다. 

git 는 네단계로 관리를 한다.

untracked <=> tracked <=> staged <=> commited <=> pushed

# 프로젝트 시작하기

## 서버로 부터 가져오면서 시작하기

```sh
$ git clone ssh://user@server.com/git/project.git
$ git clone git://user@server.com/git/project.git
```

## 로컬에서 관리하면서 시작하기

```sh
$ mkdir project
$ cd project
$ git init
```

## 공유지점을 만들면서 시작하기

```sh
$ git init --bare project.git
```

# 프로젝트 진행 흐름 따라잡기

## 서버에서 생성되어 있는 브랜치 보기

```sh
$ git branch -rorigin/HEAD -> origin/masterorigin/developmentorigin/master
```

## 서버에서 생성되어 있는 브랜치 가져오기

```sh
$ git checkout -b <new branch name> <server branch name>
$ git checkout -b development origin/development
```

## 내가 최초로 서버에 브랜치 만들기

```sh
$ git push <server name> <local branch>:<remote branch>
$ git push origin master:development
```

내가 clone 해 온 서버는 자동으로 서버의 이름으로 origin 이란 이름을 가진다. 아래 명령을 해 보면, 현재의 리포지토리와 연결된 서버의 이름의 목록이 출력 된다.

```sh
$ git remoteorigin
```

또한 최초로 만들어진 branch 의 이름은 master 이다.

## 서버에서 진행된 상황 가져오기

```sh
$ git pull origin master
```

위 명령을 통해서, 현재 브랜치에, origin 서버에 있는 master 브랜치의 내용을 가져와서 merge 를 해 준다.

만일 매번 origin master 를 써 주기가 귀찮을 경우, 현재 브랜치(master)는 항상 origin 서버의 master 브랜치를 가져와 merge 할 것이다 라는 것을 아래 명령으로 지정해 준다.

```sh
$ git config branch.master.remote origin
$ git config branch.master.merge refs/heads/master
$ git pull
```

# 새로운 기능 추가하기

## branch 간 이동하기

```sh
$ git branch
development
* master
$ git checkout development
```

## 새로운 기능 추가를 위한 branch 만들기

```sh
$ git checkout -b feature-great-new development
```

## 새로 만든 branch 서버에 올리기

```sh
$ git push <server name> <local branch>:<remote branch>
$ git push origin feature-great-new:feature-great-new
```

## 추가한 기능 공유하기

일단 새로운 기능을 구현한다.

```sh
$ edit new-feature.c
```

그리고, 구현이 완료가 되면, 커밋한다.

```sh
$ git commit -a -m “Log Message”
```

그러면, 로컬 리포지토리에 커밋이 기록된다. 그리고, 서버에 반영하려면,

```sh
$ git push
```

새로운 기능 추가 마무리구현이 마무리가 되면, development branch 에 merge 해 준다.

```sh
$ git checkout development
$ git merge feature-great-new
```

그리고, development branch 에 완전히 적용이 됐다면, feature-great-new 브랜치는 없애 준다.

```sh
$ git branch -d feature-great-new
$ git push origin :feature-great-new
```

## 수정한 내용 취소하기

```sh
$ git checkout .
```

# 설정하기

## 내 정보 설정

```sh
# personalize these with your own name and email address
$ git config --global user.name "Sooyong Wang"
$ git config --global user.email "wangsy@wangsy.com"
```

## color 설정

```sh
$ git config --global color.ui auto
```

## alias 설정

```sh
# shortcut aliases
$ git config --global alias.st status
$ git config --global alias.ci commit
$ git config --global alias.co checkout
```

