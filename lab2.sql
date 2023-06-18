1.

SELECT nazwisko, (SUBSTR(etat, 1, 2) || id_prac) AS kod FROM pracownicy;

2. 

SELECT nazwisko, TRANSLATE(nazwisko, 'KLM', 'XXX') AS wojna_literom FROM pracownicy;

3. 

SELECT nazwisko FROM pracownicy WHERE INSTR(SUBSTR(nazwisko, 1, FLOOR(LENGTH(nazwisko)/2)), 'L', 1, 1) > 0;

4.
SELECT nazwisko, ROUND(placa_pod+placa_pod*0.15, 0) AS podwyzka FROM pracownicy;

5.
SELECT nazwisko, placa_pod, (placa_pod*0.2) AS inwestycja, ROUND(placa_pod*0.2*POWER((1+(10/100)), 10), 6) AS kapital, ROUND(placa_pod*0.2*POWER((1+(10/100)), 10), 6) - placa_pod*0.2 AS zysk
FROM pracownicy;

6.
SELECT nazwisko, TO_CHAR(zatrudniony, 'YY/MM/DD') as zatrudniony, (DATE'2000-01-01'-zatrudniony) YEAR TO MONTH AS staz_w_2000 FROM pracownicy;

7.
SELECT nazwisko, TO_CHAR(zatrudniony, 'MONTH, dd, yyyy') AS data_zatrudnienia FROM pracownicy WHERE id_zesp='20';

8.
SELECT TO_CHAR(CURRENT_DATE, 'DAY') AS dzis FROM dual;

9.
SELECT nazwa, adres,
CASE adres
WHEN 'MIELZYNSKIEGO 30' THEN 'Stare Miasto'
WHEN 'STRZELECKA 14' THEN 'Stare Miasto'
WHEN 'PIOTROWO 3A' THEN 'Nowe Miasto'
WHEN 'WLODKOWICA 16' THEN 'Grunwald'
END AS dzielnica FROM zespoly;

10. 
SELECT nazwisko, placa_pod,
CASE
WHEN placa_pod < 480 THEN 'Ponizej 480'
WHEN placa_pod = 480 THEN 'Dokladnie 480'
WHEN placa_pod > 480 THEN 'Powyzej 480'
END AS prog FROM pracownicy;