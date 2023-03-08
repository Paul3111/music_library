TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO artists (name, genre) VALUES ('Michael Jackson', 'Pop');
INSERT INTO artists (name, genre) VALUES ('Elvis Presley', 'Rock');
INSERT INTO artists (name, genre) VALUES ('BB King', 'Blues');
INSERT INTO albums (title, release_year, artist_id) VALUES('Album1', '1999', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album2', '2001', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album1', '1974', 2);
INSERT INTO albums (title, release_year, artist_id) VALUES('Album1', '1965', 3);