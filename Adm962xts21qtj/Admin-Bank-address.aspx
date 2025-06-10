<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" CodeFile="Admin-Bank-address.aspx.cs" Inherits="Adm962xts21qtj_Admin_Bank_address" Title="Add Bank Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .m-w-100 {
            min-width: 100px;
        }
        @media(max-width: 767px) {
            .text-sm-left {
                text-align: left!important;
            }
        }
    </style>
    <div class="container-fluid">
        <div class="adnewss">
            <div class="row justify-content-center">
                <div class="col-md-12 col-12">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                </div>
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Payment Mode:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:DropDownList ID="ddlmode" runat="server" OnSelectedIndexChanged="ddlmode_SelectedIndexChanged" AutoPostBack="true" CssClass="ComposeTxtBx form-control">
                        <asp:ListItem>Choose Payment Mode</asp:ListItem>
                        <asp:ListItem Value="Bank">Bank</asp:ListItem>
                        <asp:ListItem Value="QRCode">QRCode</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Bank Type:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="ComposeTxtBx form-control">
                        <%--OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged"--%>
                        <asp:ListItem>Choose Bank</asp:ListItem>
                        <asp:ListItem Value="Abhyudaya Co-operative Bank Ltd.">Abhyudaya Co-operative Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value="Abu Dhabi Commercial Bank Ltd.">Abu Dhabi Commercial Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">Allahabad Bank">Allahabad Bank</asp:ListItem>
                        <asp:ListItem Value=">American Express Bank Ltd.">American Express Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">Andhra Bank">Andhra Bank</asp:ListItem>
                        <asp:ListItem Value=">Antwerp Diamond Bank N.V.">Antwerp Diamond Bank N.V.</asp:ListItem>
                        <asp:ListItem Value=">Apna Sahakari Bank Ltd">Apna Sahakari Bank Ltd</asp:ListItem>
                        <asp:ListItem Value="Apex Bank">Apex Bank</asp:ListItem>
                        <asp:ListItem Value="Arab Bangladesh Bank Limited">Arab Bangladesh Bank Limited</asp:ListItem>
                        <asp:ListItem Value="Axis Bank">Axis Bank</asp:ListItem>
                        <asp:ListItem Value="AU Small Finence Bank">AU Small Finence Bank</asp:ListItem>
                        <asp:ListItem Value="Bandhan Bank">Bandhan Bank</asp:ListItem>
                        <asp:ListItem Value="Bank Internasional Indonesia">Bank Internasional Indonesia</asp:ListItem>
                        <asp:ListItem Value="Bank of America N.A.">Bank of America N.A.</asp:ListItem>
                        <asp:ListItem Value="Bank of Bahrain Kuwait BSC">Bank of Bahrain Kuwait BSC</asp:ListItem>
                        <asp:ListItem Value="Bank of Baroda">Bank of Baroda</asp:ListItem>
                        <asp:ListItem Value="Bank of Ceylon">Bank of Ceylon</asp:ListItem>
                        <asp:ListItem Value="Bank of India">Bank of India</asp:ListItem>
                        <asp:ListItem Value="Bank of Maharashtra">Bank of Maharashtra</asp:ListItem>
                        <asp:ListItem Value="Barclays Bank Plc">Barclays Bank Plc</asp:ListItem>
                        <asp:ListItem Value="Baroda Rajasthan Kshetriya Garmin Bank">Baroda Rajasthan Kshetriya Garmin Bank </asp:ListItem>
                        <asp:ListItem Value="BASSEIN CATHOLIC CO-OPERATIVE BANK LTD">BASSEIN CATHOLIC CO-OPERATIVE BANK LTD</asp:ListItem>
                        <asp:ListItem Value="BNP PARIBAS">BNP PARIBAS</asp:ListItem>
                        <asp:ListItem Value="Calyon Bank">Calyon Bank</asp:ListItem>
                        <asp:ListItem Value="Canara Bank">Canara Bank</asp:ListItem>
                        <asp:ListItem Value="Catholic Syrian Bank Ltd.">Catholic Syrian Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value="Central Bank of India">Central Bank of India</asp:ListItem>
                        <asp:ListItem Value="Chembur Nagarik Sahakari Bank LTD.">Chembur Nagarik Sahakari Bank LTD.</asp:ListItem>
                        <%--<asp:ListItem Value=">Chinatrust Commercial Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">Cho Hung Bank</asp:ListItem>
                        <asp:ListItem Value=">Citibank N.A.</asp:ListItem>
                        <asp:ListItem Value=">City Union Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">Coastal Local Area Bank Ltd</asp:ListItem>
                        <asp:ListItem Value=">Corporation Bank</asp:ListItem>
                        <asp:ListItem Value=">DBS Bank India</asp:ListItem>
                        <asp:ListItem Value=">Dena Bank</asp:ListItem>
                        <asp:ListItem Value=">Dena Gujarat Garmin Bank</asp:ListItem>
                        <asp:ListItem Value=">Deutsche Bank AG</asp:ListItem>
                        <asp:ListItem Value=">Development Credit Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">DHANLAXMI BANK</asp:ListItem>
                        <asp:ListItem Value=">Dombivali Nagarik Sahakari Bank LTD.</asp:ListItem>
                        <asp:ListItem Value=">Export-Import Bank of India</asp:ListItem>
                        <asp:ListItem Value=">Federal bank</asp:ListItem>
                        <asp:ListItem Value=">Fino payment bank</asp:ListItem>
                        <asp:ListItem Value=">HDFC Bank</asp:ListItem>
                        <asp:ListItem Value=">ICICI Bank</asp:ListItem>
                        <asp:ListItem Value=">IDBI Bank Industrial Development Bank of India</asp:ListItem>
                        <asp:ListItem Value=">IDBI Bank Limited</asp:ListItem>
                        <asp:ListItem Value=">Idfc bank</asp:ListItem>
                        <asp:ListItem Value=">India Post Payments Bank</asp:ListItem>
                        <asp:ListItem Value=">Indian Bank</asp:ListItem>
                        <asp:ListItem Value=">Indian Overseas Bank</asp:ListItem>
                        <asp:ListItem Value=">IndusInd Bank Limited</asp:ListItem>
                        <asp:ListItem Value=">Industrial Investment Bank of India Ltd.</asp:ListItem>
                        <asp:ListItem Value=">ING Vysya Bank</asp:ListItem>
                        <asp:ListItem Value=">J P Morgan Chase Bank, National Association</asp:ListItem>
                        <asp:ListItem Value=">JAMMU AND KASHMIR BANK</asp:ListItem>
                        <asp:ListItem Value=">Karnataka Bank</asp:ListItem>
                        <asp:ListItem Value=">Karur Vysya Bank Limited.</asp:ListItem>
                        <asp:ListItem Value=">Khattri Co-operative Urban Bank Ltd</asp:ListItem>
                        <asp:ListItem Value=">Kotak Mahindra Bank Limited</asp:ListItem>
                        <asp:ListItem Value=">Krung Thai Bank Public Company Limited</asp:ListItem>
                        <asp:ListItem Value=">Lakshmi Vilas Bank</asp:ListItem>
                        <asp:ListItem Value=">Mashreqbank psc</asp:ListItem>
                        <asp:ListItem Value=">Mizuho Corporate Bank Ltd.</asp:ListItem>
                        <asp:ListItem Value=">National Bank for Agriculture and Rural Development</asp:ListItem>
                        <asp:ListItem Value=">National Housing Bank</asp:ListItem>
                        <asp:ListItem Value=">North Eastern Development Finance Corporation</asp:ListItem>
                        <asp:ListItem Value=">Oman International Bank S A O G</asp:ListItem>
                        <asp:ListItem Value=">Oriental Bank of Commerce</asp:ListItem>
                        <asp:ListItem Value=">PASCHIM BANGA GRAMIN BANK</asp:ListItem>
                        <asp:ListItem Value=">Pragathi Krishna Gramin Bank</asp:ListItem>
                        <asp:ListItem Value=">Prathama Bank</asp:ListItem>
                        <asp:ListItem Value=">Punjab &amp; Sind Bank</asp:ListItem>
                        <asp:ListItem Value=">Punjab National Bank</asp:ListItem>
                        <asp:ListItem Value=">RAJASTHAN MARUDHARA GRAMIN BANK</asp:ListItem>
                        <asp:ListItem Value=">SARVA HARIYANA GRAMIN BANK</asp:ListItem>
                        <asp:ListItem Value=">SARASWAT BANK</asp:ListItem>
                        <asp:ListItem Value=">Small Industries Development Bank of India</asp:ListItem>
                        <asp:ListItem Value=">Societe Generale</asp:ListItem>
                        <asp:ListItem Value=">Sonali Bank</asp:ListItem>
                        <asp:ListItem Value=">Standard Chartered Bank</asp:ListItem>
                        <asp:ListItem Value=">State Bank of Bikaner and Jaipur</asp:ListItem>
                        <asp:ListItem Value=">State Bank of Hyderabad</asp:ListItem>
                        <asp:ListItem Value=">State Bank of India</asp:ListItem>
                        <asp:ListItem Value=">State Bank of Mauritius Ltd.</asp:ListItem>
                        <asp:ListItem Value=">State Bank of Mysore</asp:ListItem>
                        <asp:ListItem Value=">State Bank of Patiala</asp:ListItem>
                        <asp:ListItem Value=">Syndicate Bank</asp:ListItem>
                        <asp:ListItem Value=">The Cosmos Co-operative Bank Ltd</asp:ListItem>
                        <asp:ListItem Value=">Tripura Gramin Bank</asp:ListItem>
                        <asp:ListItem Value=">Yes Bank</asp:ListItem>
                        <asp:ListItem Value=">Union Bank Of India</asp:ListItem>
                        <asp:ListItem Value=">United bank of india</asp:ListItem>
                        <asp:ListItem Value=">UCO Bank</asp:ListItem>
                        <asp:ListItem Value=">Vijaya Bank</asp:ListItem>
                        <asp:ListItem Value=">Zila Sahkari Bank</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Choose Account Type:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:DropDownList ID="ddlActctype" runat="server" CssClass="ComposeTxtBx form-control">
                        <asp:ListItem>Choose Account Type</asp:ListItem>
                        <asp:ListItem Value="Saving Account">Saving Account</asp:ListItem>
                        <asp:ListItem Value="Current Account">Current Account</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>A/c Name:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtAcname" runat="server" AutoComplete="off" Style="margin-bottom: 0px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAcname" ErrorMessage="Enter Admin Password" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>IFSC Code:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtifsccode" runat="server" AutoComplete="off" Style="margin-bottom: 0px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtifsccode" ErrorMessage="Enter Admin Password" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <%--<div class="col-md-12 col-12">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>
                </div>--%>
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Account No:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtwltaddress" ValidationGroup="g" Placeholder="Ex: '0x590468a06596575Cf6CAEc62928649000000000'" runat="server" MaxLength="70" CssClass="form-control" Width="100%" AutoComplete="Off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtwltaddress" ValidationGroup="g" runat="server" ErrorMessage="Enter Wallet Address">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Date:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtFromDate" runat="server" Width="100%" CssClass="ComposeTxtBx" AutoComplete="off" Style="margin-bottom: 0px;" placeholder="dd/mm/yyyy"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="g" ControlToValidate="txtFromDate" ErrorMessage="Select Date" SetFocusOnError="True" Width="1px">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center" id="Qrcode" runat="server">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>QR Code:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:FileUpload ID="FileUploadImg" CssClass="ComposeTxtBx" runat="server" />
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
                    <label>Admin Password:</label>
                </div>
                <div class="col-md-4 col-12">
                    <asp:TextBox ID="txtpassword" runat="server" AutoComplete="off" Style="margin-bottom: 0px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtpassword" ErrorMessage="Enter Admin Password" SetFocusOnError="true" ValidationGroup="g">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-2 col-12 text-md-right text-sm-left">
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
                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" Font-Names="poppins" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-12 col-12">
                    <br />
                    <div id="divPrint">
                        <asp:Label ID="lblEmptyMsg" runat="server" Text=""></asp:Label>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" CssClass="table-News" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
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
                                <asp:TemplateField ItemStyle-Width="60px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="EDIT" CausesValidation="false" CommandName="Edit" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="lnkbtnUpdate" runat="server" Text="UPDATE" ValidationGroup="ll" CommandName="Update" />
                                        <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="CANCEL" CausesValidation="false" CommandName="Cancel" />
                                    </EditItemTemplate>
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
                                <asp:TemplateField HeaderText="IFSC Code">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%#Eval("TransferCode") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="A/c Name">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%#Eval("PayeeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="A/c Type">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%#Eval("AccountType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblspnsr" runat="server" Text='<%#Eval("Ac_date") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Payment Mode">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEMAIL" runat="server" Text='<%#Eval("TransactionCurrency") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="QRCode">
                                    <ItemTemplate>
                                        <asp:Image ID="Image2" runat="server" Width="150" Height="100" ImageUrl='<%#Eval("QrCode")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="80px">
                                    <EditItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%#Eval("Status")%>'></asp:Label>
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="ComposeTxtBx form-control m-w-100">
                                            <asp:ListItem Text="Active">Active</asp:ListItem>
                                            <asp:ListItem Text="DeActive">In-Active</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%#Eval("Status")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>Record Not Found</EmptyDataTemplate>
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