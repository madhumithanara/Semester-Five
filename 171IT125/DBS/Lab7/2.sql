CREATE TABLE blog (
id int,

title varchar(20),
content varchar(20),
deleted int,
PRIMARY KEY (id)
);
CREATE TABLE audit( blog_id int,
changetype enum('NEW','EDIT','DELETE') NOT NULL,
changetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE
CURRENT_TIMESTAMP,
foreign key(blog_id) references blog(id)
) ;

DELIMITER $$

CREATE
	TRIGGER `blog_after_insert` AFTER INSERT 
	ON `blog` 
	FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'NEW';
		END IF;
    
		INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
		
    END$$


DELIMITER ;

DELIMITER $$

CREATE
	TRIGGER `blog_after_update` AFTER UPDATE 
	ON `blog` 
	FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'EDIT';
		END IF;
    
		INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
		
    END$$

DELIMITER ;


INSERT INTO blog (title, content,id) VALUES ('Article One', 'Initial text.',1);

UPDATE blog SET content = 'Edited text' WHERE id = 1;

UPDATE blog SET deleted = 1 WHERE id = 1;