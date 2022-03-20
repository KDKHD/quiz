ALTER DEFAULT privileges GRANT EXECUTE ON functions TO public;

REVOKE usage ON SCHEMA public FROM public_anonymous, public_user;

REVOKE EXECUTE ON FUNCTION "public".authenticate (varchar, varchar) FROM public_anonymous, public_user;
REVOKE EXECUTE ON FUNCTION "public".register_new_user (varchar, varchar, varchar, varchar) FROM public_anonymous;

REVOKE ALL privileges ON TABLE public.user FROM public_user;
