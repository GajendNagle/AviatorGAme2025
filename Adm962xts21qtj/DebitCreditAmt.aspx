<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/Adm962xts21qtj/DebitCreditAmt.aspx.cs" Inherits="Admin_DebitCreditAmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../UserPanel_css/MyRegisCss.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function redirectPage(Msg, Wallet) {
            //alert(Msg);
            //if(Wallet=="I-Wallet")
            //{ 
            //  parent.window.location.href="AdminGrowthReport.aspx?mid=User Account&sid=Account Summary";
            //}
            //if(Wallet=="D-Wallet")
            //{
            //  parent.window.location.href="AdminCCTransactionReport.aspx?mid=User Account&sid=Cash Credit Summary";
            //}
            //window.self.close();            
        }
    </script>
    <style>
        .MtblCntReg select {
            width: 100%;
            height: 43px;
            border-radius: 4px;
        }
        .ComposeTxtBx {
            width: 92%;
        }
        .MtblCntReg input[type='text'] {
            margin: 10px 0px;
        }
    </style>
</head>
<body>
    <div class="containerfluid">
        <form class="debitcreditpage" id="form1" runat="server">
            <div class="MtblCntRegBdr" style="width: 100%!important;">
                <table width="100%" cellspacing="0" class="MtblCntReg">
                    <tr>
                        <td class="hdrtblReg">
                            <span class="span">
                                <center>Credit/Debit Amount In Wallet</center>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="MtblCntReg">
                                <tr>
                                    <td style="width: 30%;" class="lbl">Select Wallet :</td>
                                    <td style="width: 60%;">
                                        <asp:DropDownList ID="ddlWallet" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlWallet_SelectedIndexChanged" CssClass="ComposeTxtBx">
                                            <%--<asp:ListItem Text="check Match Bonus" Value="check Match Bonus"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="Profit Sharing" Value="Profit Sharing"></asp:ListItem>
                                            <asp:ListItem Text="Referral Bonus" Value="Referral Bonus"></asp:ListItem>
                                            <asp:ListItem Text="Level Profit" Value="Level Profit"></asp:ListItem>
                                            <asp:ListItem Text="Royalty" Value="Royalty"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="My Account" Value="My Account"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="Level Reward" Value="Level Reward"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="TRX-Wallet" Value="f-Wallet"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="Stake Dividends" Value="Stake Dividends"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="Level Dividends" Value="Level Dividends"></asp:ListItem>--%>
                                            <%--<asp:ListItem Text="Rank Dividends" Value="Rank Dividends"></asp:ListItem>--%>
                                            <asp:ListItem Text="Game Wallet" Value="Game Wallet"></asp:ListItem>
                                            <asp:ListItem Text="Growth Wallet" Value="Growth Wallet"></asp:ListItem>
                                            <%--<asp:ListItem Text="Win Wallet" Value="Win Wallet"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10%;"></td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;" class="lbl">Member ID :</td>
                                    <td style="width: 60%;">
                                        <asp:TextBox ID="txtUserId" runat="server" CssClass="ComposeTxtBx" AutoPostBack="True" MaxLength="20" OnTextChanged="txtUserId_TextChanged"></asp:TextBox>
                                    </td>
                                    <td style="width: 10%;">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId" ErrorMessage="Please enter member id.">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;" class="lbl"></td>
                                    <td style="width: 60%;" align="left">
                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                    </td>
                                    <td style="width: 10%;"></td>
                                </tr>
                                <tr>
                                    <td class="lbl" colspan="3" align="center">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTotalCredit" runat="server" Font-Size="13px" Font-Bold="True"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTotalDebit" runat="server" Font-Size="13px" Font-Bold="True"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBal" runat="server" Font-Size="13px" Font-Bold="True"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;" class="lbl">Select Type :</td>
                                    <td style="width: 60%;">
                                        <asp:DropDownList ID="ddlTranType" runat="server">
                                            <asp:ListItem Value="DR">DEBIT</asp:ListItem>
                                            <asp:ListItem Value="CR">CREDIT</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10%;"></td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;" class="lbl">Amount :</td>
                                    <td style="width: 60%;">
                                        <asp:TextBox ID="txtAmt" runat="server" CssClass="ComposeTxtBx"></asp:TextBox>&nbsp;
                                    </td>
                                    <td style="width: 10%;">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAmt" ErrorMessage="Please Enter Amount" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtAmt" ErrorMessage="Please Enter Amount in Numbers" Operator="GreaterThan" SetFocusOnError="True" Type="Double" ValueToCompare="0">*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;" class="lbl">Remark :</td>
                                    <td style="width: 60%;">
                                        <asp:TextBox ID="txtRemark" CssClass="ComposeTxtBx" runat="server" MaxLength="100"></asp:TextBox>
                                    </td>
                                    <td style="width: 10%;"></td>
                                </tr>
                                <tr>
                                    <td style="width: 30%;"></td>
                                    <td style="width: 60%; text-align: right;">
                                        <asp:Button ID="btnpass" runat="server" OnClick="btnpass_Click" Text="SUBMIT" CssClass="Btn"/></td>
                                    <td style="width: 10%;"></td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="3" style="height: 32px;">
                                        <asp:Label ID="lblmsg" runat="server" Font-Names="Verdana" Font-Size="13px" ForeColor="Red" Font-Bold="True"></asp:Label>&nbsp;
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>