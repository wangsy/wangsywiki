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
<td>HTTP Basic Auth Protocol 의 Realm에 해당.<code>('sdmn')</code></td>
</tr>
<tr>
<th><code>kSecServerItemAttr</code></th>
<td>위치. (서버주소) <code>('srvr')</code></td>
</tr>
</table>

`SecKeychainAttributeList`구조체를 이용해서 값을 가져올 수 있다.
```c
struct SecKeychainAttributeList {
    UInt32 count;
    SecKeychainAttribute *attr;
};
```

`count`는 가져올 속성의 갯수. `attr`는 첫번째 속성을 가르키는 포인터.

```c
struct SecKeychainAttribute  {
    SecKeychainAttrType tag;
    UInt32 length;
    void *data;
};
```
`tag`는 4바이트 코드(위 테이블 참조). `length`는 `data`구조체의 크기.

[[keychain-3.png]]

# 아이템 검색

`SecKeychainAttributeList`는 다음 3가지 경우에 사용된다.

- 검색할 항목 지정
- 아이템의 값을 읽을때
- 아이템의 값을 쓸 때

예를들어, 특정 항목을 검색하고 싶을 때에는, `SecKeychainAttributeList` 값을 채워 넣은 다음 `SecKeychainSearchCreateFromAttribute` 함수를 호출하면 된다.

```c
OSStatus SecKeychainSearchCreateFromAttributes (
  CFTypeRef keychainOrArray, 
  SecItemClass itemClass,
  const SecKeychainAttributeList *attrList,
  SecKeychainSearchRef *searchRef);
```

- `keychainOrArray`에 NULL 을 넣으면, 사용자의 기본 키체인에서 검색.
- `itemClass`에는 
  - `kSecInternetPasswordItemClass`
  - `kSecGenericPasswordItemClass`
  - `kSecAppleSharePasswordItemClass`
  - `kSecCertificateItemClass`
- `attributeList` 에 NULL 값을 넣으면, 모든 값이 검색된다.

dumpem.m

```objc
// dumpem.m -- look into the keychain
// gcc -std=c99 -g -Wall -framework Security -framework Foundation -o dumpem dumpem.m
#import <Security/Security.h>
#import <Foundation/Foundation.h>
#import <stdlib.h>    // for EXIT_SUCCESS
#import <stdio.h>     // for printf() and friends
#import <string.h>    // for strncpy

int main (int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (argc != 2) {
        printf ("usage: %s account-name\n", argv[0]);
        return EXIT_FAILURE;
    }
    // Build an attribute list with just one attribute.
    SecKeychainAttribute attribute;
    attribute.tag = kSecAccountItemAttr;
    attribute.length = strlen(argv[1]);
    attribute.data = argv[1];
    // Make a list to point to this new attribute.
    SecKeychainAttributeList list;
    list.count = 1;
    list.attr = &attribute;
    // Create a search handle with the attribute list.
    SecKeychainSearchRef search;
    OSErr result = SecKeychainSearchCreateFromAttributes
        (NULL, kSecInternetPasswordItemClass, &list, &search);
    if (result != noErr) {
        printf ("result %d from SecKeychainSearchCreateFromAttributes\n", result);
    }
    // Iterate over the search results
    int count = 0;
    SecKeychainItemRef item;
    while (SecKeychainSearchCopyNext (search, &item) != errSecItemNotFound) {
        CFRelease (item);
        count++; 
    }
    printf ("%d items found\n", count);
    CFRelease (search);
    [pool drain];
    return EXIT_SUCCESS;
} // main
```

# 아이템의 속성 내용 읽기

`SecKeychainItemRef`를 가지고, 얻고 싶은 속성 목록을 `SecKeychainAttributeList`를 만든 다음, `SecKeychainItemCopyContent()`를 호출하면, 원하는 아이템의 속성값들을 가져올 수 있다.

```c
OSStatus SecKeychainItemCopyContent (
  SecKeychainItemRef itemRef, 
  SecItemClass *itemClass,
  SecKeychainAttributeList *attrList,
  UInt32 *length,
  void **outData);
```

dumpem.m 에 아래 코드 추가

```objc
// Given a carbon-style four character code, make a C string that can
// be given to printf.
const char *fourByteCodeString (UInt32 code) {
    // Splat the bytes of the four character code into a character array.
    typedef union theCheat {
      UInt32 code;
      char string[4];
    } theCheat;
    // C string that gets returned.
    static char string[5];
    // Byte-swap, otherwise string will be backwards on little endian systems.
    ((theCheat*)string)->code = ntohl(code); // network byteorder -> host byteorder (long)
    string[4] = '\0';
    return (string);
} // fourByteCodeString

// Display each attribute in the list.
void showList (SecKeychainAttributeList list) {
    for (int i = 0; i < list.count; i++) {
        SecKeychainAttribute attr = list.attr[i];
        char buffer[1024];
        if (attr.length < sizeof(buffer)) {
            // make a copy of the data so we can stick on
            // a trailing zero byte
            strncpy (buffer, attr.data, attr.length);
            buffer[attr.length] = '\0';
            printf ("\t%d: '%s' = \"%s\"\n",
                    i, fourByteCodeString(attr.tag), buffer);
        } else {
            printf ("attribute %s is more than 1K\n",
                fourByteCodeString(attr.tag));
        }
    }
} // showList

// Display a keychain item's info.
void dumpItem (SecKeychainItemRef item, bool displayPassword) {
    // Build the attributes we're interested in examining.
    SecKeychainAttribute attributes[3];
    attributes[0].tag = kSecAccountItemAttr;
    attributes[1].tag = kSecDescriptionItemAttr;
    attributes[2].tag = kSecModDateItemAttr;
    SecKeychainAttributeList list;
    list.count = 3;
    list.attr = attributes;
    // Get the item's information, including the password.
    UInt32 length = 0;
    char *password = NULL;
    OSErr result;
    if (displayPassword) {
        result = SecKeychainItemCopyContent (item, NULL, &list, &length, (void **)&password);
    } else {
        result = SecKeychainItemCopyContent (item, NULL, &list, NULL, NULL);
    }
    if (result != noErr) {
        printf ("dumpItem: error result of %d\n", result);
        return;
    }
    if (password != NULL) {
        // Copy the password into a buffer and attach a trailing zero
        // byte so we can print it out with printf.
        char *passwordBuffer = malloc(length + 1);
        strncpy (passwordBuffer, password, length);
        passwordBuffer[length] = '\0';
        printf ("Password = %s\n", passwordBuffer);
        free (passwordBuffer);
    }
    showList (list);
    SecKeychainItemFreeContent (&list, password);
} // dumpItem
```

`SecKeychainItemCopyContent()`이 호출 될 때에는, 인증창이 뜬다. 이때, "항상 허용", "거부", "허용" 중 하나를 선택한다. 매번 호출될 때마다 한번씩 물어보게 된다. 하지만, 만일 비밀번호를 물어보지 않으면, 인증창이 뜨지 않는다.

위 추가한 영역이 실행되려면, `main()`쪽에 아래 부분을 수정해야 한다.

```
    while (SecKeychainSearchCopyNext (search, &item) == noErr) {
        dumpItem (item, true);
        CFRelease (item);
        i++;
    }
```

인증창에서 "항상 허용"을 선택하면, 로그아웃 전까지는 다시 인증창이 뜨지 않는다. 하지만, 다시 컴파일하면 인증창이 다시 뜰 것이다.

# 키체인 항목 수정하기

```c
OSStatus SecKeychainItemModifyContent (
  SecKeychainItemRef itemRef, 
  const SecKeychainAttributeList *attrList,
  UInt32  newPasswordLength,
  const void *newPassword)
```

```c
OSStatus SecKeychainItemDelete (SecKeychainItemRef itemRef)
```

삭제한 후에도 반드시 `CFRelease()` 를 호출해 준다.

# 키체인 선택하기

기본 키체인에 대한 참조를 얻으려면,

```c
OSStatus SecKeychainCopyDefault (SecKeychainRef *keychain)
```

특정 키체인 파일에 대해서 접근하려면

```c
OSStatus SecKeychainOpen (
  const char *pathName, 
  SecKeychainRef *keychain)
```

다 쓴 후에는 반드시 `CFRelease()` 해 준다.

# 키체인 접근

