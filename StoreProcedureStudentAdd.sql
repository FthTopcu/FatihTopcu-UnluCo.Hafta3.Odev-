USE [PatikaDev]
GO

/****** Object:  StoredProcedure [dbo].[StudentAdd]    Script Date: 29.01.2022 13:46:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[StudentAdd](
	@studentId int,
	@courseId int
)
as
declare @endDate date
declare @today date
begin
	
	select @endDate=c.endDate from CoursePerson cp 
													 full outer join Course c 
													 on c.Id = cp.CourseId
													 full outer join Person p
													 on p.id = cp.PersonId
													 where cp.PersonId = @studentId
	
	print(@endDate)
	print(@courseId)
	print(@studentId)

	if(@endDate>=Convert(date , getdate()))
	begin
		print('Öğrenci aktif bir eğitimde bulunuyor.')
	end
	else
	begin
		insert into CoursePerson values(@CourseId,@studentId)
	end
end
GO

