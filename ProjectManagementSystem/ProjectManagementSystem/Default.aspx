<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectManagementSystem._Default" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="section-title">Project Management Dashboard</h2>
    
    <!-- Key Metrics -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Active Projects</h5>
                    <h2 class="display-1 mb-0 fw-bold py-3 text-center">
                        <asp:Literal ID="litActiveProjects" runat="server"></asp:Literal>
                    </h2>
                    <p class="card-text mt-auto">Current active projects</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Completed Tasks</h5>
                    <h2 class="display-1 mb-0 fw-bold py-3 text-center">
                        <asp:Literal ID="litCompletedTasks" runat="server"></asp:Literal>
                    </h2>
                    <p class="card-text mt-auto">Tasks completed this month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-dark h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Pending Tasks</h5>
                    <h2 class="display-1 mb-0 fw-bold py-3 text-center">
                        <asp:Literal ID="litPendingTasks" runat="server"></asp:Literal>
                    </h2>
                    <p class="card-text mt-auto">Tasks awaiting completion</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-info text-white h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Team Members</h5>
                    <h2 class="display-1 mb-0 fw-bold py-3 text-center">
                        <asp:Literal ID="litTeamMembers" runat="server"></asp:Literal>
                    </h2>
                    <p class="card-text mt-auto">Active team members</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Project Status Distribution</h5>
                </div>
                <div class="card-body">
                    <asp:Chart ID="ChartProjectStatus" runat="server" DataSourceID="SqlDataSourceProjectStatus" Width="800px" Height="300px" Palette="BrightPastel" CssClass="chart-container">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Pie" XValueMember="PROJECT_STATUS" YValueMembers="Count" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true" Inclination="30" Rotation="30" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Task Status by Project</h5>
                </div>
                <div class="card-body">
                    <asp:Chart ID="ChartTaskStatus" runat="server" DataSourceID="SqlDataSourceTaskStatus" Width="800px" Height="300px" CssClass="chart-container">
                        <Series>
                            <asp:Series Name="Completed" ChartType="Column" XValueMember="PROJECT_NAME" YValueMembers="Completed" Color="Green" />
                            <asp:Series Name="Pending" ChartType="Column" XValueMember="PROJECT_NAME" YValueMembers="Pending" Color="Red" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
        </div>
    </div>
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Upcoming Milestones by Week</h5>
                </div>
                <div class="card-body">
                    <asp:Chart ID="ChartMilestoneDue" runat="server" DataSourceID="SqlDataSourceMilestoneDue" Width="800px" Height="300px" CssClass="chart-container">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Column" XValueMember="Week" YValueMembers="Count" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
        </div>
    </div>

    <!-- Projects and Milestones -->
    <div class="row">
        <!-- Recent Projects -->
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Projects</h5>
                </div>
                <div class="card-body p-0">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-hover mb-0"
                        BorderWidth="0px" GridLines="None" DataSourceID="SqlDataSourceProjects"
                        AllowPaging="True" PageSize="5" 
                        OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project" />
                            <asp:BoundField DataField="PROJECT_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge bg-<%# GetStatusBadgeClass(Eval("PROJECT_STATUS").ToString()) %>'>
                                        <%# Eval("PROJECT_STATUS") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-container bg-light" HorizontalAlign="Center" />
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                        <HeaderStyle CssClass="table-light text-dark" />
                        <EmptyDataTemplate>
                            <div class="alert alert-info m-3">No projects found.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        
        <!-- Upcoming Milestones -->
        <div class="col-md-6">
            <div class="card mb-4">
                <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Upcoming Milestones</h5>
                </div>
                <div class="card-body p-0">
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-hover mb-0"
                        BorderWidth="0px" GridLines="None" DataSourceID="SqlDataSourceMilestones"
                        AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView2_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="MILESTONE_TITLE" HeaderText="Milestone" />
                            <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project" />
                            <asp:BoundField DataField="MILESTONE_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                        </Columns>
                        <PagerStyle CssClass="pagination-container bg-light" HorizontalAlign="Center" />
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                        <HeaderStyle CssClass="table-light text-dark" />
                        <EmptyDataTemplate>
                            <div class="alert alert-info m-3">No upcoming milestones.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Tasks Section -->
    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Tasks</h5>
                </div>
                <div class="card-body p-0">
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-striped table-hover mb-0"
                        BorderWidth="0px" GridLines="None" DataSourceID="SqlDataSourceTasks"
                        AllowPaging="True" PageSize="5"
                        OnPageIndexChanging="GridView3_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="TASK_NAME" HeaderText="Task" />
                            <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project" />
                            <asp:BoundField DataField="TASK_DUE_DATE" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge bg-<%# GetTaskStatusBadgeClass(Eval("TASK_STATUS").ToString()) %>'>
                                        <%# Eval("TASK_STATUS") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-container bg-light" HorizontalAlign="Center" />
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                        <HeaderStyle CssClass="table-light text-dark" />
                        <EmptyDataTemplate>
                            <div class="alert alert-info m-3">No recent tasks.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Data Sources for Charts -->
    <asp:SqlDataSource ID="SqlDataSourceProjectStatus" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT PROJECT_STATUS, COUNT(*) as Count FROM PROJECTS GROUP BY PROJECT_STATUS">
    </asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSourceTaskStatus" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
    ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
    SelectCommand="SELECT p.PROJECT_NAME,
                          SUM(CASE WHEN t.TASK_STATUS = 'Completed' THEN 1 ELSE 0 END) as Completed,
                          SUM(CASE WHEN t.TASK_STATUS IN ('Not Started', 'In Progress', 'On Hold') THEN 1 ELSE 0 END) as Pending
                   FROM (
                       SELECT DISTINCT project_id, task_id
                       FROM user_project_task
                   ) dt
                   JOIN TASK t ON dt.task_id = t.task_id
                   JOIN PROJECTS p ON dt.project_id = p.project_id
                   GROUP BY p.PROJECT_NAME">
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSourceMilestoneDue" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
    ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
    SelectCommand="SELECT TO_CHAR(m.MILESTONE_DUE_DATE, 'IYYY IW') as Week,
                          COUNT(*) as Count
                   FROM MILESTONES m
                   WHERE m.MILESTONE_DUE_DATE >= TO_DATE('2024-01-01', 'YYYY-MM-DD')
                   GROUP BY TO_CHAR(m.MILESTONE_DUE_DATE, 'IYYY IW')
                   ORDER BY Week">
</asp:SqlDataSource>

    <!-- Existing Data Sources -->
    <asp:SqlDataSource ID="SqlDataSourceProjects" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT project_id, project_name, project_due_date, project_status FROM projects ORDER BY project_start_date DESC">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceMilestones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT m.milestone_id, m.milestone_title, m.milestone_due_date, p.project_name 
                       FROM milestones m, projects p 
                       WHERE m.project_id = p.project_id 
                       ORDER BY m.milestone_due_date ASC">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceTasks" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT t.task_id, t.task_name, t.task_status, t.task_due_date, p.project_name 
                       FROM task t, projects p, user_project_task upt
                       WHERE t.task_id = upt.task_id AND p.project_id = upt.project_id
                       ORDER BY t.task_start_date DESC">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceActiveProjects" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT project_id FROM projects WHERE project_status = 'In Progress'">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceCompletedTasks" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT task_id FROM task WHERE task_status = 'Completed'">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourcePendingTasks" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT task_id FROM task WHERE task_status IN ('Not Started', 'In Progress', 'On Hold')">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceTeamMembers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
        SelectCommand="SELECT user_id FROM users">
    </asp:SqlDataSource>
</asp:Content>