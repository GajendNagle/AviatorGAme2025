<%@ Page Title="" Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" AutoEventWireup="true" CodeFile="Admin-Login-History.aspx.cs" Inherits="Adm962xts21qtj_Admin_Login_History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 col-12">
                <label>From Date:</label>
                <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" CssClass="ComposeTxtBx" AutoComplete="Off" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2 col-12">
                <label>To Date:</label>
                <asp:TextBox ID="txtToDate" runat="server" CssClass="ComposeTxtBx" MaxLength="12" Font-Overline="False" AutoComplete="Off" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2 col-12">
                <label>Select One:</label>
                <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="ComposeTxtBx">
                    <asp:ListItem Value="ALL">All</asp:ListItem>
                    <asp:ListItem Value="MemID">UserID</asp:ListItem>
                    <asp:ListItem Value="City">City</asp:ListItem>
                    <asp:ListItem Value="State">State</asp:ListItem>
                    <asp:ListItem Value="Country">Country</asp:ListItem>
                    <%--<asp:ListItem Value="LoginDtTime">LoginDtTime</asp:ListItem>--%>
                </asp:DropDownList>
            </div>
            <div class="col-md-2 col-12 mt-2">
                <asp:TextBox ID="txtSearch" runat="server" Text="" MaxLength="30" CssClass="ComposeTxtBx blnk-input" AutoComplete="off"></asp:TextBox>
                <asp:DropDownList ID="DDLFillItems" runat="server" Visible="False" CssClass="ComposeTxtBx blnk-input"></asp:DropDownList>
            </div>
            <div class="col-md-1 col-12 ">
                <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" Text="GO" />
            </div>
            <div class="col-md-3 col-12">
                <div class="pgsizes pt-3">
                    <label class="form-label">Page:</label>
                    &nbsp;
                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx" Width="58px" OnSelectedIndexChanged="PageChanged"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblTotRec" runat="server" CssClass="text-danger"></asp:Label>
                <asp:Label runat="server" ID="Label1" CssClass="text-danger"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div>&nbsp;</div>
        <div id="divPrint" style="width: 100%;">
            <asp:GridView ID="grdUserDtl" AutoGenerateColumns="false" runat="server" PagerSettings-Visible="false" PageSize="100" ShowFooter="True" Width="100%" DataKeyNames="MemID">
                <Columns>
                    <asp:TemplateField HeaderText="SNO.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                            .
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="CBDeleteAll" runat="server" onclick="checkAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CBDelete" runat="server" />
                            <asp:Label ID="lb" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "ID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MemID">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("MemID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="IPAddress">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("IPAddress") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LoginDtTime">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("LoginDtTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BrowserUsed">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("BrowserUsed") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="State">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("State") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Country") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <span style="font: Bold 13px verdana; color: Red; padding: 20px;">---!!! Ooops, Search Record Details Not Found !!!---</span>
                </EmptyDataTemplate>
                <PagerSettings Visible="False" />
                <RowStyle Height="30px" HorizontalAlign="Center" />
                <HeaderStyle Height="30px" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
        <div>&nbsp;</div>
    </div>
    <div class="row">
        <div class="pull-left">
            <asp:Button runat="server" ID="BtnDelete" CssClass="OuterBtn blnk-input delete-btn" OnClientClick="if ( ! UserDeleteConfirmation()) return false;" OnClick="BtnDelete_Click" Text="DELETE" />
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtFromDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        $(function () {
            $("#<%=txtToDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
    <script type="text/javascript">  
        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        inputList[i].checked = true;
                    }
                    else {
                        inputList[i].checked = false;
                    }
                }
            }
        }
        function UserDeleteConfirmation() {
            var checkedCheckBox = false;
            var dataGrid = document.getElementById("<%=grdUserDtl.ClientID %>");
            var inputList = dataGrid.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && inputList[i].checked == true) {
                    checkedCheckBox = true;
                }
            }
            if (checkedCheckBox == true) {
                return confirm("Are you sure you want to delete?");
            }
            else {
                alert('Please select record for delete.');
                return;
            }
        }
    </script>
</asp:Content>
