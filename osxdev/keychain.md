# Keychain

키체인은 비밀번호, 인증서, 관련정보를 보관하는 장소.

키체인은 여러개 가질 수 있지만, 기본적으로는 `~/Library/Keychains/login.keychain`을 기본으로 사용한다.

`Security Framework`는 이 키체인 접근과 관련한 함수와 구조체 모음이며, 키체인에 저장되는 비밀번호와 관련된 데이타를 키체인 아이템(Keychain item)이라 부른다.

# Keychain Access (키체인접근)

[[keychain-1.png]]

키체인에 들어 있는 데이타는 기본적으로 잠겨 있으나, 키체인접근에서 전체적으로 잠금해제를 하거나, 아니면 개별적인 아이템을 잠금해제를 해서, 해당 앱에서 사용가능하게 할 수 있다.

[[keychain-2.png]]

각각의 키체인 아이템에서 특정 애플리케이션에 대해서는 항상 접근 가능하도록 허용이 가능하다.

# 아이템(Items)과 속성 목록(Attributes List)

## 아이템의 종류

- 인터넷 비밀번호
- AppleShare 비밀번호
- 인증서
- 개인키, 공개키

## 인터넷 비밀번호 아이템의 속성

`/System/Library/Frameworks/Security.framework/Headers/SecKeychainItem.h` 파일을 보면, 속성 이름에 대한 상세한 정보가 있다.

<table>
<tr>
<th><code>kSecCreationDateItemAttr</code></th>
<td>생성일 <code>UInt32 ('cdat')</code></td>
</tr>
<tr>
<th><code>kSecDescriptionItemAttr</code></th>
<td>설명 <code>('desc')</code></td>
</tr>
<tr>
<th><code>kSecLabelItemAttr</code></th>
<td>이름 <code>('labl')</code></td>
</tr>
<tr>
<th><code>kSecCustomItemItemAttr</code></th>
<td>아이콘을 설정하려면 <code>kSecTypeItemAttr</code>의 값을 데스크탑 DB에 존재하는 파일타입으로 지정하고, <code>kSecCreatorItemAttr</code>를 생성한 애플리케이션의 타입으로 지정해 주어야 함. <code>Boolean ('cusi')</code></td>
</tr>
<tr>
<th><code>kSecAccountItemAttr</code></th>
<td>계정 <code>('acct')</code></td>
</tr>
<tr>
<th><code>kSecSecurityDomainItemAttr</code></th>
<td>인터넷 비밀번호의 경우 "위치" 항목 <code>('sdmn')</code></td>
</tr>
<tr>
<th><code>kSecServerItemAttr</code></th>
<td>서버 <code>UInt32 ('srvr')</code></td>
</tr>
</table>
