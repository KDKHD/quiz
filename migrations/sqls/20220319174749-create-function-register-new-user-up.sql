CREATE TYPE "public".new_user AS (
    "user" "public".user,
    "token" "public".jwt
);


CREATE FUNCTION "public".register_new_user (
        email varchar,
        password varchar,
        first_name varchar,
        last_name varchar
    ) RETURNS "public".new_user 
    AS $$
DECLARE
    new_user "public"."user";
BEGIN
    INSERT INTO "public"."user" (
        "first_name",
        "last_name",
        "email"
    ) VALUES (
        first_name,
        last_name,
        email
    ) RETURNING * INTO new_user;

    INSERT INTO "private"."user" (
        "password_hash",
        "user_id"
    ) VALUES (
        crypt(password, gen_salt('bf')),
        new_user.user_id
    );

    RETURN (new_user, (('public_user', new_user.user_id, NULL, extract(epoch FROM (now() + interval '30 days'))) :: "public".jwt));
END;
$$ 
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "public".register_new_user (varchar, varchar, varchar, varchar) TO public_anonymous;
