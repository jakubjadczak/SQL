1.

SELECT nazwisko, etat, id_zesp
FROM pracownicy
WHERE id_zesp =
    (SELECT id_zesp
    FROM pracownicy
    WHERE nazwisko = 'BRZEZINSKI');



2.

SELECT p.nazwisko, p.etat, z.nazwa
FROM pracownicy p INNER JOIN zespoly z
ON p.id_zesp = z.id_zesp
WHERE p.id_zesp =
    (SELECT id_zesp
    FROM pracownicy
    WHERE nazwisko = 'BRZEZINSKI');

3.

SELECT nazwisko, etat, zatrudniony
FROM pracownicy
WHERE etat = 'PROFESOR'
    AND zatrudniony =
    (SELECT MIN(zatrudniony)
    FROM pracownicy
    WHERE etat = 'PROFESOR');

4

SELECT nazwisko, zatrudniony, id_zesp

FROM pracownicy WHERE (zatrudniony, id_zesp) IN

(SELECT MAX(zatrudniony), id_zesp FROM pracownicy GROUP BY id_zesp);

5.

SELECT id_zesp, nazwa, adres FROM zespoly

WHERE id_zesp IS NOT NULL AND id_zesp NOT IN (

	SELECT DISTINCT id_zesp

	FROM pracownicy

);


6.

SELECT nazwisko
FROM pracownicy
WHERE etat = 'PROFESOR' AND id_prac NOT IN
    (SELECT id_szefa
    FROM pracownicy
    WHERE etat = 'STAZYSTA' AND id_szefa IS NOT NULL);
   

7.

SELECT id_zesp, SUM(placa_pod) AS suma_plac
FROM pracownicy
GROUP BY id_zesp
HAVING SUM(placa_pod) =
    (SELECT MAX(SUM(placa_pod))
    FROM pracownicy
    GROUP BY id_zesp);

8.

SELECT z.nazwa, SUM(p.placa_pod) AS suma_plac
FROM pracownicy p FULL OUTER JOIN zespoly z
ON z.id_zesp = p.id_zesp
GROUP BY z.nazwa
HAVING SUM(placa_pod) =
    (SELECT MAX(SUM(placa_pod))
    FROM pracownicy
    GROUP BY id_zesp);

9.

SELECT z.nazwa, COUNT(p.id_prac) AS ilu_pracownikow
FROM pracownicy p INNER JOIN zespoly z
ON p.id_zesp = z.id_zesp
GROUP BY z.nazwa
HAVING COUNT(p.id_prac) >
    (SELECT COUNT(p.id_prac)
    FROM pracownicy p INNER  JOIN zespoly z
    ON p.id_zesp = z.id_zesp
    WHERE z.nazwa = 'ADMINISTRACJA'
    GROUP BY p.id_zesp)
ORDER BY z.nazwa;

10.

SELECT etat
FROM pracownicy
GROUP BY etat
HAVING COUNT(id_prac) =
    (SELECT MAX(COUNT(id_prac))
    FROM pracownicy
    GROUP BY etat);



11.

SELECT etat,
LISTAGG(nazwisko, ',')
WITHIN GROUP(ORDER BY nazwisko) AS pracownicy
FROM pracownicy
GROUP BY etat
HAVING COUNT(id_prac) =
    (SELECT MAX(COUNT(id_prac))
    FROM pracownicy
    GROUP BY etat);

12.

SELECT p.nazwisko AS pracownik, s.nazwisko AS szef
FROM pracownicy p INNER JOIN pracownicy s
ON p.id_szefa = s.id_prac
WHERE (s.placa_pod-p.placa_pod) =
    (SELECT MIN(s.placa_pod-p.placa_pod)
    FROM pracownicy p INNER JOIN pracownicy s
    ON p.id_szefa = s.id_prac
    )

