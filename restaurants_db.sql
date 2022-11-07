---Datarookie Bootcamp SQL Database HOMEWORK
-- CREATE DATABASE OF A restaurants 
-- 5 TABLES 1 FACT, 4 DIM
--LINK PK TO FK
--WRITE SQL TO ANALYZE THE DATA

.headers on
.mode markdown

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

--select * from menu;

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

--select * from drinks;

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
--select * from restaurant_info;

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

--select * from cust_info ;
  
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

--select * from invoice;

select branch_id as branch_no, payment as pay_method,
  m.m_price*inv.menu_amt as food_price,  
  dk.d_price*inv.drink_amt AS drink_price
  from invoice as inv
  join menu as m on m.menu_id = inv.menu_id
  join drinks as dk on dk.drink_id = inv.drink_id
  order by branch_id,payment
 ;
select '                                                ' ;
select * from menu;
select '                               ' ;
select * from drinks;
select '                                                         ' ;
.print /////////////////////////////////////
select '                                                         ' ;
select re_in.branch_loc as branch,
  sum(m.m_price*inv.menu_amt) as food_price,  
  sum(dk.d_price*inv.drink_amt) AS drink_price
from invoice as inv 
  join menu as m on m.menu_id = inv.menu_id
  join drinks as dk on dk.drink_id = inv.drink_id
  join restaurant_info as re_in on re_in.branch_id = inv.branch_id
group by inv.branch_id
order by 2 desc;


select '                                                         ' ;
select '                    TOTAL AMOUNT                         ' ;
select '                                                         ' ;

with sub as(
select cust_id,inv_id,re_in.branch_loc as branch,
  m.m_price*inv.menu_amt AS food_price,  
  dk.d_price*inv.drink_amt AS drink_price
from invoice AS inv 
  join menu AS m on m.menu_id = inv.menu_id
  join drinks AS dk on dk.drink_id = inv.drink_id
  join restaurant_info as re_in on re_in.branch_id = inv.branch_id )

select inv_id, 
      food_price, 
      drink_price,  
     food_price + drink_price as total_amount,
      branch
      from sub
  ;




-- income by each branch



-- gender by menu
.print /////////////////////////////////////


select '                        ' ;
select '   TOTAL ORDERED        ' ;
select '                        ' ;
--Total drink and food ordered
  
select cust_fname||' '||cust_lname as FULLNAME, 
  sum(menu_amt) AS "Total food ordered",
  sum(drink_amt) AS "Total drink ordered",
  sum(m.m_price*inv.menu_amt) AS Food_spend,  
  sum(dk.d_price*inv.drink_amt) AS Drink_spend
  
  FROM cust_info AS c_inf
  JOIN invoice AS inv ON inv.cust_id = c_inf.cust_id
  join menu AS m on m.menu_id = inv.menu_id
  join drinks AS dk on dk.drink_id = inv.drink_id
  group by FULLNAME;

select '                                                      ' ;
select '                    TOP SPENDER                       ' ;
select '                                                      ' ;
-- TOP 3 SPENDERS
With spend AS(
select cust_fname||' '||cust_lname as FULLNAME, 
  sum(menu_amt) AS "Total food ordered",
  sum(drink_amt) AS "Total drink ordered",
  sum(m.m_price*inv.menu_amt) AS Food_spend,  
  sum(dk.d_price*inv.drink_amt) AS Drink_spend
  FROM cust_info AS c_inf
  JOIN invoice AS inv ON inv.cust_id = c_inf.cust_id
  join menu AS m on m.menu_id = inv.menu_id
  join drinks AS dk on dk.drink_id = inv.drink_id
  group by FULLNAME
)

select FULLNAME,
  Food_spend,
  Drink_spend,
  Drink_spend + Food_spend AS Total_spend
  from spend 
  order by Total_spend desc limit 3;

select '                                 ' ;
select '   FAV BRANCH AMONG FEMALE       ' ;
select '                                 ' ;
--most F fav branch
with cust AS(
select c_info.cust_gender AS gender,
       res_inf.branch_loc AS branch,
       count(inv.inv_id) AS number_customer
      from cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  JOIN menu AS m on m.menu_id = inv.menu_id
  JOIN drinks AS dk on dk.drink_id = inv.drink_id
  Group by gender,branch
  )

  select *
    FROM cust 
    where gender = "F"
  order by number_customer desc;
  
/*
with cust AS(
select res_inf.branch_loc AS branch,
       count(inv.inv_id) AS number_customer
      from cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  where c_info.cust_gender = "M"
  group by branch
  )

  select *
    FROM cust 
    ;
*/
/*
with cust AS(
select c_info.cust_gender,
        res_inf.branch_loc AS branch,
       count(inv.inv_id) AS number_customer
        from cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
 -- group by inv.branch_id 
  group by c_info.cust_gender
  )

  select *
    FROM cust 
  
  ;
*/

select '                                               ' ;
select '                INCOME BY BRANCH               ' ;
select '                                               ' ;
-- income by each branch
with iin AS(
select res_inf.branch_loc AS branch,
       count(inv.inv_id) AS number_customer,
  sum(m.m_price*inv.menu_amt) AS Food_spend,  
  sum(dk.d_price*inv.drink_amt) AS Drink_spend
      from cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  JOIN menu AS m on m.menu_id = inv.menu_id
  JOIN drinks AS dk on dk.drink_id = inv.drink_id
  Group by branch
  )

select branch,
  Food_spend,
  Drink_spend,
  Drink_spend + Food_spend AS Total_spend
  from iin 
  order by Total_spend desc;

select '                                                              ' ;
select '                    MOST FAV FOOD                             ' ;
select '                                                              ' ;
-- most ordered menu

with fav_menu AS(
select 
  m.menu_name AS FOOD_MENU,
  m.m_price AS price,
  count(inv.menu_id) AS num_ordered,
  sum(inv.menu_amt) AS sale_quantity,
  sum(inv.menu_amt * m.m_price) AS total_sale
        From cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  JOIN menu AS m on m.menu_id = inv.menu_id
  JOIN drinks AS dk on dk.drink_id = inv.drink_id
  Group by menu_name
  )

select * from fav_menu order by total_sale desc;


select '                                                             ' ;
select '                   MOST FAV DRINKS                           ' ;
select '                                                             ' ;
-- most fav drinks menu

with fav_drinks AS(
select 
  dk.drink_name AS DRINKS,
  dk.d_price AS price,
  count(inv.drink_id) AS num_ordered,
  sum(inv.drink_amt) AS sale_quantity,
  sum(inv.drink_amt * dk.d_price) AS total_sale
        From cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  JOIN menu AS m on m.menu_id = inv.menu_id
  JOIN drinks AS dk on dk.drink_id = inv.drink_id
  Group by drink_name
  )

select * from fav_drinks order by total_sale desc;


select '                                             ' ;
select '                PAYMENT METHOD               ' ;
select '                                             ' ;


with payment_method AS(
select 
  inv.payment AS PAYMENT_METHOD,
  sum(inv.menu_amt * m.m_price) AS FOOD_SALE,
  sum(inv.drink_amt * dk.d_price) AS DRINK_SALE
     From cust_info as c_info
  JOIN invoice AS inv ON inv.cust_id = c_info.cust_id
  JOIN restaurant_info AS res_inf ON inv.branch_id = res_inf.branch_id
  JOIN menu AS m on m.menu_id = inv.menu_id
  JOIN drinks AS dk on dk.drink_id = inv.drink_id
     Group by PAYMENT_METHOD
  )

select PAYMENT_METHOD,
       FOOD_SALE,
       DRINK_SALE,
      FOOD_SALE +  DRINK_SALE AS TOTAL
    from payment_method order by TOTAL desc;







