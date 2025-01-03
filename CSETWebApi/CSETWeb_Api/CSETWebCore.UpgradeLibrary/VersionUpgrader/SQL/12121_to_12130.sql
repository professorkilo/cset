/*
Run this script on:

        (localdb)\INLLocalDB2022.CSETWeb12121    -  This database will be modified

to synchronize it with:

        (localdb)\INLLocalDB2022.CSETWeb12130

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.10.9.22680 from Red Gate Software Ltd at 2/12/2024 11:35:38 AM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[HYDRO_DATA]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[HYDRO_DATA] ADD
[Action_Item_Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Action_Items] [nchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Severity] [int] NULL,
[Sequence] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[COMPONENT_SYMBOLS_MAPPINGS]'
GO
CREATE TABLE [dbo].[COMPONENT_SYMBOLS_MAPPINGS]
(
[Component_Symbol_Id] [int] NOT NULL,
[Application] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Malcolm_Role] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Mapping_Id] [int] NOT NULL IDENTITY(1, 1)
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ISE_ACTIONS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ISE_ACTIONS] DROP
COLUMN [Severity],
COLUMN [Mat_Option_Id],
COLUMN [Sequence]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[NETWORK_WARNINGS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NETWORK_WARNINGS] ADD
[Rule_Violated] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[vQUESTION_HEADINGS]'
GO

ALTER VIEW [dbo].[vQUESTION_HEADINGS]
AS
SELECT dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Heading_Pair_Id, dbo.QUESTION_GROUP_HEADING.Question_Group_Heading, dbo.QUESTION_GROUP_HEADING.Question_Group_Heading_Id, 
                  dbo.UNIVERSAL_SUB_CATEGORIES.Universal_Sub_Category, dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Sub_Heading_Question_Description, dbo.UNIVERSAL_SUB_CATEGORIES.Universal_Sub_Category_Id
FROM     dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS INNER JOIN
                  dbo.UNIVERSAL_SUB_CATEGORIES ON dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Universal_Sub_Category_Id = dbo.UNIVERSAL_SUB_CATEGORIES.Universal_Sub_Category_Id INNER JOIN
                  dbo.QUESTION_GROUP_HEADING ON dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS.Question_Group_Heading_Id = dbo.QUESTION_GROUP_HEADING.Question_Group_Heading_Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getOverallRankedCategories]'
GO

-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getOverallRankedCategories]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode nvarchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin
	select @maxRank = max(c.Ranking) 
		FROM NEW_QUESTION c 
		join (select distinct question_id,Assessment_Id from NEW_QUESTION_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Question_Id = s.Question_Id
		where s.Assessment_Id = @assessment_id 
	

	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT h.Question_Group_Heading,
		h.Question_Group_Heading_Id as [QGH_Id],
		isnull(count(c.question_id),0) qc,  
		isnull(SUM(@maxRank-c.Ranking),0) cr, 
		sum(sum(@maxrank - c.Ranking)) OVER() AS Total 
		into #temp
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)
		s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA'
		group by Question_Group_Heading, Question_Group_Heading_id
     
	 SELECT h.Question_Group_Heading, 
		h.Question_Group_Heading_Id as [QGH_Id],
		isnull(count(c.question_id),0) nuCount, 
		isnull(SUM(@maxRank-c.Ranking),0) cr 
		into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)	s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('N','U')
		group by Question_Group_Heading, Question_Group_Heading_Id

	select t.*, 
	isnull(a.nuCount,0) nuCount, 
	isnull(a.cr,0) Actualcr, 
	Round(isnull(cast(a.cr as decimal(18,3))/Total,0)*100,2) [prc],  
	isnull(a.nuCount,0)/(cast(qc as decimal(18,3))) as [Percent]
	from #temp t left join #tempAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by prc desc	
end
else 
begin 
	select @maxRank = max(c.Ranking) 
		FROM NEW_REQUIREMENT c 
		join (select distinct requirement_id,Assessment_Id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Requirement_Id=s.Requirement_Id
		where s.Assessment_Id = @assessment_id 
	
	IF OBJECT_ID('tempdb..#TempR') IS NOT NULL DROP TABLE #TempR
	IF OBJECT_ID('tempdb..#TempRAnswered') IS NOT NULL DROP TABLE #TempRAnswered

	SELECT h.Question_Group_Heading,
	h.Question_Group_Heading_Id as [QGH_Id],
	count(c.Requirement_Id) qc,  
	SUM(@maxRank-c.Ranking) cr, 
	sum(sum(@maxrank - c.Ranking)) OVER() AS Total
	into #tempR
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join (select distinct requirement_id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1 and v.assessment_id = @assessment_id)
		s on c.Requirement_Id = s.Requirement_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA'
		group by Question_Group_Heading, h.Question_Group_Heading_Id

	SELECT h.Question_Group_Heading,
	h.Question_Group_Heading_Id as [QGH_Id],
	isnull(count(c.requirement_id),0) nuCount,
	SUM(@maxRank-c.Ranking) cr
	into #tempRAnswered
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join (select distinct requirement_id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1 and v.assessment_id = @assessment_id)
		s on c.Requirement_Id = s.Requirement_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('N','U')
		group by Question_Group_Heading, h.Question_Group_Heading_Id

	select t.*, 
	isnull(a.nuCount,0) nuCount, 
	isnull(a.cr,0) Actualcr, 	
	ROUND(isnull(cast(a.cr as decimal(18,3))/Total,0)*100,2) [prc],  
	isnull(a.nuCount,0)/(cast(qc as decimal(18,3))) as [Percent]
	from #tempR t left join #tempRAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by prc desc	
end
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getRankedCategories]'
GO

-- =============================================
-- Author:		barry
-- Create date: 7/20/2018
-- Description:	returns the ranked categories
-- =============================================
ALTER PROCEDURE [dbo].[usp_getRankedCategories]
	@assessment_id int	
AS
BEGIN
	SET NOCOUNT ON;
	-- ranked category calculation is 
	-- sum up the total category risk
	-- for the questions on this assessment
	-- then take the number of questions - the question rank 

/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode nvarchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin
	select @maxRank = max(c.Ranking) 
		FROM NEW_QUESTION c 
		join (select distinct question_id,Assessment_Id from NEW_QUESTION_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Question_Id = s.Question_Id
		where s.Assessment_Id = @assessment_id 
	

	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT h.Question_Group_Heading, Question_Group_Heading_Id, isnull(count(c.question_id),0) qc,  isnull(SUM(@maxRank-c.Ranking),0) cr, sum(sum(@maxrank - c.Ranking)) OVER() AS Total into #temp
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)
		s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA'
		group by Question_Group_Heading, Question_Group_Heading_Id
     
	 SELECT h.Question_Group_Heading, h.Question_Group_Heading_Id, isnull(count(c.question_id),0) nuCount, isnull(SUM(@maxRank-c.Ranking),0) cr into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id
		join (
			select distinct s.question_id from NEW_QUESTION_SETS s 
				join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
				join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id
				join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
				join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
				where v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		)	s on c.Question_Id = s.Question_Id
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('N','U')
		group by Question_Group_Heading, Question_Group_Heading_Id

	select t.*, isnull(a.nuCount,0) nuCount, isnull(a.cr,0) Actualcr, isnull(cast(a.cr as decimal(18,3))/Total,0)*100 [prc],  isnull(a.nuCount,0)/(cast(qc as decimal(18,3))) as [Percent]
	from #temp t left join #tempAnswered a on t.Question_Group_Heading = a.Question_Group_Heading
	order by prc desc	
end
else 
begin 
	select @maxRank = max(c.Ranking) 
		FROM NEW_REQUIREMENT c 
		join (select distinct requirement_id,Assessment_Id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Requirement_Id=s.Requirement_Id
		where s.Assessment_Id = @assessment_id 
	

	IF OBJECT_ID('tempdb..#TempR') IS NOT NULL DROP TABLE #TempR

	SELECT h.Question_Group_Heading, h.Question_Group_Heading_Id as [QGH_Id], count(c.Requirement_Id) qc,  SUM(@maxRank-c.Ranking) cr, sum(sum(@maxrank - c.Ranking)) OVER() AS Total into #tempR
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join (select distinct requirement_id from REQUIREMENT_SETS s join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name where v.Selected = 1)
		s on c.Requirement_Id = s.Requirement_Id
		where a.Assessment_Id = @assessment_id 
		group by Question_Group_Heading, h.Question_Group_Heading_Id

	
	select *, isnull(cast(cr as decimal(18,3))/Total, 0) * 100 [prc] from #tempR
	order by prc desc
end
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_getStandardsResultsByCategory]'
GO

-- =============================================
-- Author:		hansbk
-- Create date: 8/1/2018
-- Description:	Stub needs completed
-- =============================================
ALTER PROCEDURE [dbo].[usp_getStandardsResultsByCategory]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
TODO this needs to take into account requirements vs questions
get the question set then for all the questions take the total risk (in this set only)
then calculate the total risk in each question_group_heading(category) 
then calculate the actual percentage of the total risk in each category 
order by the total
*/
declare @applicationMode nvarchar(50)

exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output


declare @maxRank int 
if(@ApplicationMode = 'Questions Based')	
begin
	IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp
	IF OBJECT_ID('tempdb..#TempAnswered') IS NOT NULL DROP TABLE #TempAnswered

	SELECT s.Set_Name, Question_Group_Heading, Question_Group_Heading_Id, isnull(count(c.question_id),0) qc into #temp	
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id		
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id and a.Answer_Text != 'NA' and v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		group by s.Set_Name, Question_Group_Heading, Question_Group_Heading_Id

	insert into #temp (Set_Name, Question_Group_Heading, QC) 
	select a.Set_name,a.Question_Group_Heading, qc=0 from 
	(select * from (select distinct question_group_heading from #temp) a, (select distinct set_name from #temp) b) a 
	left join #temp on a.question_group_heading=#temp.question_group_heading and a.set_name = #temp.set_name
	where #temp.set_name is null

	SELECT s.Set_Name, Question_Group_Heading, Question_Group_Heading_Id, isnull(count(c.question_id),0) qc into #tempAnswered
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id
		join vQuestion_Headings h on c.Heading_Pair_Id=h.heading_pair_Id		
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id and a.Answer_Text in ('Y','A') and v.Selected = 1 and v.Assessment_Id = @assessment_id and l.Universal_Sal_Level = ul.Universal_Sal_Level
		group by s.Set_Name, Question_Group_Heading, question_group_Heading_Id
     
	select t.Set_Name,
	s.Short_Name,
	t.Question_Group_Heading, 
	t.Question_Group_Heading_Id as [QGH_Id],
	isnull(a.qc,0) yaCount, 
	isnull(t.qc,0) Actualcr, 
	round(isnull(cast(a.qc as decimal(18,3))/t.qc,0),5) * 100 [prc]
	from #temp t left join #tempAnswered a on t.Set_Name = a.Set_Name and  t.Question_Group_Heading = a.Question_Group_Heading
	join [SETS] s on t.Set_Name = s.Set_Name
	order by Question_Group_Heading desc	
end
else 
begin 

	IF OBJECT_ID('tempdb..#TempR') IS NOT NULL DROP TABLE #TempR
	IF OBJECT_ID('tempdb..#TempRAnswer') IS NOT NULL DROP TABLE #TempRAnswer

	SELECT s.set_name, h.Question_Group_Heading, h.Question_Group_Heading_Id, isnull(count(c.Requirement_Id),0) qc into #tempR
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join REQUIREMENT_SETS s on c.Requirement_Id = s.Requirement_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 		
		where a.Assessment_Id = @assessment_id and v.Assessment_Id = a.Assessment_Id and v.Selected = 1 and a.Answer_Text <> 'NA'
		group by s.set_name, Question_Group_Heading, h.question_group_heading_id

			/**for multiple sets get the unique list of sets and question_group headers
	   take the cross product 
	   left join and fill with zero
	   Essentially fill in the gaps on the categories
	   */


	insert into #tempR (Set_Name,Question_Group_Heading, QC) 
	select a.Set_name,a.Question_Group_Heading, qc=0 from 
	(select * from (select distinct question_group_heading from #tempR) a, (select distinct set_name from #tempR) b) a 
	left join #tempR on a.question_group_heading=#tempR.question_group_heading and a.set_name = #tempR.set_name
	where #tempR.set_name is null

	SELECT s.set_name, h.Question_Group_Heading, h.question_group_heading_id, count(c.Requirement_Id) qc into #tempRAnswer
		FROM Answer_Requirements a 
		join NEW_REQUIREMENT c on a.Question_Or_Requirement_Id=c.Requirement_Id
		join QUESTION_GROUP_HEADING h on c.Question_Group_Heading_Id = h.Question_Group_Heading_Id
		join REQUIREMENT_SETS s on c.Requirement_Id = s.Requirement_Id
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 		
		where a.Assessment_Id = @assessment_id and v.Assessment_Id = a.Assessment_Id and v.Selected = 1 and a.Answer_Text in ('Y','A')
		group by s.set_name, Question_Group_Heading, h.Question_Group_Heading_Id

	select t.Set_Name, 
	s.Short_Name, 
	t.Question_Group_Heading, 
	t.Question_Group_heading_id as [QGH_Id],
	isnull(a.qc,0) yaCount, 
	isnull(t.qc,0) Actualcr, 
	--isnull(a.qc,0)/cast(t.qc as decimal(18,3)) * 100 [prc]
	round(isnull(cast(a.qc as decimal(18,3))/t.qc,0),5) * 100 [prc]
	from #tempR t 
	left join #tempRAnswer a on t.Set_Name = a.Set_Name and t.Question_Group_Heading = a.Question_Group_Heading
	join [SETS] s on t.Set_Name = s.Set_Name
	order by Question_Group_Heading desc
end
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[NIST_SAL_INFO_TYPES_DEFAULTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[NIST_SAL_INFO_TYPES_DEFAULTS] ADD
[Type_Id] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[MALCOLM_MAPPING]'
GO
CREATE TABLE [dbo].[MALCOLM_MAPPING]
(
[Malcolm_Id] [int] NOT NULL IDENTITY(1, 1),
[Question_Id] [int] NOT NULL,
[Rule_Violated] [int] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_MALCOLM_MAPPING] on [dbo].[MALCOLM_MAPPING]'
GO
ALTER TABLE [dbo].[MALCOLM_MAPPING] ADD CONSTRAINT [PK_MALCOLM_MAPPING] PRIMARY KEY CLUSTERED ([Malcolm_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[COMPONENT_SYMBOLS_MAPPINGS]'
GO
ALTER TABLE [dbo].[COMPONENT_SYMBOLS_MAPPINGS] ADD CONSTRAINT [FK_COMPONENT_SYMBOLS_MAPPINGS_COMPONENT_SYMBOLS] FOREIGN KEY ([Component_Symbol_Id]) REFERENCES [dbo].[COMPONENT_SYMBOLS] ([Component_Symbol_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
