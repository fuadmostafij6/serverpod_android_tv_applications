BEGIN;


--
-- MIGRATION VERSION FOR tv_applications
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('tv_applications', '20250417180153963', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250417180153963', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
