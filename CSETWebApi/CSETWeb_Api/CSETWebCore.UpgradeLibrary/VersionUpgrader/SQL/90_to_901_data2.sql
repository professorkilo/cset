﻿/*
Run this script on:

(localdb)\v11.0.csetweb90    -  This database will be modified

to synchronize it with:

localhost.csetweb

You are recommended to back up your database before running this script

Script created by SQL Data Compare version 13.7.7.10021 from Red Gate Software Ltd at 4/24/2019 4:26:49 PM

*/
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION

PRINT(N'Drop constraints from [dbo].[NEW_QUESTION]')
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_SETS]
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SAL_LEVEL]
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SUB_CATEGORY_HEADINGS]

PRINT(N'Drop constraint FK_Component_Questions_NEW_QUESTION from [dbo].[COMPONENT_QUESTIONS]')
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] NOCHECK CONSTRAINT [FK_Component_Questions_NEW_QUESTION]

PRINT(N'Drop constraint FK_STANDARD_COMPONENT_QUESTIONS_NEW_QUESTION from [dbo].[COMPONENT_STANDARD_QUESTIONS]')
ALTER TABLE [dbo].[COMPONENT_STANDARD_QUESTIONS] NOCHECK CONSTRAINT [FK_STANDARD_COMPONENT_QUESTIONS_NEW_QUESTION]

PRINT(N'Drop constraint FK_FINANCIAL_QUESTIONS_NEW_QUESTION from [dbo].[FINANCIAL_QUESTIONS]')
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] NOCHECK CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION]

PRINT(N'Drop constraint FK_NERC_RISK_RANKING_NEW_QUESTION from [dbo].[NERC_RISK_RANKING]')
ALTER TABLE [dbo].[NERC_RISK_RANKING] NOCHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_QUESTION]

PRINT(N'Drop constraint FK_NEW_QUESTION_SETS_NEW_QUESTION from [dbo].[NEW_QUESTION_SETS]')
ALTER TABLE [dbo].[NEW_QUESTION_SETS] NOCHECK CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION]

PRINT(N'Drop constraint FK_QUESTION_SUB_QUESTION_NEW_QUESTION from [dbo].[QUESTION_SUB_QUESTION]')
ALTER TABLE [dbo].[QUESTION_SUB_QUESTION] NOCHECK CONSTRAINT [FK_QUESTION_SUB_QUESTION_NEW_QUESTION]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1 from [dbo].[REQUIREMENT_QUESTIONS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION from [dbo].[REQUIREMENT_QUESTIONS_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION]

PRINT(N'Drop constraint FK_ADDRESS_USER_DETAIL_INFORMATION1 from [dbo].[ADDRESS]')
ALTER TABLE [dbo].[ADDRESS] NOCHECK CONSTRAINT [FK_ADDRESS_USER_DETAIL_INFORMATION1]

PRINT(N'Drop constraint FK_UNIVERSAL_SUB_CATEGORY_HEADINGS_UNIVERSAL_SUB_CATEGORIES from [dbo].[UNIVERSAL_SUB_CATEGORY_HEADINGS]')
ALTER TABLE [dbo].[UNIVERSAL_SUB_CATEGORY_HEADINGS] NOCHECK CONSTRAINT [FK_UNIVERSAL_SUB_CATEGORY_HEADINGS_UNIVERSAL_SUB_CATEGORIES]

PRINT(N'Drop constraints from [dbo].[NEW_REQUIREMENT]')
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_SETS]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY]

PRINT(N'Drop constraint FK_STANDARD_COMPONENT_QUESTIONS_NEW_REQUIREMENT from [dbo].[COMPONENT_STANDARD_QUESTIONS]')
ALTER TABLE [dbo].[COMPONENT_STANDARD_QUESTIONS] NOCHECK CONSTRAINT [FK_STANDARD_COMPONENT_QUESTIONS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT from [dbo].[FINANCIAL_REQUIREMENTS]')
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] NOCHECK CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_NERC_RISK_RANKING_NEW_REQUIREMENT from [dbo].[NERC_RISK_RANKING]')
ALTER TABLE [dbo].[NERC_RISK_RANKING] NOCHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_Parameter_Requirements_NEW_REQUIREMENT from [dbo].[PARAMETER_REQUIREMENTS]')
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] NOCHECK CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_LEVELS]')
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] NOCHECK CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_QUESTIONS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_QUESTIONS_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT from [dbo].[REQUIREMENT_REFERENCES]')
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] NOCHECK CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_SETS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT from [dbo].[REQUIREMENT_SOURCE_FILES]')
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] NOCHECK CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT]

PRINT(N'Drop constraints from [dbo].[IRP]')
ALTER TABLE [dbo].[IRP] NOCHECK CONSTRAINT [FK_IRP_IRP_HEADER]

PRINT(N'Drop constraint FK__Assessmen__IRP_I__5EDF0F2E from [dbo].[ASSESSMENT_IRP]')
ALTER TABLE [dbo].[ASSESSMENT_IRP] NOCHECK CONSTRAINT [FK__Assessmen__IRP_I__5EDF0F2E]

PRINT(N'Delete rows from [dbo].[USER_DETAIL_INFORMATION]')
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '782e9afc-c725-4a50-b411-051b559b48c1'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '0cc2bce9-3f85-49f1-8e5f-0f4a0919533a'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '45e08292-9b35-4f33-b324-126db4077a7c'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'e504642c-49fc-4526-9c42-16a426843314'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '5139ce3b-174a-4ca5-92a1-1dcba611fd9b'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'b4784b32-6719-4b87-944b-2db5816210d1'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '89e95497-df48-49a9-88c1-396d76b8f57b'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '57e7eaf5-ace2-45a1-b469-3e61eb76cfab'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '0db8ec7c-5232-466e-92b7-3eaac25966dd'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '8e230e45-1fbb-49c7-9882-4023633b1c3e'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '9a11243c-e320-4798-8334-4738faab40c2'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'd3e1578e-2db2-4f94-b2ad-4b06ca6c2037'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '5df01281-19d0-4b6c-ad64-4dec87202f81'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '3cf05b3c-4dd6-45c3-aa3d-5bcc97fa9214'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '64f8e2c7-b346-46c0-8dc9-5d269855392e'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'a1e79b08-519c-455a-9458-5dacd199f240'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '293c6dfe-f257-4b8c-8096-680b0a65bc7b'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'd6e86458-a70b-4f9b-a1e2-7350d0614652'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'fd872814-7614-4694-9de8-76cf618a2b80'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '1804da62-b3d1-4d5e-97d3-9260fc031d60'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'd02a9a64-b7cc-4407-ad46-bc954848e93c'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '2ff8c94d-9296-4b5a-b4ee-beede4fd0d40'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'a09606d0-383a-4c65-9d15-c897553527e6'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'aa0ce6eb-ba53-40a1-84e2-c96d6fd667b0'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '231ae166-4cda-4e47-92fe-cdd810029461'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = '85cf555d-2561-42d2-b3ab-e1f3ee444226'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'daac2379-61d0-43d2-a00d-e42c260fcc05'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'f01cecf5-5da3-4712-a50f-e66d90d3be15'
DELETE FROM [dbo].[USER_DETAIL_INFORMATION] WHERE [Id] = 'aecca173-6fdd-4724-aba0-e687cfdf2847'
PRINT(N'Operation applied to 29 rows out of 29')

PRINT(N'Delete row from [dbo].[UNIVERSAL_SUB_CATEGORIES]')
DELETE FROM [dbo].[UNIVERSAL_SUB_CATEGORIES] WHERE [Universal_Sub_Category] = 'Physical Access Control
'

PRINT(N'Update rows in [dbo].[NEW_QUESTION]')
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization have members of management that are responsible for implementing and managing information security and business continuity programs? 
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the institution use reports and metrics that go beyond events and incidents to address threat intelligence trends and its security posture?
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the change management system use thresholds to determine when a change requires a risk assessment?
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does a formal change management function govern decentralized or highly distributed change requests?
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Do risk assessments focus on safeguarding customer information?
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Do independent audits or reviews evaluate policies, procedures, and controls for significant risks associated with the institution''s operations?

Do idependent audits include risks in new products, emerging technologies, and information systems?' WHERE [Question_Id] = 15575
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Do access controls include password complexity and limits to password attempts and reuse?
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the training for personnel that process personally identifiable information include: 
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization implement mechanisms for users to authorize the processing of their personally identifiable information prior to the collection that:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization facilitate the destruction of personally identifiable information by:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Do you require the developer of the system, system component, or system service to perform threat modeling and vulnerability analyses at [Assignment: organization-defined breadth and depth] during development and during the subsequent testing and evaluation of the system, component, or service that:
PRINT(N'Operation applied to 11 rows out of 11')

PRINT(N'Update rows in [dbo].[NEW_REQUIREMENT]')
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Supplemental Guidance from NIST 800-53 Rev 4, CA-2
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Supplemental Guidance from NIST 800-53 Rev 4, SI-3
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Supplemental Guidance from NIST 800-53 Rev 4, CA-2
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The board or a board committee should be tasked for the oversight of these programs and should ensure compliance with the requirements of the programs by the financial institution’s management, employees, and contractors.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='At least annually, the board or an appropriate board committee reviews
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Management presents information to the board, in board meetings, pertaining to threats and related trends that are most prevalent and potentially impacting to the financial institution. The objective is to offer information that addresses potential or future risk exposure, which can help identify how management might strengthen the financial institutions security posture.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Continuous improvement is a constant process that identifies opportunities to increase efficiency, reduce costs, and enhance processes. This statement asks if management has a formal continuous improvement process (CIP) and if they apply that process to cybersecurity oversight.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='By sharing threat and incident data with reputable organizations there is potential benefit to the financial sector by enabling other institutions to assess and respond to current attacks. A threat information sharing policy customarily would:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should use cybersecurity metrics to determine where weaknesses or gaps exist within the cybersecurity program. The metrics can then be used to identify trends, make strategic decisions to address those trends, and allocate funding appropriately.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institution management should ensure the institution has sufficient expertise to oversee and manage their IT security operations. If there are gaps, management should obtain the needed expertise by outsourcing or improving security training for current security staff.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Documented practices for collecting information could include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Cyber intelligence model refers to the entire cyber intelligence function, addressing items such as strategy, budget, processes, policies, procedures, and resources including staffing. A cyber intelligence model includes a documented methodology for the collection, processing, integration, evaluation, analysis, and interpretation of available information. Specific components or considerations include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution procures and/or builds information sharing technologies that push threat information to non-security parts of the organization that may be targeted by those threats. The financial institution enables non-security parts of the organization to easily provide threat information to the security function.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Information-sharing activities are formally established in policies, standards and processes. These policies, standards and processes are supported by sufficient resources (people, funding, and tools) and include key stakeholders based on function (e.g., connected financial institutions, vendors, sector financial institutions, regulators, internal entities).
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Anti-virus software and intrusion detection or prevention systems help identify unusual activity by analyzing network traffic or code and alerting or take action, such as blocking traffic that enters the network. Anti-Virus protection should be deployed on all resources. In instances where anti-virus protection cannot be deployed, management should and provide mitigating measures in the financial institution''s risk assessment.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Segmenting is evidenced by separate local area networks (LANs) or virtual local area networks (VLANs) (supported by a unique subnet) for each floor or department at a site, for each branch, and most definitely between public facing and private sections of the network. It might include a separate LAN for automated teller machines (ATMs). LANs are defined as being able to communicate with each other. Only specific devices can communicate between LANs.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Remote administration means a defined number of individuals within the financial institution or its contractors or vendors receive privileged access rights that include remote access capabilities. Remote access (e.g., mobile device or offsite workstation) enables network troubleshooting, update, and maintenance. These users often have access to highly critical systems and data; therefore, the financial institution must establish strong security controls and closely monitor all access.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='In a virtual environment a single physical server can operate and process data for several individual operating systems and related applications. These combined resources are referred to as virtual instances, or virtual machines. A virtual instance resides within the overall network environment. The manner in which these traditional physical devices and virtual instances communicate, transfer data, and store information is governed by secure configuration and active monitoring that help establish trusted and untrusted segments or zones. Controls commonly implemented include establishing granular access controls, use of firewalls and routers to properly direct traffic flow, and strong data and user logging capabilities, such as cross system log correlation.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Every financial institution is at risk for zero-day exploits regardless of size. These exploits will often circulate for months until the vulnerability is made public, leaving financial institutions unprotected.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The goal of access control is to allow access by authorized individuals and devices and to disallow access by all others. Authorized individuals may be employees, technology service provider (TSP) employees, vendors, contractors, customers, or visitors. Access should be authorized and provided only to individuals whose identity is established, and their activities should be limited to the minimum required for business purposes.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should conduct risk assessments and use effective authentication methods appropriate to the level of risk. Best practices include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Separation of non-production (e.g., development) from the production environment is important to safeguarding the confidentiality and integrity of information. Institutions can establish test environments which may house either live production or test data. These environments should both include strong security controls, logical and physical separation (e.g., firewalls and segmentation), active monitoring, and individual test (usually limited to development staff) and production user access privileges that are regularly reviewed and approved. Gaps in production and test environment controls could lead to unintended data modification, unauthorized access, and malicious or fraudulent activity.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Mobile device encryption, using either hardware or software-based solutions, is a way to secure data on smartphones, tablets, and mobile devices against the loss of information due to a loss or theft. Institutions should ensure any mobile device storing or accessing confidential information has implemented an effective encryption solution.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should secure remote access to and from their critical systems. Typically, remote access to systems and devices are gained through virtual private network (VPN) gateways and remote access technologies such as WebEx or Citrix. Communications should be encrypted to ensure the privacy and confidentiality of information.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Call centers/help desks should have a documented protocol for user identification before addressing issues or taking requested actions.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='A data destruction policy is a part of the data retention policy. Completing and implementing a data retention policy will help determine where information and data is stored, which makes it easier to delete old data no longer needed. Once the data has been mapped to the stored locations and a retention policy developed outlining how long it should be kept, a disposal process should be formalized and implemented.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Encryption Key Management, if not done properly, can lead to compromise and disclosure of private keys used to secure sensitive data and hence, compromise of the data. While users may understand it is important to encrypt certain documents and electronic communications, they may not be familiar with minimum standards for protecting encryption keys, for their ATMs for example. Symmetric encryption keys, when at rest, must be protected with security measures at least as stringent as the measures used for distribution of that key.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Privilege escalation is an attack technique that attempts to gain unauthorized access to a network. Successful privilege escalation attacks grant hackers privileges normal users don''t have. The attacker takes advantage of programming errors or design flaws that enable elevated access to the network, data, and applications. There are two types of privilege escalation: vertical and horizontal.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Multifactor authentication (MFA) is a security control that requires more than one authenticating element to verify the user’s identity (e.g., something known, something the user has, or something they are).
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='High-risk transactions involve access to customer information or the movement of funds to other parties. For example, a high-risk system is one that is remotely accessible and allows direct access to funds, fund transfer mechanisms, or sensitive customer data.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Tokenization is a process by which a primary value is replaced with a surrogate value called a token. De-tokenization is the reverse process of redeeming a token for its associated primary value. The security of an individual token relies predominantly on the infeasibility of determining the original primary value knowing only the surrogate value.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions may employ passwords, tokens, or biometrics to authenticate user identities, or in the case of multifactor authentication, some combination of one or more of the above. A financial institution''s IT organization should be in control of centralized vendor access pathways that allow them to enforce access control policies and to record and monitor all third-party activity. Financial institutions often select two or three authentication solutions that can be implemented together to achieve acceptable levels of risk mitigation:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Failure to control or manage the use of removable media can lead to material financial loss, the theft of information, the introduction of malware and the loss of reputation. Financial institution management should perform a risk assessment on the use of removable media and apply appropriate and proportionate security controls, in the context of their business and risk appetite. Risk mitigation approaches that financial institution management may implement to address these risks may include: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Defending mobile and remote machines against the latest known threats involves solutions that verify that the necessary fixes or patches are in place and that the machines are in compliance with corporate policies. For example, institutions may require that machines have up to date antivirus software.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Defending mobile and remote machines against the latest known threats involves solutions that verify that the necessary fixes or patches are in place and that the machines are in compliance with corporate policies. For example, institutions may require that machines have up to date antivirus software.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Sandboxing is a computer security term referring to when a program is set aside from other programs in a separate environment so that if errors or security issues occur, those issues will not spread to other areas on the computer. Programs are enabled in their own sequestered area, where they can be worked on without posing any threat to other programs.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The system development life cycle is the overall process of developing, implementing, and retiring information systems through a multistep process from initiation, analysis, design, implementation, and maintenance to disposal. There are many different system development life cycle (SDLC) models and methodologies, but each generally consists of a series of defined steps or phases. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should determine whether application security should be considered at the pre or post development phase or throughout the SDLC process of application development. Application developers and architects should know the importance of security to their applications and how security as a process should be incorporated during their development lifecycle.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='A vulnerability scan identifies a financial institution''s known vulnerabilities. A penetration test attempts to exploit potential vulnerabilities.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Malware has become more and more sophisticated in recent years, evolving from annoyance attacks or proof-of-concept attacks to rootkits and key loggers designed to steal critical business data. To combat these types of threats, financial institutions should use tools to detect viruses and malware on all systems (laptops, tablets, servers, mobile, etc.).
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Sandboxing is a computer security term referring to when a program is set aside from other programs in a separate environment so that if errors or security issues occur, those issues will not spread to other areas on the computer. Programs are enabled in their own sequestered area, where they can be worked on without posing any threat to other programs.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should have safe and efficient systems for transferring funds internally, among themselves, and with their customers for large-dollar payments relating to financial market transactions and settling wholesale and consumer payments. This may include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution maintains sufficient logs of physical and logical access to review an event.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='A mechanism for real-time automated risk scoring of threats: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should have system event and antivirus systems configured to alert management and/or appropriate security personnel when an event is detected.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The most effective way to detect and prevent network compromise and data breaches is through early recognition and investigation of potentially suspicious network activity. If a financial institution cannot detect activity that is out of the ordinary, then unexpected usage, unauthorized changes, and malicious attacks can go unnoticed. This may lead to network resource exhaustion, network compromise, and data breaches. Therefore, appropriate staff should be responsible for monitoring and reporting suspicious systems activity.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Patch management standards should include procedures for identifying, evaluating, approving, testing, installing, and documenting patches and to identify available patches and to acquire them from trusted sources.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Gramm-Leach-Bliley Act (GLBA) guidelines direct financial institutions to test key information security program controls. Senior management should require periodic self-assessments to provide an ongoing assessment of policy adequacy and compliance and ensure timely corrective action of significant deficiencies.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institutions should have a formal data destruction policy and procedures to handle the various types of data outlined within their data classification policy.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Management should control and monitor all third-party connections. Controls can include network segmentation, inline IDS/IPS and SIEM or log aggregation tools.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='A financial institution''s board and management should conduct appropriate due diligence on all potential third parties before selecting and entering into contracts or relationships. A financial institution should not rely solely on experience with or prior knowledge of the third-party as a proxy for an objective, in-depth assessment of the third-party’s ability to perform the activity in compliance with all applicable laws and regulations and in a safe and sound manner.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institution management may rely on third-parties to provide critical services; management, however, remains responsible for ensuring the confidentiality, integrity and availability of the financial institution’s systems and information by overseeing the effectiveness of the services provided by third-party service providers. Management must require its service providers by contract to implement appropriate measures designed to meet the objectives of regulatory guidelines for safeguarding member information (GLBA guidelines). Management should verify that third-party service providers implement and maintain controls sufficient to appropriately mitigate risks. The financial institution’s contracts customarily would: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institution management may rely on third-parties to provide critical services; management, however, remains responsible for ensuring the confidentiality, integrity and availability of the financial institution’s systems and information by overseeing the effectiveness of the services provided by third-party service providers. Management must require its service providers by contract to implement appropriate measures designed to meet the objectives of regulatory guidelines for safeguarding member information (GLBA guidelines). Management should verify that third-party service providers implement and maintain controls sufficient to appropriately mitigate risks. The financial institution’s contracts customarily would: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Financial institution management may rely on third-parties to provide critical services; management, however, remains responsible for ensuring the confidentiality, integrity and availability of the financial institution’s systems and information by overseeing the effectiveness of the services provided by third-party service providers. Management customarily oversees outsourced operations through: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Contracts require third-party service provider’s security policies meet or
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution should have a board-approved business continuity, disaster recovery, and data backup program to recover operations following an incident. The BCP should address: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='An incident response plan should contain provisions for preparation, detection, containment, eradication, remediation and follow-up. At a minimum, each financial institution must have a response program for unauthorized access to customer information as required by Gramm Leach Bliley Act (GLBA). Specifically, the response program must contain provisions to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Cyber incidents can potentially cause significant financial loss due to business interruptions, reputational damage, data breaches, theft of corporate or customer funds, and compromise of strategic plans or other critical intellectual property.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution may use active and or passive monitoring tools that will generate an alert when it detects any deviation from normal or expected operation. The security team based on their analysis of the alert may invoke the incident response program.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='An insider can have levels of authorization that increase their ability to access a financial institution''s internal systems and resources. A financial institution''s processes should help detect and alert the incident response team of potential insider activity that may manifest into a security violation. Incidents that may relate to insider threat activity include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution uses network-monitoring software to detect internal and external cyber threats. To determine what kinds of patterns are anomalous and therefore potentially suspicious, institutions should establish a network activity baseline.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution has an effective process that can detect and block zero-day attempts and inform management and the incident response team in real-time.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Where feasible, every step taken, from the time the incident was detected to its final resolution, should be documented and timestamped. Recording the steps performed can also lead to more efficient, systematic, and less error-prone forensic and recovery efforts. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='One of the most important parts of incident response is also the most often omitted: learning and improving. Holding a “lessons learned” meeting with all involved parties after a major incident, and optionally periodically after lesser incidents as resources permit, can be extremely helpful in improving security measures and the incident handling process itself.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution has procedures in place to restore system functionality once the infected devices have been restored or replaced. Procedures should also address when the temporary containment or restrictive security measures will be terminated. In all cases, the devices or operating system should be restored so that they are no longer vulnerable to the malware threat. The procedures should address restoration of single or few devices as well as the rebuilding of a large number of the financial institution’s IT devices and systems.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution may have an Incident Management and Cyber Threat Intelligence department. The two departments may also be one department but the information they handle varies and must be coordinated. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='To enhance incident response actions and bolster cyber defenses, institutions should harness the collective wisdom of incident response functions within the financial institution and the collective wisdom of peer organizations through information sharing and coordinated incident response.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The financial institution follows a defense-in-depth strategy. "Defense-in-Depth" relies on the intelligent application of techniques and technologies and overlay of controls. Defense-in-depth methodologies and techniques might include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='An incident response plan should contain provisions for preparation, detection, containment, eradication, remediation and follow-up. Each institution should have a response program to address incidents of unauthorized access to customer information under Interagency Guidance on Response Programs for Unauthorized Access to Customer Information and Customer Notice. Response program components: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='The incident response program includes incident reporting procedures that ensure the financial institution promptly reports incident information to appropriate authorities and service providers, if appropriate.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Quantitative examples include elapsed time from the beginning of the incident to incident discovery, to the initial impact assessment, and to each stage of the incident handling process (e.g., containment, recovery).
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='System account types include, for example, individual, shared, group, system, guest, anonymous, emergency, developer/manufacturer/vendor, temporary, and service. The identification of authorized users of the system and the specification of access privileges reflects the requirements in other controls in the security plan. Users requiring administrative privileges on system accounts receive additional scrutiny by appropriate organizational personnel responsible for approving such accounts and privileged access, including, for example, system owner, mission/business owner, or chief information security officer. Organizations may choose to define access privileges or other attributes by account, by type of account, or a combination of both. Other attributes required for authorizing access include, for example, restrictions on time-of-day, day-of-week, and point-of-origin. In defining other account attributes, organizations consider system-related requirements and mission/business requirements. Failure to consider these factors could affect system availability. Temporary and emergency accounts are intended for short-term use. Organizations establish temporary accounts as a part of normal account activation procedures when there is a need for short-term accounts without the demand for immediacy in account activation. Organizations establish emergency accounts in response to crisis situations and with the need for rapid account activation. Therefore, emergency account activation may bypass normal account authorization processes. Emergency and temporary accounts are not to be confused with infrequently used accounts including, for example, local logon accounts used for special tasks or when network resources are unavailable. Such accounts remain available and are not subject to automatic disabling or removal dates. Conditions for disabling or deactivating accounts include, for example, when shared/group, emergency, or temporary accounts are no longer required; or when individuals
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='In contrast to conventional access control approaches which employ static system accounts and predefined user privileges, dynamic access control approaches rely on run time access control decisions facilitated by dynamic privilege management such as attribute based access control (ABAC). While user identities remain relatively constant over time, user privileges typically change more frequently based on ongoing mission or business requirements and operational needs of organizations. Dynamic privilege management can include, for example, immediate revocation of privileges from users, as opposed to requiring
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Privileged roles are organization-defined roles assigned to individuals that allow those individuals to perform certain security-relevant functions that ordinary users are not authorized to perform. These privileged roles include, for example, key management, account management, network and system administration, database administration, and web administration.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Mandatory access control is a type of nondiscretionary access control. The above class of mandatory access control policies constrains what actions subjects can take with information obtained from data objects for which they have already been granted access. This prevents the subjects from passing the information to unauthorized subjects and objects. This class of mandatory access control policies also constrains what actions subjects can take with respect to the propagation of access control privileges; that is, a subject with a privilege cannot pass that privilege to other subjects. The policy is uniformly enforced over all subjects and objects to which the system has control. Otherwise, the access control policy can be circumvented. This enforcement is provided by an implementation that meets the reference monitor concept as described in AC-25. The policy is bounded by the system boundary (i.e., once the information is passed outside of the control of the system, additional means may be required to ensure that the constraints on the information remain in effect). The trusted subjects described above are granted privileges consistent with the concept of least privilege (see AC-6). Trusted subjects are only given the minimum privileges relative to the above policy necessary for satisfying organizational mission/business needs. The control is most applicable when there is a policy mandate that establishes a policy regarding access to controlled unclassified information or classified information and some users of the system are not authorized access to all such information resident in the system. This control can operate in conjunction with AC-3(4). A subject constrained in its operation by policies governed by this control is still able to operate under the less rigorous constraints of AC-3(4), but policies governed by this control take precedence over the less rigorous constraints of AC-3(4). For example, while a mandatory access control policy imposes a constraint preventing a subject from passing information to another subject operating at a different sensitivity label, AC-3(4) permits the subject to pass the information to any subject with the same sensitivity label as the
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Role-based access control (RBAC) is an access control policy that restricts system access to authorized users. Organizations can create specific roles based on job functions and the authorizations (i.e., privileges) to perform needed operations on the systems associated with the organization-defined roles. When users are assigned to the organizational roles, they inherit the authorizations or privileges defined for those roles. RBAC simplifies privilege administration for organizations because privileges are not assigned directly to every user (which can be a significant number of individuals for mid- to large-size organizations) but are instead acquired through role assignments. RBAC can be implemented either as a mandatory or discretionary form of access control. For organizations implementing RBAC with mandatory access controls, the requirements in AC-3(3) define the
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Attribute-based access control (ABAC) is an access control policy that restricts system access to authorized users based on their organizational attributes, such as job function; environmental attributes, such as time of day; and resource attributes, such as the classification of a document. Organizations can create specific rules based on attributes and the authorizations (i.e., privileges) to perform needed operations on the systems associated with the organization-defined attributes and rules. When users are assigned to attributes defined in ABAC policies or rules, they can be provisioned to a system with appropriate privileges or dynamically granted access to a protected resource upon access. ABAC can be implemented either as a mandatory or discretionary form of access control. For organizations implementing ABAC with mandatory access controls, the requirements in AC-3(3) define the scope of the subjects and objects covered by the policy. NIST Special Publications 800-57-1, 800-57-2, 800-57-3, 800-162; NIST Interagency
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Information flow control regulates where information can travel within a system and between systems (as opposed to who is allowed to access the information) and without explicit regard to subsequent accesses to that information. Flow control restrictions include, for example, keeping export-controlled information from being transmitted in the clear to the Internet, blocking outside traffic that claims to be from within the organization, restricting web requests to the Internet that are not from the internal web proxy server, and limiting information transfers between organizations based on data structures and content. Transferring information between systems in different security domains with different security policies introduces risk that such transfers violate one or more domain security policies. In such situations, information owners or stewards provide guidance at designated policy enforcement points between interconnected systems. Organizations consider mandating specific architectural solutions when required to enforce specific security policies. Enforcement includes, for example, prohibiting information transfers between interconnected systems (i.e., allowing access only); employing hardware mechanisms to enforce one-way information flows; and implementing trustworthy regrading
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Review [Assignment: organization-defined frequency] the privileges assigned to [Assignment: organization-defined roles or classes of users] to validate the need for such privileges; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Enforce a limit of [Assignment: organization-defined number] consecutive invalid logon attempts by a user during a [Assignment: organization-defined time-period]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Display [Assignment: organization-defined system use notification message or banner] to users before granting access to the system that provides privacy and security notices consistent with applicable laws, Executive Orders, directives, policies, regulations, standards, and guidelines and state that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Prevent further access to the system by initiating a device lock after [Assignment: organization-defined time-period] of inactivity or upon receiving a request from a user; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Identify [Assignment: organization-defined user actions] that can be performed on the system without identification or authentication consistent with organizational missions and business functions; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Provide the means to associate [Assignment: organization-defined types of security and privacy attributes] having [Assignment: organization-defined security and privacy attribute values] with information in storage, in process, and/or in transmission; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish and document usage restrictions, configuration/connection requirements, and implementation guidance for each type of remote access allowed; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Authorize the execution of privileged commands and access to security-relevant information via remote access only for [Assignment: organization-defined needs]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish usage restrictions, configuration/connection requirements, and implementation guidance for wireless access; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish usage restrictions, configuration requirements, connection requirements, and implementation guidance for organization-controlled mobile devices; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Prohibit the use of unclassified mobile devices in facilities containing systems processing, storing, or transmitting classified information unless specifically permitted by the authorizing official; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Establish terms and conditions, consistent with any trust relationships established with other organizations owning, operating, and/or maintaining external systems, allowing authorized individuals to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Permit authorized individuals to use an external system to access the system or to process, store, or transmit organization-controlled information only after: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Facilitate information sharing by enabling authorized users to determine whether access authorizations assigned to the sharing partner match the access restrictions and privacy authorizations on the information for [Assignment: organization-defined information sharing circumstances where user discretion is required]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Designate individuals authorized to post information onto a publicly accessible system; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide basic security and privacy awareness training to system users (including managers, senior executives, and contractors): 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide role-based security and privacy training to personnel with the following roles and responsibilities: [Assignment: organization-defined roles and responsibilities]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide personnel who process personally identifiable information with initial and [Assignment: organization-defined frequency] training on: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Document and monitor individual system security and privacy training activities including basic security and privacy awareness training and specific role-based system security and privacy training; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Verify that the system can audit the following event types: [Assignment: organization-defined auditable event types]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Alert [Assignment: organization-defined personnel or roles] in the event of an audit processing failure within [Assignment: organization-defined time-period]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Review and analyze system audit records [Assignment: organization-defined frequency] for indications of [Assignment: organization-defined inappropriate or unusual activity]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide and implement an audit reduction and report generation capability that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Use internal system clocks to generate time stamps for audit records; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Compare the internal system clocks [Assignment: organization-defined frequency] with [Assignment: organization-defined authoritative time source]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Identify a secondary authoritative time source that is in a different geographic region than the primary authoritative time source; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='This control enhancement helps reduce the risk of a vulnerability specific to an operating system resulting in a compromise of the audit records.  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Bind the identity of the information producer with the information to [Assignment: organization-defined strength of binding]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Validate the binding of the information producer identity to the information at [Assignment: organization-defined frequency]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Validate the binding of the information reviewer identity to the information at the transfer or release points prior to release or transfer between [Assignment: organization-defined security domains]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Provide audit record generation capability for the auditable event types in AU-2 a. at [Assignment: organization-defined system components]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop a security and privacy assessment plan that describes the scope of the assessment including: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Authorize connections from the system to other systems using Interconnection Security Agreements; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Identify secondary and tertiary connections to the interconnected systems; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop a plan of action and milestones for the system to document the planned remedial actions of the organization to correct weaknesses or deficiencies noted during the assessment of the controls and to reduce or eliminate known vulnerabilities in the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Assign a senior-level executive or manager as the authorizing official for the system and for any common controls inherited by the system; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Develop a security and privacy continuous monitoring strategy and implement security and privacy continuous monitoring programs that include: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Ensure risk monitoring is an integral part of the continuous monitoring strategy that includes the following: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Authorize internal connections of [Assignment: organization-defined system components or classes of components] to the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and maintain under configuration control, a current baseline configuration of the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Issue [Assignment: organization-defined systems or system components] with [Assignment: organization-defined configurations] to individuals traveling to locations that the organization deems to be of significant risk; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Determine the types of changes to the system that are configuration-controlled; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Employ automated mechanisms to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Enforce access restrictions; and  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Limit privileges to change system components and system-related information within a production or operational environment; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish and document configuration settings for components employed within the system using [Assignment: organization-defined common secure configurations] that reflect the most restrictive mode consistent with operational requirements; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Configure the system to provide only essential capabilities; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Review the system [Assignment: organization-defined frequency] to identify unnecessary and/or nonsecure functions, ports, protocols, and services; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Identify [Assignment: organization-defined software programs not authorized to execute on the system]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Identify [Assignment: organization-defined software programs authorized to execute on the system]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and document an inventory of system components that:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ automated mechanisms [Assignment: organization-defined frequency] to detect the presence of unauthorized hardware, software, and firmware components within the system; and
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Verify that all components within the authorization boundary of the system are not duplicated in other system component inventories; or
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Assign [Assignment: organization-defined acquired system components] to a system; and
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Develop, document, and implement a configuration management plan for the system that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Use software and associated documentation in accordance with contract agreements and copyright laws; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish [Assignment: organization-defined policies] governing the installation of software by users; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Identify the location of [Assignment: organization-defined information] and the specific system components on which the information resides; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop a contingency plan for the system that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide contingency training to system users consistent with assigned roles and responsibilities:  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Test the contingency plan for the system [Assignment: organization-defined frequency] using [Assignment: organization-defined tests] to determine the effectiveness of the plan and the organizational readiness to execute the plan; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Test the contingency plan at the alternate processing site: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish an alternate storage site including necessary agreements to permit the storage and retrieval of system backup information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish an alternate processing site including necessary agreements to permit the transfer and resumption of [Assignment: organization-defined system operations] for essential missions and business functions within [Assignment: organization-defined time-period consistent with recovery time and recovery point objectives] when the primary processing capabilities are unavailable; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Develop primary and alternate telecommunications service agreements that contain priority-of-service provisions in accordance with organizational availability requirements (including recovery time objectives); and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Require primary and alternate telecommunications service providers to have contingency plans; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Conduct backups of user-level information contained in the system [Assignment: organization-defined frequency consistent with recovery time and recovery point objectives]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='This control enhancement applies to organizations implementing logical access control and physical access control systems. Personal Identity Verification (PIV) credentials are those credentials issued by federal agencies that conform to FIPS Publication 201 and supporting guidance documents. The adequacy and reliability of PIV card issuers are addressed and authorized using NIST Special Publication 800-79. Acceptance of PIV credentials includes derived PIV credentials, the use of which is addressed in NIST 800-166. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Where addresses are allocated dynamically, standardize dynamic address allocation lease information and the lease duration assigned to devices in accordance with [Assignment: organization-defined lease information and lease duration]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Manage system identifiers by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Manage system authenticators by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='For password-based authentication: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='For public key-based authentication: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Identity proof users that require accounts for logical access to systems based on appropriate identity assurance level requirements as specified in applicable standards and guidelines;  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Implement [Assignment: organization-defined tools or mechanisms] for users to authorize the processing of their personally identifiable information prior to its collection that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish and implement a process for individuals to have inaccurate personally identifiable information maintained by the organization corrected or amended; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Make privacy notice(s) available to individuals upon first interacting with an organization, and subsequently [Assignment: organization-defined frequency]. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Include Privacy Act Statements on organizational forms that collect personally identifiable information, or on separate forms that can be retained by individuals; or 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide incident response training to system users consistent with assigned roles and responsibilities: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Use qualitative and quantitative data from testing to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Implement an incident handling capability for security and privacy incidents that includes preparation, detection and analysis, containment, eradication, and recovery; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Require personnel to report suspected security and privacy incidents to the organizational incident response capability within [Assignment: organization-defined time-period]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Establish a direct, cooperative relationship between its incident response capability and external providers of system protection capability; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop an incident response plan that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Include the following additional processes in the Incident Response Plan for incidents involving personally identifiable information: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Respond to information spills by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Schedule, document, and review records of maintenance, repair, or replacement on system components in accordance with manufacturer or vendor specifications and/or organizational requirements; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ automated mechanisms to schedule, conduct, and document maintenance, repair, and replacement actions for the system or system components; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Approve, control, and monitor the use of system maintenance tools; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Prevent the removal of maintenance equipment containing organizational information by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Approve and monitor nonlocal maintenance and diagnostic activities; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Audit [Assignment: organization-defined audit events] for nonlocal maintenance and diagnostic sessions; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Require that nonlocal maintenance and diagnostic services be performed from a system that implements a security capability comparable to the capability implemented on the system being serviced; or 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Protect nonlocal maintenance sessions by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Require the approval of each nonlocal maintenance session by [Assignment: organization-defined personnel or roles]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish a process for maintenance personnel authorization and maintains a list of authorized maintenance organizations or personnel; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Implement procedures for the use of maintenance personnel that lack appropriate security clearances or are not U.S. citizens, that include the following requirements: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Verify that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Mark system media indicating the distribution limitations, handling caveats, and applicable security markings (if any) of the information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Physically control and securely store [Assignment: organization-defined types of digital and/or non-digital media] within [Assignment: organization-defined controlled areas]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Protect and control [Assignment: organization-defined types of system media] during transport outside of controlled areas using [Assignment: organization-defined security safeguards]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Sanitize [Assignment: organization-defined system media] prior to disposal, release out of organizational control, or release for reuse using [Assignment: organization-defined sanitization techniques and procedures]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Facilitate the destruction of personally identifiable information by: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. [Selection: Restrict; Prohibit] the use of [Assignment: organization-defined types of system media] on [Assignment: organization-defined systems or system components] using [Assignment: organization-defined security safeguards]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish [Assignment: organization-defined system media downgrading process] that includes employing downgrading mechanisms with strength and integrity commensurate with the security category or classification of the information; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate guidelines to [Assignment: organization-defined personnel or roles] for the sharing of personally identifiable information externally, only for the authorized purposes identified in the Privacy Act and/or described in its notices, or for a purpose that is compatible with those purposes;  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, approve, and maintain a list of individuals with authorized access to the facility where the system resides; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Enforce physical access authorizations at [Assignment: organization-defined entry and exit points to the facility where the system resides] by; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Monitor physical access to the facility where the system resides to detect and respond to physical security incidents; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Provide the capability of shutting off power to the system or individual system components in emergency situations; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Provide a long-term alternate power supply for the system that is: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ fire suppression devices/systems for the system that provide automatic notification of any activation to [Assignment: organization-defined personnel or roles] and [Assignment: organization-defined emergency responders]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Maintain temperature and humidity levels within the facility where the system resides at [Assignment: organization-defined acceptable levels]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Determine and document the [Assignment: organization-defined alternate work sites] allowed for use by employees; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Plan the location or site of the facility where the system resides considering physical and environmental hazards; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop security and privacy plans for the system that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish and provide to individuals requiring access to the system, the rules that describe their responsibilities and expected behavior for information and system usage, security, and privacy; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop a Concept of Operations (CONOPS) for the system describing how the organization intends to operate the system from the perspective of information security and privacy; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop security and privacy architectures for the system that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Design the security and privacy architectures for the system using a defense-in-depth approach that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and disseminate an organization-wide information security program plan that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Appoint a Senior Agency Information Security Officer with the mission and resources to coordinate, develop, implement, and maintain an organization-wide information security program; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Include the resources needed to implement the information security and privacy programs in capital planning and investment requests and document all exceptions to this requirement; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Implement a process to ensure that plans of action and milestones for the security and privacy programs and associated organizational systems: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develops a comprehensive strategy to manage: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Manage the security and privacy state of organizational systems and the environments in which those systems operate through authorization processes; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Define organizational mission and business processes with consideration for information security and privacy and the resulting risk to organizational operations, organizational assets, individuals, other organizations, and the Nation; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Implement a process for ensuring that organizational plans for conducting security and privacy testing, training, and monitoring activities associated with organizational systems: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Establish and institutionalize contact with selected groups and associations within the security and privacy communities: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish policy and procedures to ensure that the requirements for the protection of Controlled Unclassified Information processed, stored or transmitted on external systems, are implemented in accordance with applicable laws, Executive Orders, directives, policies, regulations, and standards. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and disseminate an organization-wide privacy program plan that provides an overview of the agency''s privacy program, and: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Publish System of Records Notices in the Federal Register, subject to required oversight processes, for systems containing personally identifiable information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Ensure that the public has access to information about organizational privacy activities and can communicate with its Senior Agency Official for Privacy; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and maintain an accounting of disclosures of personally identifiable information held in each system of records under its control, including: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish a written charter for a Data Management Board; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and implement policies and procedures that address the use of personally identifiable information for internal testing, training, and research; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Publish: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Implement a process for receiving and responding to complaints, concerns, or questions from individuals about the organizational privacy practices that includes: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish, maintain, and update [Assignment: organization-defined frequency] an inventory of all programs and systems that create, collect, use, process, store, maintain, disseminate, disclose, or dispose of personally identifiable information; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Develop, disseminate, and update privacy reports to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop a plan for managing supply chain risks associated with the development, acquisition, maintenance, and disposal of systems, system components, and system services; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Identify assumptions affecting risk assessments, risk response, and risk monitoring; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Assign a risk designation to all organizational positions; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Screen individuals prior to authorizing access to the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Verify that individuals accessing a system processing, storing, or transmitting information requiring special protection: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Upon termination of individual employment: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Notify terminated individuals of applicable, legally binding post-employment requirements for the protection of organizational information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Review and confirm ongoing operational need for current logical and physical access authorizations to systems and facilities when individuals are reassigned or transferred to other positions within the organization; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and document access agreements for organizational systems; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Verify that access to classified information requiring special protection is granted only to individuals who: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Notify individuals of applicable, legally binding post-employment requirements for protection of organizational information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish personnel security requirements including security roles and responsibilities for external providers; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Employ a formal sanctions process for individuals failing to comply with established information security policies and procedures; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Categorize the system and information it processes, stores, and transmits; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Conduct a risk assessment, including the likelihood and magnitude of harm, from: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Assess supply chain risks associated with [Assignment: organization-defined systems, system components, and system services]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Scan for vulnerabilities in the system and hosted applications [Assignment: organization-defined frequency and/or randomly in accordance with organization-defined process] and when new vulnerabilities potentially affecting the system are identified and reported; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Conduct privacy impact assessments for systems, programs, or other activities that pose a privacy risk before: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Determine information security and privacy requirements for the system or system service in mission and business process planning; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Manage the system using [Assignment: organization-defined system development life cycle] that incorporates information security and privacy considerations; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Approve, document, and control the use of live data in development, test, and integration environments for the system, system component, or system service; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Include the following requirements, descriptions, and criteria, explicitly or by reference, in the acquisition contract for the system, system component, or system service: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ only government off-the-shelf or commercial off-the-shelf information assurance and information assurance-enabled information technology products that compose an NSA-approved solution to protect classified information when the networks used to transmit the information are at a lower classification level than the information being transmitted; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Limit the use of commercially provided information assurance and information assurance-enabled information technology products to those products that have been successfully evaluated against a National Information Assurance partnership (NIAP)-approved Protection Profile for a specific technology type, if such a profile exists; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Obtain administrator documentation for the system, system component, or system service that describes: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Require that providers of external system services comply with organizational security and privacy requirements and employ [Assignment: organization-defined security and privacy controls]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Conduct an organizational assessment of risk prior to the acquisition or outsourcing of information security services; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service, at all post-design phases of the system development life cycle, to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to perform threat modeling and vulnerability analyses at [Assignment: organization-defined breadth and depth] during development and during the subsequent testing and evaluation of the system, component, or service that:  
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Require an independent agent satisfying [Assignment: organization-defined independence criteria] to verify the correct implementation of the developer security and privacy assessment plans and the evidence produced during testing and evaluation; and
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Employ [Assignment: organization-defined supply chain safeguards] to protect against supply chain risks to the system, system component, or system service and to limit the harm or consequences from supply chain-related events; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Every system and system component has a point of origin and may be changed throughout its existence. Provenance is the chronology of the origin, development, ownership, location, and changes to a system or system component and associated data. It may also include personnel and processes used to interact with or make modifications to the system, component, or associated data. Organizations consider developing procedures for allocating responsibilities for the creation, maintenance, and monitoring of provenance for systems and components; transferring provenance documentation and responsibility between organizations; and preventing and monitoring for unauthorized changes to the provenance records. Organizations consider developing methods to document, monitor, and maintain valid provenance baselines for systems, system components, and related data. Such actions help track, assess, and document changes to the provenance, including changes in supply 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Require the developer of the system, system component, or system service to follow a documented development process that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Define quality metrics at the beginning of the development process; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to produce a design specification and security architecture that: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require the developer of the system, system component, or system service to: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop and implement anti-counterfeit policy and procedures that include the means to detect and prevent counterfeit components from entering the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Organizations determine that certain system components likely cannot be trusted due to specific threats to and vulnerabilities in those components, and for which there are no viable security controls to adequately mitigate the resulting risk. Re-implementation or custom development of such components helps to satisfy requirements for higher assurance. This is accomplished by initiating changes to system components (including hardware, software, and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Require that the developer of [Assignment: organization-defined system, system 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Minimize the number of nonsecurity functions included within the isolation boundary containing 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ [Assignment: organization-defined monitoring tools] to detect indicators of denial of service attacks against the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Monitor and control communications at the external boundary of the system and at key internal boundaries within the system; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Implement a managed interface for each external telecommunication service; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Detect and deny outgoing communications traffic posing a threat to external systems; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Prevent the exfiltration of information; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='For systems that process, store, or transmit personally identifiable information: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Provide a [Selection: physically; logically] isolated trusted communications path for communications between the user and the trusted components of the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Provide a trusted communications path that is irrefutably distinguishable from other communications paths; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Prohibit remote activation of collaborative computing devices and applications with the following exceptions: [Assignment: organization-defined exceptions where remote activation is to be allowed]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Define acceptable and unacceptable mobile code and mobile code technologies; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish usage restrictions and implementation guidelines for Voice over Internet Protocol (VoIP) technologies; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Provide additional data origin authentication and integrity verification artifacts along with the authoritative name resolution data the system returns in response to external name/address resolution queries; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Perform a covert channel analysis to identify those aspects of communications within the system that are potential avenues for covert [Selection (one or more): storage; timing] channels; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='At [Assignment: organization-defined system components]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ hardware-based, write-protect for [Assignment: organization-defined system firmware components]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ polling techniques to identify potential faults, errors, or compromises to [Assignment: organization-defined distributed processing and storage components]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Maintain a separate execution domain for each thread in [Assignment: organization-defined multi-
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='[Selection: Physically or Logically] disable or remove [Assignment: organization-defined 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Prohibit the remote activation of environmental sensing capabilities on organizational systems or system components with the following exceptions: [Assignment: organization-defined exceptions where remote activation of sensors is allowed]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Establish usage restrictions and implementation guidelines for [Assignment: organization-defined system components]; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Develop, document, and disseminate to [Assignment: organization-defined personnel or roles]: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Identify, report, and correct system flaws; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Measure the time between flaw identification and flaw remediation; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Identify and correct flaws related to the collection, usage, processing, or dissemination of personally identifiable information; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Implement [Selection (one or more): signature based; non-signature based] malicious code protection mechanisms at system entry and exit points to detect and eradicate malicious code; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Test malicious code protection mechanisms [Assignment: organization-defined frequency] by introducing a known benign, non-spreading test case into the system; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Employ [Assignment: organization-defined tools and techniques] to analyze the characteristics and behavior of malicious code; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Monitor the system to detect: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Analyze communications traffic and event patterns for the system; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Employ automated mechanisms to monitor: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Receive system security alerts, advisories, and directives from [Assignment: organization-defined external organizations] on an ongoing basis; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Verify the correct operation of [Assignment: organization-defined security and privacy functions]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Organizations select response actions based on types of software, 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Allow execution of binary or machine-executable code only in confined physical or virtual machine environments and with the explicit approval of [Assignment: organization-defined personnel or roles] when such code is: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Prohibit the use of binary or machine-executable code from sources with limited or no warranty and without the provision of source code; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Employ spam protection mechanisms at system entry and exit points to detect and act on unsolicited messages; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='(a) Provide a manual override capability for input validation of [Assignment: organization-defined inputs]; 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Generate error messages that provide information necessary for corrective actions without revealing information that could be exploited; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Determine mean time to failure (MTTF) for [Assignment: organization-defined system components] in specific environments of operation; and 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='If system component failures are detected: 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='a. Upon collection or creation of personally identifiable information, check for the accuracy, relevance, timeliness, impact, completeness, and de-identification of that information across the information life cycle; and 
PRINT(N'Operation applied to 323 rows out of 323')

PRINT(N'Update rows in [dbo].[IRP]')
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the network topology diagram(s) for external connections (DRL 28).

If external connections are not clearly denoted in the network diagram(s) discuss the existence of external connections with management in order to identify if there are any that are unsecured.' WHERE [IRP_ID] = 3
UPDATE [dbo].[IRP] SET [Risk_5_Description]='Wireless corporate network access; all employees have access; substantial number of access points (>1,000
users; >100 access points)' WHERE [IRP_ID] = 4
UPDATE [dbo].[IRP] SET [Risk_3_Description]='Multiple device types used; available to
<10% of employees (staff, executives, managers) and board; e-mail access only', [Risk_4_Description]='Multiple device types used; available to
<25% of authorized employees (staff, executives, managers) and board; e-mail and some applications accessed' WHERE [IRP_ID] = 5
UPDATE [dbo].[IRP] SET [Risk_4_Description]='Significant number of third parties (11–25) and significant number of individuals from third parties (501–1,500) with
access; high level of complexity in terms of how they access systems', [Validation_Approach]='Review the listing of third-party service providers and the number of their employees (DRL 27a).

Discuss with management the complexity (security of the connection) with which third parties access credit union systems.' WHERE [IRP_ID] = 6
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the network diagram(s) to determine if the institution identifies dedicated connections (DRL 28). 

Discuss with management the nature and business need for these connections.   ' WHERE [IRP_ID] = 7
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the inventory of internally developed software, applications, or technologies (DRL 22). 

Discuss with management which are internally hosted, professionally developed, and supporting critical activities.' WHERE [IRP_ID] = 8
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Few applications (6–
30)', [Validation_Approach]='Review the inventory of software and or applications (DRL 22).

Discuss with management which applications are internally hosted, vendor-developed, and supporting critical activities. ' WHERE [IRP_ID] = 9
UPDATE [dbo].[IRP] SET [Risk_3_Description]='101–500
technologies', [Risk_4_Description]='501–2,500
technologies', [Validation_Approach]='Review the inventory of internally developed software, applications, or technologies (DRL22).
 
Discuss with management which applications are internally hosted, user-developed technologies ( non-professionals), and supporting critical activities. ' WHERE [IRP_ID] = 10
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the inventory of credit union owned hardware and software and their end of life dates to determine if any reach that date within 2 years (DRL 22).

If not included above review the network server and operating system list and determine if any of their end of life dates are within 2 years (DRL 22a). 

Discuss with management whether any of these systems that are within 2 years of their end of life date support critical activities. 
' WHERE [IRP_ID] = 11
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the software inventory for open source software (DRL 22).

Discuss with management whether any of these support critical operations. ' WHERE [IRP_ID] = 12
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Few devices (250–
1,500)', [Risk_4_Description]='Significant number of devices (25,001–
50,000)', [Validation_Approach]='Review the hardware inventory to identify the total number of network devices in use at the institution (DRL 22). 

Confirm with management this includes virtual servers not physical servers in their virtualized environment. ' WHERE [IRP_ID] = 13
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the listing of third-party service providers, services they provide, and their risk level (DRL 10).  

Discuss with management which of these store and process information supporting critical activities. ' WHERE [IRP_ID] = 14
UPDATE [dbo].[IRP] SET [Risk_4_Description]='Significant number of cloud providers (8–
10); cloud-provider locations used include international; use of public cloud', [Validation_Approach]='Review the listing of third-party service providers, the service they provide and their risk level (DRL 10). 

Discuss with management which of these  service providers supporting critical activities use private or public cloud platforms and if any of them use international cloud locations. ' WHERE [IRP_ID] = 15
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the credit union''s website, list of third party service providers, list of services running on network servers, and network topology diagrams to determine the nature of delivery channels offered (DRL 10, 22a, 28, 28a),

Discuss with management which of these include retail account origination or management of large value assets. ' WHERE [IRP_ID] = 17
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the credit union online profile IT tab, third party service providers, risk assessment for electronic banking services, software inventory, and network topology diagrams to determine the complexity of mobile banking offerings (DRL 10,18,22).

Discuss with management if these services are provided to corporate clients and if they are originating ACH or accepting wires via mobile devices. ' WHERE [IRP_ID] = 18
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the credit union online profile IT tab, the Sites tab (site functions), and network topology diagrams to determine the level of ATM offerings (DRL28).

Discuss with management if the ATM services are managed internally, reloaded internally, if they provide ATM services to other instiutions, and if they have  international ATMs. ' WHERE [IRP_ID] = 19
UPDATE [dbo].[IRP] SET [Risk_3_Description]='Issue debit or credit cards through a third party; between 10,000–50,000 cards
outstanding', [Risk_4_Description]='Issue debit or credit cards directly; between 50,000–
100,000 cards outstanding', [Validation_Approach]='Review credit union online profile programs & services tab to determine if a debit or credit card program exists.   

Discuss with management the volume of debit or credit cards issued directly or via a third party service provider. ' WHERE [IRP_ID] = 21
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Issue prepaid cards through a third party;
<5,000 cards outstanding', [Risk_3_Description]='Issue prepaid cards through a third party; 5,000–10,000 cards
outstanding', [Risk_4_Description]='Issue prepaid cards through a third party; 10,001–20,000 cards
outstanding', [Validation_Approach]='Review credit union online profile programs & services tab to detemine if a prepaid card program exists.   

Discuss with management the volume of prepaid cards issued directly or via a third party service provider. ' WHERE [IRP_ID] = 22
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Customers allowed to originate payments; used by
<1,000 customers or monthly transaction volume is <50,000', [Risk_3_Description]='Customers allowed to originate payments; used by 1,000–5,000 customers or monthly transaction volume is between 50,000–
100,000', [Risk_4_Description]='Customers allowed to originate payments; used by 5,001–10,000
customers or monthly transaction volume is between 100,001–
1 million' WHERE [IRP_ID] = 24
UPDATE [dbo].[IRP] SET [Risk_5_Description]='Sponsor nested third- party payment processors; originate debits and credits with daily volume that is
>25% of total assets', [Validation_Approach]='Review the credit union online profile IT tab to determine if the credit union originates ACH transactions.  

Discuss with management if they have third party payment senders or nested third party senders. 

Ask management for the daily volume of debits and credits originated.' WHERE [IRP_ID] = 25
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the credit union online profile IT tab to determine if the credit union originates wholesale payments (CHIPS).

Confirm with mangement whether the credit union originates wholesale payments and confirm the volume to total assets. ' WHERE [IRP_ID] = 26
UPDATE [dbo].[IRP] SET [Risk_2_Description]='In person wire requests only; domestic wires only; daily wire volume
<3% of total assets', [Risk_3_Description]='In person, phone, and fax wire requests; domestic daily wire volume 3%–5% of total assets; international daily wire volume
<3% of total assets', [Validation_Approach]='Review the credit union online profile IT tab to determine if the credit union performs domestic and international wires and the various ways they receive wire requests. 
wire transfers.  ' WHERE [IRP_ID] = 27
UPDATE [dbo].[IRP] SET [Risk_2_Description]='<100 merchant clients; daily volume of transactions is
<3% of total assets', [Validation_Approach]='Review credit union online profile IT tab and determine if the credit union offers merchant processing.  

Discuss with management if they offer merchants remote deposit capture and how many clients use it and to provide a list of daily transaction volume. ' WHERE [IRP_ID] = 28
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Gross daily transaction volume is
<3% of total assets', [Validation_Approach]='Review credit union online products & services tab and determine if the credit union offers global (international) remittances.  

Discuss with management the gross daily transaction volume of global remittances. ' WHERE [IRP_ID] = 29
UPDATE [dbo].[IRP] SET [Risk_4_Description]='Services offered include accounts receivable solutions and liquidity management; number of clients is between 10,001–
20,000' WHERE [IRP_ID] = 30
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Trust services are offered through a third-party provider; assets under management total
<$500 million', [Risk_3_Description]='Trust services provided directly; portfolio of assets under management total $500 million–
$999 million', [Risk_4_Description]='Trust services provided directly; assets under management total
$1 billion–$10 billion', [Risk_5_Description]='Trust services provided directly; assets under management total
>$10 billion' WHERE [IRP_ID] = 31
UPDATE [dbo].[IRP] SET [Risk_3_Description]='Act as a merchant acquirer; outsource card payment processing; 1,000–
10,000 merchants', [Risk_4_Description]='Act as a merchant acquirer and card payment processor; 10,001–100,000
merchants', [Risk_5_Description]='Act as a merchant acquirer and card payment processor;
>100,000 merchants', [Validation_Approach]='Review the credit union online profile IT tab to determine whether the credit union provides merchant processing. 

Discus with management the number of merchants for whom they provide this service. ' WHERE [IRP_ID] = 33
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review credit union online profile IT tab, the strategic and/or business plans for IT, list of recent and planned IT projects, and the information security and technology budget to identify potential mergers or acquisitions or divestitures and joint ventures (DRL 4, 4a, 4b).

Discuss with management their intentions regarding mergers, acquisitions, divestitures or joint ventures. ' WHERE [IRP_ID] = 36
UPDATE [dbo].[IRP] SET [Risk_2_Description]='Number of employees totals 50–
2,000', [Risk_5_Description]='Number of employees is
>50,000', [Validation_Approach]='Review the most recent 5300 Call Report, page 7, to determine the number of full and part time employees.  

Discuss with management the total number of employees including information technology and cybersecurity contractors.   ' WHERE [IRP_ID] = 37
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review IT/ IS organizational charts, job descriptions for IT/Is, and succession plans for critical IT staff (DRL 6,6a, 6b).

Confirm with management the amount of turnover of key IT and information security staff. ' WHERE [IRP_ID] = 38
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the list of network and system administrators (DRL 21).

Discuss with management the level turnover of network and system administrators and the use if any of external administrators. ' WHERE [IRP_ID] = 39
UPDATE [dbo].[IRP] SET [Validation_Approach]='Review the list of recent and planned IT projects, and the information security and technology budget, the report to the board on compliance with ISP, the IT steering or other committee minutes.  DRL(4,4a,4b,5,5a)

Discuss with management the frequency and volume of information technology changes.' WHERE [IRP_ID] = 40
UPDATE [dbo].[IRP] SET [Risk_4_Description]='Significant number of attempts monthly (501–100,000); spear
phishing campaigns targeting high net worth customers and employees at the institution or third parties supporting critical activities; Institution specifically is named in threat reports; may ha', [Validation_Approach]='Review the report to the board on the annual compliance with the ISP, the IT steering or other management committee, the incident reports for security events occurring since the last exam (DRL 5,5a,5b).

Discuss with management the number of security events or cyber attacks attempted since the last examination.' WHERE [IRP_ID] = 44
PRINT(N'Operation applied to 33 rows out of 33')

PRINT(N'Add constraints to [dbo].[NEW_QUESTION]')
ALTER TABLE [dbo].[NEW_QUESTION] WITH CHECK CHECK CONSTRAINT [FK_NEW_QUESTION_SETS]
ALTER TABLE [dbo].[NEW_QUESTION] WITH CHECK CHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SAL_LEVEL]
ALTER TABLE [dbo].[NEW_QUESTION] WITH CHECK CHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SUB_CATEGORY_HEADINGS]
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] CHECK CONSTRAINT [FK_Component_Questions_NEW_QUESTION]
ALTER TABLE [dbo].[COMPONENT_STANDARD_QUESTIONS] CHECK CONSTRAINT [FK_STANDARD_COMPONENT_QUESTIONS_NEW_QUESTION]
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] WITH CHECK CHECK CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION]
ALTER TABLE [dbo].[NERC_RISK_RANKING] CHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_QUESTION]
ALTER TABLE [dbo].[NEW_QUESTION_SETS] CHECK CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION]
ALTER TABLE [dbo].[QUESTION_SUB_QUESTION] CHECK CONSTRAINT [FK_QUESTION_SUB_QUESTION_NEW_QUESTION]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] WITH CHECK CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION]
ALTER TABLE [dbo].[ADDRESS] WITH CHECK CHECK CONSTRAINT [FK_ADDRESS_USER_DETAIL_INFORMATION1]
ALTER TABLE [dbo].[UNIVERSAL_SUB_CATEGORY_HEADINGS] WITH CHECK CHECK CONSTRAINT [FK_UNIVERSAL_SUB_CATEGORY_HEADINGS_UNIVERSAL_SUB_CATEGORIES]

PRINT(N'Add constraints to [dbo].[NEW_REQUIREMENT]')
ALTER TABLE [dbo].[NEW_REQUIREMENT] CHECK CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category]
ALTER TABLE [dbo].[NEW_REQUIREMENT] WITH CHECK CHECK CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING]
ALTER TABLE [dbo].[NEW_REQUIREMENT] CHECK CONSTRAINT [FK_NEW_REQUIREMENT_SETS]
ALTER TABLE [dbo].[NEW_REQUIREMENT] CHECK CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY]
ALTER TABLE [dbo].[COMPONENT_STANDARD_QUESTIONS] CHECK CONSTRAINT [FK_STANDARD_COMPONENT_QUESTIONS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] WITH CHECK CHECK CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[NERC_RISK_RANKING] CHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT]
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] CHECK CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] CHECK CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] WITH CHECK CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] CHECK CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_SETS] CHECK CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] CHECK CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT]

PRINT(N'Add constraints to [dbo].[IRP]')
ALTER TABLE [dbo].[IRP] WITH CHECK CHECK CONSTRAINT [FK_IRP_IRP_HEADER]
ALTER TABLE [dbo].[ASSESSMENT_IRP] WITH CHECK CHECK CONSTRAINT [FK__Assessmen__IRP_I__5EDF0F2E]
COMMIT TRANSACTION
GO
BEGIN TRANSACTION
PRINT(N'Update 1 row in [dbo].[CSET_VERSION]')
UPDATE [dbo].[CSET_VERSION] SET [Version_Id]=9.0100, [Cset_Version]='9.0.1' WHERE [Id] = 1
COMMIT TRANSACTION
GO