/*
Run this script on:

        (localdb)\INLLocalDb2022.CSETWeb12019    -  This database will be modified

to synchronize it with:

        (localdb)\INLLocalDb2022.CSETWeb12020

You are recommended to back up your database before running this script

Script created by SQL Compare version 14.10.9.22680 from Red Gate Software Ltd at 5/31/2023 1:08:01 PM

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
PRINT N'Dropping foreign keys from [dbo].[ISE_ACTIONS_FINDINGS]'
GO
ALTER TABLE [dbo].[ISE_ACTIONS_FINDINGS] DROP CONSTRAINT [FK_ISE_ACTIONS_FINDINGS_ISE_ACTIONS]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[ISE_ACTIONS]'
GO
ALTER TABLE [dbo].[ISE_ACTIONS] DROP CONSTRAINT [FK_MATURITY_QUESTIONS_MAT_QUESTION_ID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping constraints from [dbo].[ISE_ACTIONS]'
GO
ALTER TABLE [dbo].[ISE_ACTIONS] DROP CONSTRAINT [PK__ISE_ACTI__B0B2E4E66B6807D2]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[MATURITY_QUESTIONS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[MATURITY_QUESTIONS] ADD
[Scope] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Recommend_Action] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Risk_Addressed] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Services] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ISE_ACTIONS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ISE_ACTIONS] ADD
[Action_Item_Id] [int] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ISE_ACTIONS] ADD
[Severity] [int] NULL,
[Mat_Option_Id] [int] NULL,
[Sequence] [int] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ISE_ACTIONS] on [dbo].[ISE_ACTIONS]'
GO
ALTER TABLE [dbo].[ISE_ACTIONS] ADD CONSTRAINT [PK_ISE_ACTIONS] PRIMARY KEY CLUSTERED ([Action_Item_Id], [Mat_Question_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[USERS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[USERS] ADD
[PreventEncrypt] [bit] NOT NULL CONSTRAINT [DF_USERS_PreventEncryption] DEFAULT ((1))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TTP_MAT_QUESTION]'
GO
CREATE TABLE [dbo].[TTP_MAT_QUESTION]
(
[TTP_Code] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Mat_Question_Id] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TTP_MAT_QUESTION] on [dbo].[TTP_MAT_QUESTION]'
GO
ALTER TABLE [dbo].[TTP_MAT_QUESTION] ADD CONSTRAINT [PK_TTP_MAT_QUESTION] PRIMARY KEY CLUSTERED ([TTP_Code], [Mat_Question_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [IX_TTP_MAT_QUESTION] on [dbo].[TTP_MAT_QUESTION]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TTP_MAT_QUESTION] ON [dbo].[TTP_MAT_QUESTION] ([TTP_Code], [Mat_Question_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[TTP]'
GO
CREATE TABLE [dbo].[TTP]
(
[TTP_Code] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[URL] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TTP] on [dbo].[TTP]'
GO
ALTER TABLE [dbo].[TTP] ADD CONSTRAINT [PK_TTP] PRIMARY KEY CLUSTERED ([TTP_Code])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_Assessments_Completion_For_Access_Key]'
GO



ALTER PROCEDURE [dbo].[usp_Assessments_Completion_For_Access_Key]
@accessKey varchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	--This procedure returns the number of answers and total number of available standard, maturity, and diagram questions
	--	available for each of the user's assessments.

	--Creating table variables
	declare @AssessmentCompletedQuestions table(AssessmentId INT, CompletedCount INT)
	declare @AssessmentTotalMaturityQuestionsCount table(AssessmentId INT, TotalMaturityQuestionsCount INT)
	declare @AssessmentTotalStandardQuestionsCount table(AssessmentId INT, TotalStandardQuestionsCount INT)
	declare @AssessmentTotalDiagramQuestionsCount table(AssessmentId INT, TotalDiagramQuestionsCount INT)

	-- I don't like hardcoding in these model ids, but we have to manually declare which models utilize user selected levels to 
	-- filter questions since some maturity models default to ML 1, but also have questions above that level.
	declare @MaturityModelsWithLevels table(ModelId INT)
	declare @MaturityModelsWithoutLevels table (ModelId INT)
	insert into @MaturityModelsWithLevels values (1), (2), (6)
	insert into @MaturityModelsWithoutLevels values (3), (4), (8), (5), (11), (9), (12), (13)

	declare @ParentMatIds table(Id INT)
	insert into @ParentMatIds select Parent_Question_Id from MATURITY_QUESTIONS where Parent_Question_Id is not null

	--Creating temp tables to hold applicable questions for each type of question
	select a.Assessment_Id, mq.Mat_Question_Id into #AvailableMatQuestions
		from MATURITY_QUESTIONS mq
		join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where a.UseMaturity = 1 and amm.model_id in (select ModelId from @MaturityModelsWithoutLevels)
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)


	select a.Assessment_Id, mq.Mat_Question_Id, mq.Maturity_Level_Id into #AvailableMatQuestionsWithLevels
		from MATURITY_QUESTIONS mq
			join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id
			join MATURITY_LEVELS ml on ml.Maturity_Level_Id = mq.Maturity_Level_Id
			where a.UseMaturity = 1
			and asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level >= ml.Level and amm.model_id in (select ModelId from @MaturityModelsWithLevels)
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)

    
	-- special case for ISE
	select a.Assessment_Id, mq.Mat_Question_Id, mq.Maturity_Level_Id into #AvailableMatQuestionsForIse
		from MATURITY_QUESTIONS mq
			join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id and asl.Level_Name = 'Maturity_Level'
			join MATURITY_LEVELS ml on ml.Maturity_Level_Id = mq.Maturity_Level_Id
			where a.UseMaturity = 1
			and amm.model_id = 10 AND ml.Maturity_Level_Id = mq.Maturity_Level_Id AND ml.level = asl.Standard_Specific_Sal_Level
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)


	-- special case for VADR
	select a.Assessment_Id, mq.Mat_Question_Id into #AvailableMatQuestionsForVadr
		from MATURITY_QUESTIONS mq
		join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id
			where a.UseMaturity = 1 and amm.model_id = 7
			and mq.Parent_Question_Id is null


	select a.Assessment_Id, q.question_Id into #AvailableQuestionBasedStandard
		from NEW_QUESTION q
			join NEW_QUESTION_SETS qs on q.Question_Id = qs.Question_Id
			join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id
			join UNIVERSAL_SUB_CATEGORY_HEADINGS usch on q.Heading_Pair_Id = usch.Heading_Pair_Id
			join AVAILABLE_STANDARDS stand on qs.Set_Name = stand.Set_Name
			join QUESTION_GROUP_HEADING qgh on usch.Question_Group_Heading_Id = qgh.Question_Group_Heading_Id
			join UNIVERSAL_SUB_CATEGORIES usc on usch.Universal_Sub_Category_Id = usc.Universal_Sub_Category_Id
			join ASSESSMENTS a on a.Assessment_Id = stand.Assessment_Id
			join STANDARD_SELECTION ss on ss.Assessment_Id = stand.Assessment_Id and Application_Mode = 'Questions Based'
			join UNIVERSAL_SAL_LEVEL usl on ss.Selected_Sal_Level = usl.Full_Name_Sal
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where a.UseStandard = 1 and stand.Selected = 1 and nql.Universal_Sal_Level = usl.Universal_Sal_Level


	select a.Assessment_Id, r.Requirement_Id into #AvailableRequirementBasedStandard
		from REQUIREMENT_SETS rs
			join AVAILABLE_STANDARDS stand on stand.Set_Name = rs.Set_Name and stand.Selected = 1
			join NEW_REQUIREMENT r on r.Requirement_Id = rs.Requirement_Id
			join ASSESSMENTS a on a.Assessment_Id = stand.Assessment_Id
			join STANDARD_SELECTION ss on ss.Assessment_Id = a.assessment_Id and Application_Mode = 'Requirements Based'
			join UNIVERSAL_SAL_LEVEL usl on usl.Full_Name_Sal = ss.Selected_Sal_Level
			join REQUIREMENT_LEVELS rl on rl.Requirement_Id = r.Requirement_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where a.UseStandard = 1 and rl.Standard_Level = usl.Universal_Sal_Level


	select a.Assessment_Id, q.Question_Id into #AvailableDiagramQuestions
		from STANDARD_SELECTION ss
			join 
			(select q.question_id, adc.assessment_id
				from ASSESSMENT_DIAGRAM_COMPONENTS adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id = nq.question_id		
				join new_question_sets qs on nq.question_id = qs.question_id	
				join DIAGRAM_CONTAINER l on adc.Layer_id = l.Container_Id
				left join DIAGRAM_CONTAINER z on adc.Zone_Id = z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
				where l.visible = 1) f on ss.assessment_id = f.assessment_id							
			join NEW_QUESTION q on f.Question_Id = q.Question_Id 
			join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			join UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
			join Answer_Components ac on f.Question_Id = ac.Question_Or_Requirement_Id and f.assessment_id = ac.assessment_id
			join ASSESSMENTS a on a.Assessment_Id = ss.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where a.UseDiagram = 1


	insert into @AssessmentCompletedQuestions
	select
		AssessmentId = a.Assessment_Id,
		CompletedCount = COUNT(DISTINCT(ans.Answer_Id))
		from ASSESSMENTS a 
			join ANSWER ans on ans.Assessment_Id = a.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where ans.Answer_Text != 'U' 
			and --This ensures the completed question counts are accurate even if users switch assessments types later on
			(ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestions amq
												where amq.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsWithLevels amql
												join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id 
												join MATURITY_LEVELS ml on ml.Maturity_Level_Id = amql.Maturity_Level_Id 
												where asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level >= ml.Level)
			or
			ans.Question_Or_Requirement_Id in (select Question_Id from #AvailableQuestionBasedStandard aqbs
												where aqbs.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Requirement_Id from #AvailableRequirementBasedStandard arbs
												where arbs.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Question_Id from #AvailableDiagramQuestions ads
												where ads.Assessment_Id = a.Assessment_Id)
			OR
            ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsForIse amqi
												join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id 
												join MATURITY_LEVELS ml on ml.Maturity_Level_Id = amqi.Maturity_Level_Id 
												where asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level = ml.Level)
			or
			ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsForVadr amqv 
												where amqv.Assessment_Id = a.Assessment_Id))
			group by a.Assessment_Id


	--Place 0 in completed questions count for assessments that have no answers yet
	insert into @AssessmentCompletedQuestions
	select
		AssessmentId = a.Assessment_Id,
		CompletedCount = 0
		from ASSESSMENTS a
		join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
		WHERE a.Assessment_Id 
		not in (select AssessmentId from @AssessmentCompletedQuestions)
		

	--Maturity questions count (For maturity models with level selection) available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsWithLevels
		group by Assessment_Id


	--Total Maturity questions count (for maturity models without level selection) available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestions
		group by Assessment_Id


	--Total Maturity questions count for ISE available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsForIse
		group by Assessment_Id
	

	--Total Maturity questions count for VADR available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsForVadr
		group by Assessment_Id


	--Requirements based questions count
	insert into @AssessmentTotalStandardQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalStandardQuestionsCount = COUNT(DISTINCT(Requirement_Id))
		from #AvailableRequirementBasedStandard
		group by Assessment_Id


	--Questions based standards questions count
	insert into @AssessmentTotalStandardQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalStandardQuestionsCount = COUNT(DISTINCT(Question_Id))
		from #AvailableQuestionBasedStandard
		group by Assessment_Id
	

		--Total diagram questions count
	insert into @AssessmentTotalDiagramQuestionsCount
	select                  
		AssessmentId = a.Assessment_Id,
		TotalDiagramQuestionsCount = COUNT(ans.Answer_Id)
		from ANSWER ans
			join ASSESSMENTS a on a.Assessment_Id = ans.Assessment_Id
			join ACCESS_KEY_ASSESSMENT aka on a.Assessment_Id = aka.Assessment_Id and aka.AccessKey = @accessKey
			where a.UseDiagram = 1 and ans.Question_Type = 'Component'
			group by a.Assessment_Id
	
	select
		AssessmentId = acq.AssessmentId,
		CompletedCount = acq.CompletedCount,
		TotalMaturityQuestionsCount = atmq.TotalMaturityQuestionsCount,
		TotalStandardQuestionsCount = atsq.TotalStandardQuestionsCount,
		TotalDiagramQuestionsCount = atdq.TotalDiagramQuestionsCount
		from @AssessmentCompletedQuestions acq
			full join @AssessmentTotalMaturityQuestionsCount atmq on atmq.AssessmentId = acq.AssessmentId
			full join @AssessmentTotalStandardQuestionsCount atsq on atsq.AssessmentId = acq.AssessmentId
			full join @AssessmentTotalDiagramQuestionsCount atdq on atdq.AssessmentId = acq.AssessmentId
END	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[usp_Assessments_Completion_For_User]'
GO



ALTER PROCEDURE [dbo].[usp_Assessments_Completion_For_User]
@User_Id int
AS
BEGIN
	SET NOCOUNT ON;

	--This procedure returns the number of answers and total number of available standard, maturity, and diagram questions
	--	available for each of the user's assessments.

	--Creating table variables
	declare @AssessmentCompletedQuestions table(AssessmentId INT, CompletedCount INT)
	declare @AssessmentTotalMaturityQuestionsCount table(AssessmentId INT, TotalMaturityQuestionsCount INT)
	declare @AssessmentTotalStandardQuestionsCount table(AssessmentId INT, TotalStandardQuestionsCount INT)
	declare @AssessmentTotalDiagramQuestionsCount table(AssessmentId INT, TotalDiagramQuestionsCount INT)

	-- I don't like hardcoding in these model ids, but we have to manually declare which models utilize user selected levels to 
	-- filter questions since some maturity models default to ML 1, but also have questions above that level.
	declare @MaturityModelsWithLevels table(ModelId INT)
	declare @MaturityModelsWithoutLevels table (ModelId INT)
	insert into @MaturityModelsWithLevels values (1), (2), (6)
	insert into @MaturityModelsWithoutLevels values (3), (4), (8), (5), (11), (9), (12), (13)

	declare @ParentMatIds table(Id INT)
	insert into @ParentMatIds select Parent_Question_Id from MATURITY_QUESTIONS where Parent_Question_Id is not null

	IF OBJECT_ID('tempdb..#AvailableMatQuestions') IS NOT NULL drop table #availableMatQuestions
	--Creating temp tables to hold applicable questions for each type of question
	select a.Assessment_Id, mq.Mat_Question_Id into #AvailableMatQuestions
		from MATURITY_QUESTIONS mq
		join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseMaturity = 1 and amm.model_id in (select ModelId from @MaturityModelsWithoutLevels)
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)

	IF OBJECT_ID('tempdb..#AvailableMatQuestionsWithLevels') IS NOT NULL drop table #AvailableMatQuestionsWithLevels
	select a.Assessment_Id, mq.Mat_Question_Id, mq.Maturity_Level_Id into #AvailableMatQuestionsWithLevels
		from MATURITY_QUESTIONS mq
			join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id
			join MATURITY_LEVELS ml on ml.Maturity_Level_Id = mq.Maturity_Level_Id
			where u.UserId = @User_Id and a.UseMaturity = 1
			and asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level >= ml.Level and amm.model_id in (select ModelId from @MaturityModelsWithLevels)
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)
    
	-- special case for ISE
	IF OBJECT_ID('tempdb..#AvailableMatQuestionsForIse') IS NOT NULL drop table #AvailableMatQuestionsForIse
		select a.Assessment_Id, mq.Mat_Question_Id, mq.Maturity_Level_Id into #AvailableMatQuestionsForIse	
		from MATURITY_QUESTIONS mq
			join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id and asl.Level_Name = 'Maturity_Level'
			join MATURITY_LEVELS ml on ml.Maturity_Level_Id = mq.Maturity_Level_Id
			where u.UserId = @User_Id and a.UseMaturity = 1
			and amm.model_id = 10 AND ml.Maturity_Level_Id = mq.Maturity_Level_Id AND ml.level = asl.Standard_Specific_Sal_Level
			and mq.Mat_Question_Id not in (select Id from @ParentMatIds)

	-- special case for VADR
	IF OBJECT_ID('tempdb..#AvailableMatQuestionsForVadr') IS NOT NULL drop table #availableMatQuestionsForVadr
	select a.Assessment_Id, mq.Mat_Question_Id into #AvailableMatQuestionsForVadr
		from MATURITY_QUESTIONS mq
		join AVAILABLE_MATURITY_MODELS amm on amm.model_id = mq.Maturity_Model_Id
			join ASSESSMENTS a on a.Assessment_Id = amm.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseMaturity = 1 and amm.model_id = 7
			and mq.Parent_Question_Id is null

	IF OBJECT_ID('tempdb..#AvailableQuestionBasedStandard') IS NOT NULL drop table #AvailableQuestionBasedStandard		
	select a.Assessment_Id, q.question_Id, ss.Selected_Sal_Level into #AvailableQuestionBasedStandard
		from NEW_QUESTION q
			join NEW_QUESTION_SETS qs on q.Question_Id = qs.Question_Id
			join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id
			join UNIVERSAL_SUB_CATEGORY_HEADINGS usch on q.Heading_Pair_Id = usch.Heading_Pair_Id
			join AVAILABLE_STANDARDS stand on qs.Set_Name = stand.Set_Name
			join QUESTION_GROUP_HEADING qgh on usch.Question_Group_Heading_Id = qgh.Question_Group_Heading_Id
			join UNIVERSAL_SUB_CATEGORIES usc on usch.Universal_Sub_Category_Id = usc.Universal_Sub_Category_Id
			join ASSESSMENTS a on a.Assessment_Id = stand.Assessment_Id
			join STANDARD_SELECTION ss on ss.Assessment_Id = stand.Assessment_Id and Application_Mode = 'Questions Based'
			join UNIVERSAL_SAL_LEVEL usl on ss.Selected_Sal_Level = usl.Full_Name_Sal
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseStandard = 1 and stand.Selected = 1 and nql.Universal_Sal_Level = usl.Universal_Sal_Level 

	IF OBJECT_ID('tempdb..#AvailableRequirementBasedStandard') IS NOT NULL drop table #AvailableRequirementBasedStandard		
	select a.Assessment_Id, r.Requirement_Id into #AvailableRequirementBasedStandard
		from REQUIREMENT_SETS rs
			join AVAILABLE_STANDARDS stand on stand.Set_Name = rs.Set_Name and stand.Selected = 1
			join NEW_REQUIREMENT r on r.Requirement_Id = rs.Requirement_Id
			join ASSESSMENTS a on a.Assessment_Id = stand.Assessment_Id
			join STANDARD_SELECTION ss on ss.Assessment_Id = a.assessment_Id and Application_Mode = 'Requirements Based'
			join UNIVERSAL_SAL_LEVEL usl on usl.Full_Name_Sal = ss.Selected_Sal_Level
			join REQUIREMENT_LEVELS rl on rl.Requirement_Id = r.Requirement_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseStandard = 1 and rl.Standard_Level = usl.Universal_Sal_Level

	IF OBJECT_ID('tempdb..#AvailableDiagramQuestions') IS NOT NULL drop table #AvailableDiagramQuestions		
	select a.Assessment_Id, q.Question_Id into #AvailableDiagramQuestions
		from STANDARD_SELECTION ss
			join 
			(select q.question_id, adc.assessment_id
				from ASSESSMENT_DIAGRAM_COMPONENTS adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id = nq.question_id		
				join new_question_sets qs on nq.question_id = qs.question_id	
				join DIAGRAM_CONTAINER l on adc.Layer_id = l.Container_Id
				left join DIAGRAM_CONTAINER z on adc.Zone_Id = z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
				where l.visible = 1) f on ss.assessment_id = f.assessment_id							
			join NEW_QUESTION q on f.Question_Id = q.Question_Id 
			join vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			join UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
			join Answer_Components ac on f.Question_Id = ac.Question_Or_Requirement_Id and f.assessment_id = ac.assessment_id
			join ASSESSMENTS a on a.Assessment_Id = ss.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseDiagram = 1


	insert into @AssessmentCompletedQuestions
	select
		AssessmentId = a.Assessment_Id,
		CompletedCount = COUNT(DISTINCT(ans.Answer_Id))
		from ASSESSMENTS a 
			join ANSWER ans on ans.Assessment_Id = a.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and ans.Answer_Text != 'U'
			and --This ensures the completed question counts are accurate even if users switch assessments types later on
			(ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestions avq 
												where avq.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsWithLevels amql
												join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id 
												join MATURITY_LEVELS ml on ml.Maturity_Level_Id = amql.Maturity_Level_Id 
												where asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level >= ml.Level)
			or
			ans.Question_Or_Requirement_Id in (select aqbs.Question_Id from #AvailableQuestionBasedStandard aqbs
												where aqbs.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Requirement_Id from #AvailableRequirementBasedStandard arbs 
												where arbs.Assessment_Id = a.Assessment_Id)
			or
			ans.Question_Or_Requirement_Id in (select Question_Id from #AvailableDiagramQuestions adq
												where adq.Assessment_Id = a.Assessment_Id)
			or
            ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsForIse amqi
												join ASSESSMENT_SELECTED_LEVELS asl on asl.Assessment_Id = a.Assessment_Id 
												join MATURITY_LEVELS ml on ml.Maturity_Level_Id = amqi.Maturity_Level_Id 
												where asl.Level_Name = 'Maturity_Level' and asl.Standard_Specific_Sal_Level = ml.Level)
			or 
			ans.Question_Or_Requirement_Id in (select Mat_Question_Id from #AvailableMatQuestionsForVadr amqv 
												where amqv.Assessment_Id = a.Assessment_Id)
			)
			group by a.Assessment_Id


	--Place 0 in completed questions count for assessments that have no answers yet
	insert into @AssessmentCompletedQuestions
	select
		AssessmentId = Assessment_Id,
		CompletedCount = 0
		from ASSESSMENTS where Assessment_Id 
		not in (select AssessmentId from @AssessmentCompletedQuestions)
		and 
		AssessmentCreatorId = @User_Id
	

	--Maturity questions count (For maturity models with level selection) available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsWithLevels
		group by Assessment_Id


	--Total Maturity questions count (for maturity models without level selection) available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestions
		group by Assessment_Id


	--Total Maturity questions count for ISE available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsForIse
		group by Assessment_Id
	

	--Total Maturity questions count for VADR available to answer
	insert into @AssessmentTotalMaturityQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalMaturityQuestionsCount = COUNT(DISTINCT(Mat_Question_Id))
		from #AvailableMatQuestionsForVadr
		group by Assessment_Id


	--Requirements based questions count
	insert into @AssessmentTotalStandardQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalStandardQuestionsCount = COUNT(DISTINCT(Requirement_Id))
		from #AvailableRequirementBasedStandard
		group by Assessment_Id


	--Questions based standards questions count
	insert into @AssessmentTotalStandardQuestionsCount
	select
		AssessmentId = Assessment_Id,
		TotalStandardQuestionsCount = COUNT(DISTINCT(Question_Id))
		from #AvailableQuestionBasedStandard
		group by Assessment_Id
	

		--Total diagram questions count
	insert into @AssessmentTotalDiagramQuestionsCount
	select                  
		AssessmentId = a.Assessment_Id,
		TotalDiagramQuestionsCount = COUNT(ans.Answer_Id)
		from ANSWER ans
			join ASSESSMENTS a on a.Assessment_Id = ans.Assessment_Id
			join USERS u on a.AssessmentCreatorId = u.UserId
			join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id and c.UserId = @User_Id
			where u.UserId = @User_Id and a.UseDiagram = 1 and ans.Question_Type = 'Component'
			group by a.Assessment_Id
	

	select
		AssessmentId = acq.AssessmentId,
		CompletedCount = acq.CompletedCount,
		TotalMaturityQuestionsCount = atmq.TotalMaturityQuestionsCount,
		TotalStandardQuestionsCount = atsq.TotalStandardQuestionsCount,
		TotalDiagramQuestionsCount = atdq.TotalDiagramQuestionsCount
		from @AssessmentCompletedQuestions acq
			full join @AssessmentTotalMaturityQuestionsCount atmq on atmq.AssessmentId = acq.AssessmentId
			full join @AssessmentTotalStandardQuestionsCount atsq on atsq.AssessmentId = acq.AssessmentId
			full join @AssessmentTotalDiagramQuestionsCount atdq on atdq.AssessmentId = acq.AssessmentId

END	
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CSF_MAPPING]'
GO
CREATE TABLE [dbo].[CSF_MAPPING]
(
[CSF_Code] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Question_Type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Question_Id] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_CSF_MAPPING] on [dbo].[CSF_MAPPING]'
GO
ALTER TABLE [dbo].[CSF_MAPPING] ADD CONSTRAINT [PK_CSF_MAPPING] PRIMARY KEY CLUSTERED ([CSF_Code], [Question_Type], [Question_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ISE_ACTIONS]'
GO
ALTER TABLE [dbo].[ISE_ACTIONS] ADD CONSTRAINT [FK__ISE_ACTIO__Mat_Q__7F2CAE86] FOREIGN KEY ([Mat_Question_Id]) REFERENCES [dbo].[MATURITY_QUESTIONS] ([Mat_Question_Id])
GO
ALTER TABLE [dbo].[ISE_ACTIONS] ADD CONSTRAINT [FK_MATURITY_QUESTIONS_MAT_QUESTION_ID] FOREIGN KEY ([Mat_Question_Id]) REFERENCES [dbo].[MATURITY_QUESTIONS] ([Mat_Question_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[TTP_MAT_QUESTION]'
GO
ALTER TABLE [dbo].[TTP_MAT_QUESTION] ADD CONSTRAINT [FK_TTP_MAT_QUESTION_MATURITY_QUESTIONS] FOREIGN KEY ([Mat_Question_Id]) REFERENCES [dbo].[MATURITY_QUESTIONS] ([Mat_Question_Id])
GO
ALTER TABLE [dbo].[TTP_MAT_QUESTION] ADD CONSTRAINT [FK_TTP_MAT_QUESTION_TTP] FOREIGN KEY ([TTP_Code]) REFERENCES [dbo].[TTP] ([TTP_Code])
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