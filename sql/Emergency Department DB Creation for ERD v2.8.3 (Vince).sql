DROP DATABASE IF EXISTS MIS_531;
CREATE DATABASE MIS_531;
USE MIS_531;

CREATE TABLE CAMPUSES (
	campusID	INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cmpName		VARCHAR(80) NOT NULL,
	cmpStreet	VARCHAR(60) NOT NULL,
	cmpCity		VARCHAR(40) NOT NULL,
	cmpState	CHAR(2) NOT NULL
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE BUILDINGS (
	buildingID	INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	bldName		VARCHAR(80) NOT NULL,
	campusID	INT UNSIGNED NOT NULL REFERENCES CAMPUSES
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CLASSROOMS (
	clsrmID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	floor		VARCHAR(10) NOT NULL,
	roomNum		VARCHAR(10) NOT NULL,
	capacity	INT UNSIGNED NOT NULL,
	buildingID	INT UNSIGNED NOT NULL REFERENCES BUILDINGS
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CERTCLASSTYPES (
	certID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	certName	VARCHAR(40) NOT NULL,
	certDesc	VARCHAR(255) NOT NULL,
    certType	SET('Instructor', 'Emergency Tech', 'CE Paramedic', 'Registered Nurse') NOT NULL,
	certRenewalPeriod	INT UNSIGNED NOT NULL,
	siRatio		INT UNSIGNED NOT NULL,
    instructorCertID INT UNSIGNED REFERENCES CERTCLASSTYPES
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CERTCLASSPREREQUISITES (
	certID		INT UNSIGNED NOT NULL REFERENCES CERTCLASSTYPES,
	prereqID	INT UNSIGNED NOT NULL REFERENCES CERTCLASSTYPES,
	PRIMARY KEY (certID, prereqID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CERTCLASSES (
	clsID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	clsDatetime	DATETIME,
	clsrmID		INT UNSIGNED NOT NULL REFERENCES CLASSROOMS,
	certID		INT UNSIGNED NOT NULL REFERENCES CERTCLASSTYPES
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE EMPLOYEES (
	empID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	empType		SET('Instructor', 'Emergency Tech', 'CE Paramedic', 'Registered Nurse', 'Other') NOT NULL DEFAULT 'Other',
	empfName	VARCHAR(40) NOT NULL,
	emplName	VARCHAR(40) NOT NULL,
	empPhone	VARCHAR(40) NOT NULL,
	empStreet	VARCHAR(60) NOT NULL,
	empCity		VARCHAR(40) NOT NULL,
	empState	CHAR(2) NOT NULL,
	hireDate	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	currPosition	VARCHAR(40) NOT NULL
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE EMPLOYEETYPES (
empTypeValue	INT UNSIGNED NOT NULL PRIMARY KEY,
empType			VARCHAR(40) NOT NULL 
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CEPARAMEDICS (
	empID			INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	cepLicenseNum	VARCHAR(40) NOT NULL,
	isNationalReg	TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE REGISTEREDNURSES (
	empID				INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	medicalLicenseNum	VARCHAR(40) NOT NULL,
	PRIMARY KEY (empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CERTHISTORY (
	empID		INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	clsID		INT UNSIGNED NOT NULL REFERENCES CERTCLASSES,
	certDate	DATETIME DEFAULT NULL,
	PRIMARY KEY (empID, clsID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CERTCLASSINSTRUCTORS (
	clsID		INT UNSIGNED NOT NULL REFERENCES CERTCLASSES,
	empID		INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	PRIMARY KEY (clsID, empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE FUNCTIONALUNITS (
	unitID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	unitName	VARCHAR(40) NOT NULL,
	preReqID	INT UNSIGNED DEFAULT NULL REFERENCES FUNCTIONALUNITS 
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE FUREQUIREDCERTS (
	unitID		INT UNSIGNED NOT NULL REFERENCES FUNCTIONALUNITS,
	certID		INT UNSIGNED NOT NULL REFERENCES CERTCLASSTYPES,
	PRIMARY KEY (unitID, certID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CEUTYPES (
	ceuID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ceuType		VARCHAR(40) NOT NULL,
	unitID		INT UNSIGNED NOT NULL REFERENCES FUNCTIONALUNITS
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE CEUEARNED (
	ceuID		INT UNSIGNED NOT NULL REFERENCES CEUTYPES,
	empID		INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	ceuDate		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	ceuSource	SET('Conference','Class','Online Module') NOT NULL,
	numHours	INT UNSIGNED NOT NULL,
	PRIMARY KEY (ceuID, empID, ceuDate)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE EMPWORKHISTORY (
	empID		INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	unitID		INT UNSIGNED NOT NULL REFERENCES FUNCTIONALUNITS,
	whStartTime	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	whEndTime	TIMESTAMP DEFAULT 0,
	PRIMARY KEY	(empID, unitID, whStartTime)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE LEADERSHIPPOSITIONS (
	posID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	posName		VARCHAR(60) NOT NULL,
	unitID		INT UNSIGNED NOT NULL REFERENCES FUNCTIONALUNITS
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE MANAGEMENTAPPROVAL (
	empID		INT UNSIGNED NOT NULL REFERENCES REGISTEREDNURSES,
	posID		INT UNSIGNED NOT NULL REFERENCES LEADERSHIPPOSITION,
	apprvDate	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	apprvManager	VARCHAR(60) NOT NULL,
	PRIMARY KEY (empID, posID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE SHIFTTYPES (
	stID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	stName		VARCHAR(40) NOT NULL,
	stStartTime	TIME NOT NULL,
	stEndTime	TIME NOT NULL
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE UNITTEAMS (
	teamID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	teamName	VARCHAR(60) NOT NULL,
	teamDesc	VARCHAR(255)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE SHIFTS (
	shiftID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	shiftDate	DATE NOT NULL,
	stID		INT UNSIGNED NOT NULL REFERENCES SHIFTTYPES,
    unitID		INT UNSIGNED NOT NULL REFERENCES FUNCTIONALUNITS,
	teamID		INT UNSIGNED NOT NULL REFERENCES UNITTEAMS
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE UNITTEAMNURSES (
	teamID		INT UNSIGNED NOT NULL REFERENCES UNITTEAMS,
	empID		INT UNSIGNED NOT NULL REFERENCES REGISTEREDNURSES,
	PRIMARY KEY (teamID, empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE UNITTEAMPARAMEDICS (
	teamID		INT UNSIGNED NOT NULL REFERENCES UNITTEAMS,
	empID		INT UNSIGNED NOT NULL REFERENCES CEPARAMEDICS,
	PRIMARY KEY (teamID, empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE UNITTEAMTECHNICIANS (
	teamID		INT UNSIGNED NOT NULL REFERENCES UNITTEAMS,
	empID		INT UNSIGNED NOT NULL REFERENCES EMPLOYEES,
	PRIMARY KEY (teamID, empID)
)ENGINE=MyISAM CHARACTER SET=utf8;

CREATE TABLE USERROLES (
	roleID		INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    roleName	VARCHAR(60) NOT NULL
)ENGINE=MyISAM CHARACTER SET =utf8;

CREATE TABLE EMPLOYEELOGIN (
	empID		INT UNSIGNED NOT NULL PRIMARY KEY REFERENCES EMPLOYEES,
	username	VARCHAR(32) NOT NULL UNIQUE,
    password	CHAR(32) NOT NULL,
    lastLogin	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    roleID		INT UNSIGNED NOT NULL REFERENCES USERROLES
)ENGINE=MyISAM CHARACTER SET =utf8;
    
CREATE TABLE SCRIPTS (
	scriptID	INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    scriptName	VARCHAR(60) NOT NULL,
    scriptPath	VARCHAR(255) NOT NULL,
	parent		INT UNSIGNED NOT NULL REFERENCES SCRIPTS (scriptID)
)ENGINE=MyISAM CHARACTER SET =utf8;

CREATE TABLE ROLEACCESSTYPES (
	roleID		INT UNSIGNED NOT NULL REFERENCES USERROLES,
    scriptID	INT UNSIGNED NOT NULL REFERENCES SCRIPTS,
    accessType	SET('SELECT','INSERT','UPDATE','DELETE') NOT NULL DEFAULT 'SELECT',
    PRIMARY KEY (roleID, scriptID)
)ENGINE=MyISAM CHARACTER SET =utf8;

/****************************************************************************************************************
	FUNCTIONS
 ****************************************************************************************************************/

DROP FUNCTION IF EXISTS fValidateEmployeeCertification;

DELIMITER //
CREATE FUNCTION fValidateEmployeeCertification (_empID INT UNSIGNED, _certID INT UNSIGNED, _vDatetime DATETIME)
	RETURNS BOOLEAN 
BEGIN 
	RETURN EXISTS(SELECT * 
				  FROM CERTCLASSTYPES 
					JOIN CERTCLASSES USING (certID)
					JOIN CERTHISTORY USING (clsID)
				  WHERE empID = _empID 
					AND certID = _certID
                    AND (certRenewalPeriod = 0 OR DATE_ADD(certDate, INTERVAL certRenewalPeriod YEAR) >= _vDatetime)); 
END; //
DELIMITER ;

DROP FUNCTION IF EXISTS fValidateEmployeeUnit;

DELIMITER //
CREATE FUNCTION fValidateEmployeeUnit (_empID INT UNSIGNED, _unitID INT UNSIGNED, _vDatetime DATETIME)
	RETURNS INT UNSIGNED 
BEGIN
	DECLARE _msg VARCHAR(100);
    DECLARE _noMoreRows BOOLEAN;
    DECLARE _certID INT UNSIGNED;
	DECLARE _fuRequiredCerts CURSOR FOR SELECT certID FROM FUREQUIREDCERTS WHERE unitID = _unitID;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET _noMoreRows = TRUE;
        
	SET _noMoreRows = FALSE;
    OPEN _fuRequiredCerts;
    
    certLoop: LOOP
		FETCH _fuRequiredCerts INTO _certID;
        
        IF _noMoreRows THEN
            LEAVE certLoop;
		END IF;
        
		IF NOT fValidateEmployeeCertification (_empID, _certID, _vDatetime) THEN
			RETURN _certID;
		END IF;
	END LOOP certLoop;

	CLOSE _fuRequiredCerts;
	RETURN 0;
END; //
DELIMITER ;

/****************************************************************************************************************
	TRIGGERS
 ****************************************************************************************************************/
 
DROP TRIGGER IF EXISTS trigValidateInstructor;
DELIMITER //
CREATE TRIGGER trigValidateInstructor
	BEFORE INSERT
    ON CERTCLASSINSTRUCTORS
    FOR EACH ROW
BEGIN 
	DECLARE _instructorCertID INT UNSIGNED;
    DECLARE _clsDatetime DATETIME;
	DECLARE _msg VARCHAR(100);
	DECLARE EXIT HANDLER FOR NOT FOUND
		BEGIN
			SET _msg = CONCAT('Class does not exist for clsID: ',NEW.clsID);
			SIGNAL SQLSTATE '45000' SET message_text = _msg;
		END;
    
    SELECT instructorCertID, clsDateTime INTO _instructorCertID, _clsDatetime
      FROM CERTCLASSTYPES JOIN CERTCLASSES USING (certID) 
      WHERE clsID = NEW.clsID;
      
    IF _instructorCertID IS NOT NULL AND NOT fValidateEmployeeCertification (NEW.empID, _instructorCertID, _clsDatetime) THEN
		SET _msg = CONCAT('Instructor does not hold valid certification to teach classID: ',NEW.clsID);
		SIGNAL SQLSTATE '45000' SET message_text = _msg;
    END IF;
END; //
DELIMITER ;

DROP TRIGGER IF EXISTS trigValidateCertClass;
DELIMITER //
CREATE TRIGGER trigValidateCertClass
	BEFORE INSERT
    ON CERTHISTORY
    FOR EACH ROW
BEGIN 
	DECLARE _msg VARCHAR(100);
    DECLARE _noMoreRows BOOLEAN;
    DECLARE _prereqID INT UNSIGNED;
    DECLARE _clsDatetime DATETIME;
	DECLARE _preRequiredCerts CURSOR FOR SELECT prereqID, clsDatetime 
										FROM CERTCLASSES 
                                          JOIN CERTCLASSPREREQUISITES USING (certID)
										WHERE clsID = NEW.clsID;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET _noMoreRows = TRUE;
    
	SET _noMoreRows = FALSE;
    OPEN _preRequiredCerts;
    
    certLoop: LOOP
		FETCH _preRequiredCerts INTO _prereqID, _clsDatetime;
        
        IF _noMoreRows THEN 
            LEAVE certLoop;
		END IF;
        
		IF _prereqID IS NOT NULL AND NOT fValidateEmployeeCertification (NEW.empID, _prereqID, _clsDatetime) THEN
			SET _msg = CONCAT('Employee (',NEW.empID,') does not have a required prerequisites for classID: ', NEW.clsID);
			SIGNAL SQLSTATE '45000' SET message_text = _msg;
		END IF;
	END LOOP certLoop;

	CLOSE _preRequiredCerts;
END; //
DELIMITER ;

DROP TRIGGER IF EXISTS trigValidateUnitEmp;
DELIMITER //
CREATE TRIGGER trigValidateUnitEmp
	BEFORE INSERT
    ON EMPWORKHISTORY
    FOR EACH ROW
BEGIN 
	DECLARE _msg VARCHAR(100);
    DECLARE _certID INT UNSIGNED;
       
    SET _certID = fValidateEmployeeUnit (NEW.empID, NEW.unitID, NEW.whStartTime);   
       
	IF  _certID > 0 THEN
		SET _msg = CONCAT('Employee does not have a required cert for functional unit. CertID:  ',_certID);
		SIGNAL SQLSTATE '45000' SET message_text = _msg;
	END IF;
END; //
DELIMITER ;

DROP TRIGGER IF EXISTS trigUnitTeamTech;
DELIMITER //
CREATE TRIGGER trigUnitTeamTech
	BEFORE INSERT
    ON UNITTEAMTECHNICIANS
    FOR EACH ROW
BEGIN 
	DECLARE _msg VARCHAR(100);
        
	IF NOT EXISTS(SELECT * FROM EMPLOYEES WHERE empID = NEW.empID AND FIND_IN_SET('Emergency Tech',empType) > 0) THEN
		SET _msg = CONCAT('Employee is not a technician. empID:  ', NEW.empID);
		SIGNAL SQLSTATE '45000' SET message_text = _msg;
	END IF;
END; //
DELIMITER ;

DROP TRIGGER IF EXISTS trigValidateManagementApproval;
DELIMITER //
CREATE TRIGGER trigValidateManagementApproval
	BEFORE INSERT
    ON MANAGEMENTAPPROVAL
    FOR EACH ROW
BEGIN 
	DECLARE _unitID INT UNSIGNED;
	DECLARE _certID INT UNSIGNED;
	DECLARE _msg VARCHAR(100);
	DECLARE EXIT HANDLER FOR NOT FOUND
		BEGIN
			SET _msg = CONCAT('Position does not exist for posID: ',NEW.posID);
			SIGNAL SQLSTATE '45000' SET message_text = _msg;
		END;
    
    SELECT unitID INTO _unitID
      FROM LEADERSHIPPOSITIONS 
      WHERE posID = NEW.posID;
      
    IF _unitID IS NOT NULL THEN 
		SET _certID = fValidateEmployeeUnit (NEW.empID, _unitID, NOW());
        IF _certID > 0 THEN
			SET _msg = CONCAT('Employee is not qualified to work in position ',NEW.posID,
				'. Employee requires certID: ', _certID);
			SIGNAL SQLSTATE '45000' SET message_text = _msg;
		END IF;
    END IF;
END; //
DELIMITER ;

/****************************************************************************************************************
	DATA
 ****************************************************************************************************************/
 
INSERT INTO CAMPUSES (cmpName, cmpStreet, cmpCity, cmpState) 
VALUES 
	('Diamond Children\'s Medical Center','1501 N Campbell Ave.','Tucson','AZ'),
	('Banner - University Medical Center Tucson Campus','1501 N Campbell Ave.','Tucson','AZ'),
	('Banner - University Medical Center South Campus','2800 E Ajo Way','Tucson','AZ'),
	('Banner - University Medical Center Phoenix Campus','1111 E McDowell Road','Phoenix','AZ'),
    ('The University of Arizona College of Medicine - Phoenix','550 E Van Buren St.','Phoenix','AZ');

INSERT INTO BUILDINGS (bldName, campusID) 
VALUES 
	('Thomas W. Keating Biosearch Building',2),
    ('College of Pharmacy',2),
    ('College of Nursing',2),
    ('College of Medicine Outreach',2),
    ('Loeon F. Levy Building',2),
    ('Sydney E. Saolmon Building',2),
    ('Dermatology Clinic',2),
    ('Alzheimer\'s Center',4),
    ('Concussion Center',4),
    ('Rehabilitation Institute',4),
    ('925 Building',4),
    ('West Tower',4),
    ('Patient Tower',4),
    ('Edward\'s Building',4);

INSERT INTO CLASSROOMS 
	(floor, roomNum, capacity, buildingID) 
VALUES 
	(1,101,50,3),
	(1,102,60,3),
	(1,103,60,3),
	(1,104,50,3),
    (1,105,75,3),
    (1,106,75,3),
    (1,107,150,3),
    (1,108,150,3),
	(2,201,30,3),
    (2,202,40,3),
    (2,203,40,3),
    (2,204,30,3),
    (2,205,25,3),
    (2,206,25,3),
	(2,207,150,3),
    (2,208,150,3);

INSERT INTO CERTCLASSTYPES 
	(certName, certDesc, certType, certRenewalPeriod, siRatio, instructorCertID) 
VALUES 
	('CPR Instructor','Certified to teach CPR certification class','Instructor',0,5,NULL),
	('Functional Unit Instructor','Can teach Peds, Triage and Trauma certification classes','Instructor',2,5,NULL),
	('BLS','Certified to work in ER','Emergency Tech,CE Paramedic,Registered Nurse',2,15,1),
	('ENPC','Certified to work in Pediatrics','Registered Nurse',4,15,2),
	('ESI Class','Certified to work in Triage','Registered Nurse',0,15,2),
	('Trauma Compentency','Certified to work in Trauma','CE Paramedic,Registered Nurse',1,15,2),
	('Compentency Instructor','Certified to teach easy classes','Instructor',2,5,NULL),
	('ACLS','A medical acronym that is needed','CE Paramedic,Registered Nurse',2,15,7),
	('PALS','Make sure everyone are pals','CE Paramedic,Registered Nurse',2,15,7),
	('Annual Competency','Weed out the incompetence','CE Paramedic,Registered Nurse',1,15,7),
	('Annual Point of Care Test','Understanding of Point of Care','Emergency Tech,CE Paramedic,Registered Nurse',1,15,7),
	('EKG Test','Anyone know what an EKG is?','Emergency Tech,CE Paramedic,Registered Nurse',1,15,7),
	('TN Instructor','Certified to teach in Trauma Nurse Courses','Instructor',0,15,NULL),
	('TNCC','Certified in Trauma Nurse Core Compentencies','Registered Nurse',4,15,13),
	('ATCN','Accute Trauma Certified Nurse','Registered Nurse',4,15,13),
	('ED Academy Trainer','Certified to teach ED Academy','Instructor',0,15,NULL),
	('ED Tech Academy','Received ED Tect Academy Training','Emergency Tech',0,15,16),
	('ED Academy','Received ED Academy Training','Registered Nurse',0,15,16),
	('Portions of ED Academy','Received Some ED Academy Training','Registered Nurse',0,15,16);

INSERT INTO CERTCLASSPREREQUISITES VALUES (4,3), (5,4), (6,5);

INSERT INTO CERTCLASSES (clsDatetime, clsrmID, certID) 
VALUES 
	(STR_TO_DATE('01-FEB-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,1),
	(STR_TO_DATE('17-JAN-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,2),
	(STR_TO_DATE('05-OCT-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-NOV-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-DEC-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('20-JAN-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,4),
	(STR_TO_DATE('21-JAN-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,5),
	(STR_TO_DATE('22-JAN-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,6),
	(STR_TO_DATE('19-JAN-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-OCT-2015 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-NOV-2015 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-DEC-2015 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('18-JAN-2014 9:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,7),
	(STR_TO_DATE('18-JAN-2014 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),14,13),
	(STR_TO_DATE('19-JAN-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),14,16),
	(STR_TO_DATE('03-JAN-2016 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,2),
	(STR_TO_DATE('03-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,7),
	(STR_TO_DATE('05-JAN-2016 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3),
	(STR_TO_DATE('05-JAN-2016 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,4),
	(STR_TO_DATE('05-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,5),
	(STR_TO_DATE('05-JAN-2016 03:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,6),
	(STR_TO_DATE('06-JAN-2016 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,8),
	(STR_TO_DATE('06-JAN-2016 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,9),
	(STR_TO_DATE('06-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,10),
	(STR_TO_DATE('06-JAN-2016 03:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,11),
	(STR_TO_DATE('07-JAN-2016 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,12),
	(STR_TO_DATE('07-JAN-2016 11:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,14),
	(STR_TO_DATE('07-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,15),
	(STR_TO_DATE('07-JAN-2016 03:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,17),
	(STR_TO_DATE('08-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,18),
	(STR_TO_DATE('08-JAN-2016 03:00:00 PM','%d-%b-%Y %h:%i:%s %p'),13,19),
	(STR_TO_DATE('05-FEB-2016 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'),13,3);
    

INSERT INTO EMPLOYEES 
	(empType, empfName, emplName, empPhone, empStreet, empCity, empState, hireDate, currPosition)
VALUES 
	('Instructor', 'Jack', 'Frasier', '(520) 765-4865', '702 Meridian Rd.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Instructor'),
	('CE Paramedic', 'Robert', 'Flanighan', '(602) 528-4637', '2008 Solano Dr.', 'Phoenix', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Medic'),
	('Registered Nurse', 'Janie', 'Fritt', '(520) 294-9835', '4888 De La Canoa Dr.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Nurse'),
	('Registered Nurse', 'Amber', 'Flemming', '(520) 752-8774', '200 Whiting Dr.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Nurse'),
	('Emergency Tech', 'Bob', 'Transformer', '(520) 637-2637', '13140 45th Dr.', 'Yuma', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Tech'),
	('Registered Nurse', 'Casey', 'Shantz', '(520) 244-6366', '1920 N. 8th Ave.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Nurse'),
	('CE Paramedic', 'James', 'Watt', '(340) 948-3345', '18637 85th Ln.', 'West Liberty', 'TX', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Medic'),
	('Registered Nurse', 'Audrey', 'Lewis', '(520) 219-1192', '4011 Pershing Ave.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Nurse'),
	('CE Paramedic', 'John', 'Francis', '(520) 827-0093', '2014 Market St.', 'Tucson', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Medic'),
	('Emergency Tech', 'Clint', 'Goodyear', '(923) 983-4988', '1797 28th Ave.', 'Las Cruces', 'NM', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Tech'),
	('Registered Nurse', 'Sara', 'Flint', '(677) 627-0098', '1822 39th St.', 'El Paso', 'TX', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Nurse'),
	('CE Paramedic', 'Pierre', 'Volt', '(602) 342-7652', '1333 Mohave St.', 'Phoenix', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Medic'),
	('Emergency Tech', 'Ricky', 'Ricardo', '(203) 733-8726', '1084 Harper St.', 'Albuquerque', 'NM', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Tech'),
	('Registered Nurse', 'Lucy', 'Ricardo', '(203) 673-9922', '1085 Harper St.', 'Albuquerque', 'NM', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Head Nurse'),
	('Other', 'Lukas', 'Olson', '(602) 316-2776', '901 Desert Vista', 'Phoenix', 'AZ', STR_TO_DATE('01-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Janitor');

INSERT INTO EMPLOYEETYPES (empTypeValue, empType) VALUES 
	(1, 'Instructor'), (2, 'Emergency Tech'), (4, 'CE Paramedic'), (8, 'Registered Nurse'), (16, 'Other');

INSERT INTO CEPARAMEDICS ( empID, cepLicenseNum, isNationalReg)
VALUES
	(2,'8u7bc87bwc87',1),
    (7,'987h2f97gh43',1),
    (9,'028h3fd98unw',1),
    (12,'buy8fdg8f2g743',0);

INSERT INTO REGISTEREDNURSES (empID, medicalLicenseNum)
VALUES
	(3,'123-4515-251525-3552'),
	(4,'754-2136-176234-8238'),
	(6,'347-8387-892338-2593'),
	(8,'933-9398-466729-1898'),
	(11,'186-3944-893792-3369'),
	(14,'067-6256-929938-4483');

INSERT INTO CERTHISTORY (empID, clsID, certDate)
VALUES 
	(1, 1, STR_TO_DATE('01-FEB-2014 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 2, STR_TO_DATE('19-JAN-2014 03:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 13, STR_TO_DATE('18-JAN-2014 01:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 14, STR_TO_DATE('18-JAN-2014 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 15, STR_TO_DATE('19-JAN-2014 01:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 16, STR_TO_DATE('03-JAN-2016 01:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(1, 17, STR_TO_DATE('03-JAN-2016 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
   	(2, 3, STR_TO_DATE('05-OCT-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(7, 3, STR_TO_DATE('05-OCT-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(9, 3, STR_TO_DATE('05-OCT-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(12, 3, STR_TO_DATE('05-OCT-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(3, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(4, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(6, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(8, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(11, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(14, 4, STR_TO_DATE('05-NOV-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(5, 5, STR_TO_DATE('05-DEC-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(10, 5, STR_TO_DATE('05-DEC-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(13, 5, STR_TO_DATE('05-DEC-2014 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(15, 9, STR_TO_DATE('19-JAN-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(2, 10, STR_TO_DATE('05-OCT-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(7, 10, STR_TO_DATE('05-OCT-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
   	(9, 10, STR_TO_DATE('05-OCT-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(3, 11, STR_TO_DATE('05-NOV-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(4, 11, STR_TO_DATE('05-NOV-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(6, 11, STR_TO_DATE('05-NOV-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(8, 11, STR_TO_DATE('05-NOV-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(11, 11, STR_TO_DATE('05-NOV-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(10, 12, STR_TO_DATE('05-DEC-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(13, 12, STR_TO_DATE('05-DEC-2015 11:00:00 AM','%d-%b-%Y %h:%i:%s %p')),
	(2, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(3, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(4, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(5, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(6, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(7, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(8, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(9, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(10, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(11, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(12, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(13, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(14, 6, STR_TO_DATE('20-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(2, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(3, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(4, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(5, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(6, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(7, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(8, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(9, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(10, 7, STR_TO_DATE('21-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(2, 8, STR_TO_DATE('22-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(3, 8, STR_TO_DATE('22-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(4, 8, STR_TO_DATE('22-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(5, 8, STR_TO_DATE('22-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p')),
	(6, 8, STR_TO_DATE('22-JAN-2015 05:00:00 PM','%d-%b-%Y %h:%i:%s %p'));

INSERT INTO CERTCLASSINSTRUCTORS (clsID, empID) VALUES
	(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(18,1),(19,1),(20,1),
    (21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1);

INSERT INTO FUNCTIONALUNITS (unitName, preReqID) VALUES 
	('Emergency', NULL),
    ('Pediatrics', 1),
    ('Triage', 2),
    ('Trauma', 3);

INSERT INTO FUREQUIREDCERTS (unitID, certID) VALUES 
	(1,3),(2,4),(3,5),(4,6),(4,14),(4,15);

INSERT INTO LEADERSHIPPOSITIONS (posName, unitID) VALUES 
	('Emergency Head Nurse',1),
	('Peds Head Nurse',2),
	('Triage Head Nurse',3),
	('Trauma Head Nurse',4);

INSERT INTO MANAGEMENTAPPROVAL (empID, posID, apprvDate, apprvManager) VALUES
	(13, 1, STR_TO_DATE('02-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Bilbo Baggends'),
	(11, 2, STR_TO_DATE('02-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Bilbo Baggends'),
	(6, 3, STR_TO_DATE('02-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Bilbo Baggends'),
	(4, 3, STR_TO_DATE('02-JAN-2014 09:00:00 AM','%d-%b-%Y %h:%i:%s %p'), 'Bilbo Baggends');

INSERT INTO SHIFTTYPES (stName, stStartTime, stEndTime) VALUES
	('Days','07:00:00','19:00:00'),
	('Nights','19:00:00','07:00:00'),
	('11AM Swing','11:00:00','23:00:00'),
	('3PM Swing','15:00:00','03:00:00');   

INSERT INTO USERROLES (roleName) VALUES
	('Administrator'),('Employee');

INSERT INTO EMPLOYEELOGIN (empID, username, password, roleID) VALUES 
	(1, 'jfrasier', md5('Password123!'),2),
	(2, 'rflanighan', md5('Password123!'),2),
	(3, 'jfritt', md5('Password123!'),2), 
	(4, 'aflemming', md5('Password123!'),2), 
	(5, 'btransformer', md5('Password123!'),2), 
	(6, 'cshantz', md5('Password123!'),2), 
	(7, 'jwatt', md5('Password123!'),2), 
	(8, 'alewis', md5('Password123!'),2), 
	(9, 'jfrancis', md5('Password123!'),2), 
	(10, 'cgoodyear', md5('Password123!'),2), 
	(11, 'sflint', md5('Password123!'),2), 
	(12, 'pvolt', md5('Password123!'),2), 
	(13, 'rricardo', md5('Password123!'),2), 
	(14, 'lricardo', md5('Password123!'),2), 
	(15, 'lolson', md5('Password123!'),1); 

INSERT INTO SCRIPTS (scriptName, scriptPath, parent) VALUES
	('Employee Management','', 0),
	('Certifications','', 1),
	('Shifts','', 1),
	('Leadership Positions','', 1),
	('Class Management','', 0),
	('Class Certs','', 5),
	('Instructors','', 5),
	('Certification Management','', 0),
	('Location Management','', 0),
	('Functional Units','', 0);

INSERT INTO ROLEACCESSTYPES (roleID, scriptID, accessType) VALUES
	(1,1,'SELECT,INSERT,UPDATE,DELETE'),
	(1,2,'SELECT,INSERT,UPDATE,DELETE'),
	(1,3,'SELECT,INSERT,UPDATE,DELETE'),
	(1,4,'SELECT,INSERT,UPDATE,DELETE'),
	(1,5,'SELECT,INSERT,UPDATE,DELETE'),
	(1,6,'SELECT,INSERT,UPDATE,DELETE'),
	(1,7,'SELECT,INSERT,UPDATE,DELETE'),
	(1,8,'SELECT,INSERT,UPDATE,DELETE'),
	(1,9,'SELECT,INSERT,UPDATE,DELETE'),
	(1,10,'SELECT,INSERT,UPDATE,DELETE'),
	(2,1,'SELECT'),
	(2,2,'SELECT'),
	(2,3,'SELECT'),
	(2,4,'SELECT'),
	(2,5,'SELECT'),
	(2,6,'SELECT,INSERT');

/****************************************************************************************************************
	STORED PROCEDURES
 ****************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS GetCurrentClasses; 
DELIMITER // 
CREATE PROCEDURE GetCurrentClasses(IN _certType INT UNSIGNED) 
BEGIN 
	IF _certType = 0  OR _certType IS NULL THEN 
		SET _certType = 2047;
	END IF;
	SELECT clsID, certName, certType, clsDatetime, cmpName, bldName, roomNum, siRatio, coalesce(count(empID),0) enrollment
	FROM CERTCLASSES
	  JOIN CERTCLASSTYPES USING (certID)
	  JOIN CLASSROOMS USING (clsrmID)
	  JOIN BUILDINGS USING (buildingID)
	  JOIN CAMPUSES USING (campusID)
	  LEFT JOIN CERTHISTORY USING (clsID)
	WHERE clsDatetime > NOW()
	  AND (certType & _certType) > 0
	GROUP BY clsID, certName, certType, clsDatetime, cmpName, bldName, roomNum, siRatio
	ORDER BY clsDatetime;
END // 
DELIMITER ;

DROP PROCEDURE IF EXISTS GetCertifications; 
DELIMITER // 
CREATE PROCEDURE GetCertifications(IN _certType INT UNSIGNED) 
BEGIN 
	IF _certType = 0  OR _certType IS NULL THEN 
		SET _certType = 2047;
	END IF;
	SELECT certID, certName, certDesc, certType, certRenewalPeriod, siRatio, instructorCertID
	FROM CERTCLASSTYPES 
	WHERE (certType & _certType) > 0;
END // 
DELIMITER ;

DROP PROCEDURE IF EXISTS GetEmployees; 
DELIMITER // 
CREATE PROCEDURE GetEmployees(IN _empType INT UNSIGNED) 
BEGIN 
	IF _empType = 0  OR _empType IS NULL THEN 
		SET _empType = 2047;
	END IF;
	SELECT empID, empfName, emplName, empPhone, empStreet, empCity, empState, hireDate, currPosition, empType
	FROM EMPLOYEES
	WHERE (empType & _empType) > 0
	ORDER BY empID;
END // 
DELIMITER ;

DROP PROCEDURE IF EXISTS GetEmployeeCertNeeds; 
DELIMITER // 
CREATE PROCEDURE GetEmployeeCertNeeds(IN _empType INT UNSIGNED, IN _days INT UNSIGNED) 
BEGIN 
	IF _empType = 0  OR _empType IS NULL THEN 
		SET _empType = 2047;
	END IF;

	IF _days IS NULL THEN 
		SET _days = 0;
	END IF;

	SELECT empID, certID, lastCert, certRenewalPeriod 
	FROM EMPLOYEES 
	  JOIN CERTCLASSTYPES cct ON ((empType & 1) = 0 AND (empType & certType) > 0) 
	  LEFT JOIN (SELECT empID, certID, max(certDate) lastCert
				 FROM CERTHISTORY 
				   JOIN CERTCLASSES USING (clsID)
				   JOIN CERTCLASSTYPES USING (certID)
				 WHERE (certRenewalPeriod = 0 OR DATE_ADD(certDate, INTERVAL certRenewalPeriod YEAR) >= DATE_ADD(CURRENT_DATE, INTERVAL _days DAY))
				 GROUP BY empID, certID
				) cch USING (empID, certID)
	WHERE (empType & _empType) > 0
	  AND lastCert IS NULL
	ORDER BY empID, certID;
END // 
DELIMITER ;

