TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;
TRUNCATE TABLE books RESTART IDENTITY;

INSERT INTO books (title, author_name) VALUES ('Book1','Author1');
INSERT INTO books (title, author_name) VALUES ('Book2','Author1');

INSERT INTO artists (name, genre) VALUES ('Michael Jackson', 'Pop');
INSERT INTO artists (name, genre) VALUES ('Elvis Presley', 'Rock');
INSERT INTO artists (name, genre) VALUES ('BB King', 'Blues');
INSERT INTO albums (title, release_year, artist_id) VALUES('Album1', '1999', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album2', '2001', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album3', '1974', 2);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album4', '1965', 3);