USE [PatikaDev]
GO

/****** Object:  Trigger [dbo].[InstructorCheck]    Script Date: 29.01.2022 13:44:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[InstructorCheck] on [dbo].[Course]
instead of insert
as 
begin
declare @instructorId int,@weeks int
declare @role nvarchar(max),@content nvarchar(max)
declare @startDate date ,@endDate date
	select @instructorId = instructorId,@weeks = weeks,@content=content, @startDate=startDate,@endDate=endDate from inserted
	select @role=p.role from Person p where @instructorId=p.id
	if(@role != 'instructor')
		begin	
			print('if')
			print(@role)
			raiserror('Geçerli bir eğitmen seçiniz',1,1);
			rollback transaction
		end
	else
		begin
			print('else')
			INSERT INTO Course
				VALUES (@content,@startDate,@endDate,@weeks,@instructorId)
		end
end
GO

ALTER TABLE [dbo].[Course] ENABLE TRIGGER [InstructorCheck]
GO

