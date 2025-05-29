BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "movie" (
    "id" bigserial PRIMARY KEY,
    "title" text,
    "url" text,
    "thumbnail" bytea,
    "thumbnailUrl" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tv" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "url" text NOT NULL,
    "type" text NOT NULL,
    "shows" json,
    "channelsUrl" text,
    "thumbnail" bytea,
    "thumbnailUrl" text NOT NULL
);


--
-- MIGRATION VERSION FOR tv_applications
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('tv_applications', '20250418163235236', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250418163235236', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
