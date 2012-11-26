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

[[/osxdev/codesigning-1.png]]

