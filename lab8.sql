1.

a)

SELECT nazwisko, placa_pod
FROM pracownicy
ORDER BY placa_pod DESC
FETCH FIRST 3 ROWS WITH TIES;

b)

SELECT ROWNUM AS pozycja, T.nazwisko, T.placa_pod
FROM (SELECT nazwisko, placa_pod
      FROM pracownicy
      ORDER BY placa_pod DESC) T
WHERE ROWNUM <= 3;

2.

SELECT nazwisko, placa_pod
FROM pracownicy
ORDER BY placa_pod DESC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS WITH TIES;


SELECT K.pozycja, K.nazwisko, K.placa_pod FROM(
SELECT ROWNUM AS pozycja, T.nazwisko, T.placa_pod
FROM (SELECT nazwisko, placa_pod
      FROM pracownicy
      ORDER BY placa_pod DESC) T) K
      WHERE pozycja BETWEEN 6 AND 10;

3.
WITH avg_placa AS
    (SELECT id_zesp, AVG(placa_pod) AS placa
    FROM pracownicy
    GROUP BY id_zesp)
SELECT p.nazwisko, p.placa_pod,(p.placa_pod - a.placa) AS roznica
FROM pracownicy p INNER JOIN avg_placa a
ON a.id_zesp = p.id_zesp
WHERE (p.placa_pod - a.placa) > 0
ORDER BY p.nazwisko;
   
4.
WITH lata AS
    (SELECT EXTRACT(YEAR FROM zatrudniony) AS rok, COUNT(id_prac) AS licz
    FROM pracownicy
    GROUP BY EXTRACT(YEAR FROM zatrudniony))
SELECT rok, licz
FROM lata
ORDER BY licz DESC;

5.
WITH lata AS
    (SELECT EXTRACT(YEAR FROM zatrudniony) AS rok, COUNT(id_prac) AS licz
    FROM pracownicy
    GROUP BY EXTRACT(YEAR FROM zatrudniony))
SELECT rok, licz
FROM lata
WHERE licz = (SELECT MAX(licz) FROM lata);  

6.

WITH asystenci AS 
    (SELECT p.id_zesp, p.nazwisko, p.etat, z.nazwa, z.adres 
    FROM pracownicy p INNER JOIN zespoly z
    ON p.id_zesp = z.id_zesp
    WHERE p.etat = 'ASYSTENT'),
    piotrowo AS 
    (SELECT id_zesp, nazwa, adres FROM zespoly WHERE adres = 'PIOTROWO 3A')
SELECT nazwisko, etat, nazwa, adres FROM asystenci a
WHERE EXISTS 
    (SELECT 'a' FROM piotrowo
    WHERE id_zesp = a.id_zesp);

7.
WITH zespoly_stat AS
    (SELECT z.nazwa, '1' AS col, SUM(p.placa_pod) AS MAKS_SUMA_PLAC
    FROM pracownicy p INNER JOIN zespoly z
    ON p.id_zesp = z.id_zesp
    GROUP BY z.nazwa)
SELECT nazwa, MAKS_SUMA_PLAC 
FROM zespoly_stat
WHERE MAKS_SUMA_PLAC  = (SELECT MAX(MAKS_SUMA_PLAC) FROM zespoly_stat)

8.

WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
        (SELECT id_prac, id_szefa, nazwisko, 1
        FROM pracownicy
        WHERE nazwisko = 'BRZEZINSKI'
        UNION ALL 
        SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1
        FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa) 
SELECT id_prac, id_szefa, nazwisko, poziom
FROM podwladni;

SELECT id_prac, id_szefa, nazwisko, LEVEL AS poziom
FROM pracownicy
CONNECT BY id_szefa = PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI' ORDER SIBLINGS BY nazwisko;

9.

WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
        (SELECT id_prac, id_szefa, nazwisko, 1
        FROM pracownicy
        WHERE nazwisko = 'BRZEZINSKI'
        UNION ALL 
        SELECT p.id_prac, p.id_szefa,  '  ' || p.nazwisko, poziom+1
        FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa) 
SELECT id_prac, id_szefa, nazwisko, poziom
FROM podwladni;



WITH podwladni (id_prac,id_szefa,nazwisko,poziom,prefix) AS (



    SELECT id_prac,id_szefa,nazwisko, 1,'' FROM pracownicy WHERE nazwisko='BRZEZINSKI' UNION ALL



    SELECT p.id_prac,p.id_szefa,' '||prefix||p.nazwisko,poziom+1,prefix||' ' FROM podwladni s JOIN pracownicy p ON s.id_prac=p.id_szefa



)



SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow



SELECT nazwisko, poziom FROM podwladni ORDER BY porzadek_potomkow