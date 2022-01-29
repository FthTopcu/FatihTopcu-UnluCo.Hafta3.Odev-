USE [PatikaDev]
GO

/****** Object:  View [dbo].[CourseStudents]    Script Date: 29.01.2022 13:44:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CourseStudents] as            
SELECT 								
c.content as 'CourseName',CONCAT(p.name,' ' , p.surname) as 'StudentName'
from CoursePerson cp left join Person p
on cp.PersonId = p.id
left join Course c
on cp.CourseId = c.Id
order by c.content,p.name offset 0 rows
	
GO

