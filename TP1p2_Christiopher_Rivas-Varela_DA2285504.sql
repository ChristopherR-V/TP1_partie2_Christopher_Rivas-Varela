-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:Christopher Rivas-Varela                        Votre DA: 2285504
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
 REQUETE1: DESC OUTILS_EMPRUNT

 REQUETE2: DESC OUTILS_USAGER

 REQUETE3: DESC OUTILS_OUTIL

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(NOM_FAMILLE,' ',PRENOM) AS NOM_COMPLET
FROM OUTILS_USAGER

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT VILLE
FROM OUTILS_USAGER
ORDER BY VILLE

-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT*
FROM OUTILS_OUTIL
ORDER BY NOM

SELECT*
FROM OUTILS_OUTIL
ORDER BY CODE_OUTIL

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT CODE_OUTIL
FROM OUTILS_EMPRUNT
WHERE DATE_RETOUR IS NULL

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < '01-JAN-14'

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE UPPER(CARACTERISTIQUES) LIKE '%, J%,%'

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE FABRICANT LIKE 'Stanley'

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT CODE_OUTIL, FABRICANT
FROM OUTILS_OUTIL
WHERE ANNEE>2006 AND ANNEE<2008

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT CODE_OUTIL, FABRICANT
FROM OUTILS_OUTIL
WHERE NOT CARACTERISTIQUES LIKE '%20 VOLT%'

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS NBR_OUTILS
FROM OUTILS_OUTIL
WHERE NOT FABRICANT LIKE 'MAKITA'

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT OUTILS_OUTIL.PRIX, OUTILS_EMPRUNT.NUM_EMPRUNT,
        CONCAT(OUTILS_USAGER.NOM_FAMILLE, OUTILS_USAGER.PRENOM) AS NOM_COMPLET,
        TO_DATE(OUTILS_EMPRUNT.DATE_RETOUR) - TO_DATE(OUTILS_EMPRUNT.DATE_EMPRUNT) AS DUREE_EMPRUNT
FROM OUTILS_OUTIL
FULL OUTER JOIN OUTILS_EMPRUNT ON OUTILS_OUTIL.CODE_OUTIL = OUTILS_EMPRUNT.CODE_OUTIL
FULL OUTER JOIN OUTILS_USAGER ON OUTILS_EMPRUNT.NUM_USAGER = OUTILS_USAGER.NUM_USAGER
WHERE DATE_EMPRUNT IS NOT NULL
AND DATE_RETOUR IS NOT NULL
AND PRIX IS NOT NULL
AND OUTILS_USAGER.VILLE IN ('Vancouver', 'Regina')

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT OUTILS_OUTIL.CODE_OUTIL, OUTILS_OUTIL.NOM
FROM OUTILS_OUTIL
JOIN OUTILS_EMPRUNT ON OUTILS_OUTIL.CODE_OUTIL = OUTILS_EMPRUNT.CODE_OUTIL
WHERE OUTILS_EMPRUNT.DATE_RETOUR IS NULL

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT OUTILS_USAGER.NOM_FAMILLE, OUTILS_USAGER.COURRIEL
FROM OUTILS_USAGER
WHERE OUTILS_USAGER.NUM_USAGER IN (234, 456)

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT OUTILS_OUTIL.CODE_OUTIL, OUTILS_OUTIL.PRIX
FROM OUTILS_OUTIL
    LEFT OUTER JOIN OUTILS_EMPRUNT
    ON OUTILS_OUTIL.CODE_OUTIL = OUTILS_EMPRUNT.CODE_OUTIL
WHERE OUTILS_OUTIL.PRIX IS NOT NULL

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT PRIX, NOM, coalesce(PRIX, AVG(PRIX) OVER())
FROM OUTILS_OUTIL
WHERE FABRICANT LIKE 'Makita'
    AND PRIX > (SELECT AVG(PRIX) FROM OUTILS_OUTIL)

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT OUTILS_USAGER.PRENOM, OUTILS_USAGER.NOM_FAMILLE, OUTILS_USAGER.ADRESSE,
        OUTILS_OUTIL.CODE_OUTIL
FROM OUTILS_USAGER
    JOIN OUTILS_EMPRUNT ON OUTILS_USAGER.NUM_USAGER = OUTILS_EMPRUNT.NUM_USAGER
    JOIN OUTILS_OUTIL ON OUTILS_EMPRUNT.CODE_OUTIL = OUTILS_OUTIL.CODE_OUTIL
WHERE OUTILS_EMPRUNT.DATE_EMPRUNT > '01-JAN-14'

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT OUTILS_OUTIL.NOM, OUTILS_OUTIL.PRIX
FROM OUTILS_OUTIL
    JOIN OUTILS_EMPRUNT ON OUTILS_OUTIL.CODE_OUTIL = OUTILS_EMPRUNT.CODE_OUTIL
GROUP BY OUTILS_OUTIL.NOM, OUTILS_OUTIL.PRIX
HAVING COUNT(OUTILS_EMPRUNT.CODE_OUTIL) > 1

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT OUTILS_USAGER.PRENOM, OUTILS_USAGER.ADRESSE, OUTILS_USAGER.VILLE
FROM OUTILS_USAGER
    JOIN OUTILS_EMPRUNT ON OUTILS_USAGER.NUM_USAGER = OUTILS_EMPRUNT.NUM_USAGER

--  IN
SELECT OUTILS_USAGER.PRENOM, OUTILS_USAGER.ADRESSE, OUTILS_USAGER.VILLE
FROM OUTILS_USAGER
WHERE NOT NUM_USAGER IN (234, 456)

--  EXISTS
SELECT OUTILS_USAGER.PRENOM, OUTILS_USAGER.ADRESSE, OUTILS_USAGER.VILLE
FROM OUTILS_USAGER
WHERE EXISTS(SELECT OUTILS_EMPRUNT.NUM_USAGER FROM OUTILS_EMPRUNT WHERE OUTILS_USAGER.NUM_USAGER = OUTILS_EMPRUNT.NUM_USAGER)

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT, AVG(PRIX) AS MOYENNE_DES_PRIX
FROM OUTILS_OUTIL
GROUP BY FABRICANT

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT OUTILS_USAGER.VILLE, SUM(OUTILS_OUTIL.PRIX) AS SOMME_DES_PRIX
FROM OUTILS_OUTIL
    JOIN OUTILS_EMPRUNT ON OUTILS_OUTIL.CODE_OUTIL = OUTILS_EMPRUNT.CODE_OUTIL
    JOIN OUTILS_USAGER ON OUTILS_EMPRUNT.NUM_USAGER = OUTILS_USAGER.NUM_USAGER
GROUP BY OUTILS_USAGER.VILLE
ORDER BY SOMME_DES_PRIX DESC

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('FA16', 'SCIE ELECTRIQUE', 'TONKA', 'JAUNE, 22CM PAR 23CM', 2019, 100)

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL,NOM,ANNEE)
VALUES ('HE78', 'HACHE', 2017)

-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE
FROM OUTILS_OUTIL
WHERE NOM LIKE 'SCIE ELECTRIQUE'
AND NOM LIKE 'HACHE'

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE)
