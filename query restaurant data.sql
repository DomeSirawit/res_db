--QUERY

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


-- TOTAL ORDERED
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

--TOP 3 Spender

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

  

-- MOST FAV BRAncH BY FEMALE
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

  
-- INCOME BY EACH BRANCH
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



-- Most Ordered menu

select '                                                              ' ;
select '                    MOST FAV FOOD                             ' ;
select '                                                              ' ;

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


-- Most fav drinks menu

select '                                                             ' ;
select '                   MOST FAV DRINKS                           ' ;
select '                                                             ' ;

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

-- Payment method
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



