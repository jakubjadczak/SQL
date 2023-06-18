1.

CREATE OR REPLACE VIEW asystenci (nazwisko, placa, staz)

AS SELECT nazwisko, placa_pod + COALESCE(placa_dod, 0), (DATE '2023-1-1' - zatrudniony) YEAR TO MONTH

FROM pracownicy

WHERE etat='ASYSTENT';

2.

CREATE OR REPLACE VIEW place (

    id_zesp, srednia, min_placa, max_placa,

    fundusz, l_pensji, l_dodatkow

) AS SELECT

    z.id_zesp,

    AVG(placa_pod),

    MIN(placa_pod),

    MAX(placa_pod),

    SUM(placa_pod) + SUM(placa_dod),

    COUNT(placa_pod),

    COUNT(placa_dod)

FROM pracownicy p JOIN zespoly z ON p.id_zesp = z.id_zesp

GROUP BY z.id_zesp;



3.

SELECT nazwisko, placa_pod

FROM pracownicy p JOIN place z ON p.id_zesp = z.id_zesp

WHERE p.placa_pod < z.srednia

ORDER BY nazwisko;



4.

CREATE OR REPLACE VIEW place_minimalne

AS SELECT

id_prac, nazwisko, etat, placa_pod

FROM pracownicy

WHERE placa_pod < 700

WITH CHECK OPTION CONSTRAINT chk_placa_pod;

5.

UPDATE place_minimalne

SET placa_pod = 800

WHERE nazwisko = 'HAPKE';

6.

CREATE OR REPLACE VIEW prac_szef (

    id_prac, id_szefa, pracownik, etat, szef

) AS SELECT

p.id_prac, p.id_szefa, p.nazwisko, p.etat, s.nazwisko

FROM pracownicy p JOIN pracownicy s ON p.id_szefa = s.id_prac;

7.

CREATE OR REPLACE VIEW zarobki

AS SELECT id_prac, id_szefa, nazwisko, etat, placa_pod

FROM pracownicy p

WHERE placa_pod <= (SELECT placa_pod FROM pracownicy WHERE id_prac=p.id_szefa)

WITH CHECK OPTION CONSTRAINT CHK_ZAROBKI;

8.

SELECT column_name, updatable, insertable, deletable

FROM user_updatable_columns

WHERE table_name = 'PRAC_SZEF';

