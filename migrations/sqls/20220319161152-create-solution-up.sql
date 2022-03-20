CREATE TABLE "solution" (
  "solution_id" SERIAL PRIMARY KEY,
  "question_id" int NOT NULL,
  "answer_id" int,
  "value" varchar,
  "created_at" timestamp DEFAULT (now())
);

ALTER TABLE "solution" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("question_id");
ALTER TABLE "solution" ADD FOREIGN KEY ("answer_id") REFERENCES "answer" ("answer_id");

GRANT ALL privileges ON TABLE "public"."solution" TO public_user;
GRANT USAGE, SELECT ON SEQUENCE solution_solution_id_seq TO public_user;

