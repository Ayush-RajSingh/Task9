select * from sales where product_id = 'FUR-BO-10001798'

SELECT SUM(sales) AS totalsales
FROM sales
WHERE product_id = 'FUR-BO-10001798';

SELECT SUM(profit) AS totalprofit
FROM sales
WHERE product_id = 'FUR-BO-10001798';

SELECT 
    SUM(profit) AS totalprofit,
    SUM(sales) AS totalsales,
    (SUM(profit) / SUM(sales)) * 100 AS profitpercentage
FROM sales
WHERE product_id = 'FUR-BO-10001798';

create or replace function Final_Prof(product_id_p varchar)
RETURNS table (
    total_sales double precision,
    total_profit double precision,
    profit_percentage double precision
) AS $$
DECLARE 
	total_sales double precision;
    total_profit double precision;
    profit_percentage double precision;
BEGIN
    select SUM(sales), SUM(profit) INTO total_sales, total_profit
    from sales as s where s.product_id = product_id_p;
    
    if total_sales > 0 then
        profit_percentage := (total_profit / total_sales) * 100;
    else
        profit_percentage := 0;
    end if;

    RETURN query
    select total_sales, total_profit, profit_percentage;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Final_prof('FUR-BO-10001798');

SELECT * FROM Final_prof('OFF-BI-10001634');

