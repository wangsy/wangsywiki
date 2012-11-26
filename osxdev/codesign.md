# Code Sign

## 문제점

Keychain 을 통해서 애플리케이션의 접근 권한을 얻으면(항상 허용), 애플리케이션이 변경되지 않는 동안은 묻지 않고 계속 접근 가능하다.

하지만 만일 애플리케이션이 버젼업 되었다면?

애플리케이션이 code sign 되어 있으면, 버젼업이 되어 애플리케이션이 변경되어도 동일한 앱으로 간주된다.

## code sign을 이용하는 기본 애플리케이션

- Keychain
- Firewall
- Parental Control

## CA: Certificate Authorities

### chain of trust

시스템 내에는 기본적으로 CA의 인증서가 있고, 이 CA의 인증서로 서명된 인증서는 신뢰할 수 있는 것으로 한다.

만일 CA의 인증서로 서명된 인증서가 없다면, 내가 (Keychain Access 유틸리티를 이용해서) self signed CA 인증서를 만들어서 등록할 수 있다.

자체서명된 인증서는 방화벽에서는 쓰일 수 없고, 키체인접근 유틸리티에서는 사용 가능하다.

[[codesigning-1.png]]

키체인접근 > 인증서 지원 > 인증서 생성...

[[codesigning-2.png]]

생성된 인증서는 "타사에 의해 검증되지 않았습니다"라고 나온다

## 실제 코드 사인 해보기

```sh
$ codesign -s "CodeSigning" app-name
```

이름으로 인증서를 검색해서 서명한다.

```sh
$ codesign -d app-name
```

코드 사인이 잘 되었는지 확인할 수 있다.

```sh
$ codesign -dv app-name.app
```
상세한 내용을 확인할 수 있다.

```
Executable=/Users/wangsy/.../appname
Identifier=com.wangsy.appname
Format=bundle with Mach-O thin (x86_64)
CodeDirectory v=20100 size=207 flags=0x0(none) hashes=4+3 location=embedded
Signature size=1334
Signed Time=2012. 11. 26. 오후 6:29:04
Info.plist entries=21
Sealed Resources rules=4 files=3
Internal requirements count=1 size=96
```

코드사인 되지 않은 앱은 아래와 같이 표시된다.
```
appname: code object is not signed at all
```

코드사인은 app bundle 에도 가능하다.

```sh
$ codesign -s "CodeSigning" app-name.app
```

번들을 코드사인하면, 번들내의 리소스, Info.plist 파일등 일부만 바뀌어도 invalid 한 상태가 된다.

Xcode 에서, Build Settings 에서 `Code Signing Identity`를 세팅해 주면, 빌드할 때마다, 항상 코드사인을 해 준다.