<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="mySkin" CodeFile="UnverifyUsersReport.aspx.cs" Inherits="PowerControl_UnverifyUsersReport" Title="Unverified Users Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .table-responsive {
            margin-bottom: 0;
        }
    </style>
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
                        //row.style.backgroundColor = "aqua";  
                        inputList[i].checked = true;
                    }
                    else {
                        //If the header checkbox is checked  
                        //uncheck all checkboxes  
                        //and change rowcolor back to original   
                        if (row.rowIndex % 2 == 0) {
                            //Alternating Row Color  
                            // row.style.backgroundColor = "#C2D69B";  
                        }
                        else {
                            // row.style.backgroundColor = "white";  
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }
    </script>
    <div class="container-fluid">
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" CssClass="form-control" AutoComplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" MaxLength="12" CssClass="form-control" AutoComplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Select one: </label>
                    <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged" CssClass="form-control">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="Name">Name</asp:ListItem>
                        <asp:ListItem Value="Screen">Member ID</asp:ListItem>
                        <asp:ListItem Value="Email">Email</asp:ListItem>
                        <asp:ListItem Value="Mobile">Mobile No</asp:ListItem>
                        <asp:ListItem Value="Mobile">Mobile No</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12" id="detsdv"  runat="server">
                <div class="form-group">
                    <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="form-control blnk-input" Visible="False"></asp:DropDownList>
                    <asp:TextBox ID="txtSearch" runat="server" MaxLength="30" Text="" Visible="False" CssClass="form-control blnk-input"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input go" OnClick="btnSearch_Click" Text="Submit" CausesValidation="False" />
                </div>
            </div>
            <div class="col-md-2 col-12">
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
        <div class="row" id="EmailSend" runat="server" style="margin-top: 20px; display: none;">
            <div class="col-md-12 col-12 form-horizontal">
                <div class="row form-group">
                    <asp:Label ID="lblSmsMsg" runat="server" Font-Size="11px"></asp:Label>
                </div>
                <div class="row form-group">
                    <div class="col-md-3 col-12 control-label">
                        <asp:Label ID="lblmobiUSD" runat="server" Text="EMail Id(s)"></asp:Label>
                    </div>
                    <div class="col-md-6 col-12">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Email Id" SetFocusOnError="True">*</asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="col-md-3 col-12">
                        <asp:Label ID="lblMobileSample" runat="server" Text="*Example : abc@gmail.com" ForeColor="Black" Font-Size="11px"></asp:Label>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-md-3 col-12 control-label">
                        <label>Subject :</label>
                    </div>
                    <div class="col-md-6 col-12">
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubject" ErrorMessage="Please Enter EMail subject" SetFocusOnError="True">*</asp:RequiredFieldValidator>--%>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
                    </div>
                    <div class="col-md-3 col-12"></div>
                </div>
                <div class="row form-group">
                    <div class="col-md-3 col-12 control-label">
                        <label>Email Message :</label>
                    </div>
                    <div class="col-md-6 col-12">
                        <asp:TextBox ID="txtEmailMsg" runat="server"  TextMode="MultiLine" CssClass="form-control" Height="90px"></asp:TextBox>
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmailMsg" ErrorMessage="Please Enter Email Message" SetFocusOnError="True">*</asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="col-md-3 col-12"></div>
                </div>
                <div class="row">
                    <div class="col-md-offset-3 col-md-6 col-12">
                        <asp:Button ID="btnSendEmail" runat="server" Text="Send E-Mail" CssClass="OuterBtn" OnClick="btnSendEmail_Click" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-12">
                        <asp:Label ID="txtlblMsg" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <asp:Label ID="lblTotalData" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="False" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo">
                                <ItemTemplate>
                                    <%#Eval("SrNo")%>
                                    .
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <%--<HeaderTemplate>
                                    <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);" />
                                </HeaderTemplate>--%>
                                <itemtemplate>
                                    <asp:CheckBox ID="chkMemID" runat="server" AutoPostBack="true" OnCheckedChanged="chkMemID_CheckedChanged" />
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <itemtemplate>
                                    <asp:Label runat="server" ID="lblMemId" Text='<%# Eval("MEMID") %>' Visible="false"></asp:Label>
                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" OnClientClick="return ConfirmChoice();" OnClick="lnkDelete_Deleting"></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Verify">
                                <itemtemplate>
                                    <a href='../Verification.html?acc=<%#DataBinder.Eval(Container.DataItem, "RegnCNFCode")%>' target="_blank">Verify </a>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Resend Link">
                                <itemtemplate>
                                    <asp:LinkButton ID="lnkVerify" CausesValidation="false" runat="server" OnClick="lnkVerify_Click">Resend Link</asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Member ID">
                                <itemtemplate>
                                    <%#Eval("MEMID") %>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <itemtemplate>
                                    <asp:Label ID="lblMNAME" runat="server" Text='<%#Eval("MNAME") %>'></asp:Label>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile">
                                <itemtemplate>
                                    <asp:Label ID="lblMOBILE" runat="server" Text='<%#Eval("MOBILE") %>'></asp:Label>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <itemtemplate>
                                    <asp:Label ID="lblEMAIL" runat="server" Text='<%#Eval("EMAIL") %>'></asp:Label>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sponser">
                                <itemtemplate>
                                    <asp:Label ID="lblspnsr" runat="server" Text='<%#Eval("SponserID") %>'></asp:Label>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Verification Code">
                                <itemtemplate>
                                    <asp:Label ID="lblRegnCNFCode" runat="server" Text='<%#Eval("RegnCNFCode") %>'></asp:Label>
                                    <asp:Label ID="lblTxnPwd" runat="server" Text='<%#Eval("TxnPwd") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblLogPwd" runat="server" Text='<%#Eval("LogPwd") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblSponserID" runat="server" Text='<%#Eval("SponserID") %>' Visible="false"></asp:Label>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sign Up Date">
                                <itemtemplate>
                                    <%#Eval("Doj") %>
                                </itemtemplate>
                            </asp:TemplateField>
                        </Columns>
                        <emptydatatemplate>Record Not Found</emptydatatemplate>
                    </asp:GridView>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <%--<table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="padding: 0px;" colspan="2">
                <table width="100%">
                    <tr>
                        <td align="center" colspan="3" style="height: 10px"></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <table border="0" cellpadding="0" cellspacing="0" style="font-size: 11px; font-family: 'Poppins', sans-serif; background-color: White; width: 100%;">
                                <tr>
                                    <td align="left" style="height: 26px; width: 60px;" valign="middle">From :</td>
                                    <td align="left" style="height: 26px; width: 105px;" valign="middle">
                                        <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" Width="100px" AutoComplete="Off"></asp:TextBox>
                                    </td>
                                    <td align="left" style="height: 26px; width: 23px;" valign="middle">&nbsp;</td>
                                    <td align="right" style="height: 26px; width: 50px;" valign="middle">To :</td>
                                    <td align="left" style="height: 26px; width: 105px;" valign="middle">
                                        <asp:TextBox ID="txtToDate" runat="server" MaxLength="12" Width="100px" AutoComplete="Off"></asp:TextBox>
                                    </td>
                                    <td align="left" style="height: 26px; width: 24px;" valign="middle"></td>
                                    <td align="left" style="width: 87px; height: 26px" valign="middle">Select one:</td>
                                    <td align="left" style="width: 115px; height: 26px" valign="middle">
                                        <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged" Width="112px">
                                            <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem Value="Name">Name</asp:ListItem>
                                            <asp:ListItem Value="Screen">Member ID</asp:ListItem>
                                            <asp:ListItem Value="Email">Email</asp:ListItem>
                                            <asp:ListItem Value="Mobile">Mobile No</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" style="width: 120px; height: 26px" valign="middle">
                                        <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="ComposeTxtBx" Visible="False" Width="110px"></asp:DropDownList>
                                        <asp:TextBox ID="txtSearch" runat="server" MaxLength="30" Text="" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td align="left" style="height: 26px; padding-left: 5px;" valign="middle">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn" OnClick="btnSearch_Click" Text="Submit" CausesValidation="False" />
                                    </td>
                                    <td align="right" style="padding-left: 5px; height: 26px" valign="middle">
                                        <%=PageNo%>
                                        -
                                        <%=Pagesize %>
                                        of
                                        <asp:Label ID="lblTotRec" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr id="EmailSend" runat="server">
                                    <td align="left" colspan="11" style="height: 26px" valign="middle">
                                        <table align="left" style="font-size: 11px">
                                            <tr>
                                                <td align="left" colspan="3" style="height: 27px"><asp:Label ID="lblSmsMsg" runat="server" Font-Size="11px"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px" class="lbl">
                                                    <asp:Label ID="lblmobiUSD" runat="server" Text="EMail Id(s)" Width="80px"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 100px">
                                                    <asp:TextBox ID="txtEmail" runat="server" Width="283px" Height="83px" TextMode="MultiLine"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Email Id" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td align="left" style="width: 100px; color: red">
                                                    <asp:Label ID="lblMobileSample" runat="server" Text="*Example : abc@gmail.com, xyz@yahoo.com" Width="282px" ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px" class="lbl">Subject :</td>
                                                <td align="left" style="width: 100px; height: 15px">
                                                    <asp:TextBox ID="txtSubject" runat="server" Height="50px" TextMode="MultiLine" Width="283px"></asp:TextBox>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubject" ErrorMessage="Please Enter EMail subject" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" Width="276px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px" class="lbl">Email Message :</td>
                                                <td align="left" style="width: 100px; height: 15px">
                                                    <asp:TextBox ID="txtEmailMsg" runat="server" Height="50px" TextMode="MultiLine" Width="283px"></asp:TextBox>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px">
                                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" Width="276px" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmailMsg" ErrorMessage="Please Enter Email Message" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 129px; height: 15px"></td>
                                                <td align="left" style="width: 100px; height: 15px; padding-left: 10px;">
                                                    <asp:Button ID="btnSendEmail" runat="server" Text="Send E-Mail" CssClass="Btn" OnClick="btnSendEmail_Click" />
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="2" style="height: 15px">
                                                    <asp:Label ID="txtlblMsg" runat="server" Font-Names="Verdana" Font-Size="11px" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td align="left" style="width: 100px; height: 15px"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="9" valign="middle">
                <center>
                    <asp:Label ID="lblTotalData" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>
                </center>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="9" valign="middle" style="padding-top: 10px">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 100%" colspan="2">--%>
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