﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectManagementSystem.BasicForms
{
    public partial class TaskDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GridView1.DataBind(); // Ensure initial binding
            }
        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {
            FormView1.PageIndex = e.NewPageIndex;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                SqlDataSource1.FilterExpression = "TASK_NAME LIKE '%{0}%' OR TASK_ID LIKE '%{0}%' OR TASK_STATUS LIKE '%{0}%' OR MILESTONE_ID LIKE '%{0}%'";
                SqlDataSource1.FilterParameters.Clear();
                SqlDataSource1.FilterParameters.Add(new ControlParameter("0", txtSearch.ID, "Text"));
            }
            else
            {
                SqlDataSource1.FilterExpression = "";
                SqlDataSource1.FilterParameters.Clear();
            }
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
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
                case "Pending":
                    return "info";
                default:
                    return "info";
            }
        }
    }
}