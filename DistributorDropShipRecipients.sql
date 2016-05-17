Declare @date1 datetime
set @date1 = '3/21/2014 00:00:01';
Declare @date2 datetime
set @date2 = '3/21/2016 23:59:59';

with cte as (
Select STO.InstitutionName as [DropShip Recipient], count(*) CountOf, min(sto.Id) StoId, sum(jp.ProductQuantity) ProductQty, sum(O.TotalOrderCost) TotalPrice
--/*STO.FirstName as [First Name], STO.LastName as [Last Name],*/ A.AddressLine1 as [Street],  A.City, A.StateProvince as [State], A.ZipCode as [Zip]
from OrderView O
inner join ShipToOverride STO on STO.Id = O.ShipToId
inner join [Address] A on A.Id = STO.AddressId
inner join Easi E on E.OrderId = O.Id
inner join PreferredShipping PS on PS.Id = STO.PreferredShippingId
inner join JobView job on job.OrderId=O.Id
inner join JobProductView jp on jp.JobId=job.Id
where /*A.StateProvince in ('TN', 'NC', 'SC', 'VA', 'FL', 'GA', 'MD', 'AL', 'WV') and */
E.Specification = '940' and 
O.FinalizedDate between @date1 and @date2
/*and PS.BlindType != 4*/ --if you want to exclude the double blind shipments.
group by sto.InstitutionName
)

select cte.[DropShip Recipient], c.Name as [Distributor Name], cte.CountOf as [Number of Orders], cte.ProductQty as [Product Quantity], cte.TotalPrice as [Total Sales], addr.AddressLine1, addr.AddressLine2, addr.City, addr.StateProvince, addr.ZipCode
from cte 
inner join ShipToOverrideView sto on sto.Id=cte.StoId
inner join AddressView addr on addr.Id=sto.AddressId
left join orderview o on o.ShipToId = cte.StoId
left join customer c on c.id = o.CustomerId
where c.Name in('Bodek & Rhodes', 'Alpha Broder')  
order by ProductQty desc, [DropShip Recipient] desc