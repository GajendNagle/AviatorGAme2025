<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin_EditPayOutAmt.aspx.cs" StylesheetTheme="mySkin" Inherits="ControlSection_Admin_EditPayOutAmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Pay Out Amount</title>
    <link href="../UserPanel_css/MyRegisCss.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../UserPanel_js/jquery-1.6.1.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="js/jquery-2.1.3.js"></script>
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
        $("#<%=txtDate.ClientID%>").datepicker(
            {
                dateFormat: 'dd/mm/yy'
            });
        });
    </script>
    <script type="text/javascript">
        function redirectPage(Msg)
        {
            alert(Msg);
            parent.window.opener.location.reload(false);
            window.self.close();
        }
        function openPopup() 
        {
	        //document.getElementById('popupdiv').style.display = 'block';				 
		    if (document.getElementById('<%=ddlStatus.ClientID %>').value == 'REJECTED' )
		    {
		        document.getElementById('<%=lblAPwd.ClientID %>').style.display = 'block';
		        document.getElementById('<%=TxtAPwd.ClientID %>').style.display = 'block';
		        //return ;
		        ValidatorEnable(document.getElementById("RequiredFieldValidator1"), false);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator2"), false);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator3"), false);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator4"), false);
		        ValidatorEnable(document.getElementById("RegularExpressionValidator1"), false);
		        ValidatorEnable(document.getElementById("CustValidPwd"), true);
		    }
		    else 
		    {
		        document.getElementById('<%=lblAPwd.ClientID %>').style.display = 'none';
		        document.getElementById('<%=TxtAPwd.ClientID %>').style.display = 'none';
		        ValidatorEnable(document.getElementById("RequiredFieldValidator1"), true);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator2"), true);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator3"), true);
		        ValidatorEnable(document.getElementById("RequiredFieldValidator4"), true);
		        ValidatorEnable(document.getElementById("RegularExpressionValidator1"), true);
		        ValidatorEnable(document.getElementById("CustValidPwd"), false);
		    }		
	    }
	    function TextBoxAdPwd(sender, args) 
	    {
	        if (document.getElementById('<%=ddlStatus.ClientID %>').value == 'REJECTED' )
		    {
                var v = document.getElementById('<%=TxtAPwd.ClientID%>').value;
                if (v == '') 
                {
                    args.IsValid = false;  // field is empty
                }
                else 
                {
                    args.IsValid = true;
                }
            }
            else 
            {
                args.IsValid = true;
            }
        }
    </script>
</head>
<body onload="openPopup()">
    <form id="form1" runat="server">
        <div class="MtblCntRegBdr" style="width: 80%;">
            <table width="100%" cellspacing="0" class="MtblCntReg">
                <tr>
                    <td class="hdrtblReg">
                        <span class="span">
                            <center>Confirm Withdrawal Request</center>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="lbl" align="right">Member ID :</td>
                                <td>
                                    <asp:TextBox ID="txtMemID" runat="server" Enabled="False" CssClass="ComposeTxtBx"></asp:TextBox>
                                </td>
                                <td style="width: 21px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Status :</td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus" runat="server" Font-Names="Verdana" Font-Size="13px" CssClass="ComposeTxtBx" AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                        <asp:ListItem>PENDING</asp:ListItem>
                                        <asp:ListItem>COMPLETED</asp:ListItem>
                                        <asp:ListItem>REJECTED</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 21px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Transaction Has :</td>
                                <td>
                                    <asp:TextBox ID="txtChkNo" runat="server" TextMode="SingleLine" MaxLength="64" CssClass="ComposeTxtBx" placeholder="e.g. 8f534960013db680991458b4502181a08b113fe51d7cadb425b8306892db3f43"></asp:TextBox>
                                </td>
                                <td style="width: 21px;">
                                    &nbsp;
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtChkNo" ErrorMessage="Please enter transaction id.">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Transaction Dt :</td>
                                <td>
                                    <asp:TextBox ID="txtDate" runat="server" TextMode="SingleLine" CssClass="ComposeTxtBx"></asp:TextBox>
                                </td>
                                <td style="width: 21px;">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDate" ErrorMessage="Please enter transaction date.">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAmount" ErrorMessage="Please Enter Amount" Width="8px">*</asp:RequiredFieldValidator>
                                    Amount($) :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAmount" runat="server" TextMode="SingleLine" ReadOnly="True" CssClass="ComposeTxtBx"></asp:TextBox>
                                </td>
                                <td style="width: 21px;">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmount" ErrorMessage="Please enter amount.">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAmount" ErrorMessage="Invalid amount." ValidationExpression="[0-9.]+"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr id="trfileupload" runat="server" visible="false">
                                <td class="lbl" align="right">Upload File :</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                </td>
                                <td rowspan="1" style="width: 21px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">Remark :</td>
                                <td>
                                    <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="66px"></asp:TextBox>
                                </td>
                                <td style="width: 21px;"></td>
                            </tr>
                            <tr>
                                <td class="lbl" align="right">
                                    <asp:Label ID="lblAPwd" runat="server" Text="Admin Password:" style="position: relative; display: none;"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtAPwd" runat="server" MaxLength="20" TextMode="password" AutoCompleteType="disabled" EnableViewState="false" style="position: relative; display: none;"></asp:TextBox>
                                </td>
                                <td style="width: 21px;">
                                    <asp:CustomValidator ID="CustValidPwd" runat="server" ErrorMessage="Enter Admin Password." ClientValidationFunction="TextBoxAdPwd" OnServerValidate="TextPwd_Validate">*</asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="lbl">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="Btn" OnClick="btnSearch_Click" Text="Submit" />
                                </td>
                                <td style="width: 21px;"></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="3" style="height: 32px;">
                                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtDate" TargetControlID="txtDate"></ajaxToolkit:CalendarExtender>--%>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script language="javascript" type="text/javascript">
        $( function() {
            $("#<%=txtDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
    </script>
</body>
</html>