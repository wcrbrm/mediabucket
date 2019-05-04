CREATE TABLE files (
  "id" BIGSERIAL PRIMARY KEY,
  "tm" BIGINT NOT NULL DEFAULT '0',
  "realm" TEXT NOT NULL DEFAULT 'default',
  "tags" text[] NOT NULL DEFAULT '{}',

  "mediatype" TEXT NOT NULL DEFAULT '',
  "hash" TEXT NOT NULL DEFAULT '',
  "size" INT NOT NULL DEFAULT -1,
  "filename" TEXT
);

CREATE INDEX idx_files_tm ON files("tm");
CREATE INDEX idx_files_realm ON files("realm");
CREATE INDEX idx_files_hash ON files("hash");
CREATE INDEX idx_files_tags ON files USING gin("tags");

