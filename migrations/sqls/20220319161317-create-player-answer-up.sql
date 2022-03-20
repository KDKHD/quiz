CREATE TABLE "player_answer" (
  "player_answers_id" SERIAL PRIMARY KEY,
  "player_id" int NOT NULL,
  "question_id" int NOT NULL,
  "answer_id" int,
  "value" varchar,
  "answered_at" timestamp DEFAULT (now()),
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON TABLE "player_answer" IS '@omit update,delete';

ALTER TABLE "player_answer" ADD FOREIGN KEY ("player_id") REFERENCES "player" ("player_id");

ALTER TABLE "player_answer" ADD FOREIGN KEY ("question_id") REFERENCES "question" ("question_id");

ALTER TABLE "player_answer" ADD FOREIGN KEY ("answer_id") REFERENCES "answer" ("answer_id");

CREATE TRIGGER player_answer_player_id
    BEFORE INSERT ON "player_answer"
    FOR EACH ROW
    EXECUTE PROCEDURE "private".set_player_id();

GRANT ALL privileges ON TABLE "public"."quiz" TO public_player;
GRANT USAGE, SELECT ON SEQUENCE player_answer_player_answers_id_seq TO public_player;