난제
====

Article - Comment 관계에서 둘을 한번에 뽑을 때, in 쓰지 않기
-------------------------------------------------------------

Article 이 has_many 관계로 Comment 를 가질 때, 한 쿼리로, Article 과 한 Article 당, 가장 최신의 Comment 를 가져 오고 싶을 때에는 다음과 같은 방법을 쓴다.

<pre>
class Article .. ActiveRecord::Base

def self.articles_with_comments
  Article.join(:comments).merge(Comment.latest).select("`articles`.*, `comment`.title as comment_title")
end
end

class Comment .. ActiveRecord::Base

def self.latest
  where( id: select("MAX(id) AS id").group("article_id").collect(&:id) )
end
end
</pre>

이때 문제가 있다. 위 `self.latest`내의 `select...` 문은 결국 array 로 변환되는데, 이때 `Comment` 가 많아지면 array는 감당할 수 없을 정도로 많아지고, 그러면, SQL문 자체가 너무 커진다. 결국 4kb 이상의 SQL은 전송될 수 없는 문제에 부딯히게 된다.

따라서, SQL의 IN 을 쓰지 않고 해결 할 수 있는 방법을 찾아야 한다.