declare @today date
set @today = getdate();

select a.Abbreviation as Affiliate, v.name as Vendor, vo.Id, vo.vendorponum as PO, vo.EstimatedReceiveDate as [Est Date], vo.Memo
from vendororder vo
inner join vendor v on v.id = vo.VendorId
inner join Affiliate a on a.id = vo.AffiliateId
where vo.EstimatedReceiveDate <> '' 
and vo.EstimatedReceiveDate = @today
and vo.AllReceivedDate <> ''
and vo.IsFinalized = 1
and vo.IsForReturnRequest = 0
order by a.Abbreviation
