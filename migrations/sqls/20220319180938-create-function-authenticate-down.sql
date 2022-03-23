REVOKE EXECUTE ON FUNCTION "public".authenticate (varchar, varchar) FROM public_anonymous, public_user;
DROP FUNCTION "public".authenticate (varchar, varchar);