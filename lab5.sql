1.

SELECT p.nazwisko, p.id_zesp, z.nazwa
FROM pracownicy p RIGHT OUTER JOIN zespoly z
ON p.id_zesp = z.id_zesp;

2.

SELECT z.nazwa,
CASE
    WHEN p.nazwisko IS NULL THEN 'brak pracowników'
    ELSE CAST(p.nazwisko AS VARCHAR(15)
    )
END AS nazwisko
FROM zespoly z FULL OUTER JOIN pracownicy p
ON z.id_zesp = p.id_zesp
ORDER BY z.nazwa, p.nazwisko;

3.

SELECT
CASE
    WHEN z.nazwa IS NULL THEN 'brak zespołu'
    ELSE CAST(z.nazwa AS VARCHAR(25))
END AS zespol,
CASE
    WHEN p.nazwisko IS NULL THEN 'brak pracowników'
    ELSE CAST(p.nazwisko AS VARCHAR(15))
END AS nazwisko
FROM zespoly z FULL OUTER JOIN pracownicy p
ON z.id_zesp = p.id_zesp
ORDER BY z.nazwa, p.nazwisko;

4.

SELECT z.nazwa, COUNT(p.id_prac) as liczba, SUM(placa_pod) AS suma_plac
FROM zespoly z LEFT OUTER JOIN pracownicy p
ON z.id_zesp = p.id_zesp
GROUP BY z.nazwa;

5.

SELECT z.nazwa
FROM zespoly z LEFT OUTER JOIN pracownicy p
ON z.id_zesp = p.id_zesp
GROUP BY z.nazwa
HAVING COUNT(p.id_prac)=0
ORDER BY z.nazwa;

6.

SELECT p.nazwisko, p.id_prac, s.nazwisko AS szef, s.id_prac AS id_szefa
FROM pracownicy p LEFT OUTER JOIN pracownicy s
ON p.id_szefa = s.id_prac
ORDER BY p.nazwisko;

7.

SELECT s.nazwisko, COUNT(p.id_prac)
FROM pracownicy s LEFT OUTER JOIN pracownicy p
ON p.id_szefa = s.id_prac
GROUP BY s.nazwisko;

8.
SELECT p.nazwisko, p.etat, p.placa_pod, z.nazwa, s.nazwisko AS szef
FROM pracownicy p LEFT OUTER JOIN pracownicy s
ON p.id_szefa = s.id_prac
LEFT OUTER JOIN zespoly z
ON p.id_zesp = z.id_zesp
ORDER BY p.nazwisko;

9.
SELECT p.nazwisko, z.nazwa
FROM pracownicy p CROSS JOIN zespoly z;

10.
SELECT COUNT(*)
FROM etaty CROSS JOIN zespoly CROSS JOIN pracownicy;

11.
SELECT etat
FROM pracownicy 
WHERE EXTRACT(YEAR FROM zatrudniony) = 1992
INTERSECT
SELECT etat 
FROM pracownicy 
WHERE EXTRACT(YEAR FROM zatrudniony) = 1993
ORDER BY etat;

12.
SELECT id_zesp FROM zespoly 
MINUS
SELECT id_zesp FROM pracownicy;

13.
SELECT ID_ZESP, NAZWA FROM ZESPOLY
    MINUS
    SELECT Z.ID_ZESP, Z.NAZWA FROM PRACOWNICY P JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP;

14.
SELECT nazwisko, placa_pod,
DECODE (SIGN(placa_pod-480),
    -1, 'Poniżej 480 złotych',
     0, 'Dokładnie 480 złotych',
     1, 'Powyżej 480 złotych',
    CAST(placa_pod AS VARCHAR(30))) AS prog
FROM pracownicy 
ORDER BY placa_pod;
