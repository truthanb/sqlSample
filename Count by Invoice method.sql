select count(O.Id)
from OrderView O
join ShipToOverrideView STO on STO.Id = O.ShipToId
join PreferredShippingView PS on PS.Id = STO.PreferredShippingId
where O.FinalizedDate > 1/1/2013 and O.IsInvoiceSent = 1 and PS.SendInvoiceVia = 8