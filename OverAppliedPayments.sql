select a.Name [Company],c.Name [Customer], pr.id [Payment Received Id], pr.Amount [Amount Received], sum(pa.Amount) [Amount Applied]
from paymentreceived pr
inner join PaymentApplied pa on pa.PaymentReceivedId = pr.id
inner join customer c on c.id = pr.CustomerId
inner join Institution i on i.id = c.InstitutionId
inner join Affiliate a on a.id = i.AffiliateId
group by a.Name, c.Name, pr.id, pr.Amount
having pr.amount < sum(pa.amount)
order by Company desc, Customer asc, [Amount Applied] desc