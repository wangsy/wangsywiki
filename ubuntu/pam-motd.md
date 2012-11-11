# [pam_motd](https://help.ubuntu.com/12.10/serverguide/pam_motd.html)

사용자가 로그인 할 때, `/etc/update-motd.d` 디렉토리 아래에 있는 스크립트들을 실행해서, 그 결과를 `/var/run/motd` 에 넣고 `/etc/motd.tail` 과 합쳐서 보여준다.