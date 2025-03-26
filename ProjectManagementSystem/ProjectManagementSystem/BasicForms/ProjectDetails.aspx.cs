using System;
using System.Web.UI.WebControls;

namespace ProjectManagementSystem.BasicForms
{
    public partial class ProjectDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
               
                SqlDataSource1.SelectCommand = "SELECT * FROM \"PROJECTS\" WHERE " +
                    "PROJECT_ID LIKE '%' || :SearchTerm || '%' OR " +
                    "PROJECT_NAME LIKE '%' || :SearchTerm || '%' OR " +
                    "PROJECT_DESCRIPTION LIKE '%' || :SearchTerm || '%' OR " +
                    "PROJECT_STATUS LIKE '%' || :SearchTerm || '%'";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("SearchTerm", searchTerm);
            }
            else
            {
               
                SqlDataSource1.SelectCommand = "SELECT * FROM \"PROJECTS\"";
                SqlDataSource1.SelectParameters.Clear();
            }
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {
            FormView1.PageIndex = e.NewPageIndex;
            FormView1.DataBind();
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status)
            {
                case "Not Started":
                    return "secondary";
                case "In Progress":
                    return "primary";
                case "Completed":
                    return "success";
                case "On Hold":
                    return "warning";
                case "Cancelled":
                    return "danger";
                default:
                    return "info";
            }
        }
    }
}