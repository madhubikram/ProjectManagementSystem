<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopPerformer.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.TopPerformer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:DropDownList ID="ddlProjects" runat="server" AutoPostBack="True" DataSourceID="sdsProjects" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID">
        </asp:DropDownList>
        <asp:GridView ID="gvTopPerformers" runat="server" AutoGenerateColumns="False" DataKeyNames="USER_ID" DataSourceID="sdsTopPerformers">
            <Columns>
                <asp:BoundField DataField="USER_ID" HeaderText="USER_ID" ReadOnly="True" SortExpression="USER_ID" />
                <asp:BoundField DataField="USER_NAME" HeaderText="USER_NAME" SortExpression="USER_NAME" />
                <asp:BoundField DataField="USER_EMAIL" HeaderText="USER_EMAIL" SortExpression="USER_EMAIL" />
                <asp:BoundField DataField="TASKS_COMPLETED" HeaderText="TASKS_COMPLETED" SortExpression="TASKS_COMPLETED" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot; FROM &quot;PROJECTS&quot; ORDER BY &quot;PROJECT_NAME&quot;"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsTopPerformers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT u.user_id, u.user_name, u.user_email, COUNT(t.task_id) AS tasks_completed
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
    </form>
</body>
</html>
