with cte_institutions (Name, Accounts)
as 
(
select I.Name as School, count(C.Id) as Accounts
from Institution I
Inner Join Customer C on C.InstitutionId = I.Id
where I.AffiliateId = 1 and I.IsDisabled = 0 and I.InstitutionType=1 and I.Name<>'' and I.CreatedDate > '1/1/2011' and I.Name not like '%Academy%' --Ares, Enabled, School Type, Not Null Name
group by I.Name
)

Select A.Name, A.Accounts
from cte_institutions A
where A.Accounts < 5 --Show only institutions with less than 3 accounts.
order by Name asc
