CREATE table PATIENT (
id int primary key,
name varchar(100)
);

CREATE table MEDICINE (
pid int,
MEDICINE varchar(100),
foreign key (pid) references PATIENT(id) on delete cascade on update cascade
);

CREATE table BILL (
pid int,
details text,
foreign key (pid) references PATIENT(id) on delete cascade on update cascade
);

CREATE table ROOM (
ROOM_no int primary key,
pid int,
ROOM_status varchar(10)
);

DELIMITER $$
CREATE trigger update_records after delete on PATIENT
for each row
begin
delete from MEDICINE where pid = old.id;
delete from BILL where pid = old.id;
update ROOM set ROOM_status = 'EMPTY', pid = NULL where pid = old.id;
end$$
DELIMITER ;

INSERT INTO PATIENT VALUES (1,'Madhumitha');

INSERT INTO MEDICINE VALUES (1,'Paracetamol 520g');

INSERT INTO BILL VALUES (1,'Viral laryginitis');

INSERT INTO ROOM VALUES (221,1,'FULL');

DELETE FROM PATIENT WHERE id = 1;