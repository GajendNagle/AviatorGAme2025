<%@ Page Language="C#" StylesheetTheme="mySkin" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="BlockUnblockSetting.aspx.cs" Inherits="Admin_BlockUnblockSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .ErrorMsgForUID {
            margin-bottom: 0px;
        }
    </style>
    <div class="container-fluid">
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>
                        <asp:Label ID="lblMemId" runat="server" Text="MemberID: "></asp:Label>
                    </label>
                    <asp:TextBox ID="txtMemId" runat="server" CssClass="form-control" MaxLength="30"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                 <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input go" OnClick="btnSearch_Click" Text="GO" />
            </div>
            <div class="col-md-8 col-12">
                <div class="pgsizes">
                    <span>
                        <%=PageNo%>
                            - 
                        <%=Pagesize %>
                        of
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="PageChanged" Width="58px"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="table-responsive">
                    <table width="100%" cellspacing="0">
                        <tr>
                            <td class="ScrollBar">
                                <table align="center" border="0" cellpadding="0" cellspacing="0" class="MtblCntReg" width="100%">
                                    <tr>
                                        <td align="left" style="width: 100%;" valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">

                                                <tr>
                                                    <td align="center" style="width: 100%;" valign="top">
                                                        <%--<table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="left" style="width: 114px; height: 21px;" valign="middle" class="lbl">Enter Member ID :</td>
                                                                <td align="left" colspan="10" style="height: 21px" valign="middle">
                                                                    <asp:TextBox ID="txtMemId" runat="server" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" Width="171px" MaxLength="30"></asp:TextBox>&nbsp;
                                                                    <asp:Button ID="btnSearch" runat="server" CssClass="Btn" OnClick="btnSearch_Click" Text="GO" />
                                                                </td>
                                                                <td align="left" style="height: 21px;" valign="middle"></td>
                                                                <td align="right" style="height: 21px;" valign="middle" class="lblr" colspan="2">
                                                                    <%=PageNo%>
                                                                        -
                                                                    <%=Pagesize %>
                                                                    of
                                                                    <asp:Label id="lblTotRec" runat="server"  Font-Bold="True"></asp:Label>
                                                                    &nbsp;
                                                                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" Height="30px" OnSelectedIndexChanged="PageChanged" Width="58px"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%--<td align="left" style="width: 100%" valign="top">
                                                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                                                    </td>--%>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="BoardStructure" style="width: 100%;" valign="top"></td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 100%" valign="top" class="BoardStructure">
                                            <div id="divPrint">
                                                <asp:GridView ID="grdGiveHelpDtl" runat="server" PagerSettings-Visible="false" PageSize="100" AutoGenerateColumns="false" ShowFooter="True" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Select">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" OnCheckedChanged="chkSelect_CheckedChanged" AutoPostBack="true" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SNO.">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex+1%>
                                                                .
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Edit Status">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Status")%>'></asp:Label>
                                                                <asp:DropDownList ID="ddlStatus" runat="server" Visible="false" Width="150px">
                                                                    <asp:ListItem>BLOCK</asp:ListItem>
                                                                    <asp:ListItem>ACTIVE</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Member ID">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMemId" runat="server" Text='<%#Eval("MemID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Name">
                                                            <ItemTemplate>
                                                                <%#Eval("MName")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Mobile">
                                                            <ItemTemplate>
                                                                <%#Eval("Mobile")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Email">
                                                            <ItemTemplate>
                                                                <%#Eval("Email")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Doj">
                                                            <ItemTemplate>
                                                                <%#Eval("Doj")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Upgrade Date">
                                                            <ItemTemplate>
                                                                <%#Eval("GreenDate")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EmptyDataTemplate>
                                                        <span style="font: Bold 13px verdana; color: Red">---!!! Ooops, Search Record Details Not Found !!!---</span>
                                                    </EmptyDataTemplate>
                                                    <PagerSettings Visible="False" />
                                                    <RowStyle Height="30px" HorizontalAlign="Center" />
                                                    <HeaderStyle Height="30px" HorizontalAlign="Center" />
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 31px; padding-top: 10px;">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="Btn" OnClick="btnUpdate_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>