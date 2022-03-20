CREATE TABLE "user" (
  "user_id" SERIAL PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "email" varchar NOT NULL UNIQUE CHECK ("email" ~* '^[a-zA-Z0-9.!#$%&*+\/=?^_{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'),
  "created_at" timestamp DEFAULT (now())
);

COMMENT ON COLUMN "user".user_id IS '@omit create,update 
Users unique identifier';
COMMENT ON COLUMN "user".first_name IS 'Users first name';
COMMENT ON COLUMN "user".last_name IS 'Users last name';
COMMENT ON COLUMN "user".email IS 'Users email address';

ALTER TABLE "public"."user" ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_user ON "public"."user" FOR SELECT TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY update_user ON "public"."user" FOR UPDATE TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY delete_user ON "public"."user" FOR DELETE TO public_user USING 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

CREATE POLICY insert_user ON "public"."user" FOR INSERT TO public_user WITH CHECK 
    (user_id = nullif (current_setting ('jwt.claims.user_id', TRUE), '')::integer);

GRANT ALL PRIVILEGES ON TABLE "public"."user" TO public_user;
