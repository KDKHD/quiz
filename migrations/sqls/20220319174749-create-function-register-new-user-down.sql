REVOKE EXECUTE ON FUNCTION "public".register_new_user (varchar, varchar, varchar, varchar) FROM public_anonymous;
DROP FUNCTION "public".register_new_user (varchar, varchar, varchar, varchar);
DROP TYPE "public".new_user;