CREATE TABLE "player" (
  "player_id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "quiz_run_id" int NOT NULL,
  "score" int DEFAULT 0 CHECK ("score" >= 0),
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "player" IS '@omit update,delete';

ALTER TABLE "player" ADD FOREIGN KEY ("quiz_run_id") REFERENCES "quiz_run" ("quiz_run_id");

CREATE UNIQUE INDEX ON "player" ("quiz_run_id", "name");
