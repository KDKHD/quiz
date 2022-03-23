ALTER DEFAULT privileges GRANT EXECUTE ON functions TO public;

REVOKE usage ON SCHEMA public FROM public_anonymous, public_user;

REVOKE ALL privileges ON TABLE public.user FROM public_user;
