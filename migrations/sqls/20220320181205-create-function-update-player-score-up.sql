CREATE FUNCTION "private".update_player_score ()
    RETURNS TRIGGER
    AS $$
DECLARE
    player "public"."player";
    question "public"."question";
    quiz_run_question "public"."quiz_run_question";
    solution "public"."solution";
    answer_percentile decimal;
    answer_score integer;
BEGIN
    SELECT * INTO player FROM "public"."player" WHERE "public"."player"."player_id" = NEW.player_id;
    SELECT * INTO quiz_run_question FROM "public"."quiz_run_question" WHERE "public"."quiz_run_question"."quiz_run_id" = player.quiz_run_id AND "public"."quiz_run_question"."question_id" = NEW.question_id;
    SELECT * INTO question FROM "public"."question" WHERE "public"."question"."question_id" = NEW.question_id;
    SELECT * INTO solution FROM "public"."solution" WHERE "public"."solution"."question_id" = NEW.question_id;
    if (NEW.answer_id = solution.answer_id AND solution.value IS NULL) OR (NEW.value = solution.value AND solution.answer_id IS NULL) then
        answer_percentile := 1 - ((extract(epoch FROM NEW.answered_at) - extract(epoch FROM quiz_run_question.prompted_at)) / question.answer_duration_seconds);
        answer_score := GREATEST(1000*answer_percentile, 150);
    else
        answer_score := 0;
    end if;
    
    UPDATE "public"."player" SET "score" = "public"."player"."score" + answer_score WHERE "public"."player"."player_id" = NEW.player_id;

    RETURN NEW;
END
$$
LANGUAGE plpgsql
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "private".update_player_score () TO public_player;