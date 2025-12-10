-- Création de la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS COMPTA2;
USE COMPTA2;

-- Table des fournisseurs
CREATE TABLE IF NOT EXISTS FOURNISSEUR (
    ID INT NOT NULL PRIMARY KEY, 
    NOM VARCHAR(25) NOT NULL
);

-- Table des articles avec la clé étrangère ID_FOU qui référence le fournisseur
CREATE TABLE IF NOT EXISTS ARTICLE (
    ID INT NOT NULL PRIMARY KEY, 
    REF VARCHAR(13) NOT NULL, 
    DESIGNATION VARCHAR(255) NOT NULL, 
    PRIX DECIMAL(7,2) NOT NULL, 
    ID_FOU INT NOT NULL,
    CONSTRAINT FK_ARTICLE_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Table des bons de commande avec la clé étrangère ID_FOU qui référence le fournisseur
CREATE TABLE IF NOT EXISTS BON (
    ID INT NOT NULL PRIMARY KEY, 
    NUMERO INT, 
    DATE_CMDE DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    DELAI INT, 
    ID_FOU INT NOT NULL,
    CONSTRAINT FK_BON_FOU FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Table de composition des bons avec les clés étrangères ID_ART et ID_BON
CREATE TABLE IF NOT EXISTS COMPO (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    ID_ART INT NOT NULL, 
    ID_BON INT NOT NULL, 
    QTE INT NOT NULL,
    CONSTRAINT FK_COMPO_ART FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID),
    CONSTRAINT FK_COMPO_BON FOREIGN KEY (ID_BON) REFERENCES BON(ID)
);


-- Sélection de la base de données
USE COMPTA2;

-- Insertion des fournisseurs
INSERT INTO FOURNISSEUR (ID, NOM) 
VALUES 
(1, 'Française d''Imports'),
(2, 'FDM SA'),
(3, 'Dubois & Fils');

-- Insertion des articles
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) 
VALUES 
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d''encastrement', 8.14, 2);

-- Insertion du bon de commande auprès du fournisseur "Française d'Imports"
INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU) VALUES (1, 1, 3, 1);

-- Insertion de la composition du bon de commande n°001
INSERT INTO COMPO (ID_ART, ID_BON, QTE) VALUES
(1, 1, 3),  -- 3 Perceuses P1
(5, 1, 4),  -- 4 Meuleuses 125mm
(7, 1, 1);  -- 1 Perceuse à colonne
