<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" AutoEventWireup="true" CodeFile="Admin-Deposit-Address.aspx.cs" Inherits="Adm962xts21qtj_Admin_Deposit_Address" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="adnewss">
            <div class="row justify-content-center">
                <div class="col-md-12 col-12">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                </div>
                <div class="col-md-2 col-12 text-md-right text-left">
                    <label>Wallet Address::</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtwltaddress" ValidationGroup="g" Placeholder="Ex: '0x590468a06596575Cf6CAEc62928649000000000'" runat="server" MaxLength="70" CssClass="form-control" Width="100%" AutoComplete="Off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtwltaddress" ValidationGroup="g" runat="server" ErrorMessage="Enter Wallet Address">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-left">
                    <label>Date:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtFromDate" runat="server" Width="100%" CssClass="ComposeTxtBx" AutoComplete="off" style="margin-bottom: 0px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="g" ControlToValidate="txtFromDate"  ErrorMessage="Select Date" SetFocusOnError="True" Width="1px">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-left">
                    <label>Currency Type:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="ComposeTxtBx form-control">
                        <%--OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged"--%>
                        <asp:ListItem>Choose Currency</asp:ListItem>
                        <asp:ListItem Value="BNB">BEP20</asp:ListItem>
                      <%--  <asp:ListItem Value="TRON">TRC20</asp:ListItem>--%>
                        <%--<asp:ListItem Value="Ethereum">Ethereum</asp:ListItem>
                        <asp:ListItem Value="Bitcoin">Bitcoin</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-left">
                    <label>Admin Password:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtpassword" runat="server" AutoComplete="off" style="margin-bottom: 0px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtpassword" ErrorMessage="Enter Admin Password" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-left">
                    <label></label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:Button ID="btnpass" runat="server" Font-Bold="False" OnClick="btnSearch_Click" ValidationGroup="g" Text="Submit" Width="78px" CssClass="OuterBtn" />
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-12 col-12" style="float: right; text-align: right; margin-top: 5px;">
                    <div class="pagsnos">
                        <%=PageNo%>
                            -
                        <%=Pagesize %>
                        of
                        <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>
                        &nbsp;
                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-12 col-12"><br />
                    <div id="divPrint">
                        <asp:Label ID="lblEmptyMsg" runat="server" Text=""></asp:Label>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" CssClass="table-News gvMain">
                            <Columns>
                                <asp:TemplateField HeaderText="SrNo">
                                    <ItemTemplate>
                                        <%--<%#Eval("SrNo")%>--%>
                                        <%# Container.DataItemIndex+1 %>
                                        .
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <%--<HeaderTemplate>
                                        <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);" />
                                    </HeaderTemplate>--%>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMemID" runat="server" AutoPostBack="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblMemId" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" OnClientClick="return ConfirmChoice();" OnClick="lnkDelete_Deleting"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Member ID" Visible="false">
                                    <ItemTemplate>
                                        <%#Eval("Memid") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bank Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBNAME" runat="server" Text='<%#Eval("BankName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Account No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblaccno" runat="server" Text='<%#Eval("AccountNo") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Account Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEMAIL" runat="server" Text='<%#Eval("TransactionCurrency") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblspnsr" runat="server" Text='<%#Eval("Ac_date") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                Record Not Found
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">&nbsp;</div>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
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
        </script>
</asp:Content>