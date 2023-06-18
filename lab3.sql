1.

SELECT MIN(placa_pod) as minimum, MAX(placa_pod) as maksimum, MAX(placa_pod) - MIN(placa_pod) as roznica FROM pracownicy;

2.
SELECT etat, AVG(placa_pod) as srednia FROM pracownicy GROUP BY etat;

3.
SELECT COUNT(etat) as profesorowie FROM pracownicy WHERE etat = 'PROFESOR';

4.
SELECT id_zesp, SUM(placa_pod) + SUM(placa_dod) as sumaryczne_place FROM pracownicy GROUP BY id_zesp;
5.
SELECT MAX(SUM(placa_pod) + SUM(placa_dod)) as maks_sum_placa FROM pracownicy GROUP BY id_zesp;

6.
SELECT id_szefa, MIN(placa_pod) as minimalna FROM pracownicy WHERE id_szefa IS NOT NULL GROUP BY id_szefa;

7.
SELECT id_zesp, COUNT(id_prac) FROM pracownicy GROUP BY id_zesp;

8.
SELECT id_zesp, COUNT(id_prac) FROM pracownicy GROUP BY id_zesp HAVING COUNT(id_prac) > 3;

9.
SELECT COUNT(id_prac) FROM pracownicy GROUP BY id_prac HAVING COUNT(id_prac) > 1;

10.
SELECT etat, AVG(placa_pod) as srednia, COUNT(id_prac) as liczba FROM pracownicy WHERE zatrudniony < DATE'1990-12-30' GROUP BY etat;

11.
SELECT id_zesp, etat, AVG(placa_pod + COALESCE(placa_dod, 0)) as srednia, MAX(placa_pod + COALESCE(placa_dod, 0)) as maksymalna
FROM pracownicy
WHERE etat IN ('PROFESOR', 'ASYSTENT')
GROUP BY id_zesp, etat;

12.
SELECT EXTRACT(YEAR FROM zatrudniony) as rok, COUNT(id_prac)
FROM pracownicy
GROUP BY EXTRACT(YEAR FROM zatrudniony)
ORDER BY rok;

13.
SELECT LENGTH(nazwisko) as ile_liter, COUNT(id_prac) as w_ilu_nazwiskach
FROM pracownicy
GROUP BY LENGTH(nazwisko)
ORDER BY ile_liter;

14.
SELECT COUNT(id_prac) as ile_nazwisk_z_a
FROM pracownicy
WHERE nazwisko LIKE '%A%';

15.
SELECT
COUNT(
CASE
WHEN nazwisko LIKE '%A%' THEN 'A'
END) as ile_nazwisk_z_a,
COUNT(
CASE
WHEN nazwisko LIKE '%E%' THEN 'E'
END) as ile_nazwisk_z_e
FROM pracownicy;

16.
SELECT id_zesp, SUM(placa_pod) as suma_plac, LISTAGG(nazwisko || ':' || placa_pod, ';') 
WITHIN GROUP (ORDER BY nazwisko) as pracownicy
FROM PRACOWNICY
GROUP BY id_zesp;