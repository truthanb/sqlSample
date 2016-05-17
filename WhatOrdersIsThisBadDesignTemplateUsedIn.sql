select o.id, j.jobname, dt.CreatedFromId
from designtemplate dt
inner join jobservice js on js.DesignId = dt.id
inner join job j on j.id = js.JobId
inner join orderview o on o.id = j.OrderId
where dt.CreatedFromId in(990644, 990657, 990905, 991581, 992772, 1072716) --add bad design template ID here.
order by 3 asc