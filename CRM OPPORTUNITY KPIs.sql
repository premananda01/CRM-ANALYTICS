create database CRM;
use CRM;
Show tables from CRM;
select count(*) from opportunity;
select * from opportunity;

# Expected Amount
Select sum(ExpectedAmount) as Expected_Amount from opportunity;





# Total open opportunities
select count(OpportunityID) as Total_open_opportunities from opportunity where Stage not like 'Closed%';

# conversion rate
select 
((select count(OpportunityID) from opportunity where Stage like 'Closed Won')/
(select count(OpportunityID) from opportunity))*100
as Conversion_Rate
;

# win rate
select 
((select count(OpportunityID) from opportunity where Stage like 'Closed Won')/
(select count(OpportunityID) from opportunity where Stage like 'Closed%'))*100
as Win_Rate
;

#  Loss rate
select 
((select count(OpportunityID) from opportunity where Stage like 'Closed Lost')/
(select count(OpportunityID) from opportunity where Stage like 'Closed%'))*100
as Loss_Rate
;

# --------------------------------------------------------------------------------------------------------

# Running total comparison of expected revenue and total revenue over time 
select  Year, sum(Amount) as Total_Amount, 
sum(ExpectedAmount) as Expected_Amount, 
sum(sum(Amount))over (order by Year) as running_total_amount,
sum(sum(ExpectedAmount))over (order by Year) as running_total_Expected_amount
from opportunity 
group by year;

# Cumulative Active Vs Total opportunities Trend
Select
Year, count(*) as total_opportunities,
sum(CASE when stage not like 'Closed%' then 1 else 0 end) as active_opportunities,
sum(count(*)) over(order by Year) as cumulative_total,
sum(sum(CASE when stage not like 'Closed%' then 1 else 0 end)) over(order by Year) as cumulative_active
from opportunity 
group by Year
order by Year;


# Closed Won Vs Total Opportunities
select 
Year, count(*) as total_opportunities,
sum(CASE when Stage like 'Closed Won' then 1 else 0 end) as closed_won
from opportunity 
group by Year
order by Year;



# Closed Won Vs Total Closed Opportunities
select 
Year,
sum(case when stage like "Closed Won" then 1 else 0 end) as Closed_won,
sum(case when stage like "Closed%" then 1 else 0 end) as Total_Closed
from opportunity 
group by Year
order by Year;



# Opportunities by Industry
select Industry, count(OpportunityID) as Opportunities  from opportunity
group by Industry
order by count(OpportunityID) desc;



# Expected Amount by opportunity Type
select OpportunityType, sum(ExpectedAmount)
from opportunity
group by OpportunityType
order by sum(ExpectedAmount) desc;


