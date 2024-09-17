using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SEMASGN.Client.MinReq
{
    public partial class spm_req : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
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
                        ddlCourse.Items.Add(new System.Web.UI.WebControls.ListItem(reader["name"].ToString(), reader["id"].ToString()));
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

        protected void btnCheck_Click(object sender, EventArgs e)
        {
            if (IsValidInput())
            {
                string selectedCourseID = ddlCourse.SelectedValue;
                string subject1 = txtSubject1.Text;
                string grade1 = txtGrade1.Text;
                string subject2 = txtSubject2.Text;
                string grade2 = txtGrade2.Text;
                string subject3 = txtSubject3.Text;
                string grade3 = txtGrade3.Text;

                ProgrammeModel programme = GetProgrammeRequirements(selectedCourseID);

                bool isEligible = CheckRequirements(programme, subject1, grade1, subject2, grade2, subject3, grade3);

                if (isEligible)
                {
                    lblResult.Text = "Congratulations! You meet the minimum requirements.";
                    lblResult.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblResult.Text = "Sorry, you do not meet the minimum requirements.";
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

        private bool CheckRequirements(ProgrammeModel programme, string subject1, string grade1, string subject2, string grade2, string subject3, string grade3)
        {
            if (programme != null)
            {
                if (programme.LocalMinReq.Contains("STPM") && (grade1 == "C" || grade2 == "C" || grade3 == "C"))
                {
                    return true;
                }
                if (programme.LocalMinReq.Contains("UEC") && (grade1 == "B" || grade2 == "B" || grade3 == "B"))
                {
                    return true;
                }
                if (programme.LocalMinReq.Contains("CGPA") && float.TryParse(grade1, out float cgpa) && cgpa >= 2.5)
                {
                    return true;
                }
            }
            return false;
        }

        private bool IsValidInput()
        {
            if (string.IsNullOrWhiteSpace(txtSubject1.Text) || string.IsNullOrWhiteSpace(txtGrade1.Text))
            {
                lblResult.Text = "Please fill out Subject 1 and Grade 1.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtSubject2.Text) || string.IsNullOrWhiteSpace(txtGrade2.Text))
            {
                lblResult.Text = "Please fill out Subject 2 and Grade 2.";
                return false;
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
