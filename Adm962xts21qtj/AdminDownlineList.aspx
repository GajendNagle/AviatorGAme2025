<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="MySkin" AutoEventWireup="true" CodeFile="~/Adm962xts21qtj/AdminDownlineList.aspx.cs" Inherits="Admin_AdminDownlineList" Title="View Referrals" %>

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
                <span>
                    <asp:Label ID="lblDirect" runat="server"></asp:Label>
                    <a href='AdminDownlineLvlSummary.aspx?mid=Affiliate+Program&sid=View+Referrals&UserId=<%=DLMemID%>' onclick="NewWindow(this.href,'MList','570','250','yes','center');return false" onfocus="this.blur()">
                        <img align="absMiddle" src="../UserPanel_Images/LevelSummary_Icon.png" />
                        Downline LVL Summary
                    </a>
                </span>
            </div>
            <div class="col-md-6 col-12">
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
                    <label>Filter By :</label>
                    <asp:DropDownList ID="DDLSrchByDjGt" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DDLSrchByDjGt_SelectedIndexChanged">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="Doj">Sign-Up On</asp:ListItem>
                        <%--<asp:ListItem Value="Package">Plan</asp:ListItem>--%>
                        <asp:ListItem Value="Upgrade Date">Actived On</asp:ListItem>
                        <asp:ListItem>Level No</asp:ListItem>
                        <asp:ListItem Value="Position">Leg</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="form-control blnk-input">
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="10" AutoComplete="off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="10" AutoComplete="off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-1 col-12">
                <div class="form-group">
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Submit" CssClass="OuterBtn blnk-input" />
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:TextBox ID="txtSearch" runat="server" Text="" CssClass="form-control blnk-input" EnableTheming="True"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="pgsizes">
                    <span>
                        <%--<%=PageNo%>
                        -
                        <%=Pagesize %>
                        of &nbsp;--%>
                        <asp:Label ID="lblRecordNo" runat="server"></asp:Label>
                        &nbsp;
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    &nbsp;
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" Width="70px" Style="margin-left: 10px" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" CssClass="form-control"></asp:DropDownList>
                    <asp:DropDownList ID="ddlGrpageSz" runat="server" Width="70px" AutoPostBack="false" CssClass="form-control">
                        <asp:ListItem Text="10" Value="10" Selected="true"></asp:ListItem>
                        <asp:ListItem Text="20" Value="20"></asp:ListItem>
                        <asp:ListItem Text="30" Value="30"></asp:ListItem>
                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                        <asp:ListItem Text="100" Value="100"></asp:ListItem>
                        <asp:ListItem Text="250" Value="250"></asp:ListItem>
                        <asp:ListItem Text="500" Value="500"></asp:ListItem>
                    </asp:DropDownList>
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
                    <asp:GridView ID="grdUserDtl" runat="server" AutoGenerateColumns="False" PagerSettings-Visible="false" PageSize="10" ShowFooter="True" Width="100%" OnRowDataBound="grdUserDtl_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex +1 %>
                                    .
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Level No">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"LevelNo")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Member-ID">
                                <ItemTemplate>
                                    <a href='AdminDownlineList.aspx?mid=Affiliate Program&amp;sid=My Downline list&amp;MemID=<%#DataBinder.Eval(Container.DataItem,"MemID")%>'>
                                        <b><%#DataBinder.Eval(Container.DataItem,"MemID")%></b>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Member Name">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"Mname")%>
                                    <br />
                                    <b style="color: #337ab7"><%#DataBinder.Eval(Container.DataItem,"email")%></b>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sponser-ID">
                                <ItemTemplate>
                                    <%--<%--<%#DataBinder.Eval(Container.DataItem,"Mobile")%>
                                    <br />--%>
                                    <%--<b style="color:#337ab7"><%#DataBinder.Eval(Container.DataItem,"email")%></b>
                                    <br />--%><%#DataBinder.Eval(Container.DataItem,"sponserid")%>
                                </ItemTemplate>
                                <FooterTemplate>
                                     Total :
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deposit Amt">
                                <ItemTemplate>
                                    <b style="color: #337ab7"><%#DataBinder.Eval(Container.DataItem,"MintingAMmt")%></b><%--<br />--%>
                                    <asp:Label ID="lblAmt" runat="server" Visible="false" Text='<%#Eval("MintingAMmt")%>'></asp:Label>
                                    <%--Team: <%#DataBinder.Eval(Container.DataItem,"TeamBusiness")%>--%>
                                </ItemTemplate>
                                 <FooterTemplate>
                                    <b><asp:Label ID="lblTotAmt" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Withdraw">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"TotWithdraw")%>
                                    <asp:Label ID="lblWidAmt" runat="server" Visible="false" Text='<%#Eval("TotWithdraw")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <b><asp:Label ID="lblTotWid" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Team Business">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"TeamBusiness")%>
                                    <asp:Label ID="lblTmBuss" runat="server" Visible="false" Text='<%#Eval("TeamBusiness")%>'></asp:Label>
                                </ItemTemplate>
                                  <FooterTemplate>
                                    <b><asp:Label ID="lblTotTmBuss" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Stake Amt">
                                <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem,"StkAmount")%>
                                    <asp:Label ID="lblStkAmt" runat="server" Visible="false" Text='<%#Eval("StkAmount")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <b><asp:Label ID="lblStkTotAmt" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Stake Wid">
                                <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem,"TotStkWithdraw")%>
                                    <asp:Label ID="lblStkWid" runat="server" Visible="false" Text='<%#Eval("TotStkWithdraw")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <b><asp:Label ID="lblStkTotWid" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Stake Inc">
                                <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem,"TotStkInc")%>
                                    <asp:Label ID="lblStkInc" runat="server" Visible="false" Text='<%#Eval("TotStkInc")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <b><asp:Label ID="lblStkTotInc" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Stake Bal">
                                <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem,"TotStkBal")%>
                                    <asp:Label ID="lblStkBal" runat="server" Visible="false" Text='<%#Eval("TotStkBal")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <b><asp:Label ID="lblStkTotBal" runat="server"></asp:Label></b>
                                </FooterTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Contact">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"Mobile")%>
                                    <br />
                                    <b style="color: #337ab7"><%#DataBinder.Eval(Container.DataItem,"email")%></b>
                                    <br />
                                    Sponsor-ID: <%#DataBinder.Eval(Container.DataItem,"sponserid")%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Active Date">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"Greendate")%>
                                    <%--<br />
                                    <%#DataBinder.Eval(Container.DataItem,"City")%>--%>
                                    <br />
                                    <a href='c-Wallet-Fund-Request.aspx?mid=Make+Deposit&amp;sid=Deposit+History&amp;UserId=<%#DataBinder.Eval(Container.DataItem,"MemID")%>'><b>Deposit </b></a>
                                    <b height="25px" style="margin-left:5px;margin-right:5px"> | </b>
                                    <a href='Admin_Fromup_History.aspx?mid=Make+Game&amp;sid=Game+History&amp;UserId=<%#DataBinder.Eval(Container.DataItem,"MemID")%>'><b>Game </b></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Sponsor ID">
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem,"sponserid")%>
                                    </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Date Of Joining">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"doj")%>
                                    <br />
                                    <%#DataBinder.Eval(Container.DataItem,"Status")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Team">
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem,"TotLeftUser")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Deposit Details">
                                    <ItemTemplate>
                                        <a href='AdminDepositHistory.aspx?mid=Make+Deposit&sid=Deposit+History&UserId=<%#DataBinder.Eval(Container.DataItem,"MemID")%>'>Detail </a>
                                    </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                        <EmptyDataTemplate>
                            <span style="font: Bold 13px verdana; color: Red">---!!! Ooops, Downline List Details Not Found !!!---</span>
                        </EmptyDataTemplate>
                        <PagerSettings Visible="False" />
                        <HeaderStyle HorizontalAlign="Center" Height="30px" />
                    </asp:GridView>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <%--<table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td align="left" style="text-align: right;" valign="top">
               &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" style="background-color: White" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="7" style="height: 31px"></td>
                        <td align="left" valign="middle" colspan="7" style="height: 31px"></td>
                    </tr>
                    <tr>
                        <td align="left" style="height: 24px;" valign="middle" colspan="12">
                            <table border="0" cellpadding="0" cellspacing="0" style="font-size: 13px; width: 100%; font-family: 'Poppins', sans-serif; background-color: white">
                                <tr>
                                    <td align="left" style="padding-left: 1px; width: 76px; height: 26px; text-align: right" valign="middle">Filter By :</td>
                                    <td align="left" style="padding-left: 5px; width: 107px; height: 26px; text-align: left" valign="middle">
                                        <asp:DropDownList ID="DDLSrchByDjGt" runat="server" CssClass="ComposeTxtBx" AutoPostBack="True" OnSelectedIndexChanged="DDLSrchByDjGt_SelectedIndexChanged" Width="105px">
                                            <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem Value="Doj">Sign-Up On</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="Package">Plan</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="Upgrade Date">Actived On</asp:ListItem>
                                            <asp:ListItem>Level No</asp:ListItem>
                                            <asp:ListItem Value="Position">Leg</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>--%>
                                    <%--<td align="left" colspan="2" style="padding-left: 5px; width: 80px; height: 26px; text-align: left" valign="middle">
                                        <asp:DropDownList ID="DDLDownPos" runat="server" Width="75px" CssClass="ComposeTxtBx">
                                            <asp:ListItem>All</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                    <td align="left" style="width: 55px; height: 26px" valign="middle">From :</td>
                                    <td align="left" style="width: 95px; height: 26px" valign="middle">&nbsp;
                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="ComposeTxtBx" Width="75px" MaxLength="10" AutoComplete="off"></asp:TextBox>
                                    </td>
                                    <td align="right" style="width: 42px; height: 26px" valign="middle">To :&nbsp;</td>
                                    <td align="left" style="width: 7px; height: 26px" valign="middle">
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="ComposeTxtBx" Width="75px" MaxLength="10" AutoComplete="off"></asp:TextBox>
                                    </td>
                                    <td align="right" style="padding-right: 10px; padding-left: 5px; height: 26px; width: 104px;" valign="middle">
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Submit" CssClass="Btn" Width="82px" />
                                    </td>
                                    <td align="right" style="padding-right: 5px; padding-left: 5px; width: 50px; height: 26px" valign="middle">
                                        <asp:TextBox ID="txtSearch" runat="server" Font-Names="Verdana" Font-Size="11px" Text="" Width="100px" CssClass="ComposeTxtBx" EnableTheming="True"></asp:TextBox>
                                    </td>
                                    <td align="left" style="padding-left: 5px; padding-left: 5px; width: 310px; height: 26px" valign="middle">
                                        <span style="width: 200px;">Table Page Size:</span>
                                        <asp:DropDownList ID="ddlGrpageSz" runat="server" Width="60px" AutoPostBack="false">
                                            <asp:ListItem Text="100" Value="100" Selected="true"></asp:ListItem>
                                            <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                            <asp:ListItem Text="300" Value="300"></asp:ListItem>
                                            <asp:ListItem Text="500" Value="500"></asp:ListItem>
                                            <asp:ListItem Text="1000" Value="1000"></asp:ListItem>
                                            <asp:ListItem Text="2500" Value="2500"></asp:ListItem>
                                            <asp:ListItem Text="5000" Value="5000"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right" style="padding-left: 5px; height: 26px" valign="middle">--%>
                                        <%--<%=PageNo%>
                                        -
                                        <%=Pagesize %>
                                        of--%>
                                        <%--<asp:Label ID="lblRecordNo" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                                        <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>
                                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>--%>
                        <%--<td align="left" style="width: 254px; height: 24px;" valign="middle">&nbsp;By Position :</td>--%>
                    <%--</tr>
                    <tr>
                        <td align="center" colspan="13" style="height: 24px" valign="middle">
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px" ForeColor="Black" Width="100%"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 990px" valign="top" class="BoardStructure"></td>
        </tr>
    </table>--%>
    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtFromDate" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtToDate" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
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
</asp:Content>