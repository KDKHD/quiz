CREATE TABLE "quiz_run_question" (
  "quiz_run_question_id" SERIAL PRIMARY KEY,
  "quiz_run_id" int NOT NULL,
  "question_id" int NOT NULL,
  "prompted_at" timestamp DEFAULT (now()),
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "quiz_run_question" IS '@omit create,update,delete';

ALTER TABLE "quiz_run_question" ADD FOREIGN KEY ("quiz_run_id") REFERENCES "quiz_run" ("quiz_run_id");

ALTER TABLE "quiz_run_question" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("question_id");

CREATE UNIQUE INDEX ON "quiz_run_question" ("quiz_run_id", "question_id");

CREATE POLICY select_player ON "public"."quiz_run_question" FOR SELECT TO public_player USING 
    (quiz_run_id = (SELECT quiz_run_id FROM private.current_player));

GRANT SELECT ON TABLE "public"."quiz_run_question" TO public_player;