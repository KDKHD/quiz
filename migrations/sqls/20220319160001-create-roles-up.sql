CREATE ROLE public_postgraphile LOGIN PASSWORD 'postgres';
CREATE ROLE public_anonymous;
GRANT public_anonymous TO public_postgraphile;

CREATE ROLE public_user;
GRANT public_user TO public_postgraphile;

CREATE ROLE public_player;
GRANT public_player TO public_postgraphile;



