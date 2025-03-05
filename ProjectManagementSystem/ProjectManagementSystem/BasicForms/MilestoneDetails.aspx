<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MilestoneDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.MilestoneDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MILESTONE_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="MILESTONE_ID" HeaderText="MILESTONE_ID" ReadOnly="True" SortExpression="MILESTONE_ID" />
                <asp:BoundField DataField="MILESTONE_TITLE" HeaderText="MILESTONE_TITLE" SortExpression="MILESTONE_TITLE" />
                <asp:BoundField DataField="MILESTONE_DESCRIPTION" HeaderText="MILESTONE_DESCRIPTION" SortExpression="MILESTONE_DESCRIPTION" />
                <asp:BoundField DataField="MILESTONE_DUE_DATE" HeaderText="MILESTONE_DUE_DATE" SortExpression="MILESTONE_DUE_DATE" />
                <asp:BoundField DataField="PROJECT_ID" HeaderText="PROJECT_ID" SortExpression="PROJECT_ID" />
                <asp:TemplateField HeaderText="PROJECT NAME">
                    <ItemTemplate>
                        <asp:DropDownList Enabled="false" ID="DropDownList2" runat="server" DataSourceID="projectTitle" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID" SelectedValue='<%# Bind("PROJECT_ID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="projectTitle" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;PROJECTS&quot; WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID" InsertCommand="INSERT INTO &quot;PROJECTS&quot; (&quot;PROJECT_NAME&quot;, &quot;PROJECT_STATUS&quot;, &quot;PROJECT_ID&quot;) VALUES (:PROJECT_NAME, :PROJECT_STATUS, :PROJECT_ID)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;PROJECT_NAME&quot;, &quot;PROJECT_STATUS&quot;, &quot;PROJECT_ID&quot; FROM &quot;PROJECTS&quot;" UpdateCommand="UPDATE &quot;PROJECTS&quot; SET &quot;PROJECT_NAME&quot; = :PROJECT_NAME, &quot;PROJECT_STATUS&quot; = :PROJECT_STATUS WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID">
                            <DeleteParameters>
                                <asp:Parameter Name="PROJECT_ID" Type="String" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="PROJECT_NAME" Type="String" />
                                <asp:Parameter Name="PROJECT_STATUS" Type="String" />
                                <asp:Parameter Name="PROJECT_ID" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="PROJECT_NAME" Type="String" />
                                <asp:Parameter Name="PROJECT_STATUS" Type="String" />
                                <asp:Parameter Name="PROJECT_ID" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;MILESTONES&quot; WHERE &quot;MILESTONE_ID&quot; = :MILESTONE_ID" InsertCommand="INSERT INTO &quot;MILESTONES&quot; (&quot;MILESTONE_ID&quot;, &quot;MILESTONE_TITLE&quot;, &quot;MILESTONE_DESCRIPTION&quot;, &quot;MILESTONE_DUE_DATE&quot;, &quot;PROJECT_ID&quot;) VALUES (:MILESTONE_ID, :MILESTONE_TITLE, :MILESTONE_DESCRIPTION, :MILESTONE_DUE_DATE, :PROJECT_ID)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM &quot;MILESTONES&quot;" UpdateCommand="UPDATE &quot;MILESTONES&quot; SET &quot;MILESTONE_TITLE&quot; = :MILESTONE_TITLE, &quot;MILESTONE_DESCRIPTION&quot; = :MILESTONE_DESCRIPTION, &quot;MILESTONE_DUE_DATE&quot; = :MILESTONE_DUE_DATE, &quot;PROJECT_ID&quot; = :PROJECT_ID WHERE &quot;MILESTONE_ID&quot; = :MILESTONE_ID">
            <DeleteParameters>
                <asp:Parameter Name="MILESTONE_ID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MILESTONE_ID" Type="String" />
                <asp:Parameter Name="MILESTONE_TITLE" Type="String" />
                <asp:Parameter Name="MILESTONE_DESCRIPTION" Type="String" />
                <asp:Parameter Name="MILESTONE_DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_ID" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MILESTONE_TITLE" Type="String" />
                <asp:Parameter Name="MILESTONE_DESCRIPTION" Type="String" />
                <asp:Parameter Name="MILESTONE_DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_ID" Type="String" />
                <asp:Parameter Name="MILESTONE_ID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="MILESTONE_ID" DataSourceID="SqlDataSource1">
            <EditItemTemplate>
                MILESTONE_ID:
                <asp:Label ID="MILESTONE_IDLabel1" runat="server" Text='<%# Eval("MILESTONE_ID") %>' />
                <br />
                MILESTONE_TITLE:
                <asp:TextBox ID="MILESTONE_TITLETextBox" runat="server" Text='<%# Bind("MILESTONE_TITLE") %>' />
                <br />
                MILESTONE_DESCRIPTION:
                <asp:TextBox ID="MILESTONE_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("MILESTONE_DESCRIPTION") %>' />
                <br />
                MILESTONE_DUE_DATE:
                <asp:TextBox ID="MILESTONE_DUE_DATETextBox" runat="server" Text='<%# Bind("MILESTONE_DUE_DATE") %>' />
                <br />
                PROJECT_ID:
                <asp:TextBox ID="PROJECT_IDTextBox" runat="server" Text='<%# Bind("PROJECT_ID") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                MILESTONE_ID:
                <asp:TextBox ID="MILESTONE_IDTextBox" runat="server" Text='<%# Bind("MILESTONE_ID") %>' />
                <br />
                MILESTONE_TITLE:
                <asp:TextBox ID="MILESTONE_TITLETextBox" runat="server" Text='<%# Bind("MILESTONE_TITLE") %>' />
                <br />
                MILESTONE_DESCRIPTION:
                <asp:TextBox ID="MILESTONE_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("MILESTONE_DESCRIPTION") %>' />
                <br />
                MILESTONE_DUE_DATE:
                <asp:TextBox ID="MILESTONE_DUE_DATETextBox" runat="server" Text='<%# Bind("MILESTONE_DUE_DATE") %>' />
                <br />
                PROJECT_ID:
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;PROJECTS&quot; WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID" InsertCommand="INSERT INTO &quot;PROJECTS&quot; (&quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot;, &quot;PROJECT_STATUS&quot;) VALUES (:PROJECT_ID, :PROJECT_NAME, :PROJECT_STATUS)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot;, &quot;PROJECT_STATUS&quot; FROM &quot;PROJECTS&quot;" UpdateCommand="UPDATE &quot;PROJECTS&quot; SET &quot;PROJECT_NAME&quot; = :PROJECT_NAME, &quot;PROJECT_STATUS&quot; = :PROJECT_STATUS WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="PROJECT_ID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="PROJECT_ID" Type="String" />
                        <asp:Parameter Name="PROJECT_NAME" Type="String" />
                        <asp:Parameter Name="PROJECT_STATUS" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="PROJECT_NAME" Type="String" />
                        <asp:Parameter Name="PROJECT_STATUS" Type="String" />
                        <asp:Parameter Name="PROJECT_ID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
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
