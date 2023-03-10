CREATE TABLE albums (
    id SERIAL,
    title TEXT,
    release_year TEXT,
    artist_id INTEGER
);

CREATE TABLE artists (
    id SERIAL,
    name TEXT,
    genre TEXT
    );