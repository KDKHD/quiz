CREATE FUNCTION "private".can_player_sublit_score ()
    RETURNS TRIGGER
    AS $$
DECLARE
    player "public"."player";
    quiz_run_question "public"."quiz_run_question";
    question "public"."question";
BEGIN
    SELECT * INTO player FROM "public"."player" WHERE "public"."player"."player_id" = current_setting('jwt.claims.player_id')::integer;
    SELECT * INTO quiz_run_question FROM "public"."quiz_run_question" WHERE "public"."quiz_run_question"."quiz_run_id" = player.quiz_run_id AND "public"."quiz_run_question"."question_id" = NEW.question_id;
    SELECT * INTO question FROM "public"."question" WHERE "public"."question"."question_id" = NEW.question_id;

    IF quiz_run_question IS NULL OR quiz_run_question.prompted_at IS NULL THEN
        RAISE 'Question is not ready to accept answers';
    END IF;

    IF extract(epoch FROM (quiz_run_question.prompted_at + question.answer_duration_seconds * interval '1 seconds')) < extract(epoch from now()) THEN
        RAISE 'Question is not accepting answers anymore';
    END IF;
    
    NEW.answered_at := now();
    
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION "private".can_player_sublit_score () TO public_player;