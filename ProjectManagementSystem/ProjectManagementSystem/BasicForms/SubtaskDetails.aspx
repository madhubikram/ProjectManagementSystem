<%@ Page Title="Subtask Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubtaskDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.SubtaskDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Subtask Management</h2>
    
    <!-- Toggle Button -->
    <button type="button" id="btnToggleForm" class="btn btn-primary create-button mb-3">
        <i class="bi bi-plus-circle"></i> Create New Subtask
    </button>
    
    <!-- Subtask Insert Form Section (Initially Hidden) -->
    <div id="formContainer" class="form-toggle-container" style="display: none;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="SUBTASK_ID" 
            DataSourceID="SqlDataSource1" DefaultMode="Insert" Width="100%">
            <InsertItemTemplate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="SUBTASK_IDTextBox" class="form-label">Subtask ID:</label>
                        <asp:TextBox ID="SUBTASK_IDTextBox" runat="server" Text='<%# Bind("SUBTASK_ID") %>'
                            CssClass="form-control" placeholder="Enter Subtask ID (e.g., S016)" />
                        <asp:RequiredFieldValidator ID="rfvSubtaskID" runat="server" 
                            ControlToValidate="SUBTASK_IDTextBox" ErrorMessage="Subtask ID is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="SUBTASK_TITLETextBox" class="form-label">Subtask Title:</label>
                        <asp:TextBox ID="SUBTASK_TITLETextBox" runat="server" Text='<%# Bind("SUBTASK_TITLE") %>'
                            CssClass="form-control" placeholder="Enter subtask title" />
                        <asp:RequiredFieldValidator ID="rfvSubtaskTitle" runat="server" 
                            ControlToValidate="SUBTASK_TITLETextBox" ErrorMessage="Subtask title is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="SUBTASK_DESCRIPTIONTextBox" class="form-label">Description:</label>
                        <asp:TextBox ID="SUBTASK_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("SUBTASK_DESCRIPTION") %>'
                            CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter subtask description" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="DUE_DATETextBox" class="form-label">Due Date:</label>
                        <asp:TextBox ID="DUE_DATETextBox" runat="server" Text='<%# Bind("DUE_DATE", "{0:yyyy-MM-dd}") %>'
                            CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" 
                            ControlToValidate="DUE_DATETextBox" ErrorMessage="Due date is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="SUBTASK_STATUSDropDown" class="form-label">Status:</label>
                        <asp:DropDownList ID="SUBTASK_STATUSDropDown" runat="server" CssClass="form-select"
                            SelectedValue='<%# Bind("SUBTASK_STATUS") %>'>
                            <asp:ListItem Text="Not Started" Value="Not Started" />
                            <asp:ListItem Text="In Progress" Value="In Progress" />
                            <asp:ListItem Text="Completed" Value="Completed" />
                            <asp:ListItem Text="On Hold" Value="On Hold" />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="DropDownList1" class="form-label">Parent Task:</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" 
                            DataTextField="TASK_NAME" DataValueField="TASK_ID" CssClass="form-select"
                            SelectedValue='<%# Bind("TASK_ID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
                            ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
                            SelectCommand="SELECT &quot;TASK_ID&quot;, &quot;TASK_NAME&quot; FROM &quot;TASK&quot;">
                        </asp:SqlDataSource>
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
                    CommandName="New" Text="Add New Subtask" CssClass="btn btn-primary" />
            </ItemTemplate>
        </asp:FormView>
    </div>
    
    <!-- Subtask List Section -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <h5 class="mb-0">Subtask List</h5>
            <div class="d-flex">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm me-2"
                        placeholder="Search subtasks..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="SUBTASK_ID" DataSourceID="SqlDataSource1"
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
                    <asp:BoundField DataField="SUBTASK_ID" HeaderText="ID" ReadOnly="True" SortExpression="SUBTASK_ID" />
                    <asp:BoundField DataField="SUBTASK_TITLE" HeaderText="Title" SortExpression="SUBTASK_TITLE" />
                    <asp:BoundField DataField="DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="DUE_DATE" />
                    <asp:TemplateField HeaderText="Status" SortExpression="SUBTASK_STATUS">
                        <ItemTemplate>
                            <span class='badge bg-<%# GetStatusBadgeClass(Eval("SUBTASK_STATUS").ToString()) %>'>
                                <%# Eval("SUBTASK_STATUS") %>
                            </span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm"
                                SelectedValue='<%# Bind("SUBTASK_STATUS") %>'>
                                <asp:ListItem Text="Not Started" Value="Not Started" />
                                <asp:ListItem Text="In Progress" Value="In Progress" />
                                <asp:ListItem Text="Completed" Value="Completed" />
                                <asp:ListItem Text="On Hold" Value="On Hold" />
                                <asp:ListItem Text="Cancelled" Value="Cancelled" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Parent Task" SortExpression="TASK_ID">
                        <ItemTemplate>
                            <asp:DropDownList Enabled="false" ID="DropDownList2" runat="server" DataSourceID="sdsTaskNames" DataTextField="TASK_NAME" DataValueField="TASK_ID" SelectedValue='<%# Bind("TASK_ID") %>' CssClass="form-select form-select-sm">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTaskNames" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;TASK_NAME&quot;, &quot;TASK_ID&quot; FROM &quot;TASK&quot;"></asp:SqlDataSource>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="sdsTaskNames" DataTextField="TASK_NAME" DataValueField="TASK_ID" SelectedValue='<%# Bind("TASK_ID") %>' CssClass="form-select form-select-sm">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTaskNames" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" SelectCommand="SELECT &quot;TASK_NAME&quot;, &quot;TASK_ID&quot; FROM &quot;TASK&quot;"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="GridViewHeader" />
                <PagerStyle CssClass="pagination-container" HorizontalAlign="Center" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No subtasks found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;SUB_TASK&quot; WHERE &quot;SUBTASK_ID&quot; = :SUBTASK_ID" 
        InsertCommand="INSERT INTO &quot;SUB_TASK&quot; (&quot;SUBTASK_ID&quot;, &quot;SUBTASK_TITLE&quot;, &quot;SUBTASK_STATUS&quot;, &quot;DUE_DATE&quot;, &quot;SUBTASK_DESCRIPTION&quot;, &quot;TASK_ID&quot;) VALUES (:SUBTASK_ID, :SUBTASK_TITLE, :SUBTASK_STATUS, :DUE_DATE, :SUBTASK_DESCRIPTION, :TASK_ID)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT * FROM &quot;SUB_TASK&quot;" 
        UpdateCommand="UPDATE &quot;SUB_TASK&quot; SET &quot;SUBTASK_TITLE&quot; = :SUBTASK_TITLE, &quot;SUBTASK_STATUS&quot; = :SUBTASK_STATUS, &quot;DUE_DATE&quot; = :DUE_DATE, &quot;SUBTASK_DESCRIPTION&quot; = :SUBTASK_DESCRIPTION, &quot;TASK_ID&quot; = :TASK_ID WHERE &quot;SUBTASK_ID&quot; = :SUBTASK_ID">
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
    
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this subtask?");
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
            document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-plus-circle"></i> Create New Subtask';
            return false;
        }
    </script>
</asp:Content>