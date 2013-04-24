한 코드 영역이 실행 될 때, 동시에 하나만 실행 되도록 보장하는 방법. 즉, 한 코드블럭이 두개 이상의 쓰레드(혹은 프로세스)에서 동시에 실행되는 것을 막는다.

http://whowish-programming.blogspot.kr/2011/03/rails-critical-section-through-mysql.html

위 코드를 참조 하여, 적용함.

아이디어는, MySQL 의 GET_LOCK 함수를 이용한다. 하지만, 위 웹페이지에 있는 설명이 조금 다른 부분이 있어서, 변경해서 적용

* `GET_LOCK(name, timeout)`
  * 해당 이름으로 LOCK을 만든다.
* `RELEASE_LOCK(name)`
  * 해당 이름의 LOCK을 해제 한다.
* `IS_FREE_LOCK(name)`
  * 해당 이름의 LOCK이 현재 해제된 상태인가? 해제된 상태면 1, 아니면 0
* `IS_USED_LOCK(name)`
  * 해당 이름의 LOCK이 현재 생성된 상태인가? 생성된 상태면 1, 아니면 0

<pre>
class Lock
  def self.lock(name)
    return ActiveRecord::Base.connection.execute("SELECT GET_LOCK('#{name}',60);")
  end
  def self.release(name)
    ActiveRecord::Base.connection.execute("SELECT RELEASE_LOCK('#{name}');")
  end
  def self.free?(name)
    return ActiveRecord::Base.connection.execute("SELECT IS_FREE_LOCK('#{name}');").select.to_a[0][0] == 1
  end
  def initialize(*name)
    @lock_name = Lock.generate_name(name)
  end
  def synchronize(&block)
    until Lock.free?(@lock_name)
      sleep 0.01
    end
    Lock.lock(@lock_name) rescue (raise "Getting Lock #{@lock_name} timeout")
    block.call()
    while true
      Lock.release(@lock_name) rescue next
      break
    end
  end
  private
  def self.generate_name(names)
    names.map{ |t| t.to_s}.join('--')
  end
end
</pre>

실제 사용하는 법은

<pre>
Lock.new("lock_name_here").synchronize do
  # critical section code here
  # for example
  # model = Model.find(1)
  # model.update_colum( :col_name, value )
  # model.save!
end
</pre>

여기서 주의!

만일 원하는 것이 변경 사항을 동시에 하는 것을 막으려 한다면, ` ActiveRecord::Locking::Pessimistic`을 쓰는 것이 바른 방법이다.

동시에 두개가 유일한 것을 얻기를 원한다면, find 를 한 다음, update 를 통해서 현재 상태를 변경 시도하면, lock 이 걸려있는 상태라면 실패를 한다. 그럼 다시 검색하는 방식으로 구현하는 것이 맞다.

하지만 위 코드 처럼 검색하는 것만 막으려 한다면, critical section 을 쓰는 방법 뿐일 듯 하다.