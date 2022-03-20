CREATE TABLE "quiz_run_question" (
  "quiz_run_question_id" SERIAL PRIMARY KEY,
  "quiz_run_id" int NOT NULL,
  "question_id" int NOT NULL,
  "promted_at" timestamp DEFAULT (now()),
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "quiz_run_question" IS '@omit create,update,delete';

ALTER TABLE "quiz_run_question" ADD FOREIGN KEY ("quiz_run_id") REFERENCES "quiz_run" ("quiz_run_id");

ALTER TABLE "quiz_run_question" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("question_id");

CREATE UNIQUE INDEX ON "quiz_run_question" ("quiz_run_id", "question_id");
