CREATE TRIGGER player_answer_can_player_sublit_score
    BEFORE INSERT ON "player_answer"
    FOR EACH ROW
    EXECUTE PROCEDURE "private".can_player_sublit_score();

CREATE TRIGGER player_answer_update_player_score
    AFTER INSERT ON "player_answer"
    FOR EACH ROW
    EXECUTE PROCEDURE "private".update_player_score();