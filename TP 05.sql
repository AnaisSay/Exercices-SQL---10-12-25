-- a. Mettez en minuscules la désignation de l'ARTICLE dont l'identifiant est 2
UPDATE ARTICLE SET DESIGNATION = LOWER(DESIGNATION) WHERE id = 2;
 
-- b. Mettez en majuscules les désignations de tous les articles dont le PRIX est strictement
-- supérieur à 10€
UPDATE ARTICLE SET DESIGNATION = UPPER(DESIGNATION) WHERE PRIX > 10;
 
-- c. Baissez de 10% le PRIX de tous les articles qui n'ont pas fait l'objet d'une commande.
UPDATE ARTICLE
    LEFT JOIN COMPO on ARTICLE.ID = COMPO.ID_ART
    SET PRIX = (PRIX * 0.9)
    WHERE ID_ART IS NULL;
 
-- d. Une erreur s'est glissée dans les commandes concernant Française d'imports. Les chiffres
-- en base ne sont pas bons.
-- Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE COMPO 
    INNER JOIN BON ON COMPO.ID_BON = BON.ID
    INNER JOIN FOURNISSEUR ON BON.ID_FOU = FOURNISSEUR.ID
    SET COMPO.QTE = (COMPO.QTE *2)
    WHERE FOURNISSEUR.NOM = 'Française d''Imports';
    
 
-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations.
-- Il vous faudra utiliser des fonctions comme substring et position.
UPDATE ARTICLE
    SET DESIGNATION =
    CONCAT(
        SUBSTR(
            DESIGNATION,
            1,
            POSITION('(' IN DESIGNATION) - 1
            ),
        SUBSTR(
            DESIGNATION,
            POSITION(')' IN DESIGNATION) +1
            )
    )
    WHERE POSITION('(' IN DESIGNATION) > 1;
 