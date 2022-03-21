create database assign;
use assign;

create table User(user_id integer primary key auto_increment,
user_name varchar(255) not null,user_added_date date not null,
user_password varchar(255) not null,user_mobile bigint(10) not null);

create table Note(note_id integer  primary key auto_increment,
note_title varchar(255) not null,note_content varchar(255) not null,
note_status varchar(255) not null,note_creation_date date not null);


create table Category(category_id integer primary key auto_increment,
category_name varchar(255) not null,category_descr varchar(255) not null,
category_creation_date date not null,category_creator varchar(255) not null);

create table Reminder(reminder_id integer primary key auto_increment,
reminder_name varchar(255) not null,reminder_descr varchar(255) not null,
reminder_type varchar(255) not null,reminder_creation_date date not null,
reminder_creator varchar(255) not null);

create table NoteCategory(notecategory_id integer primary key auto_increment,
note_id integer not null,foreign key(note_id) references Note(note_id),
category_id integer not null,foreign key(category_id) references Category(category_id));

create table Notereminder(notereminder_id integer primary key auto_increment,
note_id integer not null,foreign key(note_id) references Note(note_id),
reminder_id integer not null,foreign key(reminder_id) references Reminder(reminder_id));


create table usernote(usernote_id integer primary key auto_increment,
user_id integer not null,foreign key(user_id) references User(user_id),
note_id integer not null,foreign key(note_id) references Note(note_id));

insert into User(user_name,user_added_date,user_password,user_mobile) values("veena",'2021-10-21',"veena@20",9847526232);
insert into User(user_name,user_added_date,user_password,user_mobile) values("vishnu",'2020-02-03',"vishnu@20",9848526232);
insert into User(user_name,user_added_date,user_password,user_mobile) values("archana",'2019-01-05',"archana@23",9847926232);
insert into User(user_name,user_added_date,user_password,user_mobile) values("roopika",'2018-12-16',"roopika@sree",9847526032);
insert into User(user_name,user_added_date,user_password,user_mobile) values("siva",'2018-11-16',"siva@sree",9847526002);

insert into Note values(111,"Maths","core","available",'2021-09-10');
insert into Note values(112,"Chemistry","labs","available",'2021-09-01');
insert into Note values(113,"Physics","basics","notavailable",'2019-12-08');
insert into Note values(114,"Biology","Language","available",'2018-09-18');
insert into Note values(115,"Computer Basics","Programs","notavailable",'2021-01-03');
insert into Note values(116,"java fundamentals","Programs","notavailable",'2021-01-03');
insert into Note values(118,"java fundamentals","Programs","notavailable",'2021-01-03');

insert into Category(category_id,category_name,category_descr,category_creation_date,category_creator)
values(100,"CSE","core","2019-12-23","vaishnav");


insert into Category(category_name,category_descr,category_creation_date,category_creator)
values("EEE","Choice","2020-12-23","arjun");
insert into Category(category_name,category_descr,category_creation_date,category_creator)
values("Mech","minor","2020-12-23","arjun");


insert into Reminder values(1,"story","good","available","2020-09-01","lenin");
insert into Reminder values(2,"fiction","superb","available","2017-09-01","kashi");
insert into Reminder values(3,"Novel","superb","available","2017-09-01","kashi");

insert into NoteCategory values(1000,111,100);
insert into  NoteCategory values(1001,112,101);
insert into  NoteCategory values(1002,113,102);
insert into  NoteCategory values(1003,114,100);


insert into Notereminder values(1,111,1);
insert into Notereminder values(2,113,3);
insert into Notereminder values(3,112,2);
insert into Notereminder values(4,114,1);

insert into usernote values(500,1,111);
insert into usernote values(501,2,111);
insert into usernote values(502,3,112);
insert into usernote values(503,4,114);
insert into usernote values(504,1,112);

select * from User where user_id=2 and user_password="vishnu@20";

select * from Note order by note_creation_date;

select * from category where category_creation_date>"2020-05-01";

select note_id from usernote where user_id=1;

update note set note_title="c programming" where note_id=115;

select note.note_id,user.user_name from note join user join usernote on usernote.user_id=user.user_id and 
usernote.note_id=note.note_id where user.user_id=1;

select note.note_id from note join category join NoteCategory on NoteCategory.note_id=note.note_id 
and NoteCategory.category_id=category.category_id where category.category_id=101;

select * from reminder join note join notereminder on notereminder.note_id=note.note_id and 
notereminder.reminder_id=reminder.reminder_id where reminder.reminder_id=2;

insert into note values (117,"java","features","available","2017-08-09");
insert into usernote (usernote_id,user_id,note_id) values(505,2,last_insert_id());

insert into note values (118,"spring","feature1","available","2021-08-09");
insert into notecategory values(1004,last_insert_id(),101);

insert into reminder values(4,"shortstory","thriller","available","2020-03-15","mathew");
insert into notereminder values(5,115,last_insert_id());

delete from usernote where user_id=1 and note_id=112;
delete from notereminder where note_id=112;
delete from notecategory where note_id=113;
delete from note where note_id=116;

delete from notecategory where category_id=1004 AND note_id=117;
delete from notereminder where note_id=115;
delete from usernote where note_id=117;
delete from note where note_id=118;


CREATE DEFINER=`root`@`localhost` TRIGGER `note_BEFORE_DELETE` BEFORE DELETE ON `note` FOR EACH ROW 
BEGIN
INSERT INTO `assign`.`delete_note`
(note_id,note_title,note_content,note_status,note_creation_date)
VALUES(OLD.note_id,OLD.note_title,OLD.note_content,OLD.note_status,OLD.note_creation_date);
END

delete from note where note_id=118;
select * from delete_note;

CREATE DEFINER=`root`@`localhost` TRIGGER `user_BEFORE_DELETE` BEFORE DELETE ON `user` FOR EACH ROW 
BEGIN
INSERT INTO `assign`.`delete_user`
(`user_id`,`user_name`,`user_added_date`,`user_password`,`user_mobile`)
VALUES(OLD.user_id,OLD.user_name,OLD.user_added_date,OLD.user_password,OLD.user_mobile);
END
select * from user

delete from user where user_id=6;
select * from delete_user;

select reminder.reminder_id from reminder inner join notereminder on reminder.reminder_id=notereminder.reminder_id where note_id=114;













