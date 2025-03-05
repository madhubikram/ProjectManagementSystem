<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectMilestone.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.UserProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="ddlProjects" runat="server" AutoPostBack="True" DataSourceID="sdsProjects" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID">
            </asp:DropDownList>
        </div>
        <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT project_id, project_name FROM projects ORDER BY project_name"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsProjectDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT project_id, project_name, project_description, 
       project_start_date, project_due_date, project_status 
FROM projects 
WHERE project_id = :ProjectID">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsMilestones" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT milestone_id, milestone_title, milestone_description, milestone_due_date
FROM milestones
WHERE project_id = :ProjectID">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProjects" Name="ProjectID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvProjectDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="PROJECT_ID" DataSourceID="sdsProjectDetails">
            <Columns>
                <asp:BoundField DataField="PROJECT_ID" HeaderText="PROJECT_ID" ReadOnly="True" SortExpression="PROJECT_ID" />
                <asp:BoundField DataField="PROJECT_NAME" HeaderText="PROJECT_NAME" SortExpression="PROJECT_NAME" />
                <asp:BoundField DataField="PROJECT_DESCRIPTION" HeaderText="PROJECT_DESCRIPTION" SortExpression="PROJECT_DESCRIPTION" />
                <asp:BoundField DataField="PROJECT_START_DATE" HeaderText="PROJECT_START_DATE" SortExpression="PROJECT_START_DATE" />
                <asp:BoundField DataField="PROJECT_DUE_DATE" HeaderText="PROJECT_DUE_DATE" SortExpression="PROJECT_DUE_DATE" />
                <asp:BoundField DataField="PROJECT_STATUS" HeaderText="PROJECT_STATUS" SortExpression="PROJECT_STATUS" />
            </Columns>
        </asp:GridView>
        <asp:GridView ID="gvMilestones" runat="server" AutoGenerateColumns="False" DataKeyNames="MILESTONE_ID" DataSourceID="sdsMilestones">
            <Columns>
                <asp:BoundField DataField="MILESTONE_ID" HeaderText="MILESTONE_ID" ReadOnly="True" SortExpression="MILESTONE_ID" />
                <asp:BoundField DataField="MILESTONE_TITLE" HeaderText="MILESTONE_TITLE" SortExpression="MILESTONE_TITLE" />
                <asp:BoundField DataField="MILESTONE_DESCRIPTION" HeaderText="MILESTONE_DESCRIPTION" SortExpression="MILESTONE_DESCRIPTION" />
                <asp:BoundField DataField="MILESTONE_DUE_DATE" HeaderText="MILESTONE_DUE_DATE" SortExpression="MILESTONE_DUE_DATE" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
