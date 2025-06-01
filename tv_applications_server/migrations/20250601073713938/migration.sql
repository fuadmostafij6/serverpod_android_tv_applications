BEGIN;


--
-- MIGRATION VERSION FOR tv_applications
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('tv_applications', '20250601073713938', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250601073713938', "timestamp" = now();

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
