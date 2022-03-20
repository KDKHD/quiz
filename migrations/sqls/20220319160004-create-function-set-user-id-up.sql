CREATE FUNCTION "private".set_user_id ()
    RETURNS TRIGGER
    AS $$
BEGIN
    NEW.user_id = current_setting ('jwt.claims.user_id');
    RETURN NEW;
END
$$
LANGUAGE plpgsql;