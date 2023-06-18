1.

INSERT INTO pracownicy
VALUES (250, 'KOWALSKI', 'ASYSTENT', NULL, DATE '2015-01-13',
        1500, NULL, 10);
INSERT INTO pracownicy
VALUES (260, 'ADAMSKI', 'ASYSTENT', NULL, DATE '2014-09-10',
        1500, NULL, 10);
INSERT INTO pracownicy
VALUES (270, 'NOWAK', 'ADIUNKT', NULL, DATE '1990-05-01',
        2050, 540, 10);

SELECT * FROM pracownicy
WHERE id_prac >= 250;



2.

UPDATE pracownicy
SET placa_pod = placa_pod * 1.1,
    placa_dod = CASE
                    WHEN placa_dod IS NULL THEN 100
                    ELSE placa_dod * 1.2
                    END
WHERE id_prac >= 250;

SELECT * FROM pracownicy
WHERE id_prac >= 250;

3.

INSERT INTO zespoly
VALUES (60, 'BAZY DANYCH', 'PIOTROWO 2');

4.

UPDATE pracownicy
SET id_zesp = (SELECT id_zesp FROM zespoly
               WHERE nazwa = 'BAZY DANYCH')
WHERE id_prac >= 250;



5.

UPDATE pracownicy
SET id_szefa = (SELECT id_prac FROM pracownicy
                WHERE nazwisko = 'MORZY')
WHERE id_zesp = 60;



6.

DELETE FROM zespoly
WHERE nazwa = 'BAZY DANYCH';

Naruszono więzy spójności - istnieje relacja



7.

DELETE FROM pracownicy
WHERE id_zesp = (SELECT id_zesp FROM zespoly
                WHERE nazwa = 'BAZY DANYCH');
               
DELETE FROM zespoly
WHERE nazwa = 'BAZY DANYCH';

8.

SELECT p.nazwisko, placa_pod,
    (SELECT AVG(placa_pod)*0.1 FROM pracownicy
    WHERE id_zesp = p.id_zesp) AS podwyzka
FROM pracownicy p



9.

UPDATE pracownicy p
SET placa_pod = placa_pod +
    0.1*(SELECT AVG(placa_pod) FROM pracownicy
    WHERE id_zesp = p.id_zesp);

10.

SELECT * FROM pracownicy

WHERE placa_pod = (SELECT MIN(placa_pod) FROM pracownicy);

11.

UPDATE pracownicy p

SET placa_pod = (SELECT AVG(placa_pod) FROM pracownicy)

WHERE placa_pod = (SELECT MIN(placa_pod) FROM pracownicy);



12.

UPDATE pracownicy p 

SET placa_dod = 

    (SELECT AVG(placa_pod) FROM pracownicy

    WHERE id_szefa = 

        (SELECT id_prac FROM pracownicy WHERE nazwisko = 'MORZY')

    )

WHERE id_zesp = 20;



13.

UPDATE pracownicy

SET placa_pod = placa_pod*1.25

WHERE id_zesp = (SELECT id_zesp FROM zespoly WHERE nazwa = 'SYSTEMY ROZPROSZONE')



14.

DELETE FROM 

    (SELECT p.id_szefa

    FROM pracownicy p INNER JOIN pracownicy s

    ON p.id_szefa = s.id_prac)

WHERE id_szefa = (SELECT id_prac FROM pracownicy WHERE nazwisko = 'MORZY');



15.

SELECT * FROM pracownicy;



16.

CREATE SEQUENCE prac_seq START WITH 300 INCREMENT BY 10;



17.

INSERT INTO pracownicy (id_prac, nazwisko, etat, placa_pod)

VALUES (prac_seq.NEXTVAL, 'Trąbczyński', 'STAZYSTA', 1000);

18.

UPDATE pracownicy

SET placa_dod = prac_seq.CURRVAL

WHERE nazwisko = 'Trąbczyński';



19.

DELETE FROM pracownicy

WHERE nazwisko = 'Trąbczyński';



20.

CREATE SEQUENCE mala_seq START WITH 1 INCREMENT BY 1 MAXVALUE 10;

SELECT mala_seq.NEXTVAL FROM dual;



21.

DROP SEQUENCE mala_seq;