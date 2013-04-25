# ActiveRecord 의 DB Cache 문제

ActiveRecord 에서 복합적인 쿼리를 쓰다 보면, 캐시가 강제로 먹어서 애먹는 경우가 있다.

예를 들어, 아래와 같은 쿼리에서

<pre>
where( id: select("MAX(id)").group_by("product_type").collect(&:id) )
</pre>

위 `select("MAX(id)").group_by("product_type").collect(&:id)` 이 부분의 결과 값이 항상 캐시 되어, 서버를 리부팅 하기 전까지는 값이 바뀌지 않는 문제가 발생하였다. 결과값이 캐시 되어, 다시 DB에 접근하지 않고, 계속 반복되어서 사용되었다. 서버 로그를 보니, DB쿼리도 하지 않았다.

이를 해결하는 방법

<pre>
uncached
  where( id: select("MAX(id)").group_by("product_type").collect(&:id) )
end
</pre>

위와 같이 `uncached` 블럭으로 둘러 싸 주면, 무조건 쿼리한다. 위 행이 한 request 에 반복해서 불려도, 무조건 다시 쿼리 한다.