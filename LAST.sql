# функция 
USE vk;
DROP FUNCTION IF EXISTS func_delete_user;

DELIMITER //
CREATE FUNCTION func_delete_user(check_user_id BIGINT UNSIGNED)
RETURNS INT DETERMINISTIC
    BEGIN
		DELETE FROM friend_requests where target_user_id = check_user_id;
        DELETE FROM friend_requests where initiator_user_id = check_user_id;
        DELETE FROM likes where user_id = check_user_id;
        DELETE FROM messages where from_user_id = check_user_id;
        DELETE FROM profiles where user_id = check_user_id;
        DELETE FROM users_communities where user_id = check_user_id;
        DELETE FROM media where user_id = check_user_id;
        
		DELETE FROM users where id = check_user_id;
        RETURN check_user_id;
    END//
DELIMITER ;

# ПРОЦЕДУРА
DROP PROCEDURE IF EXISTS proc_delete_user;
DELIMITER //
CREATE PROCEDURE proc_delete_user(in check_user_id BIGINT UNSIGNED)
	BEGIN
		START TRANSACTION;
			DELETE FROM friend_requests where target_user_id = check_user_id;
			DELETE FROM friend_requests where initiator_user_id = check_user_id;
			DELETE FROM likes where user_id = check_user_id;
			DELETE FROM messages where from_user_id = check_user_id;
			DELETE FROM profiles where user_id = check_user_id;
			DELETE FROM users_communities where user_id = check_user_id;
			DELETE FROM media where user_id = check_user_id;
        
			DELETE FROM users where id = check_user_id;
		COMMIT;
	END//
DELIMITER ;

DROP TRIGGER IF EXISTS trig_group_name;
DELIMITER //
CREATE TRIGGER trig_group_name BEFORE INSERT ON communities
FOR EACH ROW
	BEGIN
		IF LENGTH(NEW.name) < 5 THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Название группы не может быть короче 5 символов!';
		END IF;
	END//
DELIMITER ;



#SELECT func_delete_user(32);
#CALL proc_delete_user(25);
INSERT INTO `communities` (`id`, `name`) VALUES ('38', 'rhr')