<%@ Page Title="Task Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TaskDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.TaskDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Task Management</h2>
    
    <!-- Toggle Button -->
    <button type="button" id="btnToggleForm" class="btn btn-primary create-button mb-3">
        <i class="bi bi-plus-circle"></i> Create New Task
    </button>
    
    <!-- Task Insert Form Section (Initially Hidden) -->
    <div id="formContainer" class="form-toggle-container" style="display: none;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="TASK_ID" 
            DataSourceID="SqlDataSource1" DefaultMode="Insert" 
            OnPageIndexChanging="FormView1_PageIndexChanging" Width="100%">
            <InsertItemTemplate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="TASK_IDTextBox" class="form-label">Task ID:</label>
                        <asp:TextBox ID="TASK_IDTextBox" runat="server" Text='<%# Bind("TASK_ID") %>'
                            CssClass="form-control" placeholder="Enter Task ID (e.g., T016)" />
                        <asp:RequiredFieldValidator ID="rfvTaskID" runat="server" 
                            ControlToValidate="TASK_IDTextBox" ErrorMessage="Task ID is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="TASK_NAMETextBox" class="form-label">Task Name:</label>
                        <asp:TextBox ID="TASK_NAMETextBox" runat="server" Text='<%# Bind("TASK_NAME") %>'
                            CssClass="form-control" placeholder="Enter task name" />
                        <asp:RequiredFieldValidator ID="rfvTaskName" runat="server" 
                            ControlToValidate="TASK_NAMETextBox" ErrorMessage="Task name is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="TASK_DESCRIPTIONTextBox" class="form-label">Description:</label>
                        <asp:TextBox ID="TASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("TASK_DESCRIPTION") %>'
                            CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter task description" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="TASK_START_DATETextBox" class="form-label">Start Date:</label>
                        <asp:TextBox ID="TASK_START_DATETextBox" runat="server" Text='<%# Bind("TASK_START_DATE", "{0:yyyy-MM-dd}") %>'
                            CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" 
                            ControlToValidate="TASK_START_DATETextBox" ErrorMessage="Start date is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="TASK_DUE_DATETextBox" class="form-label">Due Date:</label>
                        <asp:TextBox ID="TASK_DUE_DATETextBox" runat="server" Text='<%# Bind("TASK_DUE_DATE", "{0:yyyy-MM-dd}") %>'
                            CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" 
                            ControlToValidate="TASK_DUE_DATETextBox" ErrorMessage="Due date is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                        <asp:CompareValidator ID="cvDates" runat="server" 
                            ControlToValidate="TASK_DUE_DATETextBox" 
                            ControlToCompare="TASK_START_DATETextBox" 
                            Operator="GreaterThanEqual" Type="Date" 
                            ErrorMessage="Due date must be after start date" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="TASK_STATUSDropDown" class="form-label">Status:</label>
                        <asp:DropDownList ID="TASK_STATUSDropDown" runat="server" CssClass="form-select"
                            SelectedValue='<%# Bind("TASK_STATUS") %>'>
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
                    CommandName="New" Text="Add New Task" CssClass="btn btn-primary" />
            </ItemTemplate>
        </asp:FormView>
    </div>
    
    <!-- Task List Section -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <h5 class="mb-0">Task List</h5>
            <div class="d-flex">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm me-2"
                        placeholder="Search tasks..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="TASK_ID" DataSourceID="SqlDataSource1"
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
                    <asp:BoundField DataField="TASK_ID" HeaderText="ID" ReadOnly="True" SortExpression="TASK_ID" />
                    <asp:BoundField DataField="TASK_NAME" HeaderText="Task" SortExpression="TASK_NAME" />
                    <asp:BoundField DataField="TASK_START_DATE" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="TASK_START_DATE" />
                    <asp:BoundField DataField="TASK_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="TASK_DUE_DATE" />
                    <asp:TemplateField HeaderText="Status" SortExpression="TASK_STATUS">
                        <ItemTemplate>
                            <span class='badge bg-<%# GetStatusBadgeClass(Eval("TASK_STATUS").ToString()) %>'>
                                <%# Eval("TASK_STATUS") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm"
                                SelectedValue='<%# Bind("TASK_STATUS") %>'>
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
                    <div class="alert alert-info m-3">No tasks found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;TASK&quot; WHERE &quot;TASK_ID&quot; = :TASK_ID" 
        InsertCommand="INSERT INTO &quot;TASK&quot; (&quot;TASK_ID&quot;, &quot;TASK_NAME&quot;, &quot;TASK_DESCRIPTION&quot;, &quot;TASK_STATUS&quot;, &quot;TASK_START_DATE&quot;, &quot;TASK_DUE_DATE&quot;) VALUES (:TASK_ID, :TASK_NAME, :TASK_DESCRIPTION, :TASK_STATUS, :TASK_START_DATE, :TASK_DUE_DATE)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT * FROM &quot;TASK&quot;" 
        UpdateCommand="UPDATE &quot;TASK&quot; SET &quot;TASK_NAME&quot; = :TASK_NAME, &quot;TASK_DESCRIPTION&quot; = :TASK_DESCRIPTION, &quot;TASK_STATUS&quot; = :TASK_STATUS, &quot;TASK_START_DATE&quot; = :TASK_START_DATE, &quot;TASK_DUE_DATE&quot; = :TASK_DUE_DATE WHERE &quot;TASK_ID&quot; = :TASK_ID">
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
    
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this task?");
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
            document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-plus-circle"></i> Create New Task';
            return false;
        }
    </script>
</asp:Content>