PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE user(
id text primary key not null,
name text not null,
surname text not null,
login text not null,
email text not null,
password text not null,
salt text not null,
profileImagePath text
);
CREATE TABLE ingridients(
id integer primary key autoincrement,
name text not null,
count int not null,
unit text not null
);
CREATE TABLE rates(
id integer primary key autoincrement,
sum int not null,
count int not null
);
CREATE TABLE foods(
id text primary key not null,
id_user text,
imagepath text not null,
date date not null,
title text not null,
description text not null,
id_rate integer,
duration_time int not null,
calories int not null,
protein int not null,
fat int not null,
carbohydrates int not null,
sugar int not null
);
CREATE TABLE recipe(
id integer primary key autoincrement,
food_id text not null,
id_ingridient integer not null
);
COMMIT;
