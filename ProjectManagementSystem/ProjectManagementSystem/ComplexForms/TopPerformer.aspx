<%@ Page Title="Top Performers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TopPerformer.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.TopPerformer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Top Performers</h2>

    <!-- Project Selection Card -->
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Select Project</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <label for="ddlProjects" class="form-label">Project:</label>
                    <asp:DropDownList ID="ddlProjects" runat="server" AutoPostBack="True"
                        DataSourceID="sdsProjects" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID"
                        CssClass="form-select" AppendDataBoundItems="True">
                        <asp:ListItem Value="" Text="Select a project"></asp:ListItem>
                    </asp:DropDownList>
                    <div class="form-text">Select a project to view details and top performing users</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Project Details Card -->
    <div class="card shadow mb-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">Project Details</h5>
        </div>
        <div class="card-body">
            <asp:FormView ID="fvProjectDetails" runat="server" DataSourceID="sdsProjectDetails" CssClass="w-100">
                <ItemTemplate>
                    <dl class="row mb-0">
                        <dt class="col-sm-3">Project Name</dt>
                        <dd class="col-sm-9"><%# Eval("PROJECT_NAME") %></dd>
                        <dt class="col-sm-3">Start Date</dt>
                        <dd class="col-sm-9"><%# Eval("PROJECT_START_DATE", "{0:yyyy-MM-dd}") %></dd>
                        <dt class="col-sm-3">Due Date</dt>
                        <dd class="col-sm-9"><%# Eval("PROJECT_DUE_DATE", "{0:yyyy-MM-dd}") %></dd>
                        <dt class="col-sm-3">Status</dt>
                        <dd class="col-sm-9">
                            <span id="statusBadge" runat="server" class="badge bg-primary" style="font-size: 1rem; padding: 0.5em 1em;">
                                <%# Eval("PROJECT_STATUS") %>
                            </span>
                        </dd>
                        <dt class="col-sm-3">Description</dt>
                        <dd class="col-sm-9"><%# Eval("PROJECT_DESCRIPTION") %></dd>
                    </dl>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <div class="alert alert-info">Please select a project to view details.</div>
                </EmptyDataTemplate>
            </asp:FormView>
        </div>
    </div>

    <!-- Top Performers Card -->
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Top Performers</h5>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="gvTopPerformers" runat="server" AutoGenerateColumns="False"
                DataKeyNames="USER_ID" DataSourceID="sdsTopPerformers"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="USER_ID" HeaderText="ID" ReadOnly="True" SortExpression="USER_ID" />
                    <asp:BoundField DataField="USER_NAME" HeaderText="Name" SortExpression="USER_NAME" />
                    <asp:BoundField DataField="USER_EMAIL" HeaderText="Email" SortExpression="USER_EMAIL" />
                    <asp:TemplateField HeaderText="Tasks Completed" SortExpression="TASKS_COMPLETED">
                        <ItemTemplate>
                            <span class="badge bg-success"><%# Eval("TASKS_COMPLETED") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Completed Tasks">
                        <ItemTemplate>
                            <%# Eval("completed_task_names") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="bg-white" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No top performers found for this project.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <!-- Data Sources -->
    <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand='SELECT "PROJECT_ID", "PROJECT_NAME" FROM "PROJECTS" ORDER BY "PROJECT_NAME"'>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsProjectDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand='SELECT "PROJECT_NAME", "PROJECT_START_DATE", "PROJECT_DUE_DATE", "PROJECT_STATUS", "PROJECT_DESCRIPTION" 
                       FROM "PROJECTS" WHERE "PROJECT_ID" = :ProjectID'>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsTopPerformers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT * FROM (
                       SELECT u.user_id, u.user_name, u.user_email, COUNT(t.task_id) AS tasks_completed,
                              LISTAGG(t.task_name, ', ') WITHIN GROUP (ORDER BY t.task_name) AS completed_task_names
                       FROM users u, user_project_task upt, task t
                       WHERE u.user_id = upt.user_id
                       AND upt.task_id = t.task_id
                       AND upt.project_id = :ProjectID
                       AND t.task_status = 'Completed'
                       GROUP BY u.user_id, u.user_name, u.user_email
                       ORDER BY COUNT(t.task_id) DESC)
                       WHERE ROWNUM <= 3">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>