create  database autorentMarijaGorbunova1;
use autorentMarijaGorbunova1;
CREATE TABLE auto1(
autoID int not null Primary key IDENTITY(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
SELECT * FROM auto1

CREATE TABLE mark(
markID int not null Primary key IDENTITY(1,1),
autoMark varchar(30) UNIQUE
);

INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;

CREATE TABLE kaigukast(
kaigukastID int not null Primary key IDENTITY(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;

ALTER TABLE auto1
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto1
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);

CREATE TABLE klient(
klientiID int not null Primary key IDENTITY (1,1),
kliendiNimi varchar(50),
telefon varchar(20),
aadress varchar(50),
soiduKogemus varchar(30)
);

CREATE TABLE tootaja(
tootajaID int not null Primary key IDENTITY (1,1),
tootajaNimi varchar(50),
ametiID int,
);

CREATE TABLE rendiLeping(
lepingID int not null Primary key IDENTITY(1,1),
rendiAlgus date,
rendiLopp date,
klientiID int,
regNumber1 varchar(6),
rendiKestvus int,
hindKokku decimal(5,2),
tootajaID int,
FOREIGN KEY (klientiID) REFERENCES klient(klientiID),
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID),
);

CREATE TABLE auto_laos(

automark varchar(30),
teenindus_aadress varchar(60)
FOREIGN KEY (automark) REFERENCES mark(autoMark) 
);

INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus)
VALUES 
('Mati Maasikas', '555-1234', 'Tartu mnt 123, Tallinn', '10 aastat'),
('Kati Kask', '555-5678', 'Pärnu mnt 45, Pärnu', '5 aastat'),
('Jüri Juurikas', '555-9876', 'Narva mnt 89, Narva', '2 aastat');

INSERT INTO tootaja (tootajaNimi, ametiID)
VALUES 
('Anne Anvelt', 1),
('Peeter Ploom', 2),
('Mari Mets', 1);

INSERT INTO rendiLeping (rendiAlgus, rendiLopp, klientiID, regNumber1, rendiKestvus, hindKokku, tootajaID)
VALUES 
('2024-08-01', '2024-08-10', 1, '123ABC', 10, 500.00, 1),
('2024-08-15', '2024-08-20', 2, '456DEF', 5, 250.00, 2),
('2024-09-01', '2024-09-05', 3, '789GHI', 4, 200.00, 3);

INSERT INTO auto1 (regNumber, markID, varv, v_aasta, kaigukastID, km)
VALUES 
('123ABC', 1, 'Red', 2020, 1, 15000),
('456DEF', 2, 'Blue', 2018, 2, 30000),
('789GHI', 3, 'Black', 2019, 1, 25000);

select * from auto1, mark, kaigukast
where mark.markID=auto1.markID and kaigukast.kaigukastID=auto1.kaigukastID

select * from auto1
INNER JOIN mark ON mark.markID=auto1.markID
INNER JOIN kaigukast ON kaigukast.kaigukastID=auto1.kaigukastID

-- 1 ülesanne
SELECT auto1.regNumber, kaigukast.kaigukast
FROM auto1 INNER JOIN kaigukast ON auto1.kaigukastID = kaigukast.kaigukastID;
--2
SELECT auto1.regNumber, mark.autoMark FROM auto1 INNER JOIN mark ON auto1.markID = mark.markID;
--3
SELECT rendiLeping.regNumber1, auto1.varv, tootaja.tootajanimi
FROM rendiLeping 
INNER JOIN auto1 ON rendiLeping.regNumber1 = auto1.regNumber 
INNER JOIN tootaja ON rendiLeping.tootajaID = tootaja.tootajaID;
--4
SELECT COUNT(regNumber) AS Renditudautosidkokku, SUM(hindKokku) AS HindKokku FROM rendiLeping;

Grant select on autorentMarijaGorbunova1 to tootja;
Grant insert on autorentMarijaGorbunova1 to tootja;