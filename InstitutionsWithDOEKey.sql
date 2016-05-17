select i.Name, i.DOEKey, maila.AddressLine1 [Mail Address Line 1], maila.AddressLine2 [Mail Address Line 2], maila.City [Mail Address City], maila.StateProvince [Mail Address State/Province], maila.ZipCode [Mail Address Zip], shipa.AddressLine1 [Ship Address Line 1], shipa.AddressLine2 [Ship Address Line 2], shipa.City [Ship Address City], shipa.StateProvince [Ship Address State/Province], shipa.ZipCode [Ship Address Zip]
from Institution i
inner join [Address] maila on maila.id = i.MailingAddressId
inner join [Address] shipa on shipa.id = i.ShippingAddressId
where i.DOEKey <> ''