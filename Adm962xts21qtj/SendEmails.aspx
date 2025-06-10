<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="MySkin" AutoEventWireup="true" CodeFile="SendEmails.aspx.cs" Inherits="SendEmails" Title="Send Emails To Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function SelectAllCheckboxesMoreSpecific(spanChk) {
            var IsChecked = spanChk.checked;
            var Chk = spanChk;
            Parent = document.getElementById('GridView1');
            for (i = 0; i < Parent.rows.length; i++) {
                var tr = Parent.rows[i];
                //var td = tr.childNodes[0];                                  
                var td = tr.firstChild;
                var item = td.firstChild;
                if (item.id != Chk && item.type == "GridView1") {
                    if (item.checked != IsChecked) {
                        item.click();
                    }
                }
            }
        }
        function HighlightRow(chkB) {
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '#FBFABD';
                chkB.parentElement.parentElement.style.color = 'Black';
            } else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';
            }
        }
    </script>
    <script type="text/javascript">  
        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex  
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        //If the header checkbox is checked  
                        //check all checkboxes  
                        //and highlight all rows  
                        row.style.backgroundColor = "aqua";
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked  
                        //uncheck all checkboxes  
                        //and change rowcolor back to original   
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color  
                            row.style.backgroundColor = "#C2D69B";
                        }
                        else {
                            row.style.backgroundColor = "white";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }
    </script>
    <table border="0" cellpadding="0" cellspacing="0" align="center" height="36" class="MtblCntReg" style="width: 100%">
        <tr>
            <td align="center" height="400" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" height="40" style="width: 100%;" align="center">
                    <tr>
                        <td align="center" >
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;" >
                                <tr>
                                    <td align="left" colspan="3" valign="middle" class="hader"></td>
                                </tr>
                                <tr>
                                    <td align="center"  valign="middle" colspan="3">
                                        <table align="center" cellpadding="0" cellspacing="0" style="width: 748px;">
                                            <tr>
                                                <td align="left" style="height: 32px" valign="middle" class="lbl">Member ID:</td>
                                                <td align="left" valign="middle" style="width: 199px">
                                                    <asp:TextBox ID="txtmemid" runat="server" ValidationGroup="one" Font-Size="11px" Font-Names="Verdana"></asp:TextBox>
                                                </td>
                                                <td align="left" valign="middle" class="lbl">Member Name:</td>
                                                <td align="left" valign="middle" style="width: 119px">
                                                    <asp:TextBox ID="txtmemname" runat="server" ValidationGroup="one" Font-Size="11px" Font-Names="Verdana"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="height: 43px;" class="lbl">From-DOJ:</td>
                                                <td style="height: 43px; width: 199px;" align="left">
                                                    <asp:TextBox ID="txtfromdate" runat="server" Font-Size="11px" Font-Names="Verdana" CssClass="ComposeTxtBx"></asp:TextBox>
                                                    </td>
                                                <td align="left" style="height: 43px;" class="lbl">To-DOJ:</td>
                                                <td align="left" style="width: 119px; height: 43px;">
                                                    <asp:TextBox ID="txttodate" runat="server" Font-Size="11px" Font-Names="Verdana" CssClass="ComposeTxtBx"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="height: 28px;" class="lbl">City:</td>
                                                <td style="width: 199px" align="left">
                                                    <asp:TextBox ID="txtcity" runat="server" ValidationGroup="one" Font-Size="11px" Font-Names="Verdana"></asp:TextBox>
                                                </td>
                                                <td align="left" class="lbl">Date Of Birth:</td>
                                                <td style="width: 119px;" align="left">
                                                    <asp:TextBox ID="txtdateofbirth" runat="server" Font-Size="11px" Font-Names="Verdana" CssClass="ComposeTxtBx"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="height: 31px;" class="lbl">Status:</td>
                                                <td style="padding-left: 10px" >
                                                    <asp:DropDownList ID="ddlstatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlstatus_SelectedIndexChanged" Font-Names="Verdana" Font-Size="11px">
                                                        <asp:ListItem Selected="True">--Select One--</asp:ListItem>
                                                        <asp:ListItem Value="1">RED</asp:ListItem>
                                                        <asp:ListItem Value="0">GREEN</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="height: 31px;" align="left"></td>
                                                <td style="width: 119px;" align="left">
                                                    <asp:DropDownList ID="DdlPackage" runat="server" AutoPostBack="True" Visible="false" OnSelectedIndexChanged="ddlstatus_SelectedIndexChanged1" Font-Names="Verdana" Font-Size="11px">
                                                        <asp:ListItem Value="0">Royal Package</asp:ListItem>
                                                        <asp:ListItem Value="1">Peers Package</asp:ListItem>
                                                        <asp:ListItem Value="2">Noble Package</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 26px;"></td>
                                                <td class="lbl">
                                                    <asp:Button ID="btnsearch" runat="server" CssClass="Btn" OnClick="btnsearch_Click" Text="Search" ValidationGroup="one" Width="112px"  />
                                                    <asp:Button ID="btnReset" runat="server" CausesValidation="False" CssClass="Btn" OnClick="btnReset_Click" Text="Reset" ValidationGroup="one" Font-Overline="False" Font-Strikeout="False" Width="72px"  />
                                                </td>
                                                <td style="height: 26px;"></td>
                                                <td style="width: 119px; height: 26px;">
                                                    <asp:Label ID="lblpwd" runat="server" Visible="False" Font-Size="12px"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 26px" colspan="4">
                                                    <asp:Label ID="lblMsg" runat="server" Font-Names="Verdana" Font-Size="11px" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:GridView ID="GridView1" runat="server" BorderStyle="None" BorderWidth="1px" CellPadding="4" Visible="False" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" DataKeyNames="Member ID" AllowPaging="True" PageSize="50" ShowFooter="True" >
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo.">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex+1 %>
                                                        .
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkMemID" onclick="javascript:HighlightRow(this);" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataTemplate>-- Ooops Record Not Found --</EmptyDataTemplate>
                                            <PagerSettings PageButtonCount="20" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="3" style="height: 59px;" valign="middle">
                                        <table align="left" style="font-size: 11px;">
                                            <tr>
                                                <td align="left" colspan="3" style="height: 27px;">
                                                    <asp:Label ID="lblSmsMsg" runat="server"  Font-Size="11px"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style=" width: 129px; height: 27px;">
                                                    <asp:Button ID="btnSelectEMailIds" runat="server" Text="Select EmaiID(s)" BorderStyle="Solid" ForeColor="Black" Width="120px" CssClass="ComposeTxtBx"  OnClick="btnSelectEMailIds_Click" CausesValidation="False" UseSubmitBehavior="False" />
                                                </td>
                                                <td align="left" style="width: 100px; height: 27px;"></td>
                                                <td align="left" style="width: 100px; color: red; height: 27px;"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" style=" width: 129px;" class="lbl">
                                                    <asp:Label ID="lblmobiUSD" runat="server" Text="EMail Id(s)" Width="80px"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 100px;">
                                                    <asp:TextBox ID="txtEmail" runat="server" Width="276px" Height="83px" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Email Id" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td align="left" style="width: 100px; color: red;">
                                                    <asp:Label ID="lblMobileSample" runat="server" Text="*Example : abc@gmail.com, xyz@yahoo.com" Width="282px" ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px;" class="lbl">Subject :</td>
                                                <td align="left" style="width: 100px; height: 15px;">
                                                    <asp:TextBox ID="txtSubject" runat="server" Height="50px" TextMode="MultiLine" Width="283px"></asp:TextBox>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubject" ErrorMessage="Please Enter EMail subject" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" Width="276px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px;" class="lbl">Email Message :</td>
                                                <td align="left" style="width: 100px; height: 15px;">
                                                    <asp:TextBox ID="txtEmailMsg" runat="server" Height="50px" TextMode="MultiLine" Width="283px"></asp:TextBox>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px;">
                                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" Width="276px" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmailMsg" ErrorMessage="Please Enter Email Message" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px;"></td>
                                                <td align="left" style="width: 100px; height: 15px; padding-left: 10px;">
                                                    <asp:Button ID="btnSendEmail" runat="server" Text="Send E-Mail" CssClass="Btn"  OnClick="btnSendEmail_Click" />
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px;"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="height: 15px">
                                                    <asp:Label ID="txtlblMsg" runat="server"  Font-Names="Verdana" Font-Size="11px" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px;"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--<asp:ValidationSummary ID="ValidationSummary3" runat="server" Font-Size="11px" Height="1px" ShowMessageBox="True" ShowSummary="False" ValidationGroup="one" Width="208px" />
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtdateofbirth" TargetControlID="txtdateofbirth"></ajaxToolkit:CalendarExtender>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtFromDate" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txttoDate" TargetControlID="txttoDate"></ajaxToolkit:CalendarExtender>--%>
                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtfromdate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        $(function () {
            $("#<%=txttodate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        $(function () {
            $("#<%=txtdateofbirth.ClientID%>").datepicker(
                   {
                       dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
</asp:Content>