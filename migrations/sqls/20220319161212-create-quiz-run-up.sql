CREATE TABLE "quiz_run" (
  "quiz_run_id" SERIAL PRIMARY KEY,
  "quiz_id" int NOT NULL,
  "finished" boolean,
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "quiz_run" IS '@omit create,delete';

ALTER TABLE "quiz_run" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("quiz_id");

GRANT SELECT ON TABLE "public"."quiz_run" TO public_user;
GRANT SELECT ON TABLE "public"."quiz_run" TO public_player;

