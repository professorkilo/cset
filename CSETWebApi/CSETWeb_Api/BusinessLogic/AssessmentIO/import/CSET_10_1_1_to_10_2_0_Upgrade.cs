﻿//////////////////////////////// 
// 
//   Copyright 2021 Battelle Energy Alliance, LLC  
// 
// 
//////////////////////////////// 
using System;
using System.Linq;
using CSETWeb_Api.BusinessLogic.ImportAssessment;
using Newtonsoft.Json.Linq;

namespace CSETWeb_Api.BusinessLogic.AssessmentIO.import
{
    internal class CSET_10_1_1_to_10_2_0_Upgrade : ICSETJSONFileUpgrade
    {
        /// <summary>
        /// this is the string we will be upgrading to
        /// </summary>
        static string versionString = "10.2.0";

        /// <summary>
        /// 
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public string ExecuteUpgrade(string json)
        {
            JObject oAssessment = JObject.Parse(json);


            bool isOldAcet = DetermineIfOldAcet(oAssessment);


            // Populate Question_Type on the ANSWER records
            foreach (var answer in oAssessment.SelectTokens("$.jANSWER").Children())
            {
                // create and populate the Question_Type column
                var qType = "Question";

                if (answer["Is_Requirement"].Value<bool>())
                {
                    qType = "Requirement";
                }
                if (answer["Is_Component"].Value<bool>())
                {
                    qType = "Component";
                }
                if (answer["Is_Framework"].Value<bool>())
                {
                    qType = "Framework";
                }

                answer["Question_Type"] = qType;



                // ACET requirement and question IDs get translated 
                // to their corresponding maturity question IDs
                if (isOldAcet)
                {
                    bool isReq = answer["Is_Requirement"].Value<bool>();

                    if (isReq)
                    {
                        int reqID = answer["Question_Or_Requirement_Id"].Value<int>();

                        if (ImportManagerACET.RequirementToMaturity.Keys.Contains(reqID))
                        {
                            int maturityQuestionID = ImportManagerACET.RequirementToMaturity[reqID];

                            answer["Question_Or_Requirement_Id"] = maturityQuestionID;
                            answer["Question_Type"] = "Maturity";
                        }
                    }
                    else
                    {
                        // The ACET assessment was in questions mode
                        int qID = answer["Question_Or_Requirement_Id"].Value<int>();

                        if (ImportManagerACET.QuestionToMaturity.Keys.Contains(qID))
                        {
                            int maturityQuestionID = ImportManagerACET.QuestionToMaturity[qID];

                            answer["Question_Or_Requirement_Id"] = maturityQuestionID;
                            answer["Question_Type"] = "Maturity";
                        }
                    }

                }
            }


            // set the features for the assessment based on what we know
            var jA = oAssessment.SelectTokens("$.jASSESSMENTS").Children().First();

            int assessmentId = jA["Assessment_Id"].Value<int>();

            jA["UseStandard"] = false;
            jA["UseMaturity"] = false;
            jA["UseDiagram"] = false;

            if (isOldAcet)
            {
                jA["UseMaturity"] = true;

                var j = new JObject();
                j["Assessment_Id"] = assessmentId;
                j["Selected"] = true;
                j["model_id"] = 1;  // hard coded to the ACET model ID for now

                var amm = new JArray(j);

                oAssessment.Add("jAVAILABLE_MATURITY_MODELS", amm);


                // Remove the deprecated ACET "standards" object from the JSON
                var oldAcetStandardRecord = oAssessment.SelectToken("$.jAVAILABLE_STANDARDS[*]")
               .Where(x => x["Set_Name"].Value<string>() == "ACET_V1" && x["Selected"].Value<Boolean>());
                ((JObject)oldAcetStandardRecord).Remove();
            }


            // if other standards are selected, set the "Standards" feature
            var jOtherStandards = oAssessment.SelectToken("$.jAVAILABLE_STANDARDS")
                .Where(x => x["Set_Name"].Value<string>() != "ACET_V1" && x["Selected"].Value<bool>()).Any();
            if (jOtherStandards)
            {
                jA["UseStandard"] = true;
            }

            // Set "Diagram" feature
            var jDiagramComponents = oAssessment.SelectTokens("$.jASSESSMENT_DIAGRAM_COMPONENTS[*]").Any();
            if (jDiagramComponents)
            {
                jA["UseDiagram"] = true;
            }



            // Older exports might have NIST_SAL_QUESTION_ANSWERS from other assessments.  
            // Clean that up now to avoid dupe key errors.
            var nistSalAnswers = oAssessment.SelectTokens("jNIST_SAL_QUESTION_ANSWERS[*]").ToList();
            foreach (var ans in nistSalAnswers)
            {
                if (ans["Assessment_Id"].Value<int>() != assessmentId)
                {
                    ((JObject)ans).Remove();
                }
            }

            return oAssessment.ToString();
        }


        /// <summary>
        /// Determines if the import is from an older (pre 10.2) version
        /// and if it used the old pseudo-standard "ACET_V1".
        /// </summary>
        /// <returns></returns>
        private bool DetermineIfOldAcet(JObject oAssessment)
        {
            var v = oAssessment.SelectTokens("$.jCSET_VERSION[*].Version_Id").FirstOrDefault().Value<string>();
            var version = System.Version.Parse(v);

            var usesAcetStandard = oAssessment.SelectTokens("$.jAVAILABLE_STANDARDS[*]")
                .Where(x => x["Set_Name"].Value<string>() == "ACET_V1" && x["Selected"].Value<Boolean>()).Any();

            if (version < System.Version.Parse("10.2") && usesAcetStandard)
            {
                return true;
            }

            return false;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public System.Version GetVersion()
        {
            return System.Version.Parse(versionString);
        }
    }
}