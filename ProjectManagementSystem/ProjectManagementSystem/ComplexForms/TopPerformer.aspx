<%@ Page Title="Top Performers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TopPerformer.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.TopPerformer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Top Performers</h2>
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Select Project</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <label for="ddlProjects" class="form-label">Project:</label>
                    <asp:DropDownList ID="ddlProjects" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsProjects" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID"
                        CssClass="form-select">
                    </asp:DropDownList>
                    <div class="form-text">Select a project to view top performing users</div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card">
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
                </Columns>
                <HeaderStyle CssClass="bg-white" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No top performers found for this project.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT &quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot; FROM &quot;PROJECTS&quot; ORDER BY &quot;PROJECT_NAME&quot;">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsTopPerformers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT u.user_id, u.user_name, u.user_email, COUNT(t.task_id) AS tasks_completed
                       FROM users u, user_project_task upt, task t 
                       WHERE u.user_id = upt.user_id
                       AND upt.task_id = t.task_id
                       AND upt.project_id = :ProjectID
                       AND t.task_status = 'Completed'
                       GROUP BY u.user_id, u.user_name, u.user_email
                       ORDER BY COUNT(t.task_id) DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>