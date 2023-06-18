1.

CREATE TABLE projekty

    (id_projektu NUMBER(4) GENERATED ALWAYS AS IDENTITY,

     opis_projektu VARCHAR(20),

     data_rozpoczecia DATE DEFAULT CURRENT_DATE,

     data_zakonczenia DATE,

     fundusz NUMBER(7,2)

    )



2.

INSERT INTO projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz) VALUES

    ('Indeksy bitmapowe',  DATE '1994-04-02', DATE '2001-08-31', 25000);

INSERT INTO projekty (opis_projektu, fundusz) VALUES

    ('Sieci kręgosłupowe', 19000);



3.

SELECT id_projektu, opis_projektu FROM projekty;



4.

INSERT INTO projekty(opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz) VALUES

    ('Indeksy drzewiaste', DATE '2013-12-24', DATE '2014-1-1', 1200);



5.

UPDATE projekty 

    SET id_projektu = 10

WHERE opis_projektu = 'Indeksy drzewiaste'

Nie powiodła się

6.

CREATE TABLE projekty_kopia AS SELECT * FROM projekty;



7.

INSERT INTO projekty_kopia VALUES

    (10, 'Sieci lokalne', CURRENT_DATE, CURRENT_DATE + INTERVAL '1' YEAR, 24500);

Powiodło się ponieważ, ograniczenia integralnościowe nie sią kopiowane



8.

DELETE FROM projekty

WHERE opis_projektu = 'Indeksy drzewiaste';

Nie został usunięty z relacji projekty_kopia



9.

SELECT table_name FROM tabs ORDER BY table_name;

