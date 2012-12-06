# Git-Flow

git-flow 는 빈센트 드리센이란 분이, 브랜치를 살 써서, 프로젝트의 리포지토리를 관리하는 법을 기술하고, git 확장 파일까지 만들었다. 이 확장파일을 설치하면, git 를 더 일관적으로 사용할 수 있다.

## 약간의 개념

### master 과 develop 브랜치

origin 의 master 브랜치는 실제 최종 릴리즈된 소스코드만을 관리한다. 개발중의 코드는 모두 develop 브랜치에 커밋한다. 즉, 처음 master 브랜치에서 develop 브랜치를 만든 다음, 개발중 계속 develop 브랜치에 커밋을 하고, 최종 릴리즈가 된 다음, master 브랜치에 머지하는 방식이다.

### feature 브랜치

feature 브랜치는 항상 develop 로 부터  브랜치를 만들며, 완료후에는 다시 develop 브랜치로 머지 된다.특정 새로운 기능을 구현 할 때, feature 브랜치를 만들고, 다 만들고 나면, 이 브랜치를 제거해 준다.일반적으로 feature 브랜치는 origin 에서는 관리하지 않는다.

### release 브랜치

release 브랜치는 develop 으로부터 브랜치를 만들고, 나중에 develop 과 master 브랜치로 머지 된다. develop 브랜치에서 왠만한 기능 구현이 완료 되었을때, release 브랜치를 만든다. 그리고, 버젼명, 빌드 날짜 등을 수정하고, 테스트 중 오류를 수정 한다. 모든 것이 완벽하면, release 브랜치는 제거되면서, develop 과 master 로 머지 시킨다.

### hotfix 브랜치

hotfix 의 경우, 현재 릴리즈 되어 있는 소스코드, 즉 master 상의 오류를 긴급 수정할 때 사용한다. master 로 부터 브랜치 하여, 긴급 수정하고, 테스트 한 이후, 문제가 없으면, master 와 develop 으로 머지 시킨다.

## 설치하기

Mac 에서는 두가지 설치방법이 있다.

### homebrew  를 사용하는 경우

```sh
$ brew install git-flow
```

### port 를 사용하는 경우

```sh
$ port install git-flow
```

## 시작하기

기존 프로젝트에서 git flow 를 적용하기 시작하려면, 아래와 같은 명령을 수행해 준다.

```sh
$ git flow init
```

그럼 많은 것을 물어보는데, 대부분 기본값을 사용하면 충분한다.

```
No branches exist yet. Base branches must be created now.
Branch name for production releases: [master] 
Branch name for "next release" development: [develop] 
How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/] 
Support branches? [support/] 
Version tag prefix? []
```

더 좋은 방법으로는, 모든 값을 기본으로 세팅하는

```sh
$ git flow init -d
```

로 하면 된다.

## 본격 프로젝트 진행하기

일반적으로 기본적인 구현 진행은 develop 브랜치에서 진행한다. 하지만, 완전히 새로운 큰 기능 구현을 시작한다면, 아래와 같은 명령을 사용한다.

```sh
$ git flow feature$ git flow feature start <name> [<base>]
$ git flow feature finish <name>
```

위에서 <base> 는 develop 브랜치의 특정 commit ID 를 뜻한다. feature 를 finish 하면 해당 브랜치가 삭제가 된다. 보통 finish를 하면 feature branch 를 develop branch 에 merge 하게 된다. 따라서, feature 를 finish 하기 전에, develop branch 를 origin 으로 부터, pull 해 주는 것이 좋다.만일 현재 작성중인 feature 를 팀원과 공유하고 싶은 경우, publish 를 통해서, origin 서버에 올릴 수 있다.

```sh
$ git flow feature publish <name>
```

다른 팀원은 위와 같이 publish 한 feature 를 아래 명령을 통해서 공유한다.

```sh
$ git flow feature pull origin <name>
```

publish 한 feature 를 삭제하고 싶은 경우, 아래 명령을 이용한다.

```sh
$ git push origin :feature/<name>
```

만일 릴리즈 과정을 시작한다면, 아래의 명령을 사용한다.

```sh
$ git flow release
$ git flow release start <release> [<base>]
$ git flow release finish <release>
```

마찬가지로, <base> 는 develop 브랜치의 commit ID 를 말한다. release 가 finish 되면, master 브랜치에 머지가 된다.릴리즈 후, 수정사항이 발생할 경우, hotfix 브랜치를 시작한다.

```sh
$ git flow hotfix
$ git flow hotfix start <release> [<base>]
$ git flow hotfix finish <release>
```

위에서 <base> 는 master 브랜치의 특정 commit ID 를 뜻한다. hotfix branch 는 develop, master branch 에 각각 다시 merge 한다. 즉, 이미 릴리즈 한 제품에 하자가 발생한 경우, 릴리즈한 제품의 소스코드가 있는 master 에서 branch 를 만들어서, 수정한 다음, 그 결과를 master 에 반영하고, 또한 현재 개발중인 develop 에도 반영한다는 컨셉이다.만일, 릴리즈 후, 수정을 하지만, 현재 개발에 다시 반영하고 싶지 않을 경우에는 support branch 를 시작한다.

```sh
$ git flow support start <support>
$ git flow support finish <support>
```

이 support branch 의 경우, 수정 후, master branch 에 다시 merge 하도, develop branch 에는 merge 하지 않는다.

## 참고

http://yakiloo.com/getting-started-git-flow/

