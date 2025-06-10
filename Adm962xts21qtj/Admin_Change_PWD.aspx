<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="Admin_Change_PWD.aspx.cs" Inherits="Adm962xts21qtj_Admin_Change_PWD" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="subx">
            <div class="row">
                <div class="col-md-9 col-md-offset-3 col-12 form-horizontal">
                    <div class="row form-group">
                        <div class="col-md-3 col-12 control-label">
                            <label> Admin ID</label>
                        </div>
                        <div class="col-md-4 col-12">
                            <asp:TextBox ID="txtloginid" runat="server" ValidationGroup="g" MaxLength="15" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-5 col-12">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtloginid" ErrorMessage="Enter User Name" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-3 col-12 control-label">
                            <label> Old Password:</label>
                        </div>
                        <div class="col-md-4 col-12">
                            <asp:TextBox ID="txtoldpass" runat="server" CssClass="form-control" MaxLength="30"></asp:TextBox>
                        </div>
                        <div class="col-md-5 col-12">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtoldpass" ErrorMessage="Enter Previous Password">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-3 col-12 control-label">
                            <label> New Password:</label>
                        </div>
                        <div class="col-md-4 col-12">
                            <asp:TextBox ID="txtnewpass" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15"></asp:TextBox>
                        </div>
                        <div class="col-md-5 col-12">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewpass" ErrorMessage="Enter New Password" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToCompare="txtnewpass" ControlToValidate="txtconfpass" ErrorMessage="New Password or Confirm Password Must Match" SetFocusOnError="True" Width="1px">*</asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="RegExp1" runat="server" ErrorMessage="Password length must be between 6 to 15 characters" ControlToValidate="txtnewpass" ValidationExpression="^[a-zA-Z0-9\s]{6,15}$" Text="*" ValidationGroup="g" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtnewpass" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$" ErrorMessage="Password must contain: Minimum 6 characters atleast 1 Alphabet and 1 Number" ForeColor="Red" Text="*" />
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-3 col-12 control-label">
                            <label> Confirm Password:</label>
                        </div>
                        <div class="col-md-4 col-12">
                            <asp:TextBox ID="txtconfpass" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15"></asp:TextBox>
                        </div>
                        <div class="col-md-5 col-12">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtconfpass" ErrorMessage="Enter Confirm Password" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Password length must be between 6 to 15 characters" ControlToValidate="txtconfpass" ValidationExpression="^[a-zA-Z0-9\s]{6,15}$" Text="*" ValidationGroup="g" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtconfpass" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$" ErrorMessage="Password must contain: Minimum 6 characters atleast 1 Alphabet and 1 Number" ForeColor="Red" Text="*" />
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12 col-12">
                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Width="100%"></asp:Label>
                        </div>
                        <div class="col-md-4 col-md-offset-3 col-12">
                            <asp:Button ID="btnChangePsw" runat="server" CssClass="OuterBtn" OnClick="btnChangePsw_Click" Text="Change Password" ValidationGroup="g" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--<div style="width: 100%;">
        <center>
            <table cellpadding="0" cellspacing="0" align="center" class="MtblCntReg">
                <tr>
                    <td></td>
                    <td></td>
                    <td class="lbl"></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td class="lbl">Admin ID:</td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:TextBox Font-Names="Verdana" ID="txtloginid" runat="server" ValidationGroup="g" MaxLength="15" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtloginid" ErrorMessage="Enter User Name" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td class="lbl">Old Password:</td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:TextBox ID="txtoldpass" runat="server" CssClass="form-control" MaxLength="30"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtoldpass" ErrorMessage="Enter Previous Password">*</asp:RequiredFieldValidator>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td class="lbl">New Password:</td>
                    <td></td>
                </tr>
                <tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:TextBox ID="txtnewpass" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewpass" ErrorMessage="Enter New Password" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToCompare="txtnewpass" ControlToValidate="txtconfpass" ErrorMessage="New Password or Confirm Password Must Match" SetFocusOnError="True" Width="1px">*</asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="RegExp1" runat="server" ErrorMessage="Password length must be between 6 to 15 characters" ControlToValidate="txtnewpass" ValidationExpression="^[a-zA-Z0-9\s]{6,15}$" Text="*" ValidationGroup="g" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtnewpass" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$" ErrorMessage="Password must contain: Minimum 6 characters atleast 1 Alphabet and 1 Number" ForeColor="Red" Text="*" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 18px;"></td>
                        <td style="height: 18px;"></td>
                        <td style="height: 18px;" class="lbl">Confirm Password:</td>
                        <td style="height: 18px;"></td>
                    </tr>
                    <tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:TextBox ID="txtconfpass" runat="server" CssClass="form-control" TextMode="Password" MaxLength="15"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtconfpass" ErrorMessage="Enter Confirm Password" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Password length must be between 6 to 15 characters" ControlToValidate="txtconfpass" ValidationExpression="^[a-zA-Z0-9\s]{6,15}$" Text="*" ValidationGroup="g" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtconfpass" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$" ErrorMessage="Password must contain: Minimum 6 characters atleast 1 Alphabet and 1 Number" ForeColor="Red" Text="*" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Width="100%"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td class="lbl">
                                <asp:Button ID="btnChangePsw" runat="server" CssClass="OuterBtn" OnClick="btnChangePsw_Click" Text="Change Password" ValidationGroup="g" />
                            </td>
                            <td></td>
                        </tr>
                    </tr>
                </tr>
            </table>
        </center>
    </div>--%>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="datalevel" ShowMessageBox="True" ShowSummary="False" ValidationGroup="g" />
</asp:Content>