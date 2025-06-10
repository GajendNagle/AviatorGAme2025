<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="mySkin" CodeFile="AdminCurrentLevelStatus.aspx.cs" Inherits="ControlSection_AdminCurrentLevelStatus" Title="Direct User List" %>

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
                    <label>Form Date </label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" MaxLength="12" AutoComplete="off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date </label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" MaxLength="12" AutoComplete="off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="form-control blnk-input" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged">
                        <asp:ListItem>SPONSERID</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control blnk-input" MaxLength="30" Text=""></asp:TextBox>
                    <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="form-control blnk-input" Visible="False"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-1 col-12">
                <%--<asp:Button ID="Button1" runat="server" Text="Show" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" />--%>
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
                           of &nbsp;
                        <asp:Label ID="lblRecordNo" runat="server"></asp:Label>
                        &nbsp;
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    &nbsp;
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" Width="70px" Style="margin-left: 10px;" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" CssClass="form-control"></asp:DropDownList>
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
                    <asp:GridView ID="gv1" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="50" Width="100%" ShowFooter="True">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1%>.
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Direct User">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "DIRECT_USER")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Level No">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "LEVELNO")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Position">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "POSITION")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sign-Up On">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "JOINING_ON")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "STATUS")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="PACKAGE">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "PACKAGE")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "PKG_AMOUNT")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Actived On">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "UPGRADE_ON")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <center>
                                <b style="color: red; font-weight: bold; font-size: 14px;">--Ooops User Pin Details Not Found--</b></center>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <%--<table width="100%" cellspacing="0">
        <tr>
            <td align="right" width="100%">
                <asp:Panel ID="PrintPanel" runat="server">
                    <table align="left" border="0" cellpadding="0" cellspacing="0" style="width: 214px">
                        <tbody>
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="Uparmenu" Font-Bold="False" Font-Names="Verdana" OnClientClick="return CallPrint('divPrint')" Style="font-size: 12px;">Print</asp:LinkButton>
                                </td>
                                <td align="left" valign="middle">
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" OnClientClick="return CallPrint('divPrint')" />
                                </td>
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="Uparmenu" Font-Bold="False" Font-Names="Verdana" OnClick="btnexporttoexport_Click" Style="font-size: 12px;">Export to Excel</asp:LinkButton>
                                </td>
                                <td align="left" valign="middle">&nbsp;
                                    <asp:ImageButton ID="btnexporttoexport" runat="server" ImageUrl="../UserPanel_Images/excel_icon.gif" OnClick="btnexporttoexport_Click" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <table class="MtblCntReg" cellpadding="0" cellspacing="0" height="36" style="width: 100%">
                    <tr>
                        <td align="center" valign="top">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 998px;" valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="center">
                                                    <table align="center" border="0" cellpadding="0" style="width: 934px">
                                                        <tr>
                                                            <td align="right" valign="middle" class="lbl">From Date :</td>
                                                            <td align="left" valign="middle" style="height: 29px; width: 127px;">
                                                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" MaxLength="12" Width="87px" Height="20px" AutoComplete="off"></asp:TextBox>
                                                            </td>
                                                            <td align="right" valign="middle" class="lbl">To Date :</td>
                                                            <td align="left" valign="middle" style="width: 127px; height: 29px;">
                                                                <asp:TextBox ID="txtToDate" runat="server" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" MaxLength="12" Width="87px" Height="20px" AutoComplete="off"></asp:TextBox>
                                                            </td>
                                                            <td align="left" valign="middle" style="height: 29px"></td>
                                                            <td align="left" valign="middle" style="height: 29px" colspan="2">
                                                                <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged" Width="112px" Height="25px">
                                                                    <asp:ListItem>SPONSERID</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtSearch" runat="server" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" MaxLength="30" Text="" Width="112px" Height="20px"></asp:TextBox>
                                                                <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="10px" Visible="False" Width="80px"></asp:DropDownList>
                                                            </td>
                                                            <td align="left" style="padding: 0px 5px 0px 5px; height: 29px;" valign="middle">
                                                                <asp:Button ID="btnSearch" runat="server" CssClass="Btn" Font-Names="Verdana" Font-Size="10px" OnClick="btnSearch_Click" Text="GO" />
                                                            </td>
                                                            <td class="lblr">
                                                                <%=PageNo%>
                                                                -
                                                                <%=Pagesize %>
                                                                of &nbsp;
                                                                <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>
                                                                &nbsp;
                                                                <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" style="padding-top: 1px; height: 188px;" class="BoardStructure"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
                <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtFromDate" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtToDate" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
            <%--</td>
        </tr>
    </table>--%>
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