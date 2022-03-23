REVOKE EXECUTE ON FUNCTION "public".register_new_player (varchar, int) FROM public_anonymous, public_user, public_player;
DROP FUNCTION "public".register_new_player (name varchar, quiz_run_id int);
DROP TYPE "public".new_player;