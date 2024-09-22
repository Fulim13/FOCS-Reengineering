using System;
using System.Configuration;
using System.Data.SqlClient;


namespace SEMASGN.Client.ProgrammeDetails
{
    public partial class ProgrammeDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                // Get the programme ID from the query string
                string programmeId = Request.QueryString["id"];

                // Get the userType from the hidden field
                string userType = userTypeHiddenField.Value;  // "local" or "international"

                if (!string.IsNullOrEmpty(programmeId) && !string.IsNullOrEmpty(userType))
                {
                    // Load programme details based on the user type
                    LoadProgrammeDetails(programmeId, userType);
                }
            }
        }

        protected void btnChat_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Client/FOCS/Chat.aspx");
        }


        private void LoadProgrammeDetails(string programmeId, string userType)
        {
            // Get the connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            // SQL query to retrieve programme details for local students
            // Define the query dynamically based on userType (local or international)
            string query = "";

            if (userType == "Local")
            {
                // SQL query for local students
                query = @"SELECT
                    name,
                    localFees AS fees,
                    mainCourse,
                    mpu,
                    localMinReq AS minReq,
                    localSpecificSubjectReq AS specificSubjectReq,
                    careerProspects,
                    description,
                    ptDuration,
                    ftDuration,
                    type,
                    campus,
                    intake
                  FROM Programme
                  WHERE id = @programmeId";
            }
            else if (userType == "International")
            {
                // SQL query for international students
                query = @"SELECT
                    name,
                    internationalFees AS fees,
                    mainCourse,
                    mpu,
                    internationalMinReq AS minReq,
                    internationalSpecificSubjectReq AS specificSubjectReq,
                    careerProspects,
                    description,
                    ptDuration,
                    ftDuration,
                    type,
                    campus,
                    intake
                  FROM Programme
                  WHERE id = @programmeId";
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@programmeId", programmeId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // Bind the retrieved data to the page controls
                        programmeName.Text = reader["name"].ToString();
                        programmeDescription.Text = reader["description"].ToString();
                        decimal fee = reader["fees"] != DBNull.Value ? Convert.ToDecimal(reader["fees"]) : 0;
                        programmeFees.Text = fee.ToString("N2"); // Format as numeric with two decimal places
                        programmeDuration.Text = reader["ftDuration"].ToString();
                        programmeIntake.Text = reader["intake"].ToString();
                        programmeCampus.Text = reader["campus"].ToString();
                        Literal1.Text = reader["specificSubjectReq"].ToString().Replace(",", "<br />");
                        programmeMainCourses.Text = reader["mainCourse"].ToString().Replace(",", "<br />");  // Replace comma with line breaks
                        programmeMpuCourses.Text = reader["mpu"].ToString().Replace(",", "<br />");
                        programmeCareers.Text = reader["careerProspects"].ToString();
                        requirement.Text = reader["minReq"].ToString().Replace(",", "<br />");
                    }
                }
            }
        }

    }
}