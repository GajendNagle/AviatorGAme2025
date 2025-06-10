<%@ Page Title="" Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="MySkin" CodeFile="Win-Wallet-Txn-History.aspx.cs" Inherits="Adm962xts21qtj_Win_Wallet_Txn_History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="flex-img-link-wrapper">
                    <div class="flex-img-link-in">
                        <span>
                            <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="Uparmenu" OnClientClick="return CallPrint('divPrint')">Print</asp:LinkButton>
                        </span>
                        <span>
                            <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="Uparmenu" OnClick="btnexporttoexport_Click">Export to Excel</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date </label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" AutoComplete="off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date </label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" AutoComplete="off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Income Type </label>
                    <asp:DropDownList ID="ddl_IncType" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Show Results By  </label>
                    <asp:DropDownList ID="DDLSrchByDjGt" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DDLSrchByDjGt_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12" id="detsdv" runat="server">
                <div class=" form-group">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="form-control blnk-input" Visible="false"></asp:DropDownList>
                    <asp:TextBox ID="txtSearch" runat="server" Visible="false" Text="" CssClass="form-control blnk-input" AutoComplete="off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnSearch" runat="server" Text="GO" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <asp:Label ID="lblTotalSum" CssClass="total-record" runat="server" Font-Bold="True" ForeColor="#FF0000"></asp:Label>
            </div>
            <div class="col-md-6 col-12">
                <div class="pgsizes">
                    <span>
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div id="divPrint">
                    <asp:GridView ID="gvinvoiceno" runat="server" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="USERID" AllowPaging="True" OnPageIndexChanging="gvinvoiceno_PageIndexChanging" PageSize="100" ShowFooter="True" Width="100%" OnRowDataBound="gvinvoiceno_RowDataBound">
                        <Columns>
                            <%--<asp:TemplateField HeaderText="SNO.">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "id")%>
                                    <%# Container.DataItemIndex+1 %>
                                    .
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtFromDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
        $(function () {

            $("#<%=txtToDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
    </script>
    <script language="javascript" type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,right=0,top=0,width=790,height=2000,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            prtContent.innerHTML = strOldOne;
        }
    </script>
</asp:Content>