<%@ Page Title="User Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProject.aspx.cs" Inherits="ProjectManagementSystem.ComplexForms.ProjectMilestone" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">User Projects</h2>
    
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Select User</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <label for="ddlUsers" class="form-label">User:</label>
                    <asp:DropDownList ID="ddlUsers" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsUsers" DataTextField="USER_NAME" DataValueField="USER_ID"
                        CssClass="form-select" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card mb-4">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">User Details</h5>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="gvUserDetails" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="USER_ID" DataSourceID="sdsUserDetails"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="USER_ID" HeaderText="ID" ReadOnly="True" SortExpression="USER_ID" />
                    <asp:BoundField DataField="USER_NAME" HeaderText="Name" SortExpression="USER_NAME" />
                    <asp:BoundField DataField="USER_EMAIL" HeaderText="Email" SortExpression="USER_EMAIL" />
                    <asp:BoundField DataField="USER_CONTACT_NO" HeaderText="Contact" SortExpression="USER_CONTACT_NO" />
                </Columns>
                <HeaderStyle CssClass="bg-white" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No user details found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Assigned Projects</h5>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="PROJECT_ID" DataSourceID="sdsProjects"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
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
                    <div class="alert alert-info m-3">No projects assigned to this user.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="sdsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;USERS&quot; WHERE &quot;USER_ID&quot; = :USER_ID" 
        InsertCommand="INSERT INTO &quot;USERS&quot; (&quot;USER_ID&quot;, &quot;USER_NAME&quot;) VALUES (:USER_ID, :USER_NAME)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT &quot;USER_ID&quot;, &quot;USER_NAME&quot; FROM &quot;USERS&quot;" 
        UpdateCommand="UPDATE &quot;USERS&quot; SET &quot;USER_NAME&quot; = :USER_NAME WHERE &quot;USER_ID&quot; = :USER_ID" OnSelecting="sdsUsers_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="USER_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="USER_ID" Type="String" />
            <asp:Parameter Name="USER_NAME" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="USER_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT p.project_id, p.project_name, p.project_description, 
            p.project_start_date, p.project_due_date, p.project_status
            FROM projects p, user_projects up 
            WHERE p.project_id = up.project_id
            AND up.user_id = :UserID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUsers" Name="UserID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsUserDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;USERS&quot; WHERE &quot;USER_ID&quot; = :USER_ID" 
        InsertCommand="INSERT INTO &quot;USERS&quot; (&quot;USER_ID&quot;, &quot;USER_NAME&quot;, &quot;USER_EMAIL&quot;, &quot;USER_CONTACT_NO&quot;) VALUES (:USER_ID, :USER_NAME, :USER_EMAIL, :USER_CONTACT_NO)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT * FROM &quot;USERS&quot; WHERE (&quot;USER_ID&quot; = :USER_ID)" 
        UpdateCommand="UPDATE &quot;USERS&quot; SET &quot;USER_NAME&quot; = :USER_NAME, &quot;USER_EMAIL&quot; = :USER_EMAIL, &quot;USER_CONTACT_NO&quot; = :USER_CONTACT_NO WHERE &quot;USER_ID&quot; = :USER_ID">
        <DeleteParameters>
            <asp:Parameter Name="USER_ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="USER_ID" Type="String" />
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="USER_EMAIL" Type="String" />
            <asp:Parameter Name="USER_CONTACT_NO" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUsers" Name="USER_ID" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="USER_EMAIL" Type="String" />
            <asp:Parameter Name="USER_CONTACT_NO" Type="String" />
            <asp:Parameter Name="USER_ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>