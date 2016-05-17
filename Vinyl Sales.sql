Select DT.Code, Sum(JS.SubtotalPrice) as Sales , Sum(JS.Quantity) as ServiceQty
From DesignTemplate DT
inner join JobService JS on JS.DesignId = DT.Id
inner join Job J on J.Id = JS.JobId
inner join OrderView O on O.Id = J.OrderId
inner join Customer C on C.Id = O.CustomerId
inner join Institution I on I.Id = C.InstitutionId
Where JS.ServiceId in(18, 19, 139, 140, 282, 284, 286, 287, 288, 289, 425, 456, 460) /*Vinyl Services*/
and DT.CreatedDate > '05/01/2013'
and DT.IsActive = 1
and I.AffiliateId =1 /*Ares*/
and DT.Code != ''
and O.OrderType = 4
group by DT.Code
order by ServiceQty desc

/*DT.CreatedFromId in(3426, 3427, 3428, 3429, 3430, 3431, 3432, 3433, 3434, 3435, 3436, 3437, 3438, 3438, 3440, 3441, 3442, 3443, 11583, 11584, 11585, 11586, 185757) */