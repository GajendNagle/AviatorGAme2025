<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="AdminViewFundRequest.aspx.cs" Inherits="ControlSection_AdminViewFundRequest" StylesheetTheme="MySkin" Title="View Fund Request" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #divPrint {
            width: 100%;
            overflow-x: scroll;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="text-right">
                <div class="col-md-6 col-12 text-left">
                    <a href="AdminViewBankCardDetails.aspx?FrmDt=<%=FrmDt%>&ToDt=<%=ToDt%>&strSearchText=<%=strSearchText%>&Pagesize=<%=Pagesize%>&currentPage=<%=cPage%>&ColumnName=<%=ColumnName%>&WthType=<%=WthType %>" onclick="NewWindow(this.href,'MList','1100','600','yes','center');return false">Click for Withdrawal list with Bank ###</a>
                    <%--<a style="margin-left:20px;" href="ConfirmTxnStatus.aspx?secret=Withdrawal" target="_blank">## Confirm Withdraw Txn Status ##</a>--%><br />
                    <br />
                </div>
                <div class="col-md-6 col-12">
                    <div class="flex-img-link-wrapper">
                        <div class="flex-img-link-in">
                            <asp:Label runat="server" ID="Label1" CssClass="text-danger"></asp:Label>
                            <a href="ConfirmTxnStatus.aspx?secret=535347VTR5u1&block=Withdrawal" target="_blank" style="font-size: 14px; line-height: 47px;">## Update Withdrawal Status ##</a>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
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
        </div>
        <div class="row form-wrap">
            <div class="col-md-12 col-12" style="display: none;">
                <div class="form-group">
                    Withdrawal Income Upto:
                    <asp:TextBox ID="txtWithInc" runat="server" Width="100px" MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtWithInc" ValidationGroup="Wth"></asp:RequiredFieldValidator>
                    <asp:Button ID="btnWithInc" runat="server" Text="Withdrawal Now !!" ValidationGroup="Wth" OnClick="btnWithInc_Click" />
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" MaxLength="12" CssClass="form-control" placeholder="DD/MM/YYYY" AutoComplete="Off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:DropDownList ID="DDLTransMode" runat="server" CssClass="form-control blnk-input">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="Withdrawal Request">Withdrawal Request</asp:ListItem>
                        <asp:ListItem Value="Withdrawal Request-Stake">Withdrawal Request-Stake</asp:ListItem>
                        <asp:ListItem Value="Withdrawal Request-WinWallet">Withdrawal Request-WinWallet</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Select One </label>
                    <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="pai.TransID">Transaction ID</asp:ListItem>
                        <asp:ListItem Value="pai.MName">Wallet address</asp:ListItem>
                        <asp:ListItem Value="pai.MemID">Member ID</asp:ListItem>
                        <asp:ListItem Value="pai.Status">Status</asp:ListItem>
                        <asp:ListItem Value="pai.AccType">Payment Mode</asp:ListItem>
                        <asp:ListItem Value="LeaderId">Leader Id</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12" id="detsdv" runat="server">
                <div class="form-group">
                    <asp:TextBox ID="txtSearch" runat="server" Font-Size="11px" MaxLength="50" Text="" CssClass="form-control blnk-input" AutoComplete="off"></asp:TextBox>
                    <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="form-control blnk-input" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="DDLFillItems_SelectedIndexChanged1">
                        <%--<asp:ListItem>PENDING</asp:ListItem>
                        <asp:ListItem>COMPLETED</asp:ListItem>
                        <asp:ListItem>REJECTED</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" Text="GO" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="pgsizes">
                    <span>
                        <%=PageNo%>
                        -
                        <%=Pagesize %>
                        of &nbsp;<asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    &nbsp;
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-md-12 col-12">
            <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="row" id="idChangeSts" runat="server">
            <div class="col-md-2 col-12">
                <asp:DropDownList ID="ddlchangeStatus" runat="server" CssClass="form-control" Visible="true">
                    <asp:ListItem>COMPLETED</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnchangestatus" CssClass="OuterBtn" Width="100%" runat="server" OnClick="btnchangestatus_Click" Text="Change Status" />
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnPayByCapi" runat="server" Width="100%" CssClass="OuterBtn" OnClick="btnPayByCapi_Click" Text="Pay by Crypto API" CausesValidation="false" AutoPostBack="true" />
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnCoinPayment" Visible="false" runat="server" Text="Pay By Payment Gateway" OnClick="btnCoinPayment_Click" Width="100%" />
            </div>
            <div class="col-md-2 col-12">
                <asp:Label ID="lblTrsMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblgvrecord" runat="server" Text=""></asp:Label>
                <div id="divPrint">
                    <asp:GridView ID="grdUserDtl" runat="server" Width="100%" OnRowDataBound="grdUserDtl_RowDataBound" ShowFooter="True" AutoGenerateColumns="False">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex +1  %>.
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkHeader" runat="server" AutoPostBack="true" OnCheckedChanged="chkHeader_CheckedChanged" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Panel ID="Panel71" runat="server" Visible='<%#Eval("Status").Equals("PENDING")?true:false%>'>
                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:Panel ID="Panel781" runat="server" Visible='<%#Eval("Status").Equals("PENDING")?true:false%>'>
                                        <a href='Admin_EditPayOutAmt.aspx?ID=<%# Eval("ID") %>' onclick="NewWindow(this.href,'MList','600','540','yes','center');return false"
                                            onfocus="this.blur()">Edit</a>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Account">
                                <ItemTemplate>
                                    <a href='BankDetailFill.aspx?ID=<%# Eval("ID") %>' onclick="NewWindow(this.href,'MList','530','450','yes','center');return false"
                                        onfocus="this.blur()">Detail</a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Member ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblmemberID" runat="server" Text='<%#Eval("Memid")%>'></asp:Label>
                                    <asp:Label ID="lblID" runat="server" Visible="False" Text='<%#Eval("ID")%>'></asp:Label>
                                    <asp:Label ID="lblAutoWithno" runat="server" Visible="False" Text='<%#Eval("TransID")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <b><%# DataBinder.Eval(Container.DataItem, "Name")%><br />
                                    </b>
                                    A/c:
                                    <asp:Label ID="lblAccno" runat="server" Text='<%#Eval("accno")%>'></asp:Label><br />
                                    A/c Type:
                                    <asp:Label ID="lblaccType" runat="server" Text='<%#Eval("Currancy")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Mobile")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Issue Mode">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "issueMode")%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Request Date">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "RequestDate")%>
                                </ItemTemplate>
                                <FooterTemplate>
                                    Total :
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount ($)">
                                <ItemTemplate>
                                    <asp:Label ID="lblAmt" runat="server" Text='<%#Eval("NetAmt")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotAmt" runat="server"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction Hash">
                                <ItemTemplate>
                                    <asp:Label ID="lblAmt1" runat="server" Text='<%#Eval("TransHash")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction ID">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "TransID")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction Date">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "UpdateDate")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction Status">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Withdrawal From">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "TransMode")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="IssueMode">
                                <ItemTemplate>
                                    <asp:Label ID="lblIssueMode" runat="server" Text='<%#Eval("issueMode") %>' Visible="false"></asp:Label>
                                    <a href="Admin_WithDrawalMode_Detail.aspx?U=<%# Eval("MemID") %>&M=<%#Eval("issueMode") %>" onclick="NewWindow(this.href,'MList','610','500','yes','center');return false">
                                        <%#Eval("IssueMode") %>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                        <FooterStyle BorderStyle="None" Height="30px" HorizontalAlign="Center" VerticalAlign="Middle"></FooterStyle>
                        <PagerStyle Font-Size="12px"></PagerStyle>
                        <EmptyDataTemplate>
                            <span style="color: Red;">---!!! Ooops, Amount Withdrawn Details Not Found !!!---</span>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
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
        $(function () {
            $("#<%=txtWithInc.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
</asp:Content>
