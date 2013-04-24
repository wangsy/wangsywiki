한 코드 영역이 실행 될 때, 동시에 하나만 실행 되도록 보장하는 방법. 즉, 한 코드블럭이 두개 이상의 쓰레드(혹은 프로세스)에서 동시에 실행되는 것을 막는다.

http://whowish-programming.blogspot.kr/2011/03/rails-critical-section-through-mysql.html

위 코드를 참조 하여, 적용함.

아이디어는, MySQL 의 GET_LOCK 함수를 이용한다. 하지만, 위 웹페이지에 있는 설명이 조금 다른 부분이 있어서, 변경해서 적용

------------------------------------------
| `GET_LOCK(name, timeout)` | 해당 이름으로 LOCK을 만든다. |
| `RELEASE_LOCK(name)`      | 해당 이름의 LOCK을 해제 한다. |
| `IS_FREE_LOCK(name)`      | 해당 이름의 LOCK이 현재 해제된 상태인가? 해제된 상태면 1, 아니면 0 |
| `IS_USED_LOCK(name)`      | 해당 이름의 LOCK이 현재 생성된 상태인가? 생성된 상태면 1, 아니면 0 |
------------------------------------------