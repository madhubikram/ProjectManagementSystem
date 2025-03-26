using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ProjectManagementSystem.ComplexForms
{
    public partial class TopPerformer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Subscribe to the DataBound event programmatically
            fvProjectDetails.DataBound += fvProjectDetails_DataBound;
        }

        protected void fvProjectDetails_DataBound(object sender, EventArgs e)
        {
            // Ensure the FormView is in ReadOnly mode and has data
            if (fvProjectDetails.CurrentMode == FormViewMode.ReadOnly && fvProjectDetails.DataItem != null)
            {
                // Find the statusBadge control
                var statusBadge = (HtmlGenericControl)fvProjectDetails.FindControl("statusBadge");
                if (statusBadge != null)
                {
                    // Get the project status and apply the appropriate badge class
                    string status = DataBinder.Eval(fvProjectDetails.DataItem, "PROJECT_STATUS").ToString();
                    string badgeClass = GetStatusBadgeClass(status);
                    // Apply both background and text color for high contrast
                    statusBadge.Attributes["class"] = $"badge bg-{badgeClass} {(badgeClass == "secondary" ? "text-dark" : "text-white")}";
                }
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            // Determine the CSS class for the status badge based on the project status
            switch (status)
            {
                case "Completed":
                    return "success";
                case "In Progress":
                    return "primary";
                case "Not Started":
                    return "secondary";
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