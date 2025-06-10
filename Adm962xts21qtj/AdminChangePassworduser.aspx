<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminChangePassworduser.aspx.cs" Inherits="Adm962xts21qtj_AdminChangePassworduser" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
    <link href="../UserPanel_css/MyRegisCss.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../UserPanel_js/jquery-1.6.1.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="js/jquery-2.1.3.js"></script>
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="MtblCntRegBdr" style="width: 80%">
            <table width="100%" cellspacing="0" class="MtblCntReg">
                <tr>
                    <td class="hdrtblReg">
                        <span class="span">
                            <center>Change  Password</center>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="lbl" align="right">Member ID :</td>
                                <td>
                                    <asp:TextBox ID="txtMemID" runat="server" CssClass="ComposeTxtBx" Enabled="false" BackColor="#dddddd"></asp:TextBox>
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Login Old Password :</td>
                                <td>
                                    <asp:TextBox ID="txtOldloginpass" runat="server" CssClass="ComposeTxtBx" Enabled="false" BackColor="#dddddd"></asp:TextBox>
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Transaction Old Password :</td>
                                <td>
                                    <asp:TextBox ID="txtoldTranspass" runat="server" CssClass="ComposeTxtBx" Enabled="false" BackColor="#dddddd"></asp:TextBox>
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Login New Password :</td>
                                <td>
                                    <asp:TextBox ID="txtNewloginpass" runat="server" CssClass="ComposeTxtBx" ValidationGroup="p"></asp:TextBox>
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Transaction New Password :</td>
                                <td>
                                    <asp:TextBox ID="txtNewTranspass" runat="server" CssClass="ComposeTxtBx" ValidationGroup="p"></asp:TextBox>
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="lbl">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="Btn" Text="Change Password" OnClick="btnSearch_Click" />
                                </td>
                                <td style="width: 7px;"></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="3" style="height: 32px;">
                                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtDate" TargetControlID="txtDate"></ajaxToolkit:CalendarExtender>--%>
                                    <%--<asp:HiddenField ID="HiddenField1" runat="server" />--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>