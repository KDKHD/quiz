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

ALTER TABLE "public"."player" ENABLE ROW LEVEL SECURITY;

CREATE VIEW private.current_player AS
    (SELECT * FROM public.player WHERE player_id = current_setting ('jwt.claims.player_id')::integer);

GRANT SELECT ON TABLE "private"."current_player" TO public_player;

CREATE POLICY select_player ON "public"."player" FOR SELECT TO public_player USING 
    (quiz_run_id = (SELECT quiz_run_id FROM private.current_player));

GRANT SELECT ON TABLE "public"."player" TO public_player;

CREATE POLICY select_question_player ON "public"."question" FOR SELECT TO public_player USING 
    (EXISTS(SELECT 1 FROM quiz_run
             WHERE quiz_run.quiz_id = "question".quiz_id
               AND quiz_run.quiz_run_id = (SELECT quiz_run_id FROM private.current_player)
            ));
