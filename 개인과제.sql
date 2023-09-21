CREATE SEQUENCE res_num ;
CREATE SEQUENCE movie_code ;
CREATE SEQUENCE dr_code ;

drop table member;
drop table schedule_movie;
drop table director;
drop table reservation;

commit;

/* member */
CREATE TABLE member (
	id VARCHAR2(30) primary key NOT NULL, /* id */
	pass VARCHAR2(100), /* pass */
	name VARCHAR2(50), /*  name */
	gender CHAR(1), /* gender */
	tel VARCHAR2(13), /* tel */
	regdate DATE DEFAULT sysdate NOT NULL /* regdate */
);




/* schedule_movie */
CREATE TABLE schedule_movie (
	movie_code CHAR(15) primary key NOT NULL, /* movie_seq */
	mv_life VARCHAR2(100), /* mv_life */
	mv_story VARCHAR2(4000), /* mv_story */
	mv_runtime NUMBER, /* mv_runtime */
	mv_regdate DATE DEFAULT sysdate not null /* mv_regdate */
);

/* director */
CREATE TABLE director (
	dr_code NUMBER primary key NOT NULL, /* dr_code */
	dr_name VARCHAR2(50), /* dr_name */
	dr_regdate DATE DEFAULT sysdate not null, /* dr_regdate */
	movie_code CHAR(15)REFERENCES schedule_movie(movie_code) /* movie_seq */
);

/* reservatiom */
CREATE TABLE reservation (
	res_num NUMBER primary key NOT NULL, /* res_num */
	id VARCHAR2(30) NOT NULL REFERENCES schedule_movie(movie_code), /* id */
	movie_code CHAR(15) NOT NULL REFERENCES member(id), /* movie_seq */
	regdate DATE DEFAULT sysdate not null /* regdate */
);