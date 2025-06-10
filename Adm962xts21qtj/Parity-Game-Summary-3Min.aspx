<%@ Page Title=" Parity Summary" Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" AutoEventWireup="true" CodeFile="Parity-Game-Summary-3Min.aspx.cs" Inherits="Adm962xts21qtj_Parity_Game_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 col-12 text-left"></div>
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
                <label>Select one</label>
                <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx form-control" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged">
                    <asp:ListItem>All</asp:ListItem>
                    <asp:ListItem Value="MName">Name</asp:ListItem>
                    <asp:ListItem Value="MemID">Member ID</asp:ListItem>
                    <asp:ListItem Value="Status">Status</asp:ListItem>
                    <asp:ListItem Value="TradingType">Color/Number</asp:ListItem>
                    <asp:ListItem Value="JackpotNo">Period No</asp:ListItem>
                    <%--<asp:ListItem Value="PurchaseType">PurchaseType</asp:ListItem>
                    <asp:ListItem Value="Leader-ID">Leader-ID</asp:ListItem>--%>
                </asp:DropDownList>
            </div>
            <div class="col-md-2 col-12" id="detsdv" runat="server">
                <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="ComposeTxtBx blnk-input" Visible="False"></asp:DropDownList>
                <asp:TextBox ID="txtSearch" runat="server" MaxLength="30" Text="" Visible="False" CssClass="ComposeTxtBx blnk-input"></asp:TextBox>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" Text="Submit" CausesValidation="False" />
            </div>
            <div class="col-md-2 col-12">
                <div class="pgsizes">
                    <span>
                        <%=PageNo%>
                        <%=Pagesize %>
                        of
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                        &nbsp;
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" CssClass="form-control" Width="58px"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <asp:Label ID="Label1" CssClass="total-record" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>
            </div>
        </div>
        <div class="col-md-12 col-12">
            <%--<asp:Label ID="lblTotalData" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>--%>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div id="divPrint">
                    <asp:GridView ID="GvCaptchaWork" runat="server" Font-Bold="False" AutoGenerateColumns="False" Width="100%" ShowFooter="True" OnRowDataBound="GvCaptchaWork_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo./Period No.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex +1  %>
                                    .
                                    <b color="blue">
                                    <br />
                                    <%# DataBinder.Eval(Container.DataItem, "JackpotNo")%></b>
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Member-ID">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "MNAME")%>
                                    <br />
                                    <b><%# DataBinder.Eval(Container.DataItem, "MemId")%></b>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Play Date">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Date")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Play Amt.">
                                <ItemTemplate>
                                    <b><%# DataBinder.Eval(Container.DataItem, "PlyAmt")%></b>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Select Type">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "PlayType")%>
                                    <br />
                                    <b><%# DataBinder.Eval(Container.DataItem, "SelectType")%></b>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Loss/Win Amt.">
                                <ItemTemplate>
                                    <b><%# DataBinder.Eval(Container.DataItem, "LWAmt")%></b>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Result_Color">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "RsltColor")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Result_Number">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "RsltNmbr")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Big/Small">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "WinBigSmall")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order Number">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "transID")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <span style="color: Red;">---!!! Ooops,Deposit History Detail Not Found !!!---</span>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
    </div>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="padding: 0px;" colspan="2">
                <%--<table width="100%">
                    <tr>
                        <td align="center" colspan="3">
                            <table border="0" cellpadding="0" cellspacing="0" style="font-size: 11px; font-family: 'Poppins', sans-serif; background-color: White; width: 100%;">
                                <tr>
                                    <td align="left" style="height: 26px; width: 60px;" valign="middle">From :</td>
                                    <td align="left" style="height: 26px; width: 74px;" valign="middle"></td>
                                    <td align="left" style="height: 26px; width: 23px;" valign="middle">&nbsp;</td>
                                    <td align="right" style="height: 26px; width: 50px;" valign="middle">To :</td>
                                    <td align="left" style="height: 26px; width: 85px;" valign="middle"></td>
                                    <td align="left" style="height: 26px; width: 24px;" valign="middle">&nbsp;</td>
                                    <td align="left" style="width: 87px; height: 26px" valign="middle">Select one:</td>
                                    <td align="left" style="width: 50px; height: 26px" valign="middle"></td>
                                    <td align="left" style="width: 150px; height: 26px; text-align: center" valign="middle"></td>
                                    <td align="left" style="height: 26px; padding-left: 5px;" valign="middle">
                                    <td align="right" style="padding-left: 5px; height: 26px" valign="middle">
                                        <%=PageNo%>
                                        -
                                        <%=Pagesize %>
                                        of
                                        <asp:Label ID="lblTotRec" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="Verdana"
                                            Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="9" valign="middle">
                <center></center>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="9" valign="middle"></td>
        </tr>
        <tr>
            <td style="width: 100%" colspan="2">
                <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtFromDate" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtToDate" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
            </td>
        </tr>
    </table>
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
    </script>
    <style>
        .ontop {
            z-index: 999;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            display: none;
            position: fixed;
            overflow: auto;
            background-color: #cccccc;
            color: #aaaaaa;
            opacity: .9;
            filter: alpha(opacity = 70);
        }
        #popup {
            width: 300px;
            height: 200px;
            position: absolute;
            color: #ffffff;
            background-color: #ec9806;
            border-top: black thin solid;
            border-right: black thin solid;
            border-bottom: black thin solid;
            border-left: black thin solid;
            /*To align popup window at the center of screen*/
            top: 50%;
            left: 50%;
            margin-top: -100px;
            margin-left: -150px;
        }
    </style>
    <script type="text/javascript">
        //To detect escape button
        document.onkeydown = function (evt) {
            evt = evt || window.event;
            if (evt.keyCode == 27) {
                hide();
            }
        };
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
        function Mesag(msg) {
            document.getElementById('<%=lblMsg.ClientID %>').innerHTML = msg;
        }
    </script>
</asp:Content>