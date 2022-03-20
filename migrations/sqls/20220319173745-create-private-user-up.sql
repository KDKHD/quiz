CREATE TABLE "private"."user" (
  "user_id" SERIAL PRIMARY KEY,
  "password_hash" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

ALTER TABLE "private"."user" ADD FOREIGN KEY ("user_id") REFERENCES "public"."user" ("user_id");
