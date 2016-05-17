/*This should find all results for who has opted in for marketing on our teamstore site*/
select TP.Email as Email, TP.Name as Name, TP.GraduationYear as [Grad Yr], M.Abbreviation as [Market Abbreviation] 
from TeamPlayer TP
inner join TeamPlayerMarket TPM on TPM.PlayerId = TP.Id
inner join Market M on M.Id = TPM.MarketId
where TP.IsOptedInMarketing = 1 