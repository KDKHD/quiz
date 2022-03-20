CREATE TABLE "quiz" (
  "quiz_id" SERIAL PRIMARY KEY,
  "user_id" int,
  "name" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

ALTER TABLE "quiz" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");

ALTER TABLE "public"."quiz" ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_quiz ON "public"."quiz" FOR SELECT TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY update_quiz ON "public"."quiz" FOR UPDATE TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY delete_quiz ON "public"."quiz" FOR DELETE TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY insert_quiz ON "public"."quiz" FOR INSERT TO public_user WITH CHECK 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE TRIGGER quiz_user_id
    BEFORE INSERT ON "quiz"
    FOR EACH ROW
    EXECUTE PROCEDURE "private".set_user_id();

GRANT ALL privileges ON TABLE "public"."quiz" TO public_user;
GRANT USAGE, SELECT ON SEQUENCE quiz_quiz_id_seq TO public_user;
