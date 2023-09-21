--사용자 계정 생성 user_이니셜
create user user_kmj identified by java1234;

grant connect, resource, dba to user_kmj;


--생성한 테이블 4개와 시퀀스를 backup_자신이름_전화번호뒷자리.dmp 로 백업하세요.
--cmd