using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ProjectManagementSystem
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load dynamic dashboard data
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                // Active Projects
                DataView activeProjectsView = (DataView)SqlDataSourceActiveProjects.Select(DataSourceSelectArguments.Empty);
                litActiveProjects.Text = activeProjectsView != null ? activeProjectsView.Count.ToString() : "0";

                // Completed Tasks
                DataView completedTasksView = (DataView)SqlDataSourceCompletedTasks.Select(DataSourceSelectArguments.Empty);
                litCompletedTasks.Text = completedTasksView != null ? completedTasksView.Count.ToString() : "0";

                // Pending Tasks
                DataView pendingTasksView = (DataView)SqlDataSourcePendingTasks.Select(DataSourceSelectArguments.Empty);
                litPendingTasks.Text = pendingTasksView != null ? pendingTasksView.Count.ToString() : "0";

                // Team Members
                DataView teamMembersView = (DataView)SqlDataSourceTeamMembers.Select(DataSourceSelectArguments.Empty);
                litTeamMembers.Text = teamMembersView != null ? teamMembersView.Count.ToString() : "0";
            }
            catch (Exception ex)
            {
                // If an error occurs, display default values and log the error
                litActiveProjects.Text = "0";
                litCompletedTasks.Text = "0";
                litPendingTasks.Text = "0";
                litTeamMembers.Text = "0";

                // You could log the error here
                System.Diagnostics.Debug.WriteLine("Error loading dashboard data: " + ex.Message);
            }
        }

        // Handle GridView pagination events
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            GridView2.DataBind();
        }

        protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView3.PageIndex = e.NewPageIndex;
            GridView3.DataBind();
        }

        protected string GetStatusBadgeClass(string status)
        {
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

        protected string GetTaskStatusBadgeClass(string status)
        {
            switch (status)
            {
                case "Completed":
                    return "success";
                case "In Progress":
                    return "primary";
                case "Pending":
                case "Not Started":
                    return "secondary";
                case "On Hold":
                    return "warning";
                default:
                    return "info";
            }
        }
    }
}