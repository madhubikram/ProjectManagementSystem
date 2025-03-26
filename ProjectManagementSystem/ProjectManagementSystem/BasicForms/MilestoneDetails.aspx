<%@ Page Title="Milestone Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MilestoneDetails.aspx.cs" Inherits="ProjectManagementSystem.BasicForms.MilestoneDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-4">Milestone Management</h2>
    
    <!-- Toggle Button -->
    <button type="button" id="btnToggleForm" class="btn btn-primary create-button mb-3">
        <i class="bi bi-plus-circle"></i> Create New Milestone
    </button>
    
    <!-- Milestone Insert Form Section (Initially Hidden) -->
    <div id="formContainer" class="form-toggle-container" style="display: none;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="MILESTONE_ID" 
            DataSourceID="SqlDataSource1" DefaultMode="Insert" Width="100%">
            <InsertItemTemplate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="MILESTONE_IDTextBox" class="form-label">Milestone ID:</label>
                        <asp:TextBox ID="MILESTONE_IDTextBox" runat="server" Text='<%# Bind("MILESTONE_ID") %>'
                            CssClass="form-control" placeholder="Enter Milestone ID (e.g., M016)" />
                        <asp:RequiredFieldValidator ID="rfvMilestoneID" runat="server" 
                            ControlToValidate="MILESTONE_IDTextBox" ErrorMessage="Milestone ID is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="MILESTONE_TITLETextBox" class="form-label">Milestone Title:</label>
                        <asp:TextBox ID="MILESTONE_TITLETextBox" runat="server" Text='<%# Bind("MILESTONE_TITLE") %>'
                            CssClass="form-control" placeholder="Enter milestone title" />
                        <asp:RequiredFieldValidator ID="rfvMilestoneTitle" runat="server" 
                            ControlToValidate="MILESTONE_TITLETextBox" ErrorMessage="Milestone title is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-12">
                        <label for="MILESTONE_DESCRIPTIONTextBox" class="form-label">Description:</label>
                        <asp:TextBox ID="MILESTONE_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("MILESTONE_DESCRIPTION") %>'
                            CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter milestone description" />
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="MILESTONE_DUE_DATETextBox" class="form-label">Due Date:</label>
                        <asp:TextBox ID="MILESTONE_DUE_DATETextBox" runat="server" Text='<%# Bind("MILESTONE_DUE_DATE", "{0:yyyy-MM-dd}") %>'
                            CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" 
                            ControlToValidate="MILESTONE_DUE_DATETextBox" ErrorMessage="Due date is required" 
                            Display="Dynamic" CssClass="text-danger" ValidationGroup="InsertGroup" />
                    </div>
                    <div class="col-md-6">
                        <label for="DropDownList1" class="form-label">Project:</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" 
                            DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID" CssClass="form-select"
                            SelectedValue='<%# Bind("PROJECT_ID") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
                            ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
                            SelectCommand='SELECT "PROJECT_ID", "PROJECT_NAME" FROM "PROJECTS"'>
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
                    CommandName="New" Text="Add New Milestone" CssClass="btn btn-primary" />
            </ItemTemplate>
        </asp:FormView>
    </div>
    
    <!-- Milestone List Section -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center bg-dark text-white">
            <h5 class="mb-0">Milestone List</h5>
            <div class="d-flex">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm me-2"
                        placeholder="Search milestones..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                        CssClass="btn btn-outline-light btn-sm" 
                        OnClick="btnSearch_Click" CausesValidation="false" />
            </div>
        </div>
        <div class="card-body p-0">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="MILESTONE_ID" DataSourceID="SqlDataSource1"
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
                    <asp:BoundField DataField="MILESTONE_ID" HeaderText="ID" ReadOnly="True" SortExpression="MILESTONE_ID" />
                    <asp:BoundField DataField="MILESTONE_TITLE" HeaderText="Title" SortExpression="MILESTONE_TITLE" />
                    <asp:BoundField DataField="MILESTONE_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="MILESTONE_DUE_DATE" />
                    <asp:TemplateField HeaderText="Description" SortExpression="MILESTONE_DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" 
                                Text='<%# Eval("MILESTONE_DESCRIPTION").ToString().Length > 50 ? Eval("MILESTONE_DESCRIPTION").ToString().Substring(0, 50) + "..." : Eval("MILESTONE_DESCRIPTION") %>'>
                            </asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescriptionEdit" runat="server" 
                                Text='<%# Bind("MILESTONE_DESCRIPTION") %>' CssClass="form-control" TextMode="MultiLine" Rows="3">
                            </asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Project" SortExpression="PROJECT_ID">
                        <ItemTemplate>
                            <asp:DropDownList Enabled="false" ID="DropDownList2" runat="server" DataSourceID="sdsProjectNamesItem" 
                                DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID" SelectedValue='<%# Bind("PROJECT_ID") %>' 
                                CssClass="form-select form-select-sm">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsProjectNamesItem" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
                                ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
                                SelectCommand='SELECT "PROJECT_NAME", "PROJECT_ID" FROM "PROJECTS"'>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="sdsProjectNamesEdit" 
                                DataTextField="PROJECT_NAME" DataValueField="PROJECT_ID" SelectedValue='<%# Bind("PROJECT_ID") %>' 
                                CssClass="form-select form-select-sm">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsProjectNamesEdit" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
                                ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
                                SelectCommand='SELECT "PROJECT_NAME", "PROJECT_ID" FROM "PROJECTS"'>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="GridViewHeader" />
                <PagerStyle CssClass="pagination-container" HorizontalAlign="Center" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                <EmptyDataTemplate>
                    <div class="alert alert-info m-3">No milestones found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        DeleteCommand="DELETE FROM &quot;MILESTONES&quot; WHERE &quot;MILESTONE_ID&quot; = :MILESTONE_ID" 
        InsertCommand="INSERT INTO &quot;MILESTONES&quot; (&quot;MILESTONE_ID&quot;, &quot;MILESTONE_TITLE&quot;, &quot;MILESTONE_DESCRIPTION&quot;, &quot;MILESTONE_DUE_DATE&quot;, &quot;PROJECT_ID&quot;) VALUES (:MILESTONE_ID, :MILESTONE_TITLE, :MILESTONE_DESCRIPTION, :MILESTONE_DUE_DATE, :PROJECT_ID)" 
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
        SelectCommand="SELECT * FROM &quot;MILESTONES&quot;" 
        UpdateCommand="UPDATE &quot;MILESTONES&quot; SET &quot;MILESTONE_TITLE&quot; = :MILESTONE_TITLE, &quot;MILESTONE_DESCRIPTION&quot; = :MILESTONE_DESCRIPTION, &quot;MILESTONE_DUE_DATE&quot; = :MILESTONE_DUE_DATE, &quot;PROJECT_ID&quot; = :PROJECT_ID WHERE &quot;MILESTONE_ID&quot; = :MILESTONE_ID">
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
    
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this milestone?");
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
            document.getElementById('btnToggleForm').innerHTML = '<i class="bi bi-plus-circle"></i> Create New Milestone';
            return false;
        }
    </script>
</asp:Content>