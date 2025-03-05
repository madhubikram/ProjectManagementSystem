<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.ProjectDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
    <style>
    body {
        padding: 20px;
        background-color: #f8f9fa;
    }
    .container {
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
    }
    .page-title {
        color: #343a40;
        margin-bottom: 25px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }
    .form-section {
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #dee2e6;
    }
    .btn-action {
        margin-right: 5px;
    }
    .edit-btn {
        background-color: #e7f1ff;
        color: #0d6efd;
        border: 1px solid #0d6efd;
        padding: 4px 10px;
        border-radius: 4px;
        margin-right: 5px;
        text-decoration: none;
        font-size: 0.9em;
    }
    .delete-btn {
        background-color: #f8d7da;
        color: #dc3545;
        border: 1px solid #dc3545;
        padding: 4px 10px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 0.9em;
    }
    .search-box {
        min-width: 200px;
    }
</style>
    <script type="text/javascript">
    function confirmDelete() {
        return confirm("Are you sure you want to delete this project?");
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="#">Project Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="UserDetails.aspx">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ProjectDetails.aspx">Projects</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="TaskDetails.aspx">Tasks</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SubtaskDetails.aspx">Subtasks</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MilestoneDetails.aspx">Milestones</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <h2 class="page-title">Project Management</h2>
    
            <!-- Project Insert Form Section -->
            <div class="row form-section">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Add New Project</h5>
                        </div>
                        <div class="card-body">
                            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PROJECT_ID" DataSourceID="SqlDataSource1" OnPageIndexChanging="FormView1_PageIndexChanging1">
                                <EditItemTemplate>
                                    PROJECT_ID:
                                    <asp:Label ID="PROJECT_IDLabel1" runat="server" Text='<%# Eval("PROJECT_ID") %>' />
                                    <br />
                                    PROJECT_NAME:
                                    <asp:TextBox ID="PROJECT_NAMETextBox" runat="server" Text='<%# Bind("PROJECT_NAME") %>' />
                                    <br />
                                    PROJECT_DESCRIPTION:
                                    <asp:TextBox ID="PROJECT_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("PROJECT_DESCRIPTION") %>' />
                                    <br />
                                    PROJECT_START_DATE:
                                    <asp:TextBox ID="PROJECT_START_DATETextBox" runat="server" Text='<%# Bind("PROJECT_START_DATE") %>' />
                                    <br />
                                    PROJECT_DUE_DATE:
                                    <asp:TextBox ID="PROJECT_DUE_DATETextBox" runat="server" Text='<%# Bind("PROJECT_DUE_DATE") %>' />
                                    <br />
                                    PROJECT_STATUS:
                                    <asp:TextBox ID="PROJECT_STATUSTextBox" runat="server" Text='<%# Bind("PROJECT_STATUS") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                   <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="PROJECT_IDTextBox" class="form-label">Project ID:</label>
                                            <asp:TextBox ID="PROJECT_IDTextBox" runat="server" Text='<%# Bind("PROJECT_ID") %>'
                                                CssClass="form-control" placeholder="Enter Project ID (e.g., P016)" />
                                            <asp:RequiredFieldValidator ID="rfvProjectID" runat="server" 
                                                ControlToValidate="PROJECT_IDTextBox" ErrorMessage="Project ID is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="PROJECT_NAMETextBox" class="form-label">Project Name:</label>
                                            <asp:TextBox ID="PROJECT_NAMETextBox" runat="server" Text='<%# Bind("PROJECT_NAME") %>'
                                                CssClass="form-control" placeholder="Enter project name" />
                                            <asp:RequiredFieldValidator ID="rfvProjectName" runat="server" 
                                                ControlToValidate="PROJECT_NAMETextBox" ErrorMessage="Project name is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-12">
                                            <label for="PROJECT_DESCRIPTIONTextBox" class="form-label">Description:</label>
                                            <asp:TextBox ID="PROJECT_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("PROJECT_DESCRIPTION") %>'
                                                CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter project description" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="PROJECT_START_DATETextBox" class="form-label">Start Date:</label>
                                            <asp:TextBox ID="PROJECT_START_DATETextBox" runat="server" Text='<%# Bind("PROJECT_START_DATE", "{0:yyyy-MM-dd}") %>'
                                                CssClass="form-control" TextMode="Date" />
                                            <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" 
                                                ControlToValidate="PROJECT_START_DATETextBox" ErrorMessage="Start date is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="PROJECT_DUE_DATETextBox" class="form-label">Due Date:</label>
                                            <asp:TextBox ID="PROJECT_DUE_DATETextBox" runat="server" Text='<%# Bind("PROJECT_DUE_DATE", "{0:yyyy-MM-dd}") %>'
                                                CssClass="form-control" TextMode="Date" />
                                            <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" 
                                                ControlToValidate="PROJECT_DUE_DATETextBox" ErrorMessage="Due date is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                            <asp:CompareValidator ID="cvDates" runat="server" 
                                                ControlToValidate="PROJECT_DUE_DATETextBox" 
                                                ControlToCompare="PROJECT_START_DATETextBox" 
                                                Operator="GreaterThanEqual" Type="Date" 
                                                ErrorMessage="Due date must be after start date" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="PROJECT_STATUSDropDown" class="form-label">Status:</label>
                                            <asp:DropDownList ID="PROJECT_STATUSDropDown" runat="server" CssClass="form-select"
                                                SelectedValue='<%# Bind("PROJECT_STATUS") %>'>
                                                <asp:ListItem Text="Not Started" Value="Not Started" />
                                                <asp:ListItem Text="In Progress" Value="In Progress" />
                                                <asp:ListItem Text="Completed" Value="Completed" />
                                                <asp:ListItem Text="On Hold" Value="On Hold" />
                                                <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Save" CssClass="btn btn-success" ValidationGroup="InsertGroup" />
                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary ms-2" />
                                    </div>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                
                                   
                                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Add New Project" CssClass="btn btn-primary" />
                                </ItemTemplate>
                                </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- Project List Section -->
            <div class="row form-section">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Project List
                            </h5>
                            <div class="input-group" style="width: 300px; max-width: 100%;">
                               <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-box" placeholder="Search projects..." />
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-light" OnClick="btnSearch_Click" CausesValidation="false" />
                            </div>
                        </div>
                        <div class="card-body">
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" 
                                    DataKeyNames="PROJECT_ID" DataSourceID="SqlDataSource1" 
                                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                                    CssClass="table table-striped table-hover table-bordered"
                                    BorderWidth="0px" GridLines="None">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                                            ButtonType="Link"
                                            EditText="<i class='bi bi-pencil'></i> Edit" 
                                            UpdateText="<i class='bi bi-check-lg'></i> Update"
                                            CancelText="<i class='bi bi-x-lg'></i> Cancel"
                                            DeleteText="<i class='bi bi-trash'></i> Delete" 
                                            HeaderText="Actions"
                                            ControlStyle-CssClass="btn btn-sm btn-outline-primary m-1" />
                                       <asp:BoundField DataField="PROJECT_ID" HeaderText="ID" ReadOnly="True" SortExpression="PROJECT_ID" />
                                            <asp:BoundField DataField="PROJECT_NAME" HeaderText="Name" SortExpression="PROJECT_NAME" />
                                            <asp:BoundField DataField="PROJECT_DESCRIPTION" HeaderText="Description" SortExpression="PROJECT_DESCRIPTION" />
                                            <asp:BoundField DataField="PROJECT_START_DATE" HeaderText="Start Date" SortExpression="PROJECT_START_DATE" DataFormatString="{0:yyyy-MM-dd}" />
                                            <asp:BoundField DataField="PROJECT_DUE_DATE" HeaderText="Due Date" SortExpression="PROJECT_DUE_DATE" DataFormatString="{0:yyyy-MM-dd}" />
                                            <asp:BoundField DataField="PROJECT_STATUS" HeaderText="Status" SortExpression="PROJECT_STATUS" />
                                    </Columns>
                                </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM &quot;PROJECTS&quot; WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID" InsertCommand="INSERT INTO &quot;PROJECTS&quot; (&quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot;, &quot;PROJECT_DESCRIPTION&quot;, &quot;PROJECT_START_DATE&quot;, &quot;PROJECT_DUE_DATE&quot;, &quot;PROJECT_STATUS&quot;) VALUES (:PROJECT_ID, :PROJECT_NAME, :PROJECT_DESCRIPTION, :PROJECT_START_DATE, :PROJECT_DUE_DATE, :PROJECT_STATUS)" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM &quot;PROJECTS&quot;" UpdateCommand="UPDATE &quot;PROJECTS&quot; SET &quot;PROJECT_NAME&quot; = :PROJECT_NAME, &quot;PROJECT_DESCRIPTION&quot; = :PROJECT_DESCRIPTION, &quot;PROJECT_START_DATE&quot; = :PROJECT_START_DATE, &quot;PROJECT_DUE_DATE&quot; = :PROJECT_DUE_DATE, &quot;PROJECT_STATUS&quot; = :PROJECT_STATUS WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID">
            <DeleteParameters>
                <asp:Parameter Name="PROJECT_ID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="PROJECT_ID" Type="String" />
                <asp:Parameter Name="PROJECT_NAME" Type="String" />
                <asp:Parameter Name="PROJECT_DESCRIPTION" Type="String" />
                <asp:Parameter Name="PROJECT_START_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_STATUS" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="PROJECT_NAME" Type="String" />
                <asp:Parameter Name="PROJECT_DESCRIPTION" Type="String" />
                <asp:Parameter Name="PROJECT_START_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_DUE_DATE" Type="DateTime" />
                <asp:Parameter Name="PROJECT_STATUS" Type="String" />
                <asp:Parameter Name="PROJECT_ID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
