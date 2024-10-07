USE bloodbank;
CREATE TABLE bb_manager(m_id int NOT NULL PRIMARY KEY,
 mname varchar(100)NOT NULL,
 mphno bigint
 );
 
 INSERT into bb_manager VALUES(101,'mani',9693959671),
 (102,'vicky',9693959672),
 (103,'vishnu',9693959673),
 (104,'light',9693959674),
 (105,'mikasa',9693959675);
 
INSERT into bb_manager VALUES (106,'goku',9693959676),
(107,'itachi',9693959677),
(108,'naruto',9693959678),
(109,'ludd',9693959679),
(110,'levi',9693959680);

CREATE TABLE recording_staff(reco_ID  int NOT NULL PRIMARY KEY,
reco_name varchar(100)NOT NULL,
reco_phno bigint
);


INSERT into recording_staff VALUES(101012,'tanjiro',4044846553);
INSERT into recording_staff VALUES(101112,'zenisu',4045856553),
	(101212,'inosuke',4045806553),
    (101312,'mitsuri',4045806553),
    (101412,'nezuko',4045806553);
 INSERT into recording_staff VALUES(101512,'muzan', 4045806553),
 (101612,'akaza',4045806553),
 (101712,'tengen',4045816553),
 (101812,'rengoko',4045826553),
 (101912,'kokushibo',4045836553);
 
SELECT *  FROM recording_staff;

CREATE TABLE city(	city_ID int NOT NULL PRIMARY KEY,
  city_name varchar(100) NOT NULL
  );
  
  INSERT into  city VALUES(1100,'asgard'),
  (1200,'paradis'),
  (1300,'marley'),
  (1400,'wakanda'),
  (1500,'valhalla'),
  (1600,'madripoor'),
  (1700,'hogwarts'),
  (1800,'sokovia'),
  (1900,'kamar-taj'),
  (2000,'gotham');
  
SELECT *FROM city;

CREATE TABLE blood_donor(bd_ID  int NOT NULL PRIMARY KEY,
bd_name varchar(100)NOT NULL,
bd_age varchar(100),
bd_sex varchar(100),
bd_bgroup varchar(10),
bd_reg_data date,
reco_ID int NOT NULL,
city_ID int NOT NULL,
FOREIGN KEY(reco_ID) REFERENCES recording_staff(reco_ID),
FOREIGN KEY(city_ID) REFERENCES city(city_ID)
);


INSERT into  blood_donor VALUES(150011,'manonmani',25,'F','o+','2023-07-19',101412,1100),
(150012,'steven',27,'M','A-','2023-08-24',101412,1100),
(150013,'tony',30,'M','AB+','2022-09-28',101212,1200),
(150014,'bruce',45,'F','B+','2015-12-17',101212,1300),
(150015,'harry',35,'F','A+','2014-10-20',101212,1300);

INSERT into  blood_donor VALUES(150016,'vishnu',35,'F','O+','2020-03-31',101212,1500);
SELECT * FROM blood_donor;

CREATE TABLE diseaseFinder(
dfind_ID int NOT NULL PRIMARY KEY,
dfind_name varchar(100)NOT NULL,
dfind_phno bigint
);

INSERT into diseaseFinder VALUES(11,'idiana',9693959681);
INSERT into diseaseFinder VALUES(12,'stepban',9693959682),
(13,'christine',9693959683),
(14,'viktor',9693959679),
(15,'julius',9693959685),
(16,'brutus',9693959687),
(17,'muerdock',9693959688),
(18,'kratos',9693959686);

SELECT * FROM diseaseFinder;

CREATE TABLE bloodspecimen(
specimen_number int NOT NULL,
b_group varchar(10)NOT NULL,
status int,
dfind_ID int NOT NULL,
m_id int NOT NULL,
PRIMARY KEY(specimen_number,b_group),
FOREIGN KEY(m_id) REFERENCES bb_manager(m_id),
FOREIGN KEY(dfind_ID) REFERENCES diseaseFinder(dfind_ID)
);

INSERT into bloodspecimen VALUES(1001,'b+',1,11,101),
(1002,'O+',1,12,102),
(1003,'AB+',1,11,102),
(1004,'O-',1,13,103),
(1005,'A+',0,14,101),
(1006,'A-',1,13,104),
(1007,'AB-',1,15,104);

SELECT * FROM bloodspecimen;
SELECT * FROM diseaseFinder;

-- left outer join
SELECT Specimen_number, b_group, status, dfind_name, dfind_phno from bloodspecimen A left outer join diseasefinder B on A.dfind_id = B.dfind_id;

-- right outer join
SELECT Specimen_number, b_group, status, dfind_name, dfind_phno from bloodspecimen A right outer join diseasefinder B on A.dfind_id = B.dfind_id;

-- inner join
SELECT Specimen_number, b_group, status, dfind_name, dfind_phno from bloodspecimen A inner join diseasefinder B on A.dfind_id = B.dfind_id;

-- crossjoin
select dfind_name, status from diseasefinder cross join bloodspecimen;

-- selfjoin
select Specimen_number, b_group, status, mname, mphno from bloodspecimen A, bb_manager B
where a.m_id=b.m_id;

create view vw_specimen_status as
	SELECT Specimen_number, b_group, status, dfind_name, dfind_phno from bloodspecimen A left outer join diseasefinder B on A.dfind_id = B.dfind_id;
    
select * from vw_specimen_status;

DELIMITER &&  
CREATE PROCEDURE insert_city (IN city_id INT, IN city_name varchar(50))  
BEGIN  
    insert into city VALUES(city_id,city_name);
END &&  
DELIMITER ;  

call insert_city('3000','ariyalur');
select * from city;
select * from city where city_name='ariyalur';