<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.TaskDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="TASK_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="TASK_ID" HeaderText="TASK_ID" ReadOnly="True" SortExpression="TASK_ID" />
                <asp:BoundField DataField="TASK_NAME" HeaderText="TASK_NAME" SortExpression="TASK_NAME" />
                <asp:BoundField DataField="TASK_DESCRIPTION" HeaderText="TASK_DESCRIPTION" SortExpression="TASK_DESCRIPTION" />
                <asp:BoundField DataField="TASK_STATUS" HeaderText="TASK_STATUS" SortExpression="TASK_STATUS" />
                <asp:BoundField DataField="TASK_START_DATE" HeaderText="TASK_START_DATE" SortExpression="TASK_START_DATE" />
                <asp:BoundField DataField="TASK_DUE_DATE" HeaderText="TASK_DUE_DATE" SortExpression="TASK_DUE_DATE" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;TASK&quot; WHERE &quot;TASK_ID&quot; = :TASK_ID" InsertCommand="INSERT INTO &quot;TASK&quot; (&quot;TASK_ID&quot;, &quot;TASK_NAME&quot;, &quot;TASK_DESCRIPTION&quot;, &quot;TASK_STATUS&quot;, &quot;TASK_START_DATE&quot;, &quot;TASK_DUE_DATE&quot;) VALUES (:TASK_ID, :TASK_NAME, :TASK_DESCRIPTION, :TASK_STATUS, :TASK_START_DATE, :TASK_DUE_DATE)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM &quot;TASK&quot;" UpdateCommand="UPDATE &quot;TASK&quot; SET &quot;TASK_NAME&quot; = :TASK_NAME, &quot;TASK_DESCRIPTION&quot; = :TASK_DESCRIPTION, &quot;TASK_STATUS&quot; = :TASK_STATUS, &quot;TASK_START_DATE&quot; = :TASK_START_DATE, &quot;TASK_DUE_DATE&quot; = :TASK_DUE_DATE WHERE &quot;TASK_ID&quot; = :TASK_ID">
            <DeleteParameters>
                <asp:Parameter Name="TASK_ID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TASK_ID" Type="String" />
                <asp:Parameter Name="TASK_NAME" Type="String" />
                <asp:Parameter Name="TASK_DESCRIPTION" Type="String" />
                <asp:Parameter Name="TASK_STATUS" Type="String" />
                <asp:Parameter Name="TASK_START_DATE" Type="DateTime" />
                <asp:Parameter Name="TASK_DUE_DATE" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TASK_NAME" Type="String" />
                <asp:Parameter Name="TASK_DESCRIPTION" Type="String" />
                <asp:Parameter Name="TASK_STATUS" Type="String" />
                <asp:Parameter Name="TASK_START_DATE" Type="DateTime" />
                <asp:Parameter Name="TASK_DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="TASK_ID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="TASK_ID" DataSourceID="SqlDataSource1" style="margin-top: 0px; margin-bottom: 178px;" Width="691px" OnPageIndexChanging="FormView1_PageIndexChanging">
            <EditItemTemplate>
                TASK_ID:
                <asp:Label ID="TASK_IDLabel1" runat="server" Text='<%# Eval("TASK_ID") %>' />
                <br />
                TASK_NAME:
                <asp:TextBox ID="TASK_NAMETextBox" runat="server" Text='<%# Bind("TASK_NAME") %>' />
                <br />
                TASK_DESCRIPTION:
                <asp:TextBox ID="TASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("TASK_DESCRIPTION") %>' />
                <br />
                TASK_STATUS:
                <asp:TextBox ID="TASK_STATUSTextBox" runat="server" Text='<%# Bind("TASK_STATUS") %>' />
                <br />
                TASK_START_DATE:
                <asp:TextBox ID="TASK_START_DATETextBox" runat="server" Text='<%# Bind("TASK_START_DATE") %>' />
                <br />
                TASK_DUE_DATE:
                <asp:TextBox ID="TASK_DUE_DATETextBox" runat="server" Text='<%# Bind("TASK_DUE_DATE") %>' OnTextChanged="TASK_DUE_DATETextBox_TextChanged" />
                <br />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                TASK_ID:
                <asp:TextBox ID="TASK_IDTextBox" runat="server" Text='<%# Bind("TASK_ID") %>' />
                <br />
                TASK_NAME:
                <asp:TextBox ID="TASK_NAMETextBox" runat="server" Text='<%# Bind("TASK_NAME") %>' />
                <br />
                TASK_DESCRIPTION:
                <asp:TextBox ID="TASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("TASK_DESCRIPTION") %>' />
                <br />
                TASK_STATUS:
                <asp:TextBox ID="TASK_STATUSTextBox" runat="server" Text='<%# Bind("TASK_STATUS") %>' />
                <br />
                TASK_START_DATE:
                <asp:TextBox ID="TASK_START_DATETextBox" runat="server" Text='<%# Bind("TASK_START_DATE") %>' />
                <br />
                TASK_DUE_DATE:
                <asp:TextBox ID="TASK_DUE_DATETextBox" runat="server" Text='<%# Bind("TASK_DUE_DATE") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Insert" />
            </ItemTemplate>
        </asp:FormView>
    </form>
</body>
</html>
