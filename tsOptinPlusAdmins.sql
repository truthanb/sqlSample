--past store admins
select p.WebLoginEmail [Email], c.id [CustomerID], c.MarketId [Customer Market], m.Abbreviation [Cust. Market Abrv.], p.FirstName [First Name], p.LastName [Last Name],
 i.Name [Institution Name], i.id [Institution ID], c.[Guid] [Customer Guid], c.WebsiteUrl [Market URL], a.AddressLine1 [Address 1], a.AddressLine2 [Address 2], a.City [City], a.StateProvince [State], a.ZipCode [Zip]
from Person p
inner join ShowroomProgram sp on sp.AdminId = p.Id
inner join OrderView o on o.id = sp.OrderId
inner join Customer c on c.Id = o.CustomerId
inner join Institution i on i.Id = c.InstitutionId
inner join Market m on m.id = c.MarketId
inner join [Address] a on a.id = c.MarketingAddressId
where sp.[Status] = 8 and
p.WebLoginEmail <> ''



--optins
select tp.Email [Email], c.id [Customer ID], c.MarketId [Customer Market], m.Abbreviation [Cust. Market Abrv.], tp.Name, ' ',
i.Name [Institution Name],  i.id [Institution ID], c.[Guid] [Customer Guid], c.WebsiteUrl [Market URL], a.AddressLine1 [Address 1], a.AddressLine2 [Address 2], a.City, a.StateProvince [State], a.ZipCode [Zip]
from TeamPlayer tp
inner join TeamPlayerPurchase tpp on tpp.PlayerId = tp.Id
inner join Team t on t.Id = tp.TeamId
inner join ShowroomTeam st on st.TeamId = t.Id
inner join ShowroomProgram sp on sp.Id = st.ShowroomId
inner join orderview o on o.id = sp.OrderId
inner join customer c on c.id = o.CustomerId
inner join Institution i on i.id = c.InstitutionId
inner join Market m on m.id = c.MarketId
left join [Address] a on a.id = tpp.ShipToId
where tp.IsOptedInMarketing =1 and
tp.Email <> ''
