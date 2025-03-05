<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="ProjectManagementSystem.UserDetails" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons (if you want to keep the icons for Edit/Delete/Update/Cancel) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

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
        /* Make the search box fill available space */
        .search-box {
            width: 100%;
        }
    </style>

    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this user?");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="#">Project Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" href="UserDetails.aspx">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ProjectDetails.aspx">Projects</a>
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
            <h2 class="page-title">User Details</h2>
            
            <!-- User Insert Form Section -->
            <div class="row form-section">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Add New User</h5>
                        </div>
                        <div class="card-body">
                            <asp:FormView ID="FormView1" runat="server" DataKeyNames="USER_ID" 
                                DataSourceID="SqlDataSource1" DefaultMode="Insert" 
                                OnPageIndexChanging="FormView1_PageIndexChanging" Width="100%">
                                <InsertItemTemplate>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="USER_IDTextBox" class="form-label">User ID:</label>
                                            <asp:TextBox ID="USER_IDTextBox" runat="server" Text='<%# Bind("USER_ID") %>'
                                                CssClass="form-control" placeholder="Enter User ID (e.g., U016)" />
                                            <asp:RequiredFieldValidator ID="rfvUserID" runat="server" 
                                                ControlToValidate="USER_IDTextBox" ErrorMessage="User ID is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="USER_NAMETextBox" class="form-label">Name:</label>
                                            <asp:TextBox ID="USER_NAMETextBox" runat="server" Text='<%# Bind("USER_NAME") %>'
                                                CssClass="form-control" placeholder="Enter user's full name" />
                                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                                                ControlToValidate="USER_NAMETextBox" ErrorMessage="Name is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="USER_EMAILTextBox" class="form-label">Email:</label>
                                            <asp:TextBox ID="USER_EMAILTextBox" runat="server" Text='<%# Bind("USER_EMAIL") %>'
                                                CssClass="form-control" placeholder="email@example.com" />
                                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                                ControlToValidate="USER_EMAILTextBox" ErrorMessage="Email is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                                ControlToValidate="USER_EMAILTextBox" 
                                                ErrorMessage="Please enter a valid email address" 
                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                                        </div>
                                        <div class="col-md-6">
                                            <label for="USER_CONTACT_NOTextBox" class="form-label">Contact Number:</label>
                                            <asp:TextBox ID="USER_CONTACT_NOTextBox" runat="server" Text='<%# Bind("USER_CONTACT_NO") %>'
                                                CssClass="form-control" placeholder="Phone number" />
                                            <asp:RequiredFieldValidator ID="rfvContact" runat="server" 
                                                ControlToValidate="USER_CONTACT_NOTextBox" ErrorMessage="Contact number is required" 
                                                Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
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
                                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                                        CommandName="New" Text="Add New User" CssClass="btn btn-primary" />
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- User List Section -->
            <div class="row form-section">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">User List</h5>
                            <!-- Normal search bar -->
                            <div class="input-group w-100">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-box"
                                             placeholder="Search users..." />
                                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                            CssClass="btn btn-outline-secondary" 
                                            OnClick="btnSearch_Click" CausesValidation="false" />
                            </div>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="USER_ID" DataSourceID="SqlDataSource1"
                                CssClass="table table-striped table-hover table-bordered"
                                BorderWidth="0px" GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" 
                                                CssClass="edit-btn" CausesValidation="false">
                                                <i class="bi bi-pencil"></i> Edit
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                                                CssClass="delete-btn" OnClientClick="return confirmDelete();" 
                                                CausesValidation="false">
                                                <i class="bi bi-trash"></i> Delete
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                                                CssClass="edit-btn" CausesValidation="false">
                                                <i class="bi bi-check-lg"></i> Update
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                                CssClass="delete-btn" CausesValidation="false">
                                                <i class="bi bi-x-lg"></i> Cancel
                                            </asp:LinkButton>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="USER_ID" HeaderText="ID" ReadOnly="True" SortExpression="USER_ID" />
                                    <asp:BoundField DataField="USER_NAME" HeaderText="Name" SortExpression="USER_NAME" />
                                    <asp:BoundField DataField="USER_EMAIL" HeaderText="Email" SortExpression="USER_EMAIL" />
                                    <asp:BoundField DataField="USER_CONTACT_NO" HeaderText="Contact No" SortExpression="USER_CONTACT_NO" />
                                </Columns>
                                <HeaderStyle CssClass="table-dark" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-info">No users found.</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
            DeleteCommand="DELETE FROM &quot;USERS&quot; WHERE &quot;USER_ID&quot; = :USER_ID" 
            InsertCommand="INSERT INTO &quot;USERS&quot; (&quot;USER_ID&quot;, &quot;USER_NAME&quot;, &quot;USER_EMAIL&quot;, &quot;USER_CONTACT_NO&quot;) VALUES (:USER_ID, :USER_NAME, :USER_EMAIL, :USER_CONTACT_NO)" 
            ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
            SelectCommand="SELECT * FROM &quot;USERS&quot;" 
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
            <UpdateParameters>
                <asp:Parameter Name="USER_NAME" Type="String" />
                <asp:Parameter Name="USER_EMAIL" Type="String" />
                <asp:Parameter Name="USER_CONTACT_NO" Type="String" />
                <asp:Parameter Name="USER_ID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
