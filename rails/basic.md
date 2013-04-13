# 프로젝트 시작하기

`$ rails new projectname`

# 실행

` $ bundle exec rails s`

# 스캐폴드 생성

`$ rails generate scaffold Product title:string price:decimal`

# 스캐폴드 생성 후에는 반드시

`$ rake db:migrate`

# 모델 만들기

`$ bundle exec rails g model Product title:string price:decimal`

# 마이그레이션 만들기

`$ bundle exec rails generate migration add_price_column`

# 파일 업로드

```
class CreatePictures < ActiveRecord::Migration
	def change
		create_table :pictures do |t|
			t.string :comment
			t.string :name
			t.string :content_type
			t.binary :data, :limit => 1.megabyte
		end
	end
end
```