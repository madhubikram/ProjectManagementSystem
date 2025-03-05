<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubtaskDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.SubtaskDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SUBTASK_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="SUBTASK_ID" HeaderText="SUBTASK_ID" ReadOnly="True" SortExpression="SUBTASK_ID" />
                <asp:BoundField DataField="SUBTASK_TITLE" HeaderText="SUBTASK_TITLE" SortExpression="SUBTASK_TITLE" />
                <asp:BoundField DataField="SUBTASK_STATUS" HeaderText="SUBTASK_STATUS" SortExpression="SUBTASK_STATUS" />
                <asp:BoundField DataField="DUE_DATE" HeaderText="DUE_DATE" SortExpression="DUE_DATE" />
                <asp:BoundField DataField="SUBTASK_DESCRIPTION" HeaderText="SUBTASK_DESCRIPTION" SortExpression="SUBTASK_DESCRIPTION" />
                <asp:BoundField DataField="TASK_ID" HeaderText="TASK_ID" SortExpression="TASK_ID" />
                <asp:TemplateField HeaderText="TASK NAME">
                    <ItemTemplate>
                        <asp:DropDownList Enabled="false" ID="DropDownList2" runat="server" DataSourceID="taskName" DataTextField="TASK_NAME" DataValueField="TASK_ID" SelectedValue='<%# Bind("TASK_ID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="taskName" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;TASK_NAME&quot;, &quot;TASK_STATUS&quot;, &quot;TASK_ID&quot; FROM &quot;TASK&quot;"></asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;SUB_TASK&quot; WHERE &quot;SUBTASK_ID&quot; = :SUBTASK_ID" InsertCommand="INSERT INTO &quot;SUB_TASK&quot; (&quot;SUBTASK_ID&quot;, &quot;SUBTASK_TITLE&quot;, &quot;SUBTASK_STATUS&quot;, &quot;DUE_DATE&quot;, &quot;SUBTASK_DESCRIPTION&quot;, &quot;TASK_ID&quot;) VALUES (:SUBTASK_ID, :SUBTASK_TITLE, :SUBTASK_STATUS, :DUE_DATE, :SUBTASK_DESCRIPTION, :TASK_ID)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM &quot;SUB_TASK&quot;" UpdateCommand="UPDATE &quot;SUB_TASK&quot; SET &quot;SUBTASK_TITLE&quot; = :SUBTASK_TITLE, &quot;SUBTASK_STATUS&quot; = :SUBTASK_STATUS, &quot;DUE_DATE&quot; = :DUE_DATE, &quot;SUBTASK_DESCRIPTION&quot; = :SUBTASK_DESCRIPTION, &quot;TASK_ID&quot; = :TASK_ID WHERE &quot;SUBTASK_ID&quot; = :SUBTASK_ID">
            <DeleteParameters>
                <asp:Parameter Name="SUBTASK_ID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SUBTASK_ID" Type="String" />
                <asp:Parameter Name="SUBTASK_TITLE" Type="String" />
                <asp:Parameter Name="SUBTASK_STATUS" Type="String" />
                <asp:Parameter Name="DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="SUBTASK_DESCRIPTION" Type="String" />
                <asp:Parameter Name="TASK_ID" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="SUBTASK_TITLE" Type="String" />
                <asp:Parameter Name="SUBTASK_STATUS" Type="String" />
                <asp:Parameter Name="DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="SUBTASK_DESCRIPTION" Type="String" />
                <asp:Parameter Name="TASK_ID" Type="String" />
                <asp:Parameter Name="SUBTASK_ID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="SUBTASK_ID" DataSourceID="SqlDataSource1">
            <EditItemTemplate>
                SUBTASK_ID:
                <asp:Label ID="SUBTASK_IDLabel1" runat="server" Text='<%# Eval("SUBTASK_ID") %>' />
                <br />
                SUBTASK_TITLE:
                <asp:TextBox ID="SUBTASK_TITLETextBox" runat="server" Text='<%# Bind("SUBTASK_TITLE") %>' />
                <br />
                SUBTASK_STATUS:
                <asp:TextBox ID="SUBTASK_STATUSTextBox" runat="server" Text='<%# Bind("SUBTASK_STATUS") %>' />
                <br />
                DUE_DATE:
                <asp:TextBox ID="DUE_DATETextBox" runat="server" Text='<%# Bind("DUE_DATE") %>' />
                <br />
                SUBTASK_DESCRIPTION:
                <asp:TextBox ID="SUBTASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("SUBTASK_DESCRIPTION") %>' />
                <br />
                TASK_ID:
                <asp:TextBox ID="TASK_IDTextBox" runat="server" Text='<%# Bind("TASK_ID") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                SUBTASK_ID:
                <asp:TextBox ID="SUBTASK_IDTextBox" runat="server" Text='<%# Bind("SUBTASK_ID") %>' />
                <br />
                SUBTASK_TITLE:
                <asp:TextBox ID="SUBTASK_TITLETextBox" runat="server" Text='<%# Bind("SUBTASK_TITLE") %>' />
                <br />
                SUBTASK_STATUS:
                <asp:TextBox ID="SUBTASK_STATUSTextBox" runat="server" Text='<%# Bind("SUBTASK_STATUS") %>' />
                <br />
                DUE_DATE:
                <asp:TextBox ID="DUE_DATETextBox" runat="server" Text='<%# Bind("DUE_DATE") %>' />
                <br />
                SUBTASK_DESCRIPTION:
                <asp:TextBox ID="SUBTASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("SUBTASK_DESCRIPTION") %>' />
                <br />
                TASK_ID:
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="TASK_NAME" DataValueField="TASK_ID" SelectedValue='<%# Bind("TASK_ID") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;TASK&quot; WHERE &quot;TASK_ID&quot; = :TASK_ID" InsertCommand="INSERT INTO &quot;TASK&quot; (&quot;TASK_ID&quot;, &quot;TASK_NAME&quot;) VALUES (:TASK_ID, :TASK_NAME)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;TASK_ID&quot;, &quot;TASK_NAME&quot; FROM &quot;TASK&quot;" UpdateCommand="UPDATE &quot;TASK&quot; SET &quot;TASK_NAME&quot; = :TASK_NAME WHERE &quot;TASK_ID&quot; = :TASK_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="TASK_ID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TASK_ID" Type="String" />
                        <asp:Parameter Name="TASK_NAME" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TASK_NAME" Type="String" />
                        <asp:Parameter Name="TASK_ID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
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
