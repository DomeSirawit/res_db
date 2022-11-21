-- CREATE DATABASE OF A restaurants 

--///DATABASE
-- DIM 1 menu
CREATE TABLE menu (
  menu_id INT NOT NULL,
  menu_name VARCHAR,
  m_price INT,
  PRIMARY KEY (menu_id)
);


INSERT INTO menu VALUES 
  (1, "pizza", 179),
  (2, "spaghetti", 129),
  (3, "hamburger", 79),
  (4, "chicken wings", 59),
  (5, "fish n chips", 129),
  (6, "sandger", 59),
  (7, "hot-dog", 49),
  (8, "salad", 79),
  (9, "steak", 189)
;


--  DIM 2 drinks
CREATE TABLE drinks (
  drink_id INT NOT NULL, 
  drink_name VARCHAR, 
  d_price INT, 
  PRIMARY KEY (drink_id)
);

INSERT INTO drinks VALUES
  (1, "soft-drink", 35),
  (2, "lemon-soda", 30),
  (3, "Thai-Tea", 30),
  (4, "Orange-Juice", 30),
  (5, "Milk_shake", 49);


-- DIM 3 restaurant_info
CREATE TABLE restaurant_info (
  branch_id INT NOT NULL,
  branch_loc VARCHAR,
  branch_manager VARCHAR, 
  branch_phone VARCHAR,
  PRIMARY KEY (branch_id)
);

INSERT INTO restaurant_info VALUES
  (1, "CTW", "David", "0146211"),
  (2, "Rangsit", "James", "0142412"),
  (3, "Siam", "Adam", "0143121"),
  (4, "JJ Green", "Frank", "0142231");

  -- DIM 4 cust_info
CREATE TABLE cust_info(
  cust_id INT NOT NULL, 
  cust_fname VARCHAR, 
  cust_lname VARCHAR,
  cust_phone VARCHAR,
  cust_gender VARCHAR,
  cust_dob DATE,
  PRIMARY KEY (cust_id)
);

INSERT INTO cust_info VALUES
  (1, "John", "Masofft",    "0652454595", "M", "1997-03-05"),
  (2, "Naaso", "Forewrit",  "0612894561", "F", "1986-04-30"),
  (3, "Hennry", "Thersmao", "0841454925", "M", "1995-12-11"),
  (4, "Moash", "Kirgot",    "0885424516", "M", "2001-08-28"),
  (5, "Mona", "Kim",        "0821465914", "F", "1991-01-21"),
  (6, "Amingo", "Anna",     "0681492928", "F", "2001-07-04"),
  (7, "Tino", "Mccasd",     "0912225865", "M", "1996-12-10");


   
--FACT TABLE invoice
CREATE TABLE invoice(
  inv_id INT NOT NULL,
  cust_id INT,
  order_date DATE, 
  menu_id INT,
  menu_amt INT,
  drink_id INT,
  drink_amt INT,
  branch_id INT,
  payment VARCHAR,
  PRIMARY KEY (inv_id),
  FOREIGN KEY (menu_id) REFERENCES menu(menu_id),
  FOREIGN KEY (drink_id) REFERENCES drinks(drink_id),
  FOREIGN KEY (branch_id) REFERENCES restaurant_info(branch_id),
  FOREIGN KEY (cust_id) REFERENCES cust_info(cust_id)
);

INSERT INTO invoice VALUES 
(1,2,"2022-08-19", 3, 1, 2, 1, 2, "cash"),
(2,1,"2022-08-19", 4, 2, 4, 2, 4, "credit-card"),
(3,3,"2022-08-19", 9, 1, 5, 2, 1, "cash"),
(4,5,"2022-08-19", 4, 2, 1, 1, 4, "credit-card"),
(5,1,"2022-08-19", 7, 1, 5, 2, 4, "credit-card"),
(6,3,"2022-08-19", 1, 4, 4, 5, 2, "cash"),
(7,4,"2022-08-19", 6, 1, 3, 4, 3, "cash"),
(8,1,"2022-08-19", 5, 2, 1, 3, 1, "cash"),
(9,5,"2022-08-19", 1, 2, 3, 2, 2, "cash"),
(10,1,"2022-08-19", 2, 2, 2, 1, 3, "credit-card"),
(11,5,"2022-08-19", 2, 4, 1, 5, 4, "credit-card"),
(12,1,"2022-08-20", 6, 4, 2, 2, 1, "cash"),
(13,5,"2022-08-20", 2, 1, 1, 1, 4, "cash"),
(14,1,"2022-08-20", 3, 3, 2, 1, 2, "cash"),
(15,2,"2022-08-20", 9, 3, 5, 1, 1, "credit-card"),
(16,3,"2022-08-20", 3, 1, 5, 2, 2, "cash"),
(17,4,"2022-08-20", 5, 2, 2, 1, 4, "cash"),
(18,1,"2022-08-20", 6, 2, 4, 2, 3, "cash"),
(19,4,"2022-08-21", 7, 1, 2, 1, 2, "credit-card"),
(20,1,"2022-08-21", 3, 1, 3, 2, 4, "cash"),
(21,2,"2022-08-21", 8, 4, 2, 1, 2, "cash"),
(22,1,"2022-08-21", 7, 2, 5, 1, 4, "credit-card"),
(23,3,"2022-08-21", 4, 2, 4, 2, 1, "credit-card"),
(24,5,"2022-08-22", 3, 1, 2, 4, 4, "cash"),
(25,1,"2022-08-22", 8, 2, 1, 3, 2, "cash"),
(26,2,"2022-08-22", 1, 1, 1, 2, 1, "credit-card"),
(27,4,"2022-08-22", 6, 2, 2, 2, 2, "cash"),
(28,3,"2022-08-22", 9, 3, 5, 1, 3, "credit-card"),
(29,1,"2022-08-22", 4, 5, 5, 2, 2, "cash"),
(30,2,"2022-08-22", 3, 1, 4, 2, 4, "cash");