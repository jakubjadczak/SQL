1.

SELECT z.id_zesp, z.nazwa, z.adres
FROM zespoly z
WHERE NOT EXISTS
    (SELECT id_zesp FROM pracownicy p
    WHERE z.id_zesp = p.id_zesp)

2.

SELECT p.nazwisko, p.placa_pod, p.etat
FROM pracownicy p
WHERE p.placa_pod >
    (SELECT AVG(placa_pod)
    FROM pracownicy
    WHERE etat = p.etat)
ORDER BY p.placa_pod DESC;

3.

SELECT p.nazwisko, p.placa_pod
FROM pracownicy p
WHERE p.placa_pod >=
    0.75 * (SELECT s.placa_pod
    FROM pracownicy s
    WHERE p.id_szefa = s.id_prac)
ORDER BY p.nazwisko

4.

SELECT s.nazwisko
FROM pracownicy s
WHERE s.etat = 'PROFESOR' AND s.id_prac NOT IN
    (SELECT p.id_szefa
    FROM pracownicy p
    WHERE p.etat = 'STAZYSTA' AND p.id_szefa = s.id_prac);

5.

SELECT nazwa, maks_suma_plac.maks
    FROM (
    SELECT MAX(SUM(placa_pod)) AS maks
    FROM pracownicy
    GROUP BY id_zesp
    ) maks_suma_plac
INNER JOIN (
    SELECT id_zesp, SUM(placa_pod) AS suma
    FROM pracownicy
    GROUP BY id_zesp
    ) suma_plac_w_zespole ON maks_suma_plac.maks = suma_plac_w_zespole.suma
INNER JOIN zespoly ON suma_plac_w_zespole.id_zesp = zespoly.id_zesp  



6.

SELECT nazwisko, placa_pod
FROM pracownicy p
WHERE (
    SELECT COUNT(*)
    FROM pracownicy
    WHERE placa_pod > p.placa_pod) <= 2
ORDER BY placa_pod DESC



7.

SELECT EXTRACT( YEAR FROM zatrudniony), COUNT(*) FROM pracownicy GROUP BY EXTRACT( YEAR FROM zatrudniony) ORDER BY COUNT(*) DESC;

SELECT ROK,LICZBA FROM (SELECT EXTRACT(YEAR FROM zatrudniony) AS ROK, COUNT(*) AS LICZBA FROM pracownicy GROUP BY EXTRACT(YEAR FROM zatrudniony)) ORDER BY LICZBA DESC;



8.

SELECT extract( YEAR FROM zatrudniony), COUNT(*) 
FROM pracownicy 
GROUP BY extract( YEAR FROM zatrudniony) 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
                   FROM pracownicy 
                   GROUP BY extract( YEAR FROM zatrudniony));h



9.

SELECT nazwisko, placa_pod, placa_pod - (SELECT AVG(placa_pod) FROM pracownicy GROUP BY id_zesp HAVING p.id_zesp = id_zesp) AS ROZNICA
FROM pracownicy p
ORDER BY nazwisko;



10.

SELECT nazwisko, placa_pod, placa_pod - (SELECT AVG(placa_pod) FROM pracownicy group by id_zesp HAVING p.id_zesp = id_zesp) AS ROZNICA
FROM pracownicy p
WHERE placa_pod - (SELECT AVG(placa_pod) FROM pracownicy group by id_zesp HAVING p.id_zesp = id_zesp) > 0
ORDER BY nazwisko;



SELECT nazwisko, placa_pod, placa_pod-roznica as "ROZNICA" 
FROM (SELECT id_zesp, AVG(placa_pod) as roznica FROM pracownicy group by id_zesp) z INNER JOIN pracownicy p ON z.id_zesp=p.id_zesp 
WHERE (placa_pod - roznica) > 0
ORDER BY nazwisko;



11.

SELECT nazwisko, (SELECT COUNT(id_prac) FROM pracownicy WHERE id_szefa = s.id_prac) AS podwladni
FROM pracownicy s JOIN zespoly z USING(id_zesp)
WHERE etat = 'PROFESOR' AND adres LIKE 'PIOTROWO%';



12.

SELECT naz, sr_zesp, srednia, 
    CASE
        WHEN srednia <= sr_zesp THEN ':)'
        WHEN srednia > sr_zesp THEN ':('
        WHEN sr_zesp IS NULL THEN '???'
        END AS nAStruj
FROM (SELECT nazwa AS naz, AVG(placa_pod) AS sr_zesp 
      FROM zespoly z LEFT JOIN pracownicy p using(id_zesp) 
      group by nazwa) CROSS JOIN (SELECT ROUND(avg(placa_pod),2) AS srednia FROM pracownicy);



13.

SELECT * FROM etaty e
ORDER BY (SELECT COUNT(id_prac) FROM pracownicy WHERE e.nazwa = etat ) DESC, nazwa;

