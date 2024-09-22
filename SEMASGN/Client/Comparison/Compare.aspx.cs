using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEMASGN.Client.Comparison
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load the dropdown lists with programme data on first load.
                LoadProgrammes();
            }

        }


        protected void ddlProgramme1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string programmeId = ddlProgramme1.SelectedValue;
            
            if(ddlProgramme1.SelectedIndex == 0)
            {
                lblProgramme1ID.Text = "";
                lblProgramme1Description.Text = "";
                lblProgramme1LocalFees.Text = ""; 
                lblProgramme1InternationalFees.Text = "";
                lblProgramme1MainCourse.Text = "";
                lblProgramme1LocalMinReq.Text = "";
                lblProgramme1InternationalMinReq.Text = ""; 
                lblProgramme1CareerProspects.Text = "";
                lblProgramme1PTDuration.Text = ""; 
                lblProgramme1FTDuration.Text = "";
                lblProgramme1Type.Text = "";
                lblProgramme1Campus.Text = ""; 
                lblProgramme1Intake.Text = "";
            }
            RetrieveProgrammeDetails(programmeId, lblProgramme1ID, lblProgramme1Description, lblProgramme1LocalFees, lblProgramme1InternationalFees,
                                      lblProgramme1MainCourse, lblProgramme1LocalMinReq, lblProgramme1InternationalMinReq, lblProgramme1CareerProspects,
                                      lblProgramme1PTDuration, lblProgramme1FTDuration, lblProgramme1Type, lblProgramme1Campus, lblProgramme1Intake);
        }

        protected void ddlProgramme2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string programmeId = ddlProgramme2.SelectedValue;
            if (ddlProgramme2.SelectedIndex == 0)
            {
                lblProgramme2ID.Text = "";
                lblProgramme2Description.Text = "";
                lblProgramme2LocalFees.Text = "";
                lblProgramme2InternationalFees.Text = "";
                lblProgramme2MainCourse.Text = "";
                lblProgramme2LocalMinReq.Text = "";
                lblProgramme2InternationalMinReq.Text = "";
                lblProgramme2CareerProspects.Text = "";
                lblProgramme2PTDuration.Text = "";
                lblProgramme2FTDuration.Text = "";
                lblProgramme2Type.Text = "";
                lblProgramme2Campus.Text = "";
                lblProgramme2Intake.Text = "";
            }
            RetrieveProgrammeDetails(programmeId, lblProgramme2ID, lblProgramme2Description, lblProgramme2LocalFees, lblProgramme2InternationalFees,
                                      lblProgramme2MainCourse, lblProgramme2LocalMinReq, lblProgramme2InternationalMinReq, lblProgramme2CareerProspects,
                                      lblProgramme2PTDuration, lblProgramme2FTDuration, lblProgramme2Type, lblProgramme2Campus, lblProgramme2Intake);
        }

        private void RetrieveProgrammeDetails(string programmeId, Label lblID, Label lblDescription, Label lblLocalFees, Label lblInternationalFees,
                                               Label lblMainCourse, Label lblLocalMinReq, Label lblInternationalMinReq, Label lblCareerProspects,
                                               Label lblPTDuration, Label lblFTDuration, Label lblType, Label lblCampus, Label lblIntake)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = "SELECT * FROM Programme WHERE id = @progId;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@progId", programmeId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();

                                lblID.Text = string.IsNullOrEmpty(reader["id"].ToString()) ? "-" : reader["id"].ToString();
                                lblDescription.Text = string.IsNullOrEmpty(reader["description"].ToString()) ? "-" : reader["description"].ToString();
                                lblLocalFees.Text = string.IsNullOrEmpty(reader["localFees"].ToString()) ? "-" : reader["localFees"].ToString();
                                lblInternationalFees.Text = string.IsNullOrEmpty(reader["internationalFees"].ToString()) ? "-" : reader["internationalFees"].ToString();

                                // Deserialize JSON for local minimum requirements and append localSpecificSubjectReq (if exists)
                                string localMinReqJson = reader["localMinReq"].ToString();
                                string localSpecificSubjectReq = reader["localSpecificSubjectReq"].ToString();
                                if (!string.IsNullOrEmpty(localMinReqJson))
                                {
                                    var localMinReq = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(localMinReqJson);
                                    lblLocalMinReq.Text = FormatRequirements(localMinReq, localSpecificSubjectReq);
                                }
                                else
                                {
                                    lblLocalMinReq.Text = "-";
                                }

                                // Deserialize JSON for international minimum requirements and append internationalSpecificSubjectReq (if exists)
                                string internationalMinReqJson = reader["internationalMinReq"].ToString();
                                string internationalSpecificSubjectReq = reader["internationalSpecificSubjectReq"].ToString();
                                if (!string.IsNullOrEmpty(internationalMinReqJson))
                                {
                                    var internationalMinReq = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(internationalMinReqJson);
                                    lblInternationalMinReq.Text = FormatRequirements(internationalMinReq, internationalSpecificSubjectReq);
                                }
                                else
                                {
                                    lblInternationalMinReq.Text = "-";
                                }

                                string mainCourse = reader["mainCourse"].ToString();
                                string mpuCourses = reader["mpu"].ToString();
                                lblMainCourse.Text = FormatCourses(mainCourse, mpuCourses); lblCareerProspects.Text = string.IsNullOrEmpty(reader["careerProspects"].ToString()) ? "-" : FormatCareerProspects(reader["careerProspects"].ToString());
                                lblPTDuration.Text = string.IsNullOrEmpty(reader["ptDuration"].ToString()) ? "-" : reader["ptDuration"].ToString();
                                lblFTDuration.Text = string.IsNullOrEmpty(reader["ftDuration"].ToString()) ? "-" : reader["ftDuration"].ToString();
                                lblType.Text = string.IsNullOrEmpty(reader["type"].ToString()) ? "-" : reader["type"].ToString();
                                lblCampus.Text = string.IsNullOrEmpty(reader["campus"].ToString()) ? "-" : reader["campus"].ToString();
                                lblIntake.Text = string.IsNullOrEmpty(reader["intake"].ToString()) ? "-" : reader["intake"].ToString();
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    // Handle exceptions (e.g., log them)
                }
            }
        }

        private string FormatCourses(string mainCourse, string mpuCourses)
        {
            string formattedMainCourse = string.IsNullOrEmpty(mainCourse) ? "-" : string.Join("<br/>", mainCourse.Split(',').Select(c => c.Trim()));

            if (!string.IsNullOrEmpty(mpuCourses))
            {
                formattedMainCourse += "<br/><br/>MPU Courses:<br/>" + string.Join("<br/>", mpuCourses.Split(',').Select(c => c.Trim()));
            }

            return formattedMainCourse;
        }

        // Helper function to format JSON data and append subject-specific requirements
        private string FormatRequirements(Dictionary<string, string> requirements, string specificSubjectReq)
        {
            string formatted = string.Join("<br/>", requirements.Select(kv => $"{kv.Key}: {kv.Value}"));

            // Append subject-specific requirements if available
            if (!string.IsNullOrEmpty(specificSubjectReq))
            {
                var specificReqs = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(specificSubjectReq);
                formatted += "<br/><br/>Specific Subject Requirement:<br/>" + string.Join("<br/>", specificReqs.Select(kv => $"{kv.Key}: {kv.Value}"));
            }

            return formatted;
        }

        private void LoadProgrammes()
        {
            // Get connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT id, name FROM Programme;";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Bind Programme data to DropDownList 1
                    ddlProgramme1.DataSource = reader;
                    ddlProgramme1.DataTextField = "name";
                    ddlProgramme1.DataValueField = "id";
                    ddlProgramme1.DataBind();
                    ddlProgramme1.Items.Insert(0, new ListItem("Select a programme", null));

                    reader.Close();

                    // Execute reader again for the other dropdowns
                    reader = cmd.ExecuteReader();

                    // Bind Programme data to DropDownList 2
                    ddlProgramme2.DataSource = reader;
                    ddlProgramme2.DataTextField = "name";
                    ddlProgramme2.DataValueField = "id";
                    ddlProgramme2.DataBind();
                    ddlProgramme2.Items.Insert(0, new ListItem("Select a programme", null));

                    reader.Close();

                }
            }
        }

        // New helper function to format career prospects
        private string FormatCareerProspects(string careerProspects)
        {
            return string.Join("<br/>", careerProspects.Split(',').Select(c => c.Trim()));
        }
    }
}