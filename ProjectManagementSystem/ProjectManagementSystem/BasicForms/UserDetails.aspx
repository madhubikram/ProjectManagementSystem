<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.UserDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">User Management</h2>
    
    <!-- Toggle Button -->
    <button type="button" id="btnToggleForm" class="btn btn-primary create-button mb-3">
        <i class="bi bi-plus-circle"></i> Create New User
    </button>
    
    <!-- User Insert Form Section (Initially Hidden) -->
    <div id="formContainer" class="form-toggle-container" style="display: none;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="USER_ID" 
            DataSourceID="SqlDataSource1" DefaultMode="Insert" 
            OnPageIndexChanging="FormView1_PageIndexChanging" Width="100%">
            <InsertItemTemplate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="USER_IDTextBox" class="form-label">ID:</label>
                        <asp:TextBox ID="USER_IDTextBox" runat="server" Text='<%# Bind("USER_ID") %>'
                            CssClass="form-control" placeholder="User ID (e.g., U016)" />
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
                        CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClientClick="hideForm(); return false;" />
                </div>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="Add New User" CssClass="btn btn-primary" />
            </ItemTemplate>
        </asp:FormView>
    </div>
    
    <!-- User List Section -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <h5 class="mb-0">User List</h5>
            <div class="d-flex">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm me-2"
                        placeholder="Search users..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="USER_ID" DataSourceID="SqlDataSource1"
                CssClass="table table-striped table-hover mb-0"
                BorderWidth="0px" GridLines="None"
                AllowPaging="true" PageSize="10"
                OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="btn-group">
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" 
                                    CssClass="btn btn-sm btn-outline-primary" CausesValidation="false">
                                    <i class="bi bi-pencil"></i> Edit
                                </asp:LinkButton>
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" 
                                    CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirmDelete();" 
                                    CausesValidation="false">
                                    <i class="bi bi-trash"></i> Delete
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div class="btn-group">
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" 
                                    CssClass="btn btn-sm btn-outline-success" CausesValidation="false">
                                    <i class="bi bi-check-lg"></i> Update
                                </asp:LinkButton>
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" 
                                    CssClass="btn btn-sm btn-outline-secondary" CausesValidation="false">
                                    <i class="bi bi-x-lg"></i> Cancel
                                </asp:LinkButton>
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="USER_ID" HeaderText="ID" ReadOnly="True" SortExpression="USER_ID" />
                    <asp:BoundField DataField="USER_NAME" HeaderText="Name" SortExpression="USER_NAME" />
                    <asp:BoundField DataField="USER_EMAIL" HeaderText="Email" SortExpression="USER_EMAIL" />
                    <asp:BoundField DataField="USER_CONTACT_NO" HeaderText="Contact No" SortExpression="USER_CONTACT_NO" />
                </Columns>
                <HeaderStyle CssClass="GridViewHeader" />
                <PagerStyle CssClass="pagination-container" HorizontalAlign="Center" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No users found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
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
    
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this user?");
        }

        // Form toggle functionality
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('btnToggleForm').addEventListener('click', function () {
                toggleForm();
            });
        });

        function toggleForm() {
            var formContainer = document.getElementById('formContainer');
            if (formContainer.style.display === 'none') {
                formContainer.style.display = 'block';
                document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-dash-circle"></i> Hide Form';
            } else {
                hideForm();
            }
        }

        function hideForm() {
            document.getElementById('formContainer').style.display = 'none';
            document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-plus-circle"></i> Create New User';
            return false;
        }
    </script>
</asp:Content>