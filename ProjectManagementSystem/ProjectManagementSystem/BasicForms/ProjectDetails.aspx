<%@ Page Title="Project Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.ProjectDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Project Management</h2>
    
    <!-- Toggle Button -->
    <button type="button" id="btnToggleForm" class="btn btn-primary create-button mb-3">
        <i class="bi bi-plus-circle"></i> Create New Project
    </button>
    
    <!-- Project Insert Form Section (Initially Hidden) -->
    <div id="formContainer" class="form-toggle-container" style="display: none;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="PROJECT_ID" 
            DataSourceID="SqlDataSource1" DefaultMode="Insert" 
            OnPageIndexChanging="FormView1_PageIndexChanging" Width="100%">
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
                        CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary ms-2" OnClientClick="hideForm(); return false;" />
                </div>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="Add New Project" CssClass="btn btn-primary" />
            </ItemTemplate>
        </asp:FormView>
    </div>
    
    <!-- Project List Section -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <h5 class="mb-0">Project List</h5>
            <div class="d-flex">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm me-2"
                        placeholder="Search projects..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="PROJECT_ID" DataSourceID="SqlDataSource1"
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
                    <asp:BoundField DataField="PROJECT_ID" HeaderText="ID" ReadOnly="True" SortExpression="PROJECT_ID" />
                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project" SortExpression="PROJECT_NAME" />
                    <asp:BoundField DataField="PROJECT_START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="PROJECT_START_DATE" />
                    <asp:BoundField DataField="PROJECT_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="PROJECT_DUE_DATE" />
                    <asp:TemplateField HeaderText="Status" SortExpression="PROJECT_STATUS">
                        <ItemTemplate>
                            <span class='badge bg-<%# GetStatusBadgeClass(Eval("PROJECT_STATUS").ToString()) %>'>
                                <%# Eval("PROJECT_STATUS") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm"
                                SelectedValue='<%# Bind("PROJECT_STATUS") %>'>
                                <asp:ListItem Text="Not Started" Value="Not Started" />
                                <asp:ListItem Text="In Progress" Value="In Progress" />
                                <asp:ListItem Text="Completed" Value="Completed" />
                                <asp:ListItem Text="On Hold" Value="On Hold" />
                                <asp:ListItem Text="Cancelled" Value="Cancelled" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="GridViewHeader" />
                <PagerStyle CssClass="pagination-container" HorizontalAlign="Center" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No projects found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;PROJECTS&quot; WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID" 
        InsertCommand="INSERT INTO &quot;PROJECTS&quot; (&quot;PROJECT_ID&quot;, &quot;PROJECT_NAME&quot;, &quot;PROJECT_DESCRIPTION&quot;, &quot;PROJECT_START_DATE&quot;, &quot;PROJECT_DUE_DATE&quot;, &quot;PROJECT_STATUS&quot;) VALUES (:PROJECT_ID, :PROJECT_NAME, :PROJECT_DESCRIPTION, :PROJECT_START_DATE, :PROJECT_DUE_DATE, :PROJECT_STATUS)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT * FROM &quot;PROJECTS&quot;" 
        UpdateCommand="UPDATE &quot;PROJECTS&quot; SET &quot;PROJECT_NAME&quot; = :PROJECT_NAME, &quot;PROJECT_DESCRIPTION&quot; = :PROJECT_DESCRIPTION, &quot;PROJECT_START_DATE&quot; = :PROJECT_START_DATE, &quot;PROJECT_DUE_DATE&quot; = :PROJECT_DUE_DATE, &quot;PROJECT_STATUS&quot; = :PROJECT_STATUS WHERE &quot;PROJECT_ID&quot; = :PROJECT_ID">
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
    
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this project?");
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
            document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-plus-circle"></i> Create New Project';
            return false;
        }
    </script>
</asp:Content>