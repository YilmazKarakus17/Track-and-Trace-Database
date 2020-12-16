------------------------------------------------- Information -------------------------------------------------
-- Same group as CW-2 group - We did the scenario on pandemic track and trace
--Yilmaz Karakus 190245234
--Ayushi Khetani 190222176 
--Max Jayatillake 180047619
--Edgar E. A. Kager 190073671
------------------------------------------------- Droppping Tables -------------------------------------------------
DROP TABLE Trace;
DROP TABLE Place;
DROP TABLE Test;
DROP TABLE Person;
DROP TABLE Statement;
DROP TABLE District;
DROP TABLE County;
DROP TABLE Country;
DROP TABLE Minister;
DROP TABLE Bubble;

------------------------------------------------- Creating tables -------------------------------------------------
CREATE TABLE Bubble(BubbleID INT PRIMARY KEY);

CREATE TABLE Minister(
    MinisterID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Country(
    CountryName VARCHAR(255) PRIMARY KEY,
    MinisterID INT UNIQUE,
    CONSTRAINT fk_Minister FOREIGN KEY (MinisterID) REFERENCES Minister(MinisterID)
);

CREATE TABLE County(
    CountyID INT PRIMARY KEY,
    CountyName VARCHAR(255) NOT NULL,
    CountryName VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Country FOREIGN KEY (CountryName) REFERENCES Country(CountryName)
);    

CREATE TABLE District( 
    DistrictID INT PRIMARY KEY,
    DistrictName VARCHAR(255) NOT NULL,
    NumberOfInfections INT NOT NULL,
    Population INT NOT NULL,
    Tier INT,
    CountyID INT NOT NULL,
    CONSTRAINT fk_County FOREIGN KEY (CountyID) REFERENCES County(CountyID)
);

CREATE TABLE Statement(
    StatementID INT PRIMARY KEY,
    StatementGiven VARCHAR(500) NOT NULL,
    StatementDate DATE NOT NULL,
    MinisterID INT NOT NULL,
    FOREIGN KEY (MinisterID) REFERENCES Minister(MinisterID)
);


CREATE TABLE Person(
    PersonID INT PRIMARY KEY,
    Gender VARCHAR(55) NOT NULL,
    DOB DATE NOT NULL,
    Ethnicity VARCHAR(55) NOT NULL,
    Nationality VARCHAR(255) NOT NULL,
    Profession VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(13) NOT NULL,
    DistrictID INT NOT NULL,
    BubbleID INT NOT NULL,
    FOREIGN KEY (BubbleID) REFERENCES Bubble(BubbleID),
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID),
    CONSTRAINT person_email_chk 
        CHECK(Email LIKE '%@%')
);

CREATE TABLE Test(
    TestID INT PRIMARY KEY,
    TestingFor VARCHAR(255) NOT NULL,
    Outcome VARCHAR(10),
    TestDate DATE NOT NULL,
    PersonID INT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE Place(
    PlaceID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Line1 VARCHAR(55) NOT NULL,
    Line2 VARCHAR(55),
    Postcode VARCHAR(10) NOT NULL,
    Phone VARCHAR(13) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    DistrictID INT NOT NULL,
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID),
    CONSTRAINT place_email_chk
        CHECK(Email LIKE '%@%')
);


CREATE TABLE Trace(
    TraceDate DATE NOT NULL,
    PlaceID INT NOT NULL,
    FOREIGN KEY (PlaceID) REFERENCES Place(PlaceID),
    PersonID INT NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

------------------------------------------------- Inserting Values -------------------------------------------------
--Inserting into Bubble
INSERT INTO Bubble VALUES (1);
INSERT INTO Bubble VALUES (2);
INSERT INTO Bubble VALUES (3);
INSERT INTO Bubble VALUES (4);
INSERT INTO Bubble VALUES (5);
INSERT INTO Bubble VALUES (6);
INSERT INTO Bubble VALUES (7);
INSERT INTO Bubble VALUES (8);

--Inserting into Minister
INSERT INTO Minister (MinisterID, Name) VALUES (1,'Edward Argar');
INSERT INTO Minister (MinisterID, Name) VALUES (2,'Vaughan Gething');
INSERT INTO Minister (MinisterID, Name) VALUES (3,'Jeane Freeman');
INSERT INTO Minister (MinisterID, Name) VALUES (4, 'An tAire Sláinte');


-- Inserting into Statement
INSERT INTO Statement VALUES
    (1, 'We are prepared!', TO_DATE('07-FEB-2020', 'DD-MON-YYYY'), 1);
INSERT INTO Statement VALUES
    (2, 'We will get through this pandemic', TO_DATE('20-FEB-2020', 'DD-MON-YYYY'), 2);
INSERT INTO Statement VALUES
    (3, 'WE GOT THIS', TO_DATE('22-FEB-2020','DD-MON-YYYY'), 3);
INSERT INTO Statement VALUES
    (4, 'Follow the guidelines', TO_DATE('22-FEB-2020','DD-MON-YYYY'), 1);
INSERT INTO Statement VALUES
    (5, 'We were NOT prepared!', TO_DATE('27-APR-2020', 'DD-MON-YYYY'), 1);
INSERT INTO Statement VALUES
    (6, 'Not everyone is following the guidelines', TO_DATE('22-MAY-2020','DD-MON-YYYY'), 4);
INSERT INTO Statement VALUES
    (7, 'People need to keep their distance', TO_DATE('25-MAY-2020','DD-MON-YYYY'), 4);
INSERT INTO Statement VALUES
    (8, 'Across the world, economic output has plummeted and a million and a half people have died!', TO_DATE('07-SEP-2020', 'DD-MON-YYYY'), 1);
INSERT INTO Statement VALUES
    (9, 'It is almost a year since humanity has been tormented by COVID', TO_DATE('20-OCT-2020', 'DD-MON-YYYY'), 2);

-- Inserting into Country
INSERT INTO Country VALUES
 ('England', 1);
INSERT INTO Country VALUES
 ('Wales', 2);
INSERT INTO Country VALUES
 ('Scotland', 3);
INSERT INTO Country VALUES
 ('Ireland', 4);
 
-- Inserting into County
INSERT INTO County VALUES
 (1, 'Greater London', 'England');
INSERT INTO County VALUES
 (2, 'Surrey', 'England');
INSERT INTO County VALUES
 (3, 'Gwent', 'Wales');
INSERT INTO County VALUES
 (4, 'Dyfed', 'Wales');
INSERT INTO County VALUES
 (5, 'Angus', 'Scotland');
INSERT INTO County VALUES
 (6, 'Aberdeen', 'Scotland');
INSERT INTO County VALUES
 (7, 'Kerry', 'Ireland');
INSERT INTO County VALUES
 (8, 'Cork', 'Ireland');

--Inserting Districts
    --Greater London Districts
INSERT INTO District VALUES
    (1, 'Hornsey', 2500, 12659, 2, 1);
INSERT INTO District VALUES
    (2, 'Wood Green', 5225, 28453, 1, 1);
INSERT INTO District VALUES
    (3, 'Edmonton', 21458, 82472, 3, 1);
    --Surrey Districts
INSERT INTO District VALUES
    (4, 'Spelthorne District', 5225, 99334, 1, 2);
INSERT INTO District VALUES
    (5, 'Runnymede District', 25052, 88000, 3, 2);
    --Gwent Districts
INSERT INTO District VALUES
    (6, 'Newport', 2158, 9300, 3, 3);
INSERT INTO District VALUES
    (7, 'Islwyn', 1300, 10508, 1, 3);
    --Dyfed Districts
INSERT INTO District VALUES
    (8, 'Carmarthen', 5423, 13760, 2, 4);    
INSERT INTO District VALUES
    (9, 'Llanelli', 15423, 49591, 3, 4);    
    --Angus Districts
INSERT INTO District VALUES
    (10, 'Forfar', 1250, 14048, 1, 5);    
    --Aberdeen Districts
INSERT INTO District VALUES
    (11, 'Altens', 500, 5025, 2, 6);    
    --Kerry Districts
INSERT INTO District VALUES
    (12, 'Kenmare', 255, 2376, 1, 7);    
    -- Cork Districts   
INSERT INTO District VALUES
    (13, 'Macroom', 230, 3765, 1, 8);    
     

--Inserting into Person
INSERT INTO Person VALUES (1,'Female',TO_DATE('18-09-1998','DD-MM-YYYY'),'White','British','Nurse','AnnieSmith5948@outlook.com','07641699379',1,1);
INSERT INTO Person VALUES (2,'Female',TO_DATE('18-07-1999','DD-MM-YYYY'),'White','British','Engineer','AnneSmith9254@outlook.com','07285588963',2,1);
INSERT INTO Person VALUES (3,'Female',TO_DATE('15-12-1984','DD-MM-YYYY'),'White','British','Author','AmberSmith7034@outlook.com','07814257599',3,1);
INSERT INTO Person VALUES (4,'Male',TO_DATE('15-10-1975','DD-MM-YYYY'),'Black','French','Nurse','JacquesSmith3978@outlook.com','07836813151',3,1);
INSERT INTO Person VALUES (5,'Female',TO_DATE('15-05-1990','DD-MM-YYYY'),'Asian','British','Builder','AnnieJohnson5726@outlook.com','07826574247',4,2);
INSERT INTO Person VALUES (6,'Male',TO_DATE('20-01-1982','DD-MM-YYYY'),'Other','British','Author','JosephWilliams7792@outlook.com','07597793471',6,3);
INSERT INTO Person VALUES (7,'Male',TO_DATE('03-04-1997','DD-MM-YYYY'),'Other','German','Engineer','JohnsonJohnson8361@outlook.com','07235313879',8,4);
INSERT INTO Person VALUES (8,'Female',TO_DATE('02-01-1996','DD-MM-YYYY'),'Other','British','Engineer','AnnieJackson1974@outlook.com','07223338137',8,4);
INSERT INTO Person VALUES (9,'Male',TO_DATE('13-09-1987','DD-MM-YYYY'),'White','British','Salesman','JosephWilliams7605@outlook.com','07888687758',9,5);
INSERT INTO Person VALUES (10,'Female',TO_DATE('02-04-1993','DD-MM-YYYY'),'Black','British','Salesman','AmandaJohnson4329@outlook.com','07938756284',9,5);
INSERT INTO Person VALUES (11,'Male',TO_DATE('01-12-1987','DD-MM-YYYY'),'White','British','Mechanic','GeoffWilliams6590@outlook.com','07167271832',10,6);
INSERT INTO Person VALUES (12,'Male',TO_DATE('09-10-1985','DD-MM-YYYY'),'Black','British','Mechanic','MohammedJohnson2250@outlook.com','07379511547',11,6);
INSERT INTO Person VALUES (13,'Female',TO_DATE('05-07-1982','DD-MM-YYYY'),'White','British','Nurse','AeshaBrown828@outlook.com','07394747375',7,3);
INSERT INTO Person VALUES (14,'Female',TO_DATE('02-11-1961','DD-MM-YYYY'),'White','German','Nurse','AnneJohnson5520@outlook.com','07844726378',5,2);
INSERT INTO Person VALUES (15,'Male',TO_DATE('20-10-1992','DD-MM-YYYY'),'Other','British','Salesman','JosephBrown3584@outlook.com','07169637416',12,7);
INSERT INTO Person VALUES (16,'Male',TO_DATE('15-12-2000','DD-MM-YYYY'),'White','British','Nurse','MohammedBrown3353@outlook.com','07785746199',6,3);
INSERT INTO Person VALUES (17,'Male',TO_DATE('01-01-1988','DD-MM-YYYY'),'Hispanic','British','Doctor','JackJohnson1930@outlook.com','07715665221',13,8);
INSERT INTO Person VALUES (18,'Female',TO_DATE('20-07-1991','DD-MM-YYYY'),'Black','British','Doctor','EmmaWhite9718@outlook.com','07919932576',12,7);
INSERT INTO Person VALUES (19,'Female',TO_DATE('20-09-1996','DD-MM-YYYY'),'White','British','Manager','MaryWhite8457@outlook.com','07185293394',13,8);
INSERT INTO Person VALUES (20,'Female',TO_DATE('20-10-1996','DD-MM-YYYY'),'Asian','British','Manager','SallySingh@outlook.com','07185293999',13,8);
INSERT INTO Person VALUES (21,'Male',TO_DATE('10-09-1983','DD-MM-YYYY'),'Asian','British','Engineer','RajPatel@outlook.com','07185293444',13,8);
INSERT INTO Person VALUES (22,'Female',TO_DATE('24-10-1987','DD-MM-YYYY'),'Black','German','Manager','SalmaSyed@outlook.com','07185293239',4,2);
INSERT INTO Person VALUES (23,'Male',TO_DATE('27-09-1993','DD-MM-YYYY'),'Asian','British','Nurse','JayKhan@outlook.com','07185299464',4,2);

--Inserting the Tests
INSERT INTO Test VALUES
    (1,'Covid-19','Positive',TO_DATE('25-11-2020','DD-MM-YYYY'),1);
INSERT INTO Test VALUES
    (2,'Covid-19','Negative',TO_DATE('26-11-2020','DD-MM-YYYY'),5);   
INSERT INTO Test VALUES
    (3,'Covid-19','Negative',TO_DATE('27-11-2020','DD-MM-YYYY'),16);  
INSERT INTO Test VALUES
    (4,'Covid-19','Positive',TO_DATE('28-11-2020','DD-MM-YYYY'),8);
INSERT INTO Test VALUES
    (5,'Covid-19','Negative',TO_DATE('29-11-2020','DD-MM-YYYY'),9);   
INSERT INTO Test VALUES
    (6,'Covid-19','Positive',TO_DATE('07-12-2020','DD-MM-YYYY'),12);
INSERT INTO Test VALUES
    (7,'Covid-19','Negative',TO_DATE('07-12-2020','DD-MM-YYYY'),15);  
INSERT INTO Test VALUES
    (8,'Covid-19','Negative',TO_DATE('08-12-2020','DD-MM-YYYY'),17);
INSERT INTO Test VALUES
    (9,'Covid-19','Negative',TO_DATE('09-12-2020','DD-MM-YYYY'),2);   
INSERT INTO Test VALUES
    (10,'Covid-19','Positive',TO_DATE('10-12-2020','DD-MM-YYYY'),7);
INSERT INTO Test VALUES
    (11,'Covid-19','Positive',TO_DATE('10-12-2020','DD-MM-YYYY'),20);
INSERT INTO Test VALUES
    (12,'Covid-19','Negative',TO_DATE('11-12-2020','DD-MM-YYYY'),21);
INSERT INTO Test VALUES
    (13,'Covid-19','Positive',TO_DATE('11-12-2020','DD-MM-YYYY'),17);
INSERT INTO Test VALUES
    (14,'Covid-19','Negative',TO_DATE('11-12-2020','DD-MM-YYYY'),3);
INSERT INTO Test VALUES
    (15,'Covid-19','Positive',TO_DATE('12-12-2020','DD-MM-YYYY'),22);
INSERT INTO Test VALUES
    (16,'Covid-19','Negative',TO_DATE('12-12-2020','DD-MM-YYYY'),23);

--Inserting Places
INSERT INTO Place VALUES
    (1,'Johnsons Restaurant','1 Green Street','London','N8 7DZ','07118286937','JohnsonsRestaurant@outlook.com',1);
INSERT INTO Place VALUES
    (2,'Johnsons Bar','42 Craft Street','London','N15 7AZ','07255841593','JohnsonsBar@outlook.com',2);
INSERT INTO Place VALUES
    (3,'Johnsons Club','Grate Road','London','N9 7DZ','07627329863','JohnsonsClub@outlook.com',3);
INSERT INTO Place VALUES
    (4,'The Club','Wales Road','Surrey','TW15','07112999878','TheClub@outlook.com',4);
INSERT INTO Place VALUES
    (5,'The Bar','Bar Road','Surrey','TW20','07734747294','TheBar@outlook.com',5);
INSERT INTO Place VALUES
    (6,'Jacks Restaurant','52 Jacks Street','Newport','NP10','07988884513','JacksRestaurant@outlook.com',6);
INSERT INTO Place VALUES
    (7,'Johns Bar','Bond Road','Islwyn','NP12 2DB','07954877197','JohnsBar@outlook.com',7);
INSERT INTO Place VALUES
    (8,'Jacks Club','Grateful Road','Carmarthen','SA31','07517355838','JacksClub@outlook.com',8);
INSERT INTO Place VALUES
    (9,'Johns Club','3 Walking Street','Llanelli','SA14','07366969777','JohnsClub@outlook.com',9);
INSERT INTO Place VALUES
    (10,'Tims Bar','Tims Road','Forfar','DD8','07734747294','TimsBar@outlook.com',10);
INSERT INTO Place VALUES
    (11,'Jerrys Club','12 Famous Street','Altens','AB12 3TT','07845735523','JerrysClub@outlook.com',11);
INSERT INTO Place VALUES
    (12,'Jerrys Bowling Club','Bowling Road','Kenmare','V93 A009','07435193297','JerrysBowlingClub@outlook.com',12);
INSERT INTO Place VALUES
    (13,'Raising the Bar','Kenmare Road','Kenmare','PH15','07934822677','RaisingtheBar@outlook.com',13);    
    
--Inserting the Traces
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),1,1);
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),1,2);
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),1,5);
--
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),5,4);
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),5,3);
INSERT INTO Trace VALUES
    (TO_DATE('23-11-2020','DD-MM-YYYY'),5,14);
--
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),9,8);
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),9,7);
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),9,9);
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),9,10);
--
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),1,4);
INSERT INTO Trace VALUES
    (TO_DATE('27-11-2020','DD-MM-YYYY'),1,3);
------------------------------------------------- Eight SQL queries -------------------------------------------------
    --Basic Queries
--Show all districts with Tier level 3 and a population over 10,000
SELECT DistrictID, DistrictName, Population, Tier FROM District WHERE Tier = 3 AND Population > 10000;
/*
|  District ID  |  District Name        |   Population  |   Tier    |
------------------------------------------------------------------------
|       3       |   Edmonton            |   82472       |   3       | 
|       5       |   Runnymede District  |   88000       |   3       |
|       9       |   Llanelli            |   49591       |   3       |
*/

--Show all the people who's professions are Nurses and are born before 1970
SELECT * FROM Person WHERE Profession = 'Nurse' AND DOB < TO_DATE('1970','YYYY');
/*
|Person ID|Gender|  DOB         |Ethnicity|Nationality|Profession|          Email               |Phone      |DistrictId|BubbleID|
----------------------------------------------------------------------------------------------------------------------------------
|14       |Female|  02-NOV-61   |White    |German      |Nurse    |AnneJohnson5520@outlook.com   |07844726378|   5       |2      |
*/


    --Medium Queries
--show the total amount of visitors per place and order it in descending order
SELECT DISTINCT T.PlaceID, P.Name, COUNT(T.PersonID) AS Amount_of_Visitors FROM Trace T, Place P WHERE P.PlaceID = T.PlaceID
    GROUP BY T.PlaceID, P.Name 
    ORDER BY Amount_of_Visitors DESC;
/*
|Place ID | Name               | Amount_Of_Vistors|
----------------------------------------------------
|1        |Johnsoms Restaurant | 5                | 
|2        |Johns Club          | 4                | 
|4        |The Bar             | 3                | 
*/

--Show the PersonID and bubbleID, DistrictID, CountyName and CountryName of people living in England
SELECT P.PersonID, P.BubbleID, D.DistrictName, C.CountyName, Country.CountryName  
    FROM Person P, District D, County C, Country 
    WHERE 
        P.DistrictID = D.DistrictID 
        AND D.CountyID = C.CountyID 
        AND C.CountryName = Country.CountryName 
        AND Country.CountryName = 'England';
/*
|PersonID | BubbleID |      District Name   |      CountryName |CountryName|
--------------------------------------------------------------------------------
|1        | 1        |Hornsey               |Greater London     |England   |
|2        | 1        |Wood Green            |Greater London     |England   |
|3        | 1        |Edmonton              |Greater London     |England   |
|4        | 1        |Edmonton              |Greater London     |England   |
|5        | 2        |Spelthorne District   |Surrey             |England   |
|14       | 2        |Runnymede District    |Surrey             |England   |
|22       | 2        |Spelthorne District   |Surrey             |England   |
|23       | 2        |Spelthorne District   |Surrey             |England   |
*/

--Show all the statements made by England's Minister between the dates FEB-APR in ascending order of statements
SELECT DISTINCT C.CountryName, M.Name, S.StatementID, S.StatementGiven FROM STATEMENT S, Country C, Minister M 
    WHERE S.MinisterID = C.MinisterID AND S.MinisterID = M.MinisterID AND CountryName = 'England' AND StatementDate BETWEEN TO_DATE('02','MM') AND TO_DATE('05','MM')
    ORDER BY S.StatementID ASC;
/*
|COUNTRYNAME|    NAME    |STATEMENTID|STATEMENTGIVEN       |
|----------------------------------------------------------|
|ENGLAND    |EDWARD ARGAR|1	      |We are prepared!     |
|ENGLAND    |EDWARD ARGAR|4	      |Follow the guidelines|
|ENGLAND    |EDWARD ARGAR|5	      |We were NOT Prepared!|
|----------------------------------------------------------|
*/


    --Advanced Queries
--Show average amount of people in bubble rounded to the nearest integer
DROP VIEW numOfPeople_per_Bubble;
CREATE VIEW numOfPeople_per_Bubble AS SELECT P.BubbleID, COUNT(P.PersonID) AS NumOfPeople FROM Person P GROUP BY P.BubbleID;
SELECT ROUND(AVG(NumOfPeople)) AS AVG_NumOfPeople_Per_Bubble FROM numOfPeople_per_Bubble;
/*
|AVG_NUMOFPEOPLE_PER_BUBBLE	|
|------------------------------|
|3				|
|------------------------------|
 */

-- Find the contact details of all the people who went to the same place [on the same date] as a person who tested positive for covid-19 including the infected people
DROP VIEW infected_people_view;
CREATE VIEW infected_people_view AS SELECT T.PersonID FROM Test T WHERE T.Outcome = 'Positive' AND T.TestingFOR = 'Covid-19';
DROP VIEW Places_Dates_Visited;
CREATE VIEW Places_Dates_Visited AS SELECT T.PlaceID, T.TraceDate FROM Trace T WHERE T.PersonID = ANY(SELECT PersonID FROM infected_people_view);
SELECT DISTINCT P.PersonID, P.Email, P.Phone FROM Person P, Trace T, Places_Dates_Visited V WHERE T.PlaceID = V.PlaceID AND T.TraceDate = V.TraceDate AND P.PersonID = T.PersonID;
/*
|   PERSONID   |                EMAIL               |        PHONE      |
|-----------------------------------------------------------------------|
|       8      |    AnnieJackson1974@outlook.com    |    07223338137    |
|       2      |    AnneSmith9254@outlook.com       |    07285588963    |
|       10     |    AmandaJohnson4329@outlook.com   |    07938756284    |
|       5      |    AnnieJohnson5726@outlook.com    |    07826574247    |
|       7      |    JohnsonJohnson8361@outlook.com  |    07235313879    |
|       1      |    AnnieSmith5948@outlook.com      |    07641699379    |
|       9      |    JosephWilliams7605@outlook.com  |    07888687758    |
*/

--Show the percentage breakdown of registered people on the system who test positive for covid-19 by ethnicity; sorted by most affected to least
DROP VIEW infected_people_view;
CREATE VIEW infected_people_view AS SELECT T.PersonID FROM Test T WHERE T.Outcome = 'Positive' AND T.TestingFOR = 'Covid-19';
DROP VIEW ethnicities_affected;
CREATE VIEW ethnicities_affected AS SELECT  P.ethnicity, ROUND((COUNT(P.PersonID)/(SELECT COUNT(Person.PersonID) FROM Person) *100),2) as percentage_of_population FROM Person P
WHERE P.PersonID = ANY (SELECT * FROM infected_people_view) GROUP by P.ethnicity ORDER BY percentage_of_population;
SELECT * FROM ethnicities_affected;
/*
|ETHNICITY|PERCENTAGE_OF_POPULATION|
|----------------------------------|
|Hispanic |4.35                    |
|Asian    |4.35                    |
|White    |4.35                    |
|Other    |8.7                     |
|Black    |8.7                     |
*/