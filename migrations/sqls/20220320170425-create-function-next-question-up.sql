CREATE FUNCTION "public".next_question (quiz_run_id int)
    RETURNS "public".quiz_run_question
    AS $$
DECLARE
    last_quiz_run_question "public"."quiz_run_question";
    quiz "public"."quiz";
    last_question "public"."question";
    quiz_run "public"."quiz_run";
    question "public"."question";
    inserted_quiz_run_question "public"."quiz_run_question";
BEGIN

    SELECT * INTO last_quiz_run_question FROM "public"."quiz_run_question" WHERE "public"."quiz_run_question"."quiz_run_id" = next_question.quiz_run_id ORDER BY CREATED_AT DESC LIMIT 1;
    SELECT * INTO last_question FROM "public"."question" WHERE "public"."question"."question_id" = last_quiz_run_question.question_id;
    SELECT * INTO quiz_run FROM "public"."quiz_run" WHERE "public"."quiz_run"."quiz_run_id" = next_question.quiz_run_id;
    SELECT * INTO quiz FROM "public"."quiz" WHERE "public"."quiz"."quiz_id" = quiz_run.quiz_id;

    IF quiz.user_id != current_setting ('jwt.claims.user_id')::integer THEN
        RAISE 'You do not have access to quiz %', new_quiz_run.quiz_id;
    END IF;

    IF last_quiz_run_question IS NULL THEN
        -- This is the first question
        SELECT * INTO question FROM "public"."question" WHERE "public"."question"."quiz_id" = quiz_run.quiz_id ORDER BY "order" ASC LIMIT 1;
    else
        -- This is not the first question
        SELECT * INTO question FROM "public"."question" WHERE "public"."question"."quiz_id" = quiz_run.quiz_id AND "order" > last_question.order ORDER BY "order" ASC LIMIT 1;
    END IF;

    IF question IS NULL THEN
        RAISE 'There are no more questions';
    END IF;

    INSERT INTO "public"."quiz_run_question" (
        "quiz_run_id",
        "question_id",
        "prompted_at"
    ) VALUES (
        next_question.quiz_run_id,
        question.question_id,
        now()
    ) RETURNING * INTO inserted_quiz_run_question;

    RETURN inserted_quiz_run_question;
END;
$$ 
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "public".next_question (int) TO public_user;
