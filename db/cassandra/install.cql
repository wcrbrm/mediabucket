

CREATE KEYSPACE IF NOT EXISTS mediabucket 
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };


DROP TABLE IF EXISTS mediabucket.tags;
CREATE TABLE mediabucket.tags (
   tag        text,
   tm         timestamp,
   path       text,
   PRIMARY KEY ((tag), tm)
);

DROP TABLE IF EXISTS mediabucket.files;
CREATE TABLE mediabucket.files (
   hash       text PRIMARY KEY,
   tm         timestamp,
   path       text,
   tags       set<text>,
);
CREATE INDEX files_tags_idx ON mediabucket.files (tags);

INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash1', toTimestamp(now()), '1.jpg', { 'one', 'two', 'three' } );
INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash2', toTimestamp(now()), '2.jpg', { 'two', 'three' } );
INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash3', toTimestamp(now()), '3.jpg', { 'three' });

INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('one', toTimestamp(now()), '1.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('two', toTimestamp(now()), '1.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('three', toTimestamp(now()), '1.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('three', toTimestamp(now()), '2.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('two', toTimestamp(now()), '2.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('three', toTimestamp(now()), '3.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('.', toTimestamp(now()), '1.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('.', toTimestamp(now()), '2.jpg');
INSERT INTO mediabucket.tags (tag, tm, path) VALUES ('.', toTimestamp(now()), '3.jpg');

SELECT * FROM mediabucket.tags WHERE tag='three' ORDER BY tm DESC;

