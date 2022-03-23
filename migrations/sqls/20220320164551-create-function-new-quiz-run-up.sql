CREATE FUNCTION "public".new_quiz_run (quiz_id int)
    RETURNS "public".quiz_run
    AS $$
DECLARE
    quiz "public"."quiz";
    inserted_quiz_run "public"."quiz_run";
BEGIN
    SELECT * INTO quiz FROM "public"."quiz" WHERE "public"."quiz"."quiz_id" = new_quiz_run.quiz_id;
    IF quiz IS NULL THEN
        RAISE 'Quiz % does not exist', new_quiz_run.quiz_id;
    END IF;

    IF quiz.user_id != current_setting ('jwt.claims.user_id')::integer THEN
        RAISE 'You do not have access to quiz %', new_quiz_run.quiz_id;
    END IF;

    INSERT INTO "public"."quiz_run" (
        "quiz_id",
        "finished"
    ) VALUES (
        new_quiz_run.quiz_id,
        false
    ) RETURNING * INTO inserted_quiz_run;

    RETURN inserted_quiz_run;
END;
$$ 
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "public".new_quiz_run (int) TO public_user;
