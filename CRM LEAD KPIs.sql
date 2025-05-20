--- 1. TOTAL LEAD

select count(`total leads`) as `Total Lead`
from `lead`;

--- 2. Expected Amount from Converted Leads 

select Status,sum(`expected amount`) as `Expected Amount`
from `lead` join account
on `lead`.`Converted Account ID`=account.`Account ID` join `oppertuninty table`
on account.`Account ID`=`oppertuninty table`.`Account ID`
where Status="converted";

--- 3. Conversion Rate

SELECT 
    CAST(SUM(CASE WHEN Status = 'Converted' THEN 1 ELSE 0 END) * 100.0 / COUNT(`total leads`) AS DECIMAL(5,2)) AS `Conversion Rate`
FROM `Lead`;



--- 4. Converted Accounts

select count(`Converted Account ID`) as `Converted Account`
from `lead`
where `Converted Account ID` is not null and `Converted Account ID` <> '';

--- 5. Converted Opportunities

select count(`Converted Opportunity ID`) as `CONVERTED OPPORTUNITY ID`
from `lead`
where `Converted Opportunity ID` is not null AND `Converted Opportunity ID` <> '';

--- 6.  Lead By Source

select `lead source` as `Lead Source`,count(`lead id`) as `Lead ID`
from `lead`
group by `Lead Source`
order by `lead id` desc;

--- 7. LEAD BY INDUSTRY

select Industry,count(`lead id`) as `Lead ID`
from `lead`
group by Industry;

--- 8. Lead by Stage

select stage,count(`lead source`) as `Lead`
from `oppertuninty table`
group by Stage;
