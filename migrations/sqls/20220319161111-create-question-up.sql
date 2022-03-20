CREATE TABLE "question" (
  "question_id" SERIAL PRIMARY KEY,
  "quiz_id" int NOT NULL,
  "type" question_type NOT NULL,
  "img" varchar,
  "prompt_duration_seconds" integer DEFAULT 60,
  "answer_duration_seconds" integer DEFAULT 120,
  "question" varchar NOT NULL,
  "order" int NOT NULL CHECK ("order" >= 0),
  "created_at" timestamp DEFAULT (now())
);

ALTER TABLE "question" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("quiz_id");

CREATE UNIQUE INDEX ON "question" ("quiz_id", "order");

ALTER TABLE "public"."question" ENABLE ROW LEVEL SECURITY;

-- Add policy to allow players to see questions

CREATE POLICY select_question ON "public"."question" FOR SELECT TO public_user USING 
    (EXISTS(SELECT 1 FROM quiz
             WHERE quiz.quiz_id = "question".quiz_id
               AND quiz.user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer
            ));

CREATE POLICY update_question ON "public"."question" FOR SELECT TO public_user USING 
    (EXISTS(SELECT 1 FROM quiz
             WHERE quiz.quiz_id = "question".quiz_id
               AND quiz.user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer
            ));

CREATE POLICY delete_question ON "public"."question" FOR SELECT TO public_user USING 
    (EXISTS(SELECT 1 FROM quiz
             WHERE quiz.quiz_id = "question".quiz_id
               AND quiz.user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer
            ));

CREATE POLICY insert_question ON "public"."question" FOR INSERT TO public_user WITH CHECK 
    (EXISTS(SELECT 1 FROM quiz
             WHERE quiz.quiz_id = "question".quiz_id
               AND quiz.user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer
            ));

GRANT ALL privileges ON TABLE "public"."question" TO public_user;
GRANT USAGE, SELECT ON SEQUENCE question_question_id_seq TO public_user;
