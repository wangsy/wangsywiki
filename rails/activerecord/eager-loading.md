# Eager Loading

N+1 쿼리의 문제점 극복

	clients = Client.limit(10)
	clients.each do | client |
		client.address.zipcode
	end

위 경우에서는 

	clients = Client.includes(:addresses).limit(10)
	client.each do | client |
		client.address.zipcode
	end

위 경우에는 2번의 쿼리만 실행.

## 주의사항

eager-loading 을 통해서, 너무 많은 객체가 오지 않는지 주의해야 한다. 예를들어, 수천,수만개가 있는 모델을 includes 해서 다 가져오면 퍼포먼스에 상당한 문제를 일으킨다.

