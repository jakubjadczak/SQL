1. SELECT * FROM ZESPOLY ORDER BY id_zesp;

2. SELECT * FROM PRACOWNICY ORDER BY id_prac;

3. SELECT nazwisko, (placa_pod*12) as ROCZNA_PLACA FROM PRACOWNICY ORDER BY nazwisko;

4. SELECT nazwisko, etat, (NVL(placa_pod, 0)+ NVL(placa_dod, 0)) AS miesieczne_zarobki FROM PRACOWNICY ORDER BY miesieczne_zarobki DESC;

5. SELECT * FROM ZESPOLY ORDER BY nazwa;

6. SELECT UNIQUE etat FROM PRACOWNICY ORDER BY etat;

7. SELECT * FROM pracownicy WHERE etat = 'ASYSTENT' ORDER BY nazwisko;

8. SELECT ID_PRAC, NAZWISKO, ETAT, PLACA_POD, ID_ZESP FROM pracownicy WHERE id_zesp IN ('30', '40') ORDER BY PLACA_POD DESC;

9. SELECT NAZWISKO, ETAT, ID_ZESP, PLACA_POD FROM pracownicy WHERE PLACA_POD BETWEEN 300 AND 800 ORDER BY nazwisko;

10.SELECT NAZWISKO, ETAT, ID_ZESP FROM pracownicy WHERE NAZWISKO LIKE '%SKI' ORDER BY nazwisko;

11.SELECT ID_PRAC, ID_SZEFA, NAZWISKO, PLACA_POD FROM pracownicy WHERE PLACA_POD > 1000 AND id_szefa IS NOT NULL;

12.SELECT NAZWISKO, ID_ZESP FROM pracownicy WHERE ID_ZESP = '20' AND (nazwisko LIKE 'M%' OR nazwisko LIKE '%SKI') ORDER BY nazwisko;

13.SELECT nazwisko, etat, NVL(placa_pod, 0)/8/20 as stawka FROM pracownicy WHERE etat NOT IN ('ADIUNKT', 'ASYSTENT', 'STAZYSTA') AND placa_pod NOT BETWEEN 400 AND 800 ORDER BY stawka;

14.SELECT nazwisko, etat, placa_pod, placa_dod FROM pracownicy WHERE (NVL(placa_pod, 0) + NVL(placa_dod, 0)) > 1000 ORDER BY etat, nazwisko;

15.SELECT (nazwisko || ' pracuje od ' || zatrudniony || ' i zarabia ' || placa_pod) AS profesorowie FROM pracownicy WHERE etat='PROFESOR' ORDER BY placa_pod DESC; 

