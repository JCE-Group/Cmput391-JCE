CREATE TABLE views (
	user_name varchar(24),
	photo_id	int,
	Primary key(user_name, photo_id),
	Foreign key (user_name) references users,
	Foreign key (photo_id) references images
);

INSERT INTO users values ('admin', 'admin', sysdate);
INSERT INTO persons values ('admin', 'admin', 'admin', 'F500 admin road', 'admin@ualberta.ca', 7804737373);