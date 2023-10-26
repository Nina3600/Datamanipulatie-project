DROP TABLE IF EXISTS HarryPotter.Discover;
DROP TABLE IF EXISTS HarryPotter.FilmActeur;
DROP TABLE IF EXISTS HarryPotter.Personage;
DROP TABLE IF EXISTS HarryPotter.Acteur;
DROP TABLE IF EXISTS HarryPotter.FilmGenre;
DROP TABLE IF EXISTS HarryPotter.Films;
DROP TABLE IF EXISTS HarryPotter.Genre;
DROP TABLE IF EXISTS HarryPotter.BoekenAuteur;
DROP TABLE IF EXISTS HarryPotter.Boeken;
DROP TABLE IF EXISTS HarryPotter.Auteur;
DROP TABLE IF EXISTS HarryPotter.Illustrator;
GO --Verwijderen van tabellen
DROP SCHEMA IF EXISTS HarryPotter;
GO --Verwijderen van schema
CREATE SCHEMA HarryPotter;
GO --Schema creëren
CREATE TABLE HarryPotter.Illustrator
(
	id				int IDENTITY (1,1),
	voornaam		varchar(45),
	naam			varchar(50) NOT NULL,
	geboortejaar	int,
	CONSTRAINT PK_Illustrator PRIMARY KEY (id)
);
GO
CREATE TABLE HarryPotter.Auteur
(
	id				int IDENTITY (1,1),
	voornaam		varchar(50),
	naam			varchar(50) NOT NULL,
	geboortejaar	int,
	CONSTRAINT PK_Auteur PRIMARY KEY (id),
);
GO
CREATE TABLE HarryPotter.Boeken --Aanmaken tabellen
(
	id				int IDENTITY (1,1),
	titel			varchar(70) NOT NULL,
	ibnNummer		varchar(70) NOT NULL,
	beschrijving	varchar(400) NOT NULL,
	auteurId		int NOT NULL,
	illustratorId	int,
	CONSTRAINT PK_Boeken PRIMARY KEY (id),
	CONSTRAINT FK_HarryPotter_Illustrator FOREIGN KEY (illustratorId) REFERENCES HarryPotter.Illustrator (id),
	CONSTRAINT FK_HarryPotter_BoekenAuteur FOREIGN KEY (auteurId) REFERENCES HarryPotter.Auteur (id)
);
GO
CREATE TABLE HarryPotter.BoekenAuteur
(
	id			int IDENTITY (1,1),
	boekenId	int NOT NULL,
	auteurId	int NOT NULL,
	CONSTRAINT PK_BoekenAuteur PRIMARY KEY (id),
	CONSTRAINT FK_HarryPotter_Boeken FOREIGN KEY (boekenId) REFERENCES HarryPotter.Boeken (id) ON DELETE CASCADE,
	CONSTRAINT FK_HarryPotter_Auteur FOREIGN KEY (auteurId) REFERENCES HarryPotter.Auteur (id) 
);
GO
CREATE TABLE HarryPotter.Genre
(
	id		int IDENTITY (1,1),
	naam	varchar(50) NOT NULL,
	CONSTRAINT PK_Genre PRIMARY KEY (id),
);
GO
CREATE TABLE HarryPotter.Films
(
	id				int IDENTITY (4,1),
	titel			varchar(70) NOT NULL,
	productieDatum	date NOT NULL,
	inhoud			varchar(1000) NOT NULL,
	genreId			int NOT NULL,
	uitgaveDatum	date,
	CONSTRAINT PK_Films PRIMARY KEY (id)
);
GO
CREATE TABLE HarryPotter.FilmGenre
(
	id		int IDENTITY (1,1),
	filmId	int NOT NULL,
	genreId int NOT NULL,
	CONSTRAINT PK_FilmGenre PRIMARY KEY (id),
	CONSTRAINT FK_HarryPotter_Films FOREIGN KEY (filmId) REFERENCES HarryPotter.Films (id) ON DELETE CASCADE,
	CONSTRAINT FK_HarryPotter_Genre FOREIGN KEY (genreId) REFERENCES HarryPotter.Genre (id)
);
GO
CREATE TABLE HarryPotter.Acteur
(
	id				int IDENTITY (1,1),
	voornaam		varchar(50),
	naam			varchar(50) NOT NULL,
	geboortedatum	date NOT NULL,
	CONSTRAINT PK_Acteur PRIMARY KEY (id),
);
GO
CREATE TABLE HarryPotter.Personage
(
	id int IDENTITY (1,1),
	voornaam varchar(50),
	naam varchar(50) NOT NULL,
	leeftijd int,
	CONSTRAINT PK_Personage PRIMARY KEY (id),
);
GO
CREATE TABLE HarryPotter.FilmActeur
(
	id int IDENTITY (1,1),
	filmId int NOT NULL,
	acteurId int NOT NULL,
	personageId int NOT NULL,
	CONSTRAINT PK_FilmActeur PRIMARY KEY (id),
	CONSTRAINT FK_FilmActeur_Films FOREIGN KEY (filmId) REFERENCES HarryPotter.Films (id) ON DELETE CASCADE,
	CONSTRAINT FK_FilmActeur_Acteur FOREIGN KEY (acteurId) REFERENCES HarryPotter.Acteur (id),
	CONSTRAINT FK_FilmActeur_Personage FOREIGN KEY (personageId) REFERENCES HarryPotter.Personage (id)
);
GO
CREATE TABLE HarryPotter.Discover
(
	id int IDENTITY (1,1),
	boekenId int NOT NULL,
	filmId int NOT NULL,
	CONSTRAINT PK_Discover PRIMARY KEY (id),
	CONSTRAINT FK_Discover_Films FOREIGN KEY (filmId) REFERENCES HarryPotter.Films (id) ON DELETE CASCADE,
	CONSTRAINT FK_Discover_Boeken FOREIGN KEY (boekenId) REFERENCES HarryPotter.Boeken (id) ON DELETE CASCADE
);
GO


--Tabel illustrator invullen
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('J.K.', 'Rowling', 1965);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Jim', 'Kay', 1974);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Thomas', 'Taylor', 1973);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Mary', 'Grandpré', 1954);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Brian', 'Selznick', 1966);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Len', 'van Laanen', 1956);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Neil', 'Packer', NULL);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Levi', 'Pinfold', NULL);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Cliff', 'Wright', 1963);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Giles', 'Greenfield', NULL);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Jason', 'Cockcroft', NULL);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Clare', 'Melinsky', 1953);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Kazu', 'Kibuishi', 1978);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Olly', 'Moss', 1987);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Jean-Claude', 'Götting', 1963);
INSERT INTO HarryPotter.Illustrator(voornaam, naam, geboortejaar)
VALUES ('Gill Olivia', 'Lomenech', 1974);

--Tabel auteur invullen
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('J.K.', 'Rowling', 1965);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Eddie', 'Redmayne', 1982);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Gill Olivia', 'Lomenech', 1974);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Dan', 'Fogler', 1976);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Jude', 'Law', 1972);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Steve', 'Kloves', 1960);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Jon', 'Voight', 1938);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Ron', 'Perlman', 1950);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Alison', 'Sudol', 1984);
INSERT INTO HarryPotter.Auteur(voornaam, naam, geboortejaar)
VALUES ('Richard', 'Coyle', 1972);

--Tabel boeken invullen
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the Philosopher'''  + 's Stone', '9780747532699', 'Met een speciale trein die vertrekt van Perron 9¾ belandt hij op Zweinsteins Hogeschool voor Hekserij en Hocus Pocus, waar hij alles leert over bezemstelen, toverdranken en monsters. En uiteindelijk moet Harry het opnemen tegen zijn aartsvijand Voldemort, een levensgevaarlijke tovenaar.', 1, 2);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the chamber of secrets', '9781551922447', 'Het wordt een bewogen jaar op Hogwarts, met toverduels, op hol geslagen Bludgers en een onheilspellende, met bloed geschreven boodschap: de Geheime Kamer is geopend. Om Hogwarts te redden zullen Harry, Ron en Hermoine al hun magische krachten en moed moeten bundelen.', 1, 2);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the prisoner of azkaban', '9781408855911', 'Harry Potter beleeft in dit boek vele avonturen: hij maakt geheime uitstapjes naar Zweinsveld en naar Hagrid, de jachtopziener, krijgt extra lessen verweer tegen zwarte kunsten om zichzelf tegen de gevreesde bewakers van Azkaban, de Dementors, te beschermen en hij leert zijn pleegvader Sirius Zwarts kennen.', 1, 4);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the goblet of fire', '9780747546245', 'Hierin moeten drie kampioenen van drie verschillende toverscholen drie gevaarlijke opdrachten voltooien om de Toverschool Trofee te winnen. Deze drie kampioenen worden door de Vuurbeker gekozen. Hij kiest Fleur Delacour van Beauxbatons, Viktor Krum van Klammfels en Carlo Kannewasser van Zweinstein.', 1, 3);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the order of the phoenix', '9780605064225', 'De Orde van de Feniks is een groep tovenaars die, in tegenstelling tot veel anderen, er wel van overtuigd zijn dat Voldemort is teruggekeerd, en ze doen er alles aan om hem tegen te houden. Enkele leden van de Orde zijn Albus Perkamentus, Zwarts, Lupos, Dolleman, meneer en mevrouw Wemel en Severus Sneep.', 1, 7);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the half blood prince', '9780747581420', 'Harry gaat achter Bellatrix van Detta en Fenrir Vaalhaar aan, wanneer Bellatrix Harry meerdere keren met Sirius''' + 'dood confronteert. Ginny rent Harry achterna om hem te helpen. Later krijgen Harry en Ginny nog hulp van meneer Wemel, Nymphadora Tops en Remus Lupos, die er die avond waren.', 1, 4);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Harry Potter and the deathly hallows', '9780747591078', 'Beschrijving. Harry, Ron en Hermione beginnen aan een levensgevaarlijke missie om de Horcruxes te vernietigen. Nu ze alleen en op de vlucht zijn, moeten ze meer dan ooit op elkaar vertrouwen, maar duistere krachten dreigen hen uit elkaar te drijven.', 1, 4);
INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
VALUES ('Fantastic beasts and where to find them', '9781338232691', 'Newt Scamander''' + 's werelds eerste (en waarschijnlijk enige) magiezoöloog, bezoekt de stad vanuit Engeland. Zijn liefde voor fabeldieren en andere magische wezens is grenzeloos. Maar zijn strijd om deze te beschermen neemt een alarmerende wending als een aantal dieren uit zijn koffer ontsnapt en in de stad opduikt.', 1, 9);

--Tabel BoekenAuteur invullen
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (1, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (2, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (3, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (4, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (5, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (6, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (7, 1);
INSERT INTO HarryPotter.BoekenAuteur(boekenId, auteurId)
VALUES (8, 1);

--Tabel Films invullen
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the Philosopher'''  + 's Stone', '1997-06-26', 'Met een speciale trein die vertrekt van Perron 9¾ belandt hij op Zweinsteins Hogeschool voor Hekserij en Hocus Pocus, waar hij alles leert over bezemstelen, toverdranken en monsters. En uiteindelijk moet Harry het opnemen tegen zijn aartsvijand Voldemort.', 1, '2001-11-21');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the chamber of secrets', '1997-06-26', 'Het wordt een bewogen jaar op Hogwarts, met toverduels, op hol geslagen Bludgers en een onheilspellende, met bloed geschreven boodschap: de Geheime Kamer is geopend. Om Hogwarts te redden zullen Harry, Ron en Hermoine al hun magische krachten en moed moeten bundelen.', 1, '2002-11-03');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the prisoner of azkaban', '1997-06-26', 'Harry Potter beleeft in dit boek vele avonturen: hij maakt geheime uitstapjes naar Zweinsveld en naar Hagrid, de jachtopziener, krijgt extra lessen verweer tegen zwarte kunsten om zichzelf tegen de gevreesde bewakers van Azkaban, de Dementors, te beschermen en hij leert zijn pleegvader Sirius Zwarts kennen.', 1, '2004-06-02');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the goblet of fire', '1997-06-26', 'Hierin moeten drie kampioenen van drie verschillende toverscholen drie gevaarlijke opdrachten voltooien om de Toverschool Trofee te winnen. Deze drie kampioenen worden door de Vuurbeker gekozen. Hij kiest Fleur Delacour van Beauxbatons, Viktor Krum van Klammfels en Carlo Kannewasser van Zweinstein.', 1, '2005-11-23');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the order of the phoenix', '1997-06-26', 'De Orde van de Feniks is een groep tovenaars die, in tegenstelling tot veel anderen, er wel van overtuigd zijn dat Voldemort is teruggekeerd, en ze doen er alles aan om hem tegen te houden. Enkele leden van de Orde zijn Albus Perkamentus, Zwarts, Lupos, Dolleman, meneer en mevrouw Wemel en Severus Sneep.', 1, '2007-07-11');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the half blood prince', '1997-06-26', 'Harry gaat achter Bellatrix van Detta en Fenrir Vaalhaar aan, wanneer Bellatrix Harry meerdere keren met Sirius''' + 'dood confronteert. Ginny rent Harry achterna om hem te helpen. Later krijgen Harry en Ginny nog hulp van meneer Wemel, Nymphadora Tops en Remus Lupos, die er die avond waren.', 1, '2009-07-15');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Harry Potter and the deathly hallows Part 1', '1997-06-26', 'De film begint wanneer Harry, Ron en Hermelien starten met de haast onmogelijke missie om de resterende Gruzielementen van Heer Voldemort op te sporen en te vernietigen. Ze staan er helemaal alleen voor, zonder de hulp van hun trouwe leraren, de Strijders van Perkamentus en Perkamentus zelf.', 1, '2010-11-17');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud,genreId, uitgaveDatum)
VALUES ('Harry Potter and the deathly hallows Part 2', '1997-06-26', 'Harry gaat naar het Verboden Bos, waar Voldemort en zijn Dooddoeners ook zijn. Hij is bereid om te sterven en geeft zich over. Voldemort vuurt de Vloek des Doods op Harry af. Harry verliest het bewustzijn en komt in een wereld tussen leven en dood terecht, waar hij in een gesprek met Perkamentus belandt.', 1, '2011-07-13');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Fantastic Beasts and Where to Find Them', '1997-06-26', 'Newt Scamander''' + 's werelds eerste (en waarschijnlijk enige) magiezoöloog, bezoekt de stad vanuit Engeland. Zijn liefde voor fabeldieren en andere magische wezens is grenzeloos. Maar zijn strijd om deze te beschermen neemt een alarmerende wending als een aantal dieren uit zijn koffer ontsnapt en in de stad opduikt.', 1, '2016-11-16');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Fantastic Beasts: The Crimes of Grindelwald', '1997-06-26', 'Het verhaal van Fantastic Beasts: The Crimes of Grindelwald neemt plaats in 1927. De film volgt Newt Scamander als hij onder opdracht van Albus Dumbledore de kwaadaardige tovenaar Gellert Grindelwald probeert tegen te houden. Grindelwald wil een oorlog tussen de niet-magische wereld en de tovenaarswereld ontketenen', 1, '2018-11-14');
INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
VALUES ('Fantastic Beasts: The Secrets of Dumbledore', '1997-06-26', 'Professor Albus Perkamentus weet dat de duistere tovenaar Gellert Grindelwald de macht over de tovenaarswereld wil overnemen. In zijn eentje kan hij hem niet tegenhouden, dus schakelt hij de hulp in van magiezoöloog Newt Scamander.', 1, '2022-04-08');

--Tabel Genre invullen
INSERT INTO HarryPotter.Genre(naam)
VALUES ('Fantasy');
INSERT INTO HarryPotter.Genre(naam)
VALUES ('Avontuur');
INSERT INTO HarryPotter.Genre(naam)
VALUES ('Kinderen');
INSERT INTO HarryPotter.Genre(naam)
VALUES ('Fictie');

--Tabel FilmGenre invullen
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (4, 3);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (6, 2);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (7, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (8, 4);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (9, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (10, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (11, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (12, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (13, 1);
INSERT INTO HarryPotter.FilmGenre(filmId, genreId)
VALUES (14, 1);


--Tabel acteur invullen
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Daniel', 'Radcliffe', '1989-07-23');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Emma', 'Watson', '1990-04-15');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Rupert', 'Grint', '1988-08-24');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Evanna', 'Lynch', '1991-08-16');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Matthew', 'Lewis', '1989-06-27');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Tom', 'Felton', '1987-09-22');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Bonnie', 'Wright', '1991-02-17');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('James', 'Phelps', '1986-02-25');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Oliver', 'Phelps', '1986-02-25');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Maggie', 'Smith', '1934-12-28');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Michael', 'Gambon', '1940-10-19');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Gary', 'Oldman', '1958-03-21');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('David', 'Thewlis', '1963-03-20');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Helena', 'Carter', '1966-05-26');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Helen', 'McCrory', '1968-08-17');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Ralph', 'Fiennes', '1962-12-22');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Christian', 'Coulson', '1978-10-3');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Toby', 'Jones', '1966-09-07');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Alan', 'Rickman', '1946-02-21');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Robbie', 'Coltrane', '1950-03-30');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Mark', 'Williams', '1959-08-22');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Julie', 'Walters', '1950-02-22');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Jason', 'Isaacs', '1963-06-06');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Louis', 'Cordice', '1989-10-01');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Eddie', 'Redmayne', '1982-01-06');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Dan', 'Fogler', '1976-10-20');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Zoë', 'Kravitz', '1988-12-01');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Johnny', 'Depp', '1963-06-09');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Alison', 'Sudol', '1984-12-23');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Katherine ', 'Waterston', '1980-03-03');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Jude', 'Law', '1972-12-29');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Hebe', 'Beardsall', '1993-07-06');
INSERT INTO HarryPotter.Acteur(voornaam, naam, geboortedatum)
VALUES ('Mads', 'Mikkelsen', '1965-11-22');

--Tabel Personage invullen
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Harry', 'Potter', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Hermione', 'Granger', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Ronald', 'Wealsey', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Luna', 'Lovegood', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Neville', 'Longbottom', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Draco', 'Malfoy', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Ginny', 'Wealsey', 18);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Fred', 'Weasley', 21);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('George', 'Weasley', 21);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Minerva', 'McGonagall', 70);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Albus', 'Dumbledore', 116);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Sirius', 'Black', 38);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Remus', 'Lupin', 38);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Bellatrix', 'Lestrange', 47);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Narcissa', 'Malfoy', 46);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES (NULL, 'Voldemort', 71);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Tom', 'Riddle', 24);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES (NULL, 'Dobby', 65);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Severus', 'Snape', 43);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Rubeus', 'Hagrid', 53);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES (NULL, 'Hedwig', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Molly', 'Weasley', 51);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Arthur', 'Weasley', 58);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Lucius', 'Malfoy', 50);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Blaise', 'Zabini', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Newt', 'Scamander', 24);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Jacob', 'Kowalski', 65);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Leta', 'Lestrange', 43);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Gellert', 'Grindelwald', 53);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Queenie', 'Goldstein', 19);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Tina', 'Goldstein', 51);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Albus', 'Dumbledore', 58);
INSERT INTO HarryPotter.Personage(voornaam, naam, leeftijd)
VALUES ('Ariana', 'Dumbledore', 50);

--Tabel FilmActeur invullen
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (4, 1, 1);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (4, 2, 2);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (4, 3, 3);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (6, 17, 17);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (6, 6, 6);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (6, 7, 7);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (7, 8, 8);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (7, 9, 9);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (7, 18, 18);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (8, 12, 12);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (8, 13, 13);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (8, 11, 11);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (9, 4, 4);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (9, 19, 19);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (9, 5, 5);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (10, 14, 14);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (10, 20, 20);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (10, 22, 22);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (11, 10, 10);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (11, 15, 15);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (11, 21, 23);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (12, 23, 24);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (12, 16, 16);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (12, 24, 25);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (13, 25, 26);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (13, 26, 27);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (13, 27, 28);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (14, 28, 29);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (14, 29, 30);
INSERT INTO HarryPotter.FilmActeur(filmId, acteurId, personageId)
VALUES (14, 30, 31);


--Tabel Discover invullen
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (1, 4);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (2, 5);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (3, 6);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (4, 7);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (5, 8);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (6, 9);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (7, 10);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (7, 11);
INSERT INTO HarryPotter.Discover(boekenId, filmId)
VALUES (8, 12);