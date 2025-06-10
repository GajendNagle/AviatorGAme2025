<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="Account-Setting-User.aspx.cs" Inherits="Adm962xts21qtj_Account_Setting_User" StylesheetTheme="MySkin" Title="Account Setting User !!" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .RowStyle {
            height: 50px;
        }
        .AlternateRowStyle {
            height: 50px;
        }
    </style>
    <div class="container-fluid">
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>
                        <asp:Label ID="lblMemId" runat="server" Text="MemberID: "></asp:Label>
                    </label>
                    <asp:TextBox ID="TxtMemID" runat="server" MaxLength="20" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnGetDetail" runat="server" Text="Show Detail" CssClass="OuterBtn blnk-input go" OnClick="GetMemIDDetail" OnClientClick="return validateForm()" />
                <asp:HiddenField ID="hdnID" runat="server" />
            </div>
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg1" runat="server" Font-Bold="True" Font-Size="11px" ForeColor="Red" Width="280px"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <span style="color: Red; font-weight: bold; font-size: 15px;" class="total-record">Note: Active:- STOP SERVICE , De-Active:- START SERVICE </span>
            </div>
            <div class="col-md-6 col-12">
                <div class="pgsizes">
                    <asp:Label ID="lblRecordNo" runat="server"></asp:Label>
                    &nbsp; 
                    <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="table-responsive">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lbpro" runat="server" Text="Profile: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cbProfile" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsgProf" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lblogin" runat="server" Text="Login: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cbLogin" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsgLog" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lbregis" runat="server" Text="Registeration: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cbRegister" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsgReg" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lbtopup" runat="server" Text="Deposit: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cbTopUp" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsgTopup" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lbwithdr" runat="server" Text="Withdrawal: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cbWithDrawal" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsgWithdra" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lblevlCommBonus" runat="server" Text="Referral Bonus: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="cblvlbonus" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="TxtMsglvlbonus" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; text-align: left;">
                                            <asp:Label ID="lblstkdiviwid" runat="server" Text="Stake Divi. Withdrawal: " Visible="false"></asp:Label>
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                            <asp:CheckBoxList ID="chkstkdiviwid" runat="server" AutoPostBack="false" RepeatDirection="Horizontal" RepeatLayout="Flow" Visible="false">
                                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                <asp:ListItem Text="De-Active" Value="De-Active"></asp:ListItem>
                                                <asp:ListItem Text="" Value="" style="display: none;"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                            <asp:TextBox ID="Txtmsgstkdiviwid" runat="server" MaxLength="100" Width="700px" Visible="false"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <asp:Button ID="btnsave" runat="server" Text="Save Detail" Width="100%" OnClick="SaveDetail" CssClass="OuterBtn" Visible="false" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td><br /></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmptyMsg" runat="server" Text=""></asp:Label>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id" EnableTheming="True" Width="100%" OnSelectedIndexChanged="OnSelectedIndexChanged" OnRowDataBound="OnRowDataBound">
                                    <RowStyle Height="50" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Mem ID">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxheading" runat="server" TextMode="MultiLine" Text='<%#Eval("MemID")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("MName")%><br />
                                                <%--<a onclick="FillDetails('<%#Eval("ID")%>','<%#Eval("MemID")%>','<%#Eval("Login")%>','<%#Eval("Profile")%>','<%#Eval("Registration")%>','<%#Eval("TopUp")%>','<%#Eval("Withdrawal")%>','<%#Eval("Mesag_Login")%>','<%#Eval("Mesag_Profile")%>','<%#Eval("Mesag_Register")%>','<%#Eval("Mesag_TopUp")%>','<%#Eval("Mesag_WithDrawal")%>');" style="cursor: pointer; color: Blue;"> <%#Eval("MemID")%></a>--%>
                                                <asp:LinkButton ID="lnkbtn" runat="server" CommandName="Select" Style="cursor: pointer; color: Blue;" Text='<%#Eval("MemID")%>'></asp:LinkButton>
                                                <asp:HiddenField ID="hidenID" Value='<%#Eval("ID")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Login">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxlogin" runat="server" TextMode="MultiLine" Text='<%#Eval("Login")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("Login")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Profile">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxprofile" runat="server" TextMode="MultiLine" Text='<%#Eval("Profile")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("Profile")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sign-Up">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxregister" runat="server" TextMode="MultiLine" Text='<%#Eval("Registration")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("Registration")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deposit">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxtopup" runat="server" TextMode="MultiLine" Text='<%#Eval("TopUp")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("TopUp")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Withdrawal">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxwithdrawal" runat="server" TextMode="MultiLine" Text='<%#Eval("Withdrawal")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("Withdrawal")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ReffBonus">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxwithdrawal" runat="server" TextMode="MultiLine" Text='<%#Eval("LvlBonus")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("LvlBonus")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="StkDiviWid">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtStkDiviwithdrawal" runat="server" TextMode="MultiLine" Text='<%#Eval("StkDiviWid")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("StkDiviWid")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Login-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxlogmsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_Login")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblomsg" runat="server" Text='<%#Eval("Mesag_Login")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Profile-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxprofmsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_Profile")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbprmsg" runat="server" Text='<%#Eval("Mesag_Profile")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sign-Up-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxregistermsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_Register")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbremsg" runat="server" Text='<%#Eval("Mesag_Register")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deposit-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxtopupmsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_TopUp")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbtomsg" runat="server" Text='<%#Eval("Mesag_TopUp")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Withdrawal-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxwithdramsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_WithDrawal")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbwimsg" runat="server" Text='<%#Eval("Mesag_WithDrawal")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ReffBonus-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxlvlbnsmsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_LvlBonus")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblvlbnsmsg" runat="server" Text='<%#Eval("Mesag_LvlBonus")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="StkDiviWith-MSG">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtStkDiviWithmsg" runat="server" TextMode="MultiLine" Text='<%#Eval("Mesag_StkDiviWithDrawal")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblstkwithmsg" runat="server" Text='<%#Eval("Mesag_StkDiviWithDrawal")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Update Date">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtbxstdate" runat="server" Text='<%#Eval("Act_Dt")%>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <%#Eval("Act_Dt")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" Height="30px" />
                                    <EmptyDataTemplate>
                                        <span style="font: bold 13px verdana; color: Red;">---Oooops, Record Not Found---</span>
                                    </EmptyDataTemplate>
                                    <PagerStyle Font-Size="12px" />
                                    <HeaderStyle Height="30px" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
    <script type="text/javascript">
        function CheckOnlyOneP(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cbProfile.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOneL(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cbLogin.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOneR(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cbRegister.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOneT(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cbTopUp.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOneW(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cbWithDrawal.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOnelvlbns(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= cblvlbonus.ClientID %>'); // give checkboxlist name
            var chks = chkBox.getElementsByTagName('INPUT');
            for (i = 0; i < chks.length; i++) {
                if (chks[i] != checker)
                    chks[i].checked = false;
            }
        }
        function CheckOnlyOneStkDiviWid(e) {
            if (!e) e = window.event;
            var sender = e.target || e.srcElement;
            if (sender.nodeName != 'INPUT') return;
            var checker = sender;
            var chkBox = document.getElementById('<%= chkstkdiviwid.ClientID %>'); // give checkboxlist name
              var chks = chkBox.getElementsByTagName('INPUT');
              for (i = 0; i < chks.length; i++) {
                  if (chks[i] != checker)
                      chks[i].checked = false;
              }
          }
        function validateForm() {
            var x = document.getElementById('<%= TxtMemID.ClientID %>').value;
            if (x == "") {
                alert("MemberID must be filled out");
                return false;
            }
        }
        function FilDetais(MemID) {
            //document.getElementById('<%= hdnID.ClientID %>').value = ID;
            //document.getElementById('<%= TxtMemID.ClientID %>').value = MemID;
            alert("MemberID must be filled out");
            return false;
        }
    </script>
</asp:Content>