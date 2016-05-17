with cte_color1 (color1, institution1) 
as (
	select c.name, count(i.id) institution
	from institution i
	inner join color c on c.id = i.SchoolColor1Id
	group by c.Name
	),

	cte_color2 (color2, institution2)
as (
	select c.name, count(i.id) institution
	from institution i
	inner join color c on c.id = i.SchoolColor2id
	group by c.Name
	)

select distinct c.name, (institution1 + institution2) as number
from color c
left join cte_color1 cte1 on cte1.color1 = c.Name
left join cte_color2 cte2 on cte2.color2 = c.Name
order by number desc