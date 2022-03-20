ALTER DEFAULT privileges REVOKE EXECUTE ON functions FROM public;

GRANT usage ON SCHEMA public TO public_anonymous, public_user;

GRANT EXECUTE ON FUNCTION "public".register_new_user (varchar, varchar, varchar, varchar) TO public_anonymous;
GRANT EXECUTE ON FUNCTION "public".authenticate (varchar, varchar) TO public_anonymous, public_user;

