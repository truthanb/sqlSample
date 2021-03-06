USE [Athena]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_autoSepsRotate]    Script Date: 4/28/2015 4:09:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Chris Klein
-- Create date: 2014/1029
-- Description:	Should a job service have the deisgn roated for auto-seps?  Returns the count of products that trigger requiring a rotate.  Zero indicates no rotate needed
-- =============================================
ALTER FUNCTION [dbo].[fn_autoSepsRotate] 
(
	-- Add the parameters for the function here
	@js BigInt
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	select @Result = count(*) 
	from JobServiceView js
	inner join DesignLocationView loc on loc.Id=js.ServiceLocationId
	inner join JobProductView jp on jp.JobId=js.JobId
	inner join ProductColorView pc on pc.Id=jp.ProductColorId
	inner join ProductView p on p.Id=pc.ProductId
	inner join ProductGroupView pg on pg.Id=p.ProductGroupId
	inner join ProductCategoryView pcat on pcat.Id=pg.CategoryId
	where js.Id=@js and (
	-- 10: bags
	(pcat.Id in (10)) or
	-- 10: left sleeve, 11: right sleeve 
	-- 18: rear end, 66: rear end left, 65: rear end right
	-- 93: left pants thigh, 13: left thigh,  84: rev-left thigh, 85: rev-right thigh, 94: right pants thigh, 15: right thigh
	-- 42: left bicep, 43: right bicep
	-- 16: left leg, 78: left leg front, 82: left leg low, 99: left leg panel, 79: left leg side, 101: left shorts leg, 17: right leg, 80: right leg front, 100: right leg panel, 81: right leg side, 102: right shorts leg, 
	(loc.Id in (10,11, 18, 66, 65, 93, 13, 84, 85, 94, 15, 42,43, 16,78,82,99,79,101,17,80,100,81,102))
	)
	-- Return the result of the function
	RETURN @Result

END

