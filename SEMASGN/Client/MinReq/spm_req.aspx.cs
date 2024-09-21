using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SEMASGN.Client.MinReq
{
    public partial class spm_req : System.Web.UI.Page
    {
        private const int MaxSubjects = 12;
        private const string SubjectViewStateKey = "SubjectCount";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
                ViewState[SubjectViewStateKey] = 2;
                AddSubjectFields(2, "");
                subjectSection.Visible = false;
                cgpaSection.Visible = false;
                mqfSection.Visible = false;
                requirementTypeSection.Visible = false;
            }
            else
            {
                int subjectCount = (int)ViewState[SubjectViewStateKey];
                string qualificationType = ddlRequirementType.SelectedValue ?? "";
                AddSubjectFields(subjectCount, qualificationType);
            }
        }

        //get the programme name in database based on "name"
        private void LoadCourses()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = "SELECT id, name FROM Programme";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    ddlCourse.Items.Clear();
                    ddlCourse.Items.Add(new ListItem("Select a Programme", ""));
                    while (reader.Read())
                    {
                        ddlCourse.Items.Add(new ListItem(reader["name"].ToString(), reader["id"].ToString()));
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblResult.Text = "Error loading courses.";
                }
            }
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCourse = ddlCourse.SelectedItem.Text;
            string programType = "";

            if (selectedCourse.IndexOf("Bachelor", StringComparison.OrdinalIgnoreCase) >= 0
                || selectedCourse.IndexOf("Degree", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                programType = "Degree";
            }
            else if (selectedCourse.IndexOf("Foundation", StringComparison.OrdinalIgnoreCase) >= 0
                     || selectedCourse.IndexOf("Diploma", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                programType = "FoundationOrDiploma";
            }
            else if (selectedCourse.IndexOf("Master", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                programType = "Master";
            }
            else if (selectedCourse.IndexOf("Doctor of Philosophy", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                programType = "PhD";
            }
            else
            {
                programType = "Other";
            }

            switch (programType)
            {
                case "Degree":
                    requirementTypeSection.Visible = true;
                    subjectSection.Visible = false; 
                    cgpaSection.Visible = false;
                    mqfSection.Visible = false;

                    //ddlRequirementType for Degree
                    ddlRequirementType.Items.Clear();
                    ddlRequirementType.Items.Add(new ListItem("Select Qualification Type", ""));
                    ddlRequirementType.Items.Add(new ListItem("STPM", "STPM"));
                    ddlRequirementType.Items.Add(new ListItem("A Level", "ALevel"));
                    ddlRequirementType.Items.Add(new ListItem("UEC", "UEC"));
                    ddlRequirementType.Items.Add(new ListItem("Other IHL", "OtherIHL"));
                    ddlRequirementType.Items.Add(new ListItem("TARUMT/TAR UC", "TARUMT"));
                    break;

                case "FoundationOrDiploma":
                    requirementTypeSection.Visible = true;
                    subjectSection.Visible = false;
                    cgpaSection.Visible = false;
                    mqfSection.Visible = false;

                    //ddlRequirementType for Foundation/Diploma
                    ddlRequirementType.Items.Clear();
                    ddlRequirementType.Items.Add(new ListItem("Select Qualification Type", ""));
                    ddlRequirementType.Items.Add(new ListItem("SPM", "SPM"));
                    ddlRequirementType.Items.Add(new ListItem("O Level", "OLevel"));
                    ddlRequirementType.Items.Add(new ListItem("UEC", "UEC"));
                    break;

                case "Master":
                    requirementTypeSection.Visible = false;
                    subjectSection.Visible = false;
                    cgpaSection.Visible = true;
                    mqfSection.Visible = true;
                    break;

                case "PhD":
                    requirementTypeSection.Visible = false;
                    subjectSection.Visible = false;
                    cgpaSection.Visible = false;
                    mqfSection.Visible = true;
                    break;

                default:
                    requirementTypeSection.Visible = false;
                    subjectSection.Visible = false;
                    cgpaSection.Visible = false;
                    mqfSection.Visible = false;
                    break;
            }
        }
        protected void ddlRequirementType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedType = ddlRequirementType.SelectedValue;

            switch (selectedType)
            {
                case "OtherIHL":
                case "TARUMT":
                    subjectSection.Visible = false;
                    cgpaSection.Visible = true;
                    mqfSection.Visible = false;
                    break;

                default:
                    subjectSection.Visible = true;
                    cgpaSection.Visible = false;
                    mqfSection.Visible = false;
                    break;
            }

            // Update the subject fields accordingly
            int subjectCount = (int)ViewState[SubjectViewStateKey];
            AddSubjectFields(subjectCount, selectedType);
        }


        private void AddSubjectFields(int subjectCount, string qualificationType)
        {
            subjectPlaceHolder.Controls.Clear();

            for (int i = 1; i <= subjectCount; i++)
            {
                Label lblSubject = new Label { Text = $"Subject {i}:", ID = $"lblSubject{i}" };
                TextBox txtSubject = new TextBox { ID = $"txtSubject{i}", CssClass = "subject-input", Width = Unit.Percentage(60) };

                Label lblGrade = new Label { Text = $"Grade {i}:", ID = $"lblGrade{i}" };
                DropDownList ddlGrade = new DropDownList { ID = $"ddlGrade{i}", CssClass = "grade-input" };
                ddlGrade.Items.Add(new ListItem("Select Grade", ""));

                switch (qualificationType)
                {
                    case "STPM":
                        ddlGrade.Items.Add(new ListItem("A", "A"));
                        ddlGrade.Items.Add(new ListItem("A-", "A-"));
                        ddlGrade.Items.Add(new ListItem("B+", "B+"));
                        ddlGrade.Items.Add(new ListItem("B", "B"));
                        ddlGrade.Items.Add(new ListItem("B-", "B-"));
                        ddlGrade.Items.Add(new ListItem("C+", "C+"));
                        ddlGrade.Items.Add(new ListItem("C", "C"));
                        ddlGrade.Items.Add(new ListItem("D+", "D+"));
                        ddlGrade.Items.Add(new ListItem("D", "D"));
                        ddlGrade.Items.Add(new ListItem("E", "E"));
                        ddlGrade.Items.Add(new ListItem("F", "F"));
                        break;
                    case "ALevel":
                        ddlGrade.Items.Add(new ListItem("A*", "A*"));
                        ddlGrade.Items.Add(new ListItem("A", "A"));
                        ddlGrade.Items.Add(new ListItem("B", "B"));
                        ddlGrade.Items.Add(new ListItem("C", "C"));
                        ddlGrade.Items.Add(new ListItem("D", "D"));
                        ddlGrade.Items.Add(new ListItem("E", "E"));
                        ddlGrade.Items.Add(new ListItem("U", "U"));
                        break;
                    case "UEC":
                        ddlGrade.Items.Add(new ListItem("A1", "A1"));
                        ddlGrade.Items.Add(new ListItem("A2", "A2"));
                        ddlGrade.Items.Add(new ListItem("B3", "B3"));
                        ddlGrade.Items.Add(new ListItem("B4", "B4"));
                        ddlGrade.Items.Add(new ListItem("B5", "B5"));
                        ddlGrade.Items.Add(new ListItem("B6", "B6"));
                        ddlGrade.Items.Add(new ListItem("C7", "C7"));
                        ddlGrade.Items.Add(new ListItem("C8", "C8"));
                        ddlGrade.Items.Add(new ListItem("F9", "F9"));
                        break;
                    case "SPM":
                        ddlGrade.Items.Add(new ListItem("A+", "A+"));
                        ddlGrade.Items.Add(new ListItem("A", "A"));
                        ddlGrade.Items.Add(new ListItem("A-", "A-"));
                        ddlGrade.Items.Add(new ListItem("B+", "B+"));
                        ddlGrade.Items.Add(new ListItem("B", "B"));
                        ddlGrade.Items.Add(new ListItem("C+", "C+"));
                        ddlGrade.Items.Add(new ListItem("C", "C"));
                        ddlGrade.Items.Add(new ListItem("D", "D"));
                        ddlGrade.Items.Add(new ListItem("E", "E"));
                        ddlGrade.Items.Add(new ListItem("G", "G"));
                        break;
                    case "OLevel":
                        ddlGrade.Items.Add(new ListItem("A*", "A*"));
                        ddlGrade.Items.Add(new ListItem("A", "A"));
                        ddlGrade.Items.Add(new ListItem("B", "B"));
                        ddlGrade.Items.Add(new ListItem("C", "C"));
                        ddlGrade.Items.Add(new ListItem("D", "D"));
                        ddlGrade.Items.Add(new ListItem("E", "E"));
                        ddlGrade.Items.Add(new ListItem("F", "F"));
                        ddlGrade.Items.Add(new ListItem("G", "G"));
                        ddlGrade.Items.Add(new ListItem("U", "U"));
                        break;
                    default:
                        ddlGrade.Items.Add(new ListItem("A", "A"));
                        ddlGrade.Items.Add(new ListItem("B", "B"));
                        ddlGrade.Items.Add(new ListItem("C", "C"));
                        ddlGrade.Items.Add(new ListItem("D", "D"));
                        ddlGrade.Items.Add(new ListItem("E", "E"));
                        ddlGrade.Items.Add(new ListItem("F", "F"));
                        ddlGrade.Items.Add(new ListItem("G", "G"));
                        break;
                }

                subjectPlaceHolder.Controls.Add(lblSubject);
                subjectPlaceHolder.Controls.Add(txtSubject);
                subjectPlaceHolder.Controls.Add(new Literal { Text = "<br />" });
                subjectPlaceHolder.Controls.Add(lblGrade);
                subjectPlaceHolder.Controls.Add(ddlGrade);
                subjectPlaceHolder.Controls.Add(new Literal { Text = "<br /><br />" });
            }
        }

        protected void btnAddSubject_Click(object sender, EventArgs e)
        {
            int subjectCount = (int)ViewState[SubjectViewStateKey];

            if (subjectCount < MaxSubjects)
            {
                subjectCount++;
                ViewState[SubjectViewStateKey] = subjectCount;
                string qualificationType = ddlRequirementType.SelectedValue ?? "";
                AddSubjectFields(subjectCount, qualificationType);
            }
            else
            {
                lblResult.Text = "You can add up to 12 subjects only.";
            }
        }

        protected void btnRemoveSubject_Click(object sender, EventArgs e)
        {
            int subjectCount = (int)ViewState[SubjectViewStateKey];

            if (subjectCount > 2)
            {
                subjectCount--;
                ViewState[SubjectViewStateKey] = subjectCount;
                string qualificationType = ddlRequirementType.SelectedValue ?? "";
                AddSubjectFields(subjectCount, qualificationType);
            }
            else
            {
                lblResult.Text = "You must have at least 2 subjects.";
            }
        }

        protected void btnCheck_Click(object sender, EventArgs e)
        {
            lblResult.Text = "";
            if (ddlCourse.SelectedValue == "")
            {
                lblResult.Text = "Please select a programme.";
                return;
            }

            string selectedCourseID = ddlCourse.SelectedValue;
            string selectedCourseName = ddlCourse.SelectedItem.Text;

            bool isEligible = false;

            bool isFoundationOrDiploma = selectedCourseName.IndexOf("Foundation", StringComparison.OrdinalIgnoreCase) >= 0
                                         || selectedCourseName.IndexOf("Diploma", StringComparison.OrdinalIgnoreCase) >= 0;

            bool isDegree = selectedCourseName.IndexOf("Bachelor", StringComparison.OrdinalIgnoreCase) >= 0
                            || selectedCourseName.IndexOf("Degree", StringComparison.OrdinalIgnoreCase) >= 0;

            bool isMaster = selectedCourseName.IndexOf("Master", StringComparison.OrdinalIgnoreCase) >= 0;
            bool isPhD = selectedCourseName.IndexOf("Doctor of Philosophy", StringComparison.OrdinalIgnoreCase) >= 0;

            if (isMaster)
            {
                // Master's programme
                if (!decimal.TryParse(txtCGPA.Text, out decimal userCGPA))
                {
                    lblResult.Text = "Please enter a valid CGPA.";
                    return;
                }

                if (ddlMQFLevel.SelectedValue == "")
                {
                    lblResult.Text = "Please select your MQF Level.";
                    return;
                }

                int userMQFLevel = int.Parse(ddlMQFLevel.SelectedValue);
                isEligible = CheckMasterRequirements(userCGPA, userMQFLevel);
            }
            else if (isPhD)
            {
                // PhD programme
                if (ddlMQFLevel.SelectedValue == "")
                {
                    lblResult.Text = "Please select your MQF Level.";
                    return;
                }

                int userMQFLevel = int.Parse(ddlMQFLevel.SelectedValue);
                isEligible = CheckPhDRequirements(userMQFLevel);
            }
            else if (isDegree)
            {
                // Bachelor's Degree programmes
                if (ddlRequirementType.SelectedValue == "")
                {
                    lblResult.Text = "Please select your qualification type.";
                    return;
                }

                string requirementType = ddlRequirementType.SelectedValue;

                if (requirementType == "OtherIHL" || requirementType == "TARUMT")
                {
                    if (decimal.TryParse(txtCGPA.Text, out decimal userCGPA))
                    {
                        isEligible = CheckCGPARequirements(userCGPA, requirementType);
                    }
                    else
                    {
                        lblResult.Text = "Please enter a valid CGPA.";
                        return;
                    }
                }
                else
                {
                    if (IsValidInput())
                    {
                        var subjectsAndGrades = GetSubjectsAndGrades();
                        isEligible = CheckSubjectRequirements(subjectsAndGrades, requirementType);

                        // Check for additional Mathematics and English requirements
                        bool mathAndEnglishEligible = CheckMathAndEnglishRequirements(subjectsAndGrades, requirementType);
                        isEligible = isEligible && mathAndEnglishEligible;
                    }
                    else
                    {
                        return;
                    }
                }
            }
            else if (isFoundationOrDiploma)
            {
                // Foundation/Diploma programmes
                if (ddlRequirementType.SelectedValue == "")
                {
                    lblResult.Text = "Please select your qualification type.";
                    return;
                }

                string requirementType = ddlRequirementType.SelectedValue;

                if (IsValidInput())
                {
                    var subjectsAndGrades = GetSubjectsAndGrades();
                    isEligible = CheckSubjectRequirements(subjectsAndGrades, requirementType);

                    // Check for additional Mathematics and English requirements
                    bool mathAndEnglishEligible = CheckMathAndEnglishRequirements(subjectsAndGrades, requirementType);
                    isEligible = isEligible && mathAndEnglishEligible;
                }
                else
                {
                    return;
                }
            }
            else
            {
                lblResult.Text = "Invalid programme selection.";
                return;
            }

            lblResult.Text = isEligible
                ? "Congratulations! You meet the minimum requirements."
                : "Sorry, you do not meet the minimum requirements.";
            lblResult.ForeColor = isEligible ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }

        private bool CheckMasterRequirements(decimal userCGPA, int userMQFLevel)
        {
            decimal minCGPA = 2.75m;
            int requiredMQFLevel = 6;

            return userCGPA >= minCGPA && userMQFLevel >= requiredMQFLevel;
        }

        private bool CheckPhDRequirements(int userMQFLevel)
        {
            int requiredMQFLevel = 7;

            return userMQFLevel >= requiredMQFLevel;
        }

        private bool CheckSubjectRequirements((string Subject, string Grade)[] subjectsAndGrades, string requirementType)
        {
            switch (requirementType)
            {
                case "STPM":
                    return CheckSTPMRequirements(subjectsAndGrades);
                case "ALevel":
                    return CheckALevelRequirements(subjectsAndGrades);
                case "UEC":
                    return CheckUECRequirements(subjectsAndGrades);
                case "SPM":
                    return CheckSPMRequirements(subjectsAndGrades);
                case "OLevel":
                    return CheckOLevelRequirements(subjectsAndGrades);
                default:
                    lblResult.Text = "Invalid requirement type.";
                    return false;
            }
        }

        private bool CheckSTPMRequirements((string Subject, string Grade)[] subjectsAndGrades)
        {
            int requiredCount = 2;
            string[] validGrades = { "A", "A-", "B+", "B", "B-", "C+", "C" };

            int count = 0;
            foreach (var (_, grade) in subjectsAndGrades)
            {
                if (Array.Exists(validGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                {
                    count++;
                    if (count >= requiredCount) return true;
                }
            }
            return false;
        }

        private bool CheckUECRequirements((string Subject, string Grade)[] subjectsAndGrades)
        {
            int requiredCount = 5;
            string[] validGrades = { "A1", "A2", "B3", "B4", "B5", "B6" }; 

            int count = 0;
            foreach (var (_, grade) in subjectsAndGrades)
            {
                if (Array.Exists(validGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                {
                    count++;
                    if (count >= requiredCount) return true;
                }
            }
            return false;
        }

        private bool CheckALevelRequirements((string Subject, string Grade)[] subjectsAndGrades)
        {
            int requiredCount = 2;
            string[] validGrades = { "A*", "A", "B", "C", "D" };

            int count = 0;
            foreach (var (_, grade) in subjectsAndGrades)
            {
                if (Array.Exists(validGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                {
                    count++;
                    if (count >= requiredCount) return true;
                }
            }
            return false;
        }

        private bool CheckSPMRequirements((string Subject, string Grade)[] subjectsAndGrades)
        {
            int requiredCount = 5;
            string[] validGrades = { "A+", "A", "A-", "B+", "B", "C+", "C" }; // Credit is C and above

            int count = 0;
            foreach (var (_, grade) in subjectsAndGrades)
            {
                if (Array.Exists(validGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                {
                    count++;
                    if (count >= requiredCount) break;
                }
            }
            return count >= requiredCount;
        }

        private bool CheckOLevelRequirements((string Subject, string Grade)[] subjectsAndGrades)
        {
            int requiredCount = 5;
            string[] validGrades = { "A*", "A", "B", "C" };

            int count = 0;
            foreach (var (_, grade) in subjectsAndGrades)
            {
                if (Array.Exists(validGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                {
                    count++;
                    if (count >= requiredCount) break;
                }
            }
            return count >= requiredCount;
        }

        private bool CheckCGPARequirements(decimal userCGPA, string requirementType)
        {
            decimal minCGPA = 2.50m; 

            return userCGPA >= minCGPA;
        }

        private bool CheckMathAndEnglishRequirements((string Subject, string Grade)[] subjectsAndGrades, string requirementType)
        {
            bool isMathEligible = false;
            bool isEnglishEligible = false;

            string[] validMathGrades;
            string[] validEnglishGrades = { "A+", "A", "A-", "B+", "B", "C+", "C", "D", "E" }; 

            switch (requirementType)
            {
                case "STPM":
                case "ALevel":
                case "UEC":
                case "OtherIHL":
                    // Bachelor's degree requirements
                    validMathGrades = new string[] { "A+", "A", "A-", "B+", "B", "C+", "C" }; 
                    break;
                case "SPM":
                case "OLevel":
                case " UEC":
                    // Foundation/Diploma requirements
                    validMathGrades = new string[] { "A+", "A", "A-", "B+", "B", "C+", "C" }; 
                    break;
                default:
                    validMathGrades = new string[] { "A", "B", "C", "D", "E" }; 
                    break;
            }

            // Identify math subjects and English subject
            foreach (var (subject, grade) in subjectsAndGrades)
            {
                if (subject.IndexOf("Mathematics", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    if (Array.Exists(validMathGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                    {
                        isMathEligible = true;
                    }
                }
                if (subject.IndexOf("English", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    if (Array.Exists(validEnglishGrades, g => g.Equals(grade, StringComparison.OrdinalIgnoreCase)))
                    {
                        isEnglishEligible = true;
                    }
                }
            }

            return isMathEligible && isEnglishEligible;
        }

        private (string Subject, string Grade)[] GetSubjectsAndGrades()
        {
            int subjectCount = (int)ViewState[SubjectViewStateKey];
            var subjectsAndGrades = new List<(string Subject, string Grade)>();

            for (int i = 1; i <= subjectCount; i++)
            {
                TextBox txtSubject = (TextBox)subjectPlaceHolder.FindControl($"txtSubject{i}");
                DropDownList ddlGrade = (DropDownList)subjectPlaceHolder.FindControl($"ddlGrade{i}");

                if (txtSubject != null && ddlGrade != null)
                {
                    subjectsAndGrades.Add((txtSubject.Text.Trim(), ddlGrade.SelectedValue.Trim().ToUpper()));
                }
            }

            return subjectsAndGrades.ToArray();
        }

        private bool IsValidInput()
        {
            int subjectCount = (int)ViewState[SubjectViewStateKey];

            for (int i = 1; i <= subjectCount; i++)
            {
                TextBox txtSubject = (TextBox)subjectPlaceHolder.FindControl($"txtSubject{i}");
                DropDownList ddlGrade = (DropDownList)subjectPlaceHolder.FindControl($"ddlGrade{i}");

                if (txtSubject == null || ddlGrade == null ||
                    string.IsNullOrWhiteSpace(txtSubject.Text) || ddlGrade.SelectedValue == "")
                {
                    lblResult.Text = $"Please fill out Subject {i} and select Grade {i}.";
                    return false;
                }
            }

            return true;
        }

        public class ProgrammeModel
        {
            public string Id { get; set; }
            public string Name { get; set; }
        }
    }
}
