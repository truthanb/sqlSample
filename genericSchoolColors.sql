/*This should find institutions with either generic blue or green as a school color*/

with cte_totalordercost (Id, totalOrderCost) as 
(
select i.Id, sum(o.TotalOrderCost) as totalOrderCost
from institution i
inner join Customer c on c.InstitutionId = i.Id
inner join OrderView o on o.CustomerId = c.Id
group by i.Id

)

select i.Id, i.Name, i.SchoolColor1Id as color1, i.SchoolColor2Id as color2, i.SchoolColor3Id as color3, cte.totalOrderCost as lifetime_sales
from institution i 
inner join cte_totalordercost cte on cte.Id = I.Id
where (i.SchoolColor1Id in(237, 238) or i.SchoolColor2Id in(237, 238) or i.SchoolColor3Id in(237, 238))/*237 is blue 238 is green*/
order by cte.totalOrderCost desc






/*select distinct(i.name),sum(o.TotalOrderCost) as lifetime_sales
from institution i
inner join Customer c on c.InstitutionId = i.Id
	inner join OrderView o on o.CustomerId = c.Id
where (i.SchoolColor1Id in(237, 238) or i.SchoolColor2Id in(237, 238) or i.SchoolColor3Id in(237, 238)) /*237 is blue 238 is green*/
group by i.Name
order by lifetime_sales desc*/