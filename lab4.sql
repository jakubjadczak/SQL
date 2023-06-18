1.

SELECT p.nazwisko, p.etat, p.id_zesp, z.nazwa
FROM pracownicy p INNER JOIN zespoly z
ON p.id_zesp = z.id_zesp;

2.

SELECT p.nazwisko, p.etat, p.id_zesp, z.nazwa
FROM pracownicy p INNER JOIN zespoly z
ON p.id_zesp = z.id_zesp
WHERE z.adres = 'PIOTROWO 3A';

3.

SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max
FROM pracownicy p INNER JOIN etaty e
ON p.etat = e.nazwa
ORDER BY p.etat, p.nazwisko;

4.

SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max,
CASE
    WHEN p.placa_pod BETWEEN e.placa_min AND e.placa_max THEN 'OK'
    WHEN p.placa_pod NOT BETWEEN e.placa_min AND e.placa_max THEN 'NIE'
END AS czy_pensja_ok FROM pracownicy p INNER JOIN etaty e
ON p.etat = e.nazwa 
ORDER BY p.etat, p.nazwisko;

5.

SELECT p.nazwisko, p.etat, p.placa_pod, e.placa_min, e.placa_max
FROM pracownicy p INNER JOIN etaty e
ON p.etat = e.nazwa 
WHERE p.placa_pod NOT BETWEEN e.placa_min AND placa_max
ORDER BY p.etat, p.nazwisko;

6.

SELECT p.nazwisko, p.placa_pod, p.etat, e.nazwa AS kat_plac, e.placa_min, e.placa_max
FROM pracownicy p INNER JOIN etaty e
ON p.placa_pod BETWEEN e.placa_min AND e.placa_max
ORDER BY p.nazwisko, e.nazwa;

7.

SELECT p.nazwisko, p.placa_pod, p.etat, e.nazwa AS kat_plac, e.placa_min, e.placa_max
FROM pracownicy p INNER JOIN etaty e
ON p.placa_pod BETWEEN e.placa_min AND e.placa_max
WHERE e.nazwa = 'SEKRETARKA'
ORDER BY p.nazwisko, e.nazwa;

8.

SELECT p.nazwisko AS pracownik, p.id_prac, s.nazwisko AS szef, s.id_prac
FROM pracownicy p INNER JOIN pracownicy s
ON p.id_szefa = s.id_prac
ORDER BY p.nazwisko;

9.

SELECT p.nazwisko AS pracownik, p.zatrudniony as prac_zatrudniony,
    s.nazwisko AS szef, s.zatrudniony AS szef_zatrudniony,
    (p.zatrudniony - s.zatrudniony) YEAR TO MONTH AS lata
FROM pracownicy p INNER JOIN pracownicy s
ON p.id_szefa = s.id_prac
WHERE (p.zatrudniony - s.zatrudniony) YEAR TO MONTH < INTERVAL '10-0' YEAR TO MONTH
ORDER BY lata, p.nazwisko;

10.

SELECT z.nazwa, COUNT(p.id_prac) as liczba, AVG(p.placa_pod) as srednia_placa
FROM pracownicy p INNER JOIN zespoly z
ON z.id_zesp = p.id_zesp
GROUP BY z.nazwa
ORDER BY z.nazwa;

11.

SELECT z.nazwa,
CASE 
    WHEN COUNT(p.id_prac) <= 2 AND COUNT(p.id_prac) > 0 THEN 'mały'
    WHEN COUNT(p.id_prac) > 2 AND COUNT(p.id_prac) < 7 THEN 'średni'
    WHEN COUNT(p.id_prac) > 6 THEN 'duży'
END AS etykieta FROM zespoly z INNER JOIN pracownicy p
ON p.id_zesp = z.id_zesp
GROUP BY z.nazwa;