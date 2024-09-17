using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SEMASGN.Client.MinReq
{
    public partial class spm_req : System.Web.UI.Page
    {
        private const int MaxSubjects = 12; // Maximum number of subjects allowed
        private const string SubjectViewStateKey = "SubjectCount";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
                ViewState[SubjectViewStateKey] = 2; 
                AddSubjectFields(2); 
            }
            else
            {
                int subjectCount = (int)ViewState[SubjectViewStateKey];
                AddSubjectFields(subjectCount);
            }
        }

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
                    while (reader.Read())
                    {
                        ddlCourse.Items.Add(new ListItem(reader["name"].ToString(), reader["id"].ToString()));
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCourse = ddlCourse.SelectedItem.Text;

            if (selectedCourse.Contains("Foundation") || selectedCourse.Contains("Diploma") || selectedCourse.Contains("Bachelor") || selectedCourse.Contains("Degree"))
            {
                subjectSection.Visible = true;
            }
            else if (selectedCourse.Contains("Master") || selectedCourse.Contains("Phd"))
            {
                subjectSection.Visible = false;
            }
        }

        private void AddSubjectFields(int subjectCount)
        {
            subjectPlaceHolder.Controls.Clear();

            for (int i = 1; i <= subjectCount; i++)
            {
                Label lblSubject = new Label { Text = $"Subject {i}:", ID = $"lblSubject{i}" };
                TextBox txtSubject = new TextBox { ID = $"txtSubject{i}", CssClass = "subject-input", Width = Unit.Percentage(60) };

                Label lblGrade = new Label { Text = $"Grade {i}:", ID = $"lblGrade{i}" };
                TextBox txtGrade = new TextBox { ID = $"txtGrade{i}", CssClass = "grade-input", Width = Unit.Pixel(50) };

                subjectPlaceHolder.Controls.Add(lblSubject);
                subjectPlaceHolder.Controls.Add(txtSubject);
                subjectPlaceHolder.Controls.Add(new Literal { Text = "<br />" });
                subjectPlaceHolder.Controls.Add(lblGrade);
                subjectPlaceHolder.Controls.Add(txtGrade);
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
                AddSubjectFields(subjectCount);
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
                AddSubjectFields(subjectCount);
            }
            else
            {
                lblResult.Text = "You must have at least 2 subjects.";
            }
        }

        protected void btnCheck_Click(object sender, EventArgs e)
        {
            if (IsValidInput())
            {
                string selectedCourseID = ddlCourse.SelectedValue;

                int subjectCount = (int)ViewState[SubjectViewStateKey];
                var subjectsAndGrades = new (string Subject, string Grade)[subjectCount];

                for (int i = 1; i <= subjectCount; i++)
                {
                    TextBox txtSubject = (TextBox)subjectPlaceHolder.FindControl($"txtSubject{i}");
                    TextBox txtGrade = (TextBox)subjectPlaceHolder.FindControl($"txtGrade{i}");

                    if (txtSubject != null && txtGrade != null)
                    {
                        subjectsAndGrades[i - 1] = (txtSubject.Text, txtGrade.Text);
                    }
                }

                ProgrammeModel programme = GetProgrammeRequirements(selectedCourseID);
                bool isEligible = CheckRequirements(programme, subjectsAndGrades);

                if (isEligible)
                {
                    lblResult.Text = "Congratulations! You meet the minimum requirements.";
                    lblResult.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblResult.Text = "Sorry, you do not meet the minimum requirements.";
                    lblResult.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private ProgrammeModel GetProgrammeRequirements(string courseID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = "SELECT id, name, localMinReq, internationalMinReq FROM Programme WHERE id = @id";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", courseID);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        ProgrammeModel programme = new ProgrammeModel
                        {
                            Id = reader["id"].ToString(),
                            Name = reader["name"].ToString(),
                            LocalMinReq = reader["localMinReq"].ToString(),
                            InternationalMinReq = reader["internationalMinReq"].ToString()
                        };
                        reader.Close();
                        return programme;
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
            return null;
        }

        private bool CheckRequirements(ProgrammeModel programme, params (string Subject, string Grade)[] subjectsAndGrades)
        {
            if (programme != null)
            {
                foreach (var (subject, grade) in subjectsAndGrades)
                {
                    if (programme.LocalMinReq.Contains("STPM") && (grade == "C" || grade == "B" || grade == "A"))
                    {
                        return true;
                    }
                    if (programme.LocalMinReq.Contains("UEC") && (grade == "B" || grade == "A"))
                    {
                        return true;
                    }
                    if (programme.LocalMinReq.Contains("CGPA") && float.TryParse(grade, out float cgpa) && cgpa >= 2.5)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        private bool IsValidInput()
        {
            int subjectCount = (int)ViewState[SubjectViewStateKey];

            for (int i = 1; i <= subjectCount; i++)
            {
                TextBox txtSubject = (TextBox)subjectPlaceHolder.FindControl($"txtSubject{i}");
                TextBox txtGrade = (TextBox)subjectPlaceHolder.FindControl($"txtGrade{i}");

                if (txtSubject == null || txtGrade == null ||
                    string.IsNullOrWhiteSpace(txtSubject.Text) || string.IsNullOrWhiteSpace(txtGrade.Text))
                {
                    lblResult.Text = $"Please fill out Subject {i} and Grade {i}.";
                    return false;
                }
            }

            return true;
        }

        public class ProgrammeModel
        {
            public string Id { get; set; }
            public string Name { get; set; }
            public string LocalMinReq { get; set; }
            public string InternationalMinReq { get; set; }
        }
    }
}
