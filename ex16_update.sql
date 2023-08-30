--ex16_update.sql

/*
 
	UPDATE
	- DML
	- 원하는 행의 원하는 컬럼값을 수정하는 명령어
	
	 UPDATE 구문
	 - update 테이블명 set 컬럼명 = 값 [, 컬럼명 = 값] X N [WHERE 절]
	  
     
  
 */


COMMIT;
ROLLBACK;


SELECT * FROM tblcountry;

-- 대한민국: 서울 > 세종 // 적용된 행 확인하기!!
UPDATE tblcountry SET capital = '세종';

UPDATE tblcountry SET capital = '세종' WHERE name = '대한민국';

UPDATE tblcountry SET capital = '세종', population = WHERE name = '대한민국';

UPDATE tblcountry SET
	capital = '세종',
	population = population + 100,
	continent = 'EU'
WHERE NAME = '대한민국';

SELECT * FROM tblcountry;
	
