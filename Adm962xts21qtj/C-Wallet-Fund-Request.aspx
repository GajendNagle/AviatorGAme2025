<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" CodeFile="C-Wallet-Fund-Request.aspx.cs" Inherits="Adm962xts21qtj_C_Wallet_Fund_Request" StylesheetTheme="MySkin" Title="C Wallet Fund Request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #divPrint {
            width: 100%;
            overflow-x: scroll;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 col-12">
                <div class="col-12 mb-2">
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClientClick="redirectToHandler(); return false;" CssClass="float-sm-end">Transfer Deposit Fund</asp:LinkButton>
                </div>
            </div>
            <div class="col-md-6 col-12">
                <div class="flex-img-link-wrapper">
                    <div class="flex-img-link-in">
                        <span>
                            <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="Uparmenu" OnClientClick="return CallPrint('divPrint')">Print</asp:LinkButton>
                        </span>
                        <span>
                            <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="Uparmenu" OnClick="btnexporttoexport_Click">Export to Excel</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>Date Type</label>
                    <asp:DropDownList ID="ddldttTyp" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>Show Results By</label>
                    <asp:DropDownList ID="ddl_IncType" runat="server" CssClass="form-control" OnSelectedIndexChanged="ColumnFilterChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12" id="detsdv" runat="server">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="form-control blnk-input" Visible="false"></asp:DropDownList>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control blnk-input" Visible="false" Text=""></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <div class="pgsizes">
                    <a href="ConfirmTxnStatus.aspx?secret=535347VTR5u1&block=Invest" target="_blank" style="font-size: 14px; line-height: 47px;">#Update Invest Status#</a>
                </div>
            </div>
            <div class="col-md-6 col-12">
                <div class="pgsizes">
                    <%--<%=PageNo%>
                    -
                    <%=Pagesize %>
                    of &nbsp;--%>
                    <asp:Label ID="lblRecordNo" runat="server" Font-Bold="True"></asp:Label>
                    &nbsp;
                    <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>
                    &nbsp;
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-md-12 col-12">
            <asp:Label ID="lblTotalSum" runat="server" Font-Bold="True" ForeColor="#FF0000"></asp:Label>
            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
        </div>
        <div class="">
            <div id="divPrint">
                <asp:GridView ID="gvinvoiceno" runat="server" BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowPaging="True" OnPageIndexChanging="gvinvoiceno_PageIndexChanging" PageSize="100" ShowFooter="True" Width="100%" AutoGenerateColumns="False">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                                .
                            </ItemTemplate>
                            <ControlStyle Width="100px" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "MNAME")%>
                                <br />
                                <b><%# DataBinder.Eval(Container.DataItem, "USERID")%></b>
                                <%--<br />
                                <a href='AdminApproveCWalletFundReq.aspx?ID=<%# Eval("TBLID") %>' onclick="NewWindow(this.href,'MList','600','540','yes','center');return false" onfocus="this.blur()">Edit</a>--%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payment ID">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "PAYMENTID")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Transaction Has/Receiver BTC/Sender BTC">
                            <ItemTemplate>
                                <%--<a style="color:Blue;" target="_blank"  href="https://blockchain.info/tx/<%# DataBinder.Eval(Container.DataItem, "TXNHAS")%>"><%# DataBinder.Eval(Container.DataItem, "TXNHAS")%></a>--%>
                                <span><%# DataBinder.Eval(Container.DataItem, "TXNHAS")%></span>
                                <%--<br />
                                <b>Receiver BTC-</b><%# DataBinder.Eval(Container.DataItem, "RECEIVERBTC")%>
                                <br />
                                <b>Sender BTC-</b><%# DataBinder.Eval(Container.DataItem, "SENDERBTC")%>--%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Paid Amt">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "AMOUNT")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Req Amt">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "PLANAMOUNT")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "STATUS")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Req Type">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "REQUEST_TYPE")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pay Date">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "PAYMENTDT")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Req Date">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "REQUESTDT")%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
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
    <script type="text/javascript">
        function redirectToHandler() {
            var handlerUrl = '../Jap762Btp28lyf/Handlers/Transfer_Deposit_Fund.ashx';
            window.open(handlerUrl, '_blank');
        }
    </script>
</asp:Content>
