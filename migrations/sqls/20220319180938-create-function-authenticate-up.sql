CREATE FUNCTION "public".authenticate (email varchar, password varchar)
    RETURNS "public".jwt
    AS $$
DECLARE
    public_user "public"."user";
    private_user "private"."user";
BEGIN
    SELECT * INTO public_user FROM "public"."user" WHERE "public"."user"."email" = authenticate.email;
    IF public_user IS NULL THEN
        RAISE 'User with email % does not exist', authenticate.email;
    END IF;

    SELECT * INTO private_user FROM "private"."user" WHERE "private"."user"."user_id" = public_user.user_id;

    IF crypt(password, private_user.password_hash) != private_user.password_hash THEN
        RAISE 'Wrong password';
    END IF;

    RETURN ('public_user', public_user.user_id, NULL, extract(epoch FROM (now() + interval '30 days'))) :: "public".jwt;
END;
$$ 
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "public".authenticate (varchar, varchar) TO public_anonymous, public_user;
