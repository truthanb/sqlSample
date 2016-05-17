select dd.Id as DdId, dd.ProductColorId as Pcid, m.Id as MarketId, m.Name as MarketName
from DesignDroid dd
left join DesignDroidMarket ddm on dd.Id = ddm.DesignDroidId
left join Market m on ddm.MarketId = m.Id
where dd.IsWebVisible = 1 and m.Id = 2