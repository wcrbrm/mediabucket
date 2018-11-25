

CREATE KEYSPACE IF NOT EXISTS mediabucket 
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

DROP TABLE IF EXISTS mediabucket.files;
CREATE TABLE mediabucket.files (
   hash       text,
   tm         timestamp,
   path       text,
   tags       set<text>,
   PRIMARY KEY (hash, tm)
) WITH CLUSTERING ORDER BY (tm DESC);

CREATE INDEX files_tags_idx ON mediabucket.files (tags);

INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash1', toTimestamp(now()), '1.jpg', { 'one', 'two', 'three' } );
INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash2', toTimestamp(now()), '2.jpg', { 'two', 'three' } );
INSERT INTO mediabucket.files (hash, tm, path, tags) 
VALUES ('fileHash3', toTimestamp(now()), '3.jpg', { 'three' });

SELECT * FROM mediabucket.files WHERE tags CONTAINS 'three';

