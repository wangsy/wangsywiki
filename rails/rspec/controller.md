rspec controller
================

`spec/controllers` 폴더에서 작성

Rails functional test 인 `ActionController::TestCase::Behavior`의 rspec wrapper

아래 항목을 주로 검사 함
- rendered templates
- redirects
- instance variables (view와 공유를 목적으로)
- cookies (response 할 목적으로)

주의
*view 는 기본적으로 render 되지 않는다. `render_views` 를 호출해 주어야 한다.*