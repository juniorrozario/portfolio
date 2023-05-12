-- Toronto Real Estate Market EDA

-- combine and export data as one table

select *
from projects.torontosales_2012
union
select *
from projects.torontosales_2013
union
select *
from projects.torontosales_2014
union
select *
from projects.torontosales_2015
union
select *
from projects.torontosales_2016
union
select *
from projects.torontosales_2017
union
select *
from projects.torontosales_2018
union
select *
from projects.torontosales_2019
union
select *
from projects.torontosales_2020
union
select *
from projects.torontosales_2021
union
select *
from projects.torontosales_2022
order by year desc;


-- add and fill Quarter column

ALTER TABLE toronto_sales
    ADD Quarter VARCHAR(100);

UPDATE toronto_sales
SET Quarter =
        CASE
            WHEN month IN ('January', 'February', 'March') THEN 'Q1'
            WHEN month IN ('April', 'May', 'June') THEN 'Q2'
            WHEN month IN ('July', 'August', 'September') THEN 'Q3'
            WHEN month IN ('October', 'November', 'December') THEN 'Q4'
            ELSE 'Unknown' END;

-- view data

select *
from projects.toronto_sales;

-- average metrics by year

select year,
       Quarter,
       avg(`# of Sales`)     avg_sales,
       avg(`Avg List Price`) avg_list_price,
       avg(`Avg Sold Price`) avg_sold_price,
       avg(`Days on Market`) avg_days_on_market
from projects.toronto_sales
group by year, quarter
order by year desc, Quarter desc;

-- average pct difference between avg list price and avg sold price

select year,
       quarter,
       avg(`Avg List Price`)                                                     avg_list_price,
       avg(`Avg Sold Price`)                                                     avg_sold_price,
       ((avg(`Avg Sold Price`) - avg(`Avg List Price`)) / avg(`Avg List Price`)) above_below_list_price
from projects.toronto_sales
group by year, quarter
order by year desc, Quarter desc;

-- pct difference between avg list price and avg sold price

select year,
       month,
       quarter,
       `Avg List Price`,
       `Avg Sold Price`,
       ((`Avg Sold Price` - `Avg List Price`) / (`Avg List Price`)) above_below_list_price
from projects.toronto_sales;

-- sales, avg above/below list price, avg days on market by quarter

select Quarter,
       sum(`# of Sales`)                                                         total_sales,
       ((avg(`Avg Sold Price`) - avg(`Avg List Price`)) / avg(`Avg List Price`)) above_below_list_price,
       avg(`Days on Market`)                                                     avg_days_on_market
from projects.toronto_sales
group by Quarter
order by Quarter desc;

-- sales, avg above/below list price, avg days on market by year, quarter

select year,
       Quarter,
       sum(`# of Sales`)                                                         total_sales,
       ((avg(`Avg Sold Price`) - avg(`Avg List Price`)) / avg(`Avg List Price`)) above_below_list_price,
       avg(`Days on Market`)                                                     avg_days_on_market
from projects.toronto_sales
group by year, Quarter
order by year desc, quarter desc;
