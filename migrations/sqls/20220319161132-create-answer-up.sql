CREATE TABLE "answer" (
  "answer_id" SERIAL PRIMARY KEY,
  "question_id" int NOT NULL,
  "img" varchar,
  "value" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "answer" IS '@omit update';

ALTER TABLE "answer" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("question_id");

GRANT ALL privileges ON TABLE "public"."answer" TO public_user;
GRANT USAGE, SELECT ON SEQUENCE answer_answer_id_seq TO public_user;