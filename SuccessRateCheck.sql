USE [PatikaDev]
GO

/****** Object:  Trigger [dbo].[SuccessRateCheck]    Script Date: 29.01.2022 13:45:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[SuccessRateCheck] on [dbo].[StudentReport]
instead of update
as 
begin
 declare @week int
 declare @successrate float,@attandance int 
 --belirtilen kurstaki haftayı almak.
	select @week = c.weeks from CoursePerson cp left join Course c on c.Id=cp.CourseId
								  left join Person p on p.id=cp.PersonId
								  left join StudentReport sr on sr.ogrenciId=p.id
	select @attandance = attandance from inserted
	update  StudentReport set successRate = Floor(((convert(float,@attandance)/@week)*100)),attandance=@attandance
end
GO

ALTER TABLE [dbo].[StudentReport] ENABLE TRIGGER [SuccessRateCheck]
GO

