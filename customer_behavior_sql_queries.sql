select * from customer limit 20

select gender, SUM(purchaseamount) as revenue
from customer
group by gender;

select customerid, purchaseamount
from customer
where discountapplied = 'Yes' and purchaseamount >= (select AVG(purchaseamount) from customer)

select itempurchased, ROUND(AVG(reviewrating::numeric),2) as "Average Product Rating"
from customer
group by itempurchased
order by avg(reviewrating) desc
limit 5;


select shippingtype,
ROUND (AVG(purchaseamount) ,2)
from customer
where shippingtype in ('Standard', 'Express')
group by shippingtype


select subscriptionstatus,
COUNT(customerid) as totalcustomers,
ROUND(AVG(purchaseamount),2) as avgspend,
ROUND (SUM(purchaseamount) ,2) as totalrevenue
from customer
group by subscriptionstatus
order by totalrevenue, avgspend desc;


SELECT itempurchased,
ROUND(
    100.0 * SUM(CASE 
                    WHEN discountapplied = 'Yes' THEN 1 
                    ELSE 0 
                END) / COUNT(*),
    2
) AS discountrate
FROM customer
GROUP BY itempurchased
ORDER BY discountrate DESC
LIMIT 5;










with customertype as (
select customerid, previouspurchases,
CASE
	WHEN previouspurchases = 1 THEN 'New'
	WHEN previouspurchases BETWEEN 2 AND 10 THEN 'Returning'
	ELSE 'Loyal'
	END AS customersegment
from customer
)

select customersegment, count(*) as "Number of Customers"
from customertype
group by customersegment






with itemcounts as (
select category,
itempurchased,
COUNT (customerid) as totalorders,
ROW_NUMBER() over (partition by category order by count(customerid) DESC) as itemrank
from customer
group by category, itempurchased
)

select itemrank, category, itempurchased, totalorders
from itemcounts
where itemrank <= 3;










select subscriptionstatus,
count(customerid) as repeatbuyers
from customer
where previouspurchases > 5
group by subscriptionstatus




select age_group,
SUM(purchaseamount) as totalrevenue
from customer
group by age_group
order by totalrevenue desc;


