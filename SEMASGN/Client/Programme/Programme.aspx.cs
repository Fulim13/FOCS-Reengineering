using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEMASGN.Client.Programme
{
    public partial class Programme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind each category of programmes to their respective repeater
                BindProgrammes("Foundation", FoundationRepeater);
                BindProgrammes("Diploma", DiplomaRepeater);
                BindProgrammes("Degree", BachelorRepeater);
                BindProgrammes("Postgraduate", PostgraduateRepeater);
            }
        }

        private void BindProgrammes(string programmeType, Repeater repeater)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            // SQL query to retrieve name and description from the Programme table where type matches the specified programmeType
            string query = "SELECT id, name, description FROM Programme WHERE type = @type";

            // Create a DataTable to store the retrieved data
            DataTable dtProgrammes = new DataTable();

            // Retrieve data from the database using ADO.NET
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add the programme type as a parameter
                    cmd.Parameters.AddWithValue("@type", programmeType);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    dtProgrammes.Load(reader);

                }
            }

            // Bind the data to the provided repeater
            repeater.DataSource = dtProgrammes;
            repeater.DataBind();
        }
    }
}