BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "tv" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "media" (
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
    VALUES ('tv_applications', '20250601072614237', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250601072614237', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
