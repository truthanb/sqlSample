select i.Mascot, count(i.Mascot)
from institution i
where i.AffiliateId = 1
and i.IsDisabled = 0
group by i.Mascot
order by 2 desc