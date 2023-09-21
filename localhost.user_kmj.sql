--사용자 계정 생성 user_이니셜

create user user_kmj identified by java1234;
grant connect, resource, dba to user_kmj;

---------------
--시퀀스 생성

CREATE SEQUENCE res_num ;
CREATE SEQUENCE movie_code ;
CREATE SEQUENCE dr_code ;
--------------------
drop SEQUENCE res_num ;
drop SEQUENCE movie_code ;
drop SEQUENCE dr_code ;

drop table member;
drop table schedule_movie;
drop table director;
drop table reservation;

--------------
-- 회원 테이블(member) 생성
CREATE TABLE member(
    id varchar2(30) PRIMARY KEY,
    pass varchar2(100),
    name varchar2(50),
    gender char(3),
    tel varchar2(13),
    regdate DATE DEFAULT sysdate
);

-- 영화 테이블(schedule_movie) 생성
CREATE TABLE schedule_movie(
    movie_code char(15) PRIMARY KEY,
    mv_title varchar2(100),
    mv_story varchar2(4000),
    mv_runtime NUMBER,
    mv_regdate DATE DEFAULT sysdate
);

-- 감독 테이블(director) 생성
CREATE TABLE director(
    dr_code char(15) PRIMARY KEY,
    dr_name varchar2(50),
    dr_regdate DATE DEFAULT sysdate,
    movie_code char(15) REFERENCES schedule_movie(movie_code)
);

-- 예약 테이블(reservation) 생성
CREATE TABLE reservation(
    res_num NUMBER PRIMARY KEY,
    id varchar2(30) REFERENCES member(id),
    movie_code char(15) REFERENCES schedule_movie(movie_code),
    regdate DATE DEFAULT sysdate
);

commit;
-----------
--회원 테이블 데이터
/*
son, 1234, 손재옥, 남, 010-7361-9876
kim, 1234, 김영주, 남, 010-6712-7652
jung,1234, 정헌석, 남, 010-7731-1471
*/

INSERT INTO member (id, pass, name, gender, tel)
VALUES ('son', '1234', '손재옥', '남', '010-7361-9876');
INSERT INTO member (id, pass, name, gender, tel)
VALUES ('kim', '1234', '김영주', '남', '010-6712-7652');
INSERT INTO member (id, pass, name, gender, tel)
VALUES ('jung', '1234', '정헌석', '남', '010-7731-1471');

select* from member;
commit;

--영화 테이블 데이터
/*
MV_000000000001, 007 노 타임 투 다이(No time to Die), 가장 강력한 운명의 적과 마주하게된 제임스 본드의 마지막 미션이 시작된다. ,163
MV_000000000002, 보이스(On the Line), 단 한 통의 전화!걸려오는 순간 걸려들었다! ,109
MV_000000000003, 수색자(The Recon),억울하게 죽은 영혼들의 무덤 DMZ, 111
MV_000000000004, 기적(Mircle), 오갈 수 있는 길은 기찻길밖에 없지만 정작 기차역은 없는 마을. , 117
*/

-- schedule_movie 테이블에 데이터 삽입
INSERT INTO schedule_movie (movie_code, mv_title, mv_story, mv_runtime)
VALUES ('MV_' || TO_CHAR(movie_code.nextVal, 'FM000000000000'), '007 노 타임 투 다이(No time to Die)', '가장 강력한 운명의 적과 마주하게된 제임스 본드의 마지막 미션이 시작된다.', 163);

INSERT INTO schedule_movie (movie_code, mv_title, mv_story, mv_runtime)
VALUES ('MV_' || TO_CHAR(movie_code.nextVal, 'FM000000000000'), '보이스(On the Line)', '단 한 통의 전화! 걸려오는 순간 걸려들었다!', 109);

INSERT INTO schedule_movie (movie_code, mv_title, mv_story, mv_runtime)
VALUES ('MV_' || TO_CHAR(movie_code.nextVal, 'FM000000000000'), '수색자(The Recon)', '억울하게 죽은 영혼들의 무덤 DMZ', 111);

INSERT INTO schedule_movie (movie_code, mv_title, mv_story, mv_runtime)
VALUES ('MV_' || TO_CHAR(movie_code.nextVal, 'FM000000000000'), '기적(Mircle)', '오갈 수 있는 길은 기찻길 밖에 없지만 정작 기차역은 없는 마을.', 117);

select * from schedule_movie;
commit;

--감독 테이블 데이터
/*
DR_000000000001, 캐리 후쿠나가, MV_000000000001
DR_000000000002, 김선 , MV_000000000002
DR_000000000003, 김곡 , MV_000000000002
DR_000000000004, 김민섭 , MV_000000000003
DR_000000000005, 이창훈, MV_000000000004
*/

INSERT INTO director (dr_code, dr_name, movie_code)
VALUES ('DR_' || TO_CHAR(dr_code.NEXTVAL, 'FM000000000000'), '캐리 후쿠나가','MV_000000000001');

INSERT INTO director (dr_code, dr_name, movie_code)
VALUES ('DR_' || TO_CHAR(dr_code.NEXTVAL, 'FM000000000000'), '김선', 'MV_000000000002');

INSERT INTO director (dr_code, dr_name, movie_code)
VALUES ('DR_' || TO_CHAR(dr_code.NEXTVAL, 'FM000000000000'), '김곡', 'MV_000000000002');

INSERT INTO director (dr_code, dr_name, movie_code)
VALUES ('DR_' || TO_CHAR(dr_code.NEXTVAL, 'FM000000000000'), '김민섭', 'MV_000000000003');

INSERT INTO director (dr_code, dr_name, movie_code)
VALUES ('DR_' || TO_CHAR(dr_code.NEXTVAL, 'FM000000000000'), '이창훈', 'MV_000000000004');

select * from director;
commit;

--예약 테이블 데이터
/*
“손재옥” 회원이 “보이스”를 예약한다.
“손재옥” 회원이 “수색자”를 예약한다.
“김영주” 회원이 “007”을 예약한다.
“정헌석” 회원이 “보이스”를 예약한다.
*/

INSERT INTO reservation (res_num, id, movie_code)
VALUES (res_num.nextval, 'son', 'MV_000000000002');
INSERT INTO reservation (res_num, id, movie_code)
VALUES (res_num.nextval, 'son', 'MV_000000000003');
INSERT INTO reservation (res_num, id, movie_code)
VALUES (res_num.nextval, 'kim', 'MV_000000000001');
INSERT INTO reservation (res_num, id, movie_code)
VALUES (res_num.nextval, 'jung', 'MV_000000000002');

select * from reservation;
commit;
------------------------------
--검색
--1. 모든 회원 정보를 검색한다.
select * from member;

--2. 모든 예매 정보를 조회한다.
select * from reservation;

--3. 모든 감독 정보를 조회한다.
select * from director;

--4. 영화제목, 스토리, 러닝타임, 감독명을 조회한다. (감독이 n명이면 영화가 n건 조회)
SELECT 
    m.mv_title as "영화제목",
    m.mv_story as "스토리",
    m.mv_runtime as "러닝타임",
    d.dr_name as "감독명"
FROM schedule_movie m
    INNER JOIN director d
        ON m.movie_code = d.movie_code;
        
--5. 보이스 라는 영화의 예약자명, 성별, 전화번호, 예매번호, 예매일을 조회한다. 단, 예매일이 마지막에 예매된 순서대로 조회하세요.
SELECT
    b.name as "예약자명",
    b.gender as "성별",
    b.tel as "전화번호",
    r.res_num as "예매번호",
    r.regdate as "예매일"
FROM schedule_movie m
    INNER JOIN reservation r
        ON m.movie_code = r.movie_code
            INNER JOIN member b
                ON b.id = r.id
                    WHERE m.mv_title = '보이스(On the Line)'
                        ORDER BY r.regdate DESC;