# Wordpress에서 thumbnail 문제

## 현상

1. Posting 화면에서 Media 선택해서 이미지를 삽입할려고 할 때, 이미지 사이즈 옵션이 오로지 "Full Size" 하나만 나온다.

## 원인

일단 기본적으로 wordpress 에서 사용하는 이미지 에디터는 gd 와 imagemagick 두개가 있다. 만일 gd 가 아닌 imagemagick 가 선택이 되고, imagemagick 이

어떤 이유에서든 제대로 동작하지 않는 경우라면, 위와 같은 현상이 일어날 수 있다.


## 해결 방법

```
I put the following code into my functions.php file. It works!

add_filter( 'wp_image_editors', 'change_graphic_lib' );

function change_graphic_lib($array) {
  return array( 'WP_Image_Editor_GD', 'WP_Image_Editor_Imagick' );
}
```

## 이후

이상하게도 이후에 설치한 Wordpress 에서는 위와 같은 수정이 필요 없이, 정상 동작하는 것을 발견했다.
