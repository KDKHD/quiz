CREATE FUNCTION "private".set_player_id ()
    RETURNS TRIGGER
    AS $$
BEGIN
    NEW.player_id = current_setting ('jwt.claims.player_id');
    RETURN NEW;
END
$$
LANGUAGE plpgsql;