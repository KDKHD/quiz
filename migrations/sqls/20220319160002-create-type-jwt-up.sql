CREATE TYPE "public".jwt AS (
    "role" text,
    "user_id" integer,
    "player_id" integer,
    "expires" bigint
);