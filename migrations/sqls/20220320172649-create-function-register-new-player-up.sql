CREATE TYPE "public".new_player AS (
    "player" "public".player,
    "token" "public".jwt
);


CREATE FUNCTION "public".register_new_player (
        name varchar,
        quiz_run_id int
    ) RETURNS "public".new_player 
    AS $$
DECLARE
    new_player "public"."player";
BEGIN
    INSERT INTO "public"."player" (
        "name",
        "quiz_run_id"
    ) VALUES (
        name,
        quiz_run_id
    ) RETURNING * INTO new_player;

    RETURN (new_player, (('public_player', NULL, new_player.player_id, extract(epoch FROM (now() + interval '1 days'))) :: "public".jwt));
END;
$$ 
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;