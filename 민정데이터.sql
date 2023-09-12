--강의실
INSERT INTO tblClassroom VALUES (classroomName,classroomMaxPeople);

INSERT INTO tblClassroom VALUES (1,30);
INSERT INTO tblClassroom VALUES (2,30);
INSERT INTO tblClassroom VALUES (3,30);
INSERT INTO tblClassroom VALUES (4,26);
INSERT INTO tblClassroom VALUES (5,26);
INSERT INTO tblClassroom VALUES (6,26);



--과정
INSERT INTO tblCourse VALUES (courseSeq, courseName, courseStartDate, courseFinishDate, classroomName, subjectRegistrationStatus, studentNumber);
INSERT INTO tblCourse VALUES (과정번호, '과정명', TO_DATE('시작일자','YYYY-MM-DD') , TO_DATE('종료일자','YYYY-MM-DD'),강의실명,'과목등록여부', 교육생인원);

INSERT INTO tblCourse VALUES (1, '웹 애플리케이션 응용 SW 실무 개발자 양성 과정', TO_DATE('2023-03-14','YYYY-MM-DD') , TO_DATE('2023-10-13','YYYY-MM-DD'),1,'N', 30);
INSERT INTO tblCourse VALUES (2, 'Java&Python 기반 응용SW개발자 양성과정', TO_DATE('2023-02-20','YYYY-MM-DD') , TO_DATE('2023-09-19','YYYY-MM-DD'),2,'N', 30);
INSERT INTO tblCourse VALUES (3, 'Java(자바)& AWS 활용한 Full-Stack 개발자 양성과정', TO_DATE('2023-05-03','YYYY-MM-DD') , TO_DATE('2023-11-02','YYYY-MM-DD'),3,'N', 30);
INSERT INTO tblCourse VALUES (4, '자바(Java)기반 Web & 스마트플랫폼 Full-Stack 개발자 양성과정', TO_DATE('2023-05-29','YYYY-MM-DD') , TO_DATE('2023-11-28','YYYY-MM-DD'),4,'N', 26);
INSERT INTO tblCourse VALUES (5, '자바&스프링 기반 빅데이터 융합 개발자 양성과정', TO_DATE('2023-07-13','YYYY-MM-DD') , TO_DATE('2023-12-26','YYYY-MM-DD'),5,'N', 26);
INSERT INTO tblCourse VALUES (6, 'AWS 클라우드와 Elasticsearch를 활용한 Java Full-Stack 개발자 양성 과정', TO_DATE('2023-07-14','YYYY-MM-DD') , TO_DATE('2023-12-27','YYYY-MM-DD'),6,'N', 26);
INSERT INTO tblCourse VALUES (7, 'Java를 활용한 Full-Stack개발자 양성과정', TO_DATE('2023-11-09','YYYY-MM-DD') , TO_DATE('2024-06-05','YYYY-MM-DD'),3,'N', 30);
INSERT INTO tblCourse VALUES (8, '공공데이터 융합 웹 애플리케이션 개발자 양성과정', TO_DATE('2023-10-26','YYYY-MM-DD') , TO_DATE('2024-05-21','YYYY-MM-DD'),1,'N', 30);
INSERT INTO tblCourse VALUES (9, '공공데이터 융합 자바개발자 양성과정', TO_DATE('2023-09-25','YYYY-MM-DD') , TO_DATE('2024-04-23','YYYY-MM-DD'),2,'N', 30);
INSERT INTO tblCourse VALUES (10, '정보시스템 구축·운영 기반 정보보안 전문가 양성과정', TO_DATE('2023-01-05','YYYY-MM-DD') , TO_DATE('2023-07-04','YYYY-MM-DD'),5,'N', 26);
INSERT INTO tblCourse VALUES (11, 'Python 활용 빅데이터 기반 금융 솔루션 UI 개발자 양성과정', TO_DATE('2022-12-12','YYYY-MM-DD') , TO_DATE('2023-07-11','YYYY-MM-DD'),6,'N', 26);
INSERT INTO tblCourse VALUES (12, '자바기반 반응형 UI/UX 웹 콘텐츠 개발자 양성과정', TO_DATE('2022-12-13','YYYY-MM-DD') , TO_DATE('2023-05-26','YYYY-MM-DD'),4,'N', 26);



--과목목록
INSERT INTO tblSubjectList VALUES (subjectListSeq,courseSeq,subSeq,subjectStartDate,subjectFinishDate,bookSeq,tSeq);
INSERT INTO tblSubjectList VALUES (과목목록번호, 과정번호,과목번호, TO_DATE('과목시작일자','YYYY-MM-DD') , TO_DATE('과목종료일자','YYYY-MM-DD'),교재번호,교사번호);

INSERT INTO tblSubjectList VALUES (1, 1,1, TO_DATE('2023-03-14','YYYY-MM-DD') , TO_DATE('2023-04-13','YYYY-MM-DD'),13,1);
INSERT INTO tblSubjectList VALUES (2, 1,2, TO_DATE('2023-04-14','YYYY-MM-DD') , TO_DATE('2023-05-15','YYYY-MM-DD'),5,1);
INSERT INTO tblSubjectList VALUES (3, 1,4, TO_DATE('2023-05-16','YYYY-MM-DD') , TO_DATE('2023-06-10','YYYY-MM-DD'),1,1);
INSERT INTO tblSubjectList VALUES (4, 1,26, TO_DATE('2023-06-11','YYYY-MM-DD') , TO_DATE('2023-07-13','YYYY-MM-DD'),31,1);
INSERT INTO tblSubjectList VALUES (5, 1,16, TO_DATE('2023-07-14','YYYY-MM-DD') , TO_DATE('2023-08-31','YYYY-MM-DD'),32,1);
INSERT INTO tblSubjectList VALUES (6, 1,34, TO_DATE('2023-09-01','YYYY-MM-DD') , TO_DATE('2023-10-13','YYYY-MM-DD'),11,1);
INSERT INTO tblSubjectList VALUES (7, 2,1, TO_DATE('2023-02-20','YYYY-MM-DD') , TO_DATE('2023-03-31','YYYY-MM-DD'),17,2);
INSERT INTO tblSubjectList VALUES (8, 2,2, TO_DATE('2023-04-01','YYYY-MM-DD') , TO_DATE('2023-05-04','YYYY-MM-DD'),22,2);
INSERT INTO tblSubjectList VALUES (9, 2,4, TO_DATE('2023-05-05','YYYY-MM-DD') , TO_DATE('2023-06-11','YYYY-MM-DD'),1,2);
INSERT INTO tblSubjectList VALUES (10, 2,9, TO_DATE('2023-06-12','YYYY-MM-DD') , TO_DATE('2023-07-20','YYYY-MM-DD'),9,2);
INSERT INTO tblSubjectList VALUES (11, 2,12, TO_DATE('2023-07-21','YYYY-MM-DD') , TO_DATE('2023-08-10','YYYY-MM-DD'),21,2);
INSERT INTO tblSubjectList VALUES (12, 2,15, TO_DATE('2023-08-11','YYYY-MM-DD') , TO_DATE('2023-09-19','YYYY-MM-DD'),29,2);
INSERT INTO tblSubjectList VALUES (13, 3,1, TO_DATE('2023-05-03','YYYY-MM-DD') , TO_DATE('2023-06-01','YYYY-MM-DD'),23,3);
INSERT INTO tblSubjectList VALUES (14, 3,2, TO_DATE('2023-06-02','YYYY-MM-DD') , TO_DATE('2023-06-30','YYYY-MM-DD'),22,3);
INSERT INTO tblSubjectList VALUES (15, 3,4, TO_DATE('2023-07-01','YYYY-MM-DD') , TO_DATE('2023-08-05','YYYY-MM-DD'),1,3);
INSERT INTO tblSubjectList VALUES (16, 3,3, TO_DATE('2023-08-06','YYYY-MM-DD') , TO_DATE('2023-08-31','YYYY-MM-DD'),14,3);
INSERT INTO tblSubjectList VALUES (17, 3,29, TO_DATE('2023-09-01','YYYY-MM-DD') , TO_DATE('2023-09-26','YYYY-MM-DD'),33,3);
INSERT INTO tblSubjectList VALUES (18, 3,33, TO_DATE('2023-09-27','YYYY-MM-DD') , TO_DATE('2023-11-02','YYYY-MM-DD'),9,3);
INSERT INTO tblSubjectList VALUES (19, 4,1, TO_DATE('2023-05-29','YYYY-MM-DD') , TO_DATE('2023-06-30','YYYY-MM-DD'),18,4);
INSERT INTO tblSubjectList VALUES (20, 4,2, TO_DATE('2023-07-01','YYYY-MM-DD') , TO_DATE('2023-07-28','YYYY-MM-DD'),5,4);
INSERT INTO tblSubjectList VALUES (21, 4,4, TO_DATE('2023-07-29','YYYY-MM-DD') , TO_DATE('2023-08-25','YYYY-MM-DD'),1,4);
INSERT INTO tblSubjectList VALUES (22, 4,35, TO_DATE('2023-08-26','YYYY-MM-DD') , TO_DATE('2023-09-23','YYYY-MM-DD'),41,4);
INSERT INTO tblSubjectList VALUES (23, 4,19, TO_DATE('2023-09-24','YYYY-MM-DD') , TO_DATE('2023-10-14','YYYY-MM-DD'),30,4);
INSERT INTO tblSubjectList VALUES (24, 4,8, TO_DATE('2023-10-15','YYYY-MM-DD') , TO_DATE('2023-11-28','YYYY-MM-DD'),16,4);
INSERT INTO tblSubjectList VALUES (25, 5,1, TO_DATE('2023-07-13','YYYY-MM-DD') , TO_DATE('2023-08-09','YYYY-MM-DD'),13,5);
INSERT INTO tblSubjectList VALUES (26, 5,2, TO_DATE('2023-08-10','YYYY-MM-DD') , TO_DATE('2023-09-02','YYYY-MM-DD'),22,5);
INSERT INTO tblSubjectList VALUES (27, 5,4, TO_DATE('2023-09-03','YYYY-MM-DD') , TO_DATE('2023-09-27','YYYY-MM-DD'),1,5);
INSERT INTO tblSubjectList VALUES (28, 5,12, TO_DATE('2023-09-28','YYYY-MM-DD') , TO_DATE('2023-10-20','YYYY-MM-DD'),21,5);
INSERT INTO tblSubjectList VALUES (29, 5,15, TO_DATE('2023-10-21','YYYY-MM-DD') , TO_DATE('2023-11-23','YYYY-MM-DD'),29,5);
INSERT INTO tblSubjectList VALUES (30, 5,11, TO_DATE('2023-11-24','YYYY-MM-DD') , TO_DATE('2023-12-26','YYYY-MM-DD'),25,5);
INSERT INTO tblSubjectList VALUES (31, 6,1, TO_DATE('2023-07-14','YYYY-MM-DD') , TO_DATE('2023-09-01','YYYY-MM-DD'),17,6);
INSERT INTO tblSubjectList VALUES (32, 6,2, TO_DATE('2023-09-02','YYYY-MM-DD') , TO_DATE('2023-09-30','YYYY-MM-DD'),5,6);
INSERT INTO tblSubjectList VALUES (33, 6,4, TO_DATE('2023-10-01','YYYY-MM-DD') , TO_DATE('2023-10-13','YYYY-MM-DD'),1,6);
INSERT INTO tblSubjectList VALUES (34, 6,3, TO_DATE('2023-10-14','YYYY-MM-DD') , TO_DATE('2023-11-03','YYYY-MM-DD'),3,6);
INSERT INTO tblSubjectList VALUES (35, 6,16, TO_DATE('2023-11-04','YYYY-MM-DD') , TO_DATE('2023-12-01','YYYY-MM-DD'),32,6);
INSERT INTO tblSubjectList VALUES (36, 6,31, TO_DATE('2023-12-02','YYYY-MM-DD') , TO_DATE('2023-12-27','YYYY-MM-DD'),22,6);
INSERT INTO tblSubjectList VALUES (37, 7,1, TO_DATE('2023-11-09','YYYY-MM-DD') , TO_DATE('2024-01-01','YYYY-MM-DD'),18,7);
INSERT INTO tblSubjectList VALUES (38, 7,2, TO_DATE('2024-01-02','YYYY-MM-DD') , TO_DATE('2024-01-31','YYYY-MM-DD'),22,7);
INSERT INTO tblSubjectList VALUES (39, 7,4, TO_DATE('2024-02-01','YYYY-MM-DD') , TO_DATE('2024-02-25','YYYY-MM-DD'),1,7);
INSERT INTO tblSubjectList VALUES (40, 7,13, TO_DATE('2024-02-26','YYYY-MM-DD') , TO_DATE('2024-04-02','YYYY-MM-DD'),21,7);
INSERT INTO tblSubjectList VALUES (41, 7,28, TO_DATE('2024-04-03','YYYY-MM-DD') , TO_DATE('2024-05-03','YYYY-MM-DD'),35,7);
INSERT INTO tblSubjectList VALUES (42, 7,7, TO_DATE('2024-05-04','YYYY-MM-DD') , TO_DATE('2024-06-05','YYYY-MM-DD'),16,7);
INSERT INTO tblSubjectList VALUES (43, 8,1, TO_DATE('2023-10-26','YYYY-MM-DD') , TO_DATE('2023-12-27','YYYY-MM-DD'),23,8);
INSERT INTO tblSubjectList VALUES (44, 8,2, TO_DATE('2023-12-28','YYYY-MM-DD') , TO_DATE('2024-01-29','YYYY-MM-DD'),5,8);
INSERT INTO tblSubjectList VALUES (45, 8,4, TO_DATE('2024-01-30','YYYY-MM-DD') , TO_DATE('2024-02-26','YYYY-MM-DD'),1,8);
INSERT INTO tblSubjectList VALUES (46, 8,33, TO_DATE('2024-02-27','YYYY-MM-DD') , TO_DATE('2024-03-30','YYYY-MM-DD'),9,8);
INSERT INTO tblSubjectList VALUES (47, 8,25, TO_DATE('2024-03-31','YYYY-MM-DD') , TO_DATE('2024-04-27','YYYY-MM-DD'),39,8);
INSERT INTO tblSubjectList VALUES (48, 8,19, TO_DATE('2024-04-28','YYYY-MM-DD') , TO_DATE('2024-05-21','YYYY-MM-DD'),30,8);
INSERT INTO tblSubjectList VALUES (49, 9,1, TO_DATE('2023-09-25','YYYY-MM-DD') , TO_DATE('2023-12-15','YYYY-MM-DD'),13,9);
INSERT INTO tblSubjectList VALUES (50, 9,2, TO_DATE('2023-12-16','YYYY-MM-DD') , TO_DATE('2024-01-14','YYYY-MM-DD'),5,9);
INSERT INTO tblSubjectList VALUES (51, 9,4, TO_DATE('2024-01-15','YYYY-MM-DD') , TO_DATE('2024-02-03','YYYY-MM-DD'),1,9);
INSERT INTO tblSubjectList VALUES (52, 9,21, TO_DATE('2024-02-04','YYYY-MM-DD') , TO_DATE('2024-02-24','YYYY-MM-DD'),36,9);
INSERT INTO tblSubjectList VALUES (53, 9,33, TO_DATE('2024-02-25','YYYY-MM-DD') , TO_DATE('2024-03-28','YYYY-MM-DD'),9,9);
INSERT INTO tblSubjectList VALUES (54, 9,6, TO_DATE('2024-03-29','YYYY-MM-DD') , TO_DATE('2024-04-23','YYYY-MM-DD'),32,9);
INSERT INTO tblSubjectList VALUES (55, 10,1, TO_DATE('2023-01-05','YYYY-MM-DD') , TO_DATE('2023-02-16','YYYY-MM-DD'),17,10);
INSERT INTO tblSubjectList VALUES (56, 10,2, TO_DATE('2023-02-17','YYYY-MM-DD') , TO_DATE('2023-03-03','YYYY-MM-DD'),22,10);
INSERT INTO tblSubjectList VALUES (57, 10,4, TO_DATE('2023-03-04','YYYY-MM-DD') , TO_DATE('2023-04-01','YYYY-MM-DD'),1,10);
INSERT INTO tblSubjectList VALUES (58, 10,16, TO_DATE('2023-04-02','YYYY-MM-DD') , TO_DATE('2023-05-10','YYYY-MM-DD'),32,10);
INSERT INTO tblSubjectList VALUES (59, 10,22, TO_DATE('2023-05-11','YYYY-MM-DD') , TO_DATE('2023-06-04','YYYY-MM-DD'),40,10);
INSERT INTO tblSubjectList VALUES (60, 10,30, TO_DATE('2023-06-05','YYYY-MM-DD') , TO_DATE('2023-07-04','YYYY-MM-DD'),38,10);
INSERT INTO tblSubjectList VALUES (61, 11,1, TO_DATE('2022-12-12','YYYY-MM-DD') , TO_DATE('2023-01-15','YYYY-MM-DD'),23,6);
INSERT INTO tblSubjectList VALUES (62, 11,2, TO_DATE('2023-01-16','YYYY-MM-DD') , TO_DATE('2023-02-18','YYYY-MM-DD'),5,1);
INSERT INTO tblSubjectList VALUES (63, 11,4, TO_DATE('2023-02-19','YYYY-MM-DD') , TO_DATE('2023-03-21','YYYY-MM-DD'),1,4);
INSERT INTO tblSubjectList VALUES (64, 11,15, TO_DATE('2023-03-22','YYYY-MM-DD') , TO_DATE('2023-04-29','YYYY-MM-DD'),29,3);
INSERT INTO tblSubjectList VALUES (65, 11,17, TO_DATE('2023-04-30','YYYY-MM-DD') , TO_DATE('2023-05-27','YYYY-MM-DD'),37,9);
INSERT INTO tblSubjectList VALUES (66, 11,28, TO_DATE('2023-05-28','YYYY-MM-DD') , TO_DATE('2023-07-11','YYYY-MM-DD'),35,6);
INSERT INTO tblSubjectList VALUES (67, 12,1, TO_DATE('2022-12-13','YYYY-MM-DD') , TO_DATE('2023-01-04','YYYY-MM-DD'),18,10);
INSERT INTO tblSubjectList VALUES (68, 12,2, TO_DATE('2023-01-05','YYYY-MM-DD') , TO_DATE('2023-01-27','YYYY-MM-DD'),22,9);
INSERT INTO tblSubjectList VALUES (69, 12,4, TO_DATE('2023-01-28','YYYY-MM-DD') , TO_DATE('2023-02-23','YYYY-MM-DD'),1,9);
INSERT INTO tblSubjectList VALUES (70, 12,5, TO_DATE('2023-02-24','YYYY-MM-DD') , TO_DATE('2023-03-20','YYYY-MM-DD'),26,8);
INSERT INTO tblSubjectList VALUES (71, 12,20, TO_DATE('2023-03-21','YYYY-MM-DD') , TO_DATE('2023-04-24','YYYY-MM-DD'),34,8);
INSERT INTO tblSubjectList VALUES (72, 12,11, TO_DATE('2023-04-25','YYYY-MM-DD') , TO_DATE('2023-05-26','YYYY-MM-DD'),21,7);


--사물함
INSERT INTO tblLocker VALUES (lockerSeq,studentSeq);
INSERT INTO tblRecommendBook VALUES ('사물함번호', '교육생번호');

--추천도서
INSERT INTO tblRecommendBook VALUES (recommendBookSeq,bookName,author,publisherName,bookLevel,relatedSubject);
INSERT INTO tblRecommendBook VALUES (도서번호, '도서명','저자','출판사명',난이도,'연계과목');

INSERT INTO tblRecommendBook VALUES (1, 'Java의 정석','남궁성','도우출판',4,'JAVA');
INSERT INTO tblRecommendBook VALUES (2, '이것이 자바다','"신용권',' 임경균"',한빛미디어,'4');
INSERT INTO tblRecommendBook VALUES (3, '자바의 정석 기초편','남궁성','도우출판',2,'JAVA');
INSERT INTO tblRecommendBook VALUES (4, 'Do it! 알고리즈 코딩 테스트 자바 편','김종관','이지스퍼블리싱',3,'JAVA');
INSERT INTO tblRecommendBook VALUES (5, '그림으로 배우는 Java Programming','Mana Takahash','영진닷',1,'JAVA');
INSERT INTO tblRecommendBook VALUES (6, 'Java가 보이는 그림책','"ANK Co.',' Ltd."',성안당,'1');
INSERT INTO tblRecommendBook VALUES (7, '어서와 Java는 처음이지!','천인국','인피니티북스',3,'JAVA');
INSERT INTO tblRecommendBook VALUES (8, '객체지향의 사실과 오해','조영호','위키북스',5,'JAVA');
INSERT INTO tblRecommendBook VALUES (9, 'Do it! 오라클로 배우는 데이터베이스 입문','이지훈','이지스퍼블리싱',3,'Oracle');
INSERT INTO tblRecommendBook VALUES (10, '이것이 오라클이다','우재남','한빛미디어',4,'Oracle');
INSERT INTO tblRecommendBook VALUES (11, '오라클로 배우는 데이터베이스 개론과 실습','"박우창','남송휘',이현룡",'한빛아카데미');
INSERT INTO tblRecommendBook VALUES (12, '김상형의 SQL 정복','김상형','한빛미디어',3,'Oracle');
INSERT INTO tblRecommendBook VALUES (13, '뇌를 자극하는 오라클 프로그래밍 SQL&PL/SQL','홍형경','한빛미디어',3,'Oracle');
INSERT INTO tblRecommendBook VALUES (14, '코딩 자율학습 HTML + CSS + 자바스크립트','김기수','길벗',2,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (15, 'Do it! HTML+CSS+자바스크립트 웹 표준의 정석','고경희','이지스퍼블리싱',2,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (16, '완성된 웹사이트로 배우는 HTML&CSS 웹 디자인','Mana','한빛미디어',2,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (17, '코어 자바스크립트','정재남','위키북스',3,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (18, '모던 자바스크립트 핵심 가이드','알베르토 몬탈레시','한빛미디어',3,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (19, '러닝 자바스크립트','이선브라운','한빛미디어',4,'HTML/CSS/JavaScript');
INSERT INTO tblRecommendBook VALUES (20, '최범균의 JSP 2.3 웹 프로그래밍','최범균','가메출판사',4,'Servlet/JSP');
INSERT INTO tblRecommendBook VALUES (21, '뇌를 자극하는 JSP & Servlet','김윤명','한빛미디어',3,'Servlet/JSP');
INSERT INTO tblRecommendBook VALUES (22, 'Head First Servlets & JSP','케이시시에라','한빛미디어',3,'Servlet/JSP');
INSERT INTO tblRecommendBook VALUES (23, '웹 개발자를 위한 Spring 4.0 프로그래밍','최범균','가메출판사',4,'Spring');
INSERT INTO tblRecommendBook VALUES (24, '코드로 배우는 스프링 웹 프로젝트','구멍가게 코딩단','남가람북스',3,'Spring');
INSERT INTO tblRecommendBook VALUES (25, '스프링 5 레시피','"마틴 데이넘',' 다니엘 루비오', 조시 롱 ",'한빛미디어');
INSERT INTO tblRecommendBook VALUES (26, '스프링 부트 핵심 가이드','장정우','위키북스',3,'Spring Boot');
INSERT INTO tblRecommendBook VALUES (27, '코드로 배우는 스프링 부트 웹 프로젝트','구멍가게코딩단','남가람북스',3,'Spring Boot');


