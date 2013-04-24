rails 혹은 daemon 혹은 한번 떠서 오랜 시간 작업을 해야 하는 ruby 프로그램에서 rmagick 를 사용해서, 이미지를 변경하는 경우, 오랜 시간 사용하다보면 메모리가 지속적으로 올라가는 것을 발견하게 된다.

특히 rails 에서 이미지 작업을 하다보면, 메모리가 계속 올라서 문제가 되는 경우가 있었는데, 이를 해결하는 방법은 생각보다 쉽다.

<pre>
img = Image.read(file).first
# process image
img.destroy!
</pre>

위 코드와 같이 다 사용하고 난 `img` 객체에 대해서 `img.destroy!`를 통해서 반드시 메모리 해제 해 주면 된다. 그러면 GC가 돌 때, 메모리가 비워 진다.