CREATE DATABASE SOMALIA;
USE SOMALIA;

CREATE TABLE village_locations(
village_id INT NOT NULL PRIMARY KEY,
village VARCHAR(30) NOT NULL,
latitude VARCHAR(30),
longitude VARCHAR(30),
total_population INT
);

CREATE TABLE beneficiary_partner_data (
partner_id INT NOT NULL PRIMARY KEY,
partner VARCHAR (30) NOT NULL,
village VARCHAR (30) NOT NULL,
beneficiaries INT,
beneficiary_type VARCHAR(30)
);

CREATE TABLE jurisdiction_hierachy(
id INT NOT NUll PRIMARY KEY,
village VARCHAR(30),
village_type VARCHAR (30),
village_name VARCHAR(30) 
);

INSERT INTO jurisdiction_hierachy(id,village,village_type,village_name)
VALUES 
(1,'Middle Shabelle','Region',NULL),
(2,'Hiraan','Region',NULL),
(3,'Balcad','District','Middle Shabelle'),
(4,'Jowhar','District','Middle Shabelle'),
(5,'Beledweyn','District','Hiraan'),
(6,'Dharkenley','Village','Beledweyn'),
(7,'Bulo-Kahin','Village','Beledweyn'),
(8,'Hilo Kelyo','Village','Beledweyn'),
(9,'Xubow','Village','Beledweyn'),
(10,'Xiintooy','Village','Beledweyn'),
(11,'Dhagax Jebis','Village','Beledweyn'),
(12,'Filtare','Village','Beledweyn'),
(13,'Howl-Wadaag','Village','Beledweyn'),
(14,'Balcad','Village','Balcad'),
(15,'Mareeray','Village','Balcad'),
(16,'Kulmis','Village','Balcad'),
(17,'Sabuun','Village','Jowhar'),
(18,'Bayaxaw','Village','Jowhar');

SELECT * FROM jurisdiction_hierachy;

INSERT INTO beneficiary_partner_data(partner_id,partner,village,beneficiaries,beneficiary_type) 
VALUES
(1,'IRC','Balcad','1450','Individuals'),
(2,'NRC','Balcad','50','Households'),
(3,'SCI','Balcad','1123','Individuals'),
(4,'IMC','Balcad','1245','Individuals'),
(5,'SCI','Mareeray','5200','Individuals'),
(6,'IMC','Mareeray','70','Households'),
(7,'IRC','Mareeray','2100','Individuals'),
(8,'CESVI','Mareeray','1800','Individuals'),
(9,'SCI','Kulmis','1340','Individuals'),
(10,'IMC','Kulmis','55','Households'),
(11,'SCI','Kulmis','4500','Individuals'),
(12,'IMC','Kulmis','1670','Individuals'),
(13,'IMC','Sabuun','1340','Individuals'),
(14,'IRC','Sabuun','66','Households'),
(15,'CESVI','Sabuun','4090','Individuals'),
(16,'SCI','Sabuun','2930','Individuals'),
(17,'IMC','Bayaxaw','2800','Individuals'),
(18,'IRC','Bayaxaw','2100','Individuals'),
(19,'CESVI','Bayaxaw','45','Households'),
(20,'SCI','Bayaxaw','1700','Individuals'),
(21,'SCI','Bayaxawo','5900','Individuals'),
(22,'IMC','Bayaxawo','40','Households'),
(23,'IRC','Bayaxawo','1500','Individuals'),
(24,'CESVI','Bayaxawo','1260','Individuals'),
(25,'CESVI','Dharkenley','7880','Individuals'),
(26,'IRC','Dharkenley','34','Households'),
(27,'SCI','Bulo-Kahin','4300','Individuals'),
(28,'IMC','Bulo-Kahin','4212','Individuals'),
(29,'IRC','Bulo-Kahin','3200','Individuals'),
(30,'IRC','Hilo Kelyo','5212','Individuals'),
(31,'SCI','Hilo Kelyo','25','Households'),
(32,'CESVI','Xubow','2157','Individuals'),
(33,'IMC','Xiintooy','1667','Individuals'),
(34,'IRC','Xiintooy','2667','Individuals'),
(35,'CESVI','Dhagax Jebis','2856','Individuals'),
(36,'CESVI','Filtare','7519','Individuals'),
(37,'CESVI','Howl-Wadaag','6870','Individuals'),
(38,'IMC','Howl-Wadaag','32','Households');

SELECT * FROM beneficiary_partner_data;

INSERT INTO village_locations(village_id, village,latitude,longitude, total_population) 
VALUES
(1,'Dharkenley','4°47''35.40"','45°12''28.80"',12800),
(2,'Bulo-Kahin','4°47''57.00"','45°11''5.70"',9485),
(3,'Hilo Kelyo','4°47''57.00"','45°12''58.60"',5212),
(4,'Xubow','4°46''46.77"','45°12''7.57"',2558),
(5,'Xiintooy','4°44''14.40"','45°13''5.00"',3850),
(6,'Dhagax Jebis','4°44''27.86"','45°12''42.03"',3563),
(7,'Filtare','4°44''20.43"','45°12''27.89"',8000),
(8,'Howl-Wadaag','4°43''50.00"','45°11''58.20"',7525),
(9,'Balcad','2°21.624''','45°23.928''',1500),
(10,'Mareeray','2°23.504''','45°25.200''',7500),
(11,'Kulmis','2°36.761''','45°30.642''',6058),
(12,'Sabuun','2°53.020''','45°32.356''',5483),
(13,'Bayaxaw','2°44.768''','45°29.727''',3000),
(14,'Bayaxawo','2°44.768''','45°29.926''',7560);

SELECT * FROM village_locations;

SELECT * FROM beneficiary_partner_data;

SELECT * FROM jurisdiction_hierachy;

#DISTRICT SUMMARY
CREATE TABLE District_Summary AS
SELECT jh.village AS district_name,
jr.village AS Region_name,
SUM(CASE WHEN bpd.beneficiary_type = 'Households' THEN bpd.beneficiaries * 6 ELSE bpd.beneficiaries END) AS total_individual_beneficiaries,
(SUM(CASE WHEN bpd.beneficiary_type = 'Households' THEN bpd.beneficiaries * 6 ELSE bpd.beneficiaries END) / SUM(vl.total_population)) AS beneficiaries_per_total_population
FROM jurisdiction_hierachy jh
JOIN village_locations vl ON jh.village = vl.village
JOIN beneficiary_partner_data bpd ON vl.village = bpd.village
JOIN jurisdication_hierachy jr ON jh.village_name = jr.village
WHERE jh.village_type = 'Village'
GROUP BY district_name,Region_name;

SELECT * FROM District_Summary;

#PARTENER SUMMARY

CREATE TABLE Partner_Summary AS
SELECT bpd.partner AS partner_name,
COUNT(DISTINCT bpd.village) AS villages_reached,
COUNT(DISTINCT jh.village ) AS districts_reached
FROM beneficiary_partner_data bpd
JOIN village_locations vl ON bpd.village = vl.village
JOIN jurisdiction_hierachy jh ON vl.village = jh.village
WHERE jh.village_type ='Village'
GROUP BY partner_name;

SELECT * FROM Partner_Summary


