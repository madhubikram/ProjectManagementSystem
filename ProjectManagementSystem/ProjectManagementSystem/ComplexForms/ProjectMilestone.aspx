<%@ Page Title="Project Milestones" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectMilestone.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.UserProject" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Project Milestones</h2>
    
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
                </div>
            </div>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Project Details</h5>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="gvProjectDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
                DataKeyNames="PROJECT_ID" DataSourceID="sdsProjectDetails"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="PROJECT_ID" HeaderText="ID" ReadOnly="True" SortExpression="PROJECT_ID" />
                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name" SortExpression="PROJECT_NAME" />
                    <asp:BoundField DataField="PROJECT_DESCRIPTION" HeaderText="Description" SortExpression="PROJECT_DESCRIPTION" />
                    <asp:BoundField DataField="PROJECT_START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="PROJECT_START_DATE" />
                    <asp:BoundField DataField="PROJECT_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="PROJECT_DUE_DATE" />
                    <asp:TemplateField HeaderText="Status" SortExpression="PROJECT_STATUS">
                        <ItemTemplate>
                            <span class='badge bg-<%# GetStatusBadgeClass(Eval("PROJECT_STATUS").ToString()) %>'>
                                <%# Eval("PROJECT_STATUS") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="bg-white" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No project details found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Project Milestones</h5>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="gvMilestones" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="MILESTONE_ID" DataSourceID="sdsMilestones"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="MILESTONE_ID" HeaderText="ID" ReadOnly="True" SortExpression="MILESTONE_ID" />
                    <asp:BoundField DataField="MILESTONE_TITLE" HeaderText="Milestone" SortExpression="MILESTONE_TITLE" />
                    <asp:BoundField DataField="MILESTONE_DESCRIPTION" HeaderText="Description" SortExpression="MILESTONE_DESCRIPTION" />
                    <asp:BoundField DataField="MILESTONE_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="MILESTONE_DUE_DATE" />
                </Columns>
                <HeaderStyle CssClass="bg-white" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No milestones found for this project.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT project_id, project_name FROM projects ORDER BY project_name">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsProjectDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT project_id, project_name, project_description, project_start_date, project_due_date, project_status 
                       FROM projects 
                       WHERE project_id = :ProjectID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsMilestones" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT milestone_id, milestone_title, milestone_description, milestone_due_date
                       FROM milestones
                       WHERE project_id = :ProjectID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>