1.
ALTER TABLE projekty ADD
( CONSTRAINT pk_projekty PRIMARY KEY(id_projektu),
 CONSTRAINT uk_projaktu UNIQUE(opis_projektu),
 CHECK(data_zakonczenia > data_rozpoczecia),
 CHECK(fundusz >= 0) ) MODIFY opis_projektu NOT NULL;

 SELECT k.constraint_name, k.constraint_type, k.search_condition, c.column_name
FROM user_constraints k INNER JOIN user_cons_columns c
ON k.constraint_name = c.constraint_name
WHERE k.table_name = 'PROJEKTY'
ORDER BY k.constraint_name;

 2.
INSERT INTO projekty(opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz) VALUES
 ('Indeksy bitmapowe', DATE '2015-09-12', DATE '2016-09-30', 40000)
 Przyczyną błędu jest naruszenie unikatowości kolumny opis_projektu

 3. CREATE TABLE przydzialy
( id_projektu NUMBER(4) CONSTRAINT fk_przydzialy_01 REFERENCES projekty(id_projektu) NOT NULL,
 nr_pracownika NUMBER(6) CONSTRAINT fk_przydzialy_02 REFERENCES pracownicy(id_prac) NOT NULL,
 od DATE DEFAULT CURRENT_DATE,
 do DATE,
 stawka NUMBER(7,2) CONSTRAINT chk_przydzialy_stawka CHECK(stawka>0),
 rola VARCHAR(20) CONSTRAINT chk_przydzialy_rola CHECK(rola IN ('KIERUJĄCY', 'ANALITYK', 'PROGRAMISTA')), CONSTRAINT pk_przydzialy PRIMARY KEY(id_projektu, nr_pracownika),
 CONSTRAINT chk_przydzialy_daty CHECK(do>od) )

 4
INSERT INTO przydzialy

    VALUES((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Indeksy bitmapowe'), 170, DATE '1999-4-10', DATE '1999-5-10', 1000, 'KIERUJĄCY'

    );

    

INSERT INTO przydzialy(id_projektu, nr_pracownika, od, stawka, rola)

    VALUES((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Indeksy bitmapowe'), 140, DATE '2000-12-1', 1500, 'ANALITYK'

    );

    

INSERT INTO przydzialy(id_projektu, nr_pracownika, od, stawka, rola)

    VALUES((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Sieci kręgosłupowe'), 140, DATE '2015-9-14', 2500, 'KIERUJĄCY'

    );    



5.

ALTER TABLE przydzialy ADD (

    godziny NUMBER(4) CONSTRAINT max_godziny CHECK(godziny<=9999),

    CONSTRAINT godziny NOT NULL

)



6.

ALTER TABLE przydzialy ADD (

    godziny NUMBER(4) CONSTRAINT max_godziny CHECK(godziny<=9999)

);

UPDATE przydzialy SET godziny=100;

ALTER TABLE przydzialy MODIFY godziny NOT NULL;



7.

ALTER TABLE projekty DISABLE CONSTRAINT uk_projaktu;

SELECT constraint_name, status

FROM user_constraints

8.

INSERT INTO projekty(opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)

VALUES ('Indeksy bitmapowe', DATE '2015-4-12', DATE '2016-9-30', 40000)

SELECT * FROM projekty;

9.

ALTER TABLE projekty ENABLE CONSTRAINT uk_projaktu;

Nie udało się włączyć ograniczenia



10.

UPDATE projekty 

SET opis_projektu='Inne indeksy'

WHERE id_projektu=5;

ALTER TABLE projekty ENABLE CONSTRAINT uk_projaktu;



11.

ALTER TABLE projekty MODIFY opis_projektu VARCHAR(10);

Zmiana się nie powiodła, nie można zmniejszyć długości kolumny

12.

DELETE FROM projekty

WHERE opis_projektu='Sieci kręgosłupowe'

Nie można usunąć, naruszono więzy integralności

13.

ALTER TABLE przydzialy DROP CONSTRAINT fk_przydzialy_01;

ALTER TABLE przydzialy ADD CONSTRAINT fk_przydzialy_01 FOREIGN KEY(id_projektu) REFERENCES projekty(id_projektu) ON DELETE CASCADE;

DELETE FROM projekty WHERE opis_projektu = 'Sieci kręgosłupowe';

SELECT * FROM projekty;

SELECT * FROM przydzialy;

14.

DROP TABLE projekty CASCADE CONSTRAINTS;

SELECt constraint_name, constraint_type, search_condition

FROM user_constraints

WHERE table_name = 'PRZYDZIALY'

ORDER BY constraint_name;

15.

DROP TABLE przydzialy;

DROP TABLE projekty_kopia;

SELECT table_name FROM user_tables;

