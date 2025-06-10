<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="Add_With_Address.aspx.cs" Inherits="Adm80bdr753nto_Add_With_Address" Title="Add Withdraw Address" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .paging-dd > .form-label {
            line-height: 40px;
        }

        @media(min-width: 767px) {
            .print-group {
                margin-top: 1.85rem;
            }
        }

        .row {
            margin-left: 0px;
            margin-right: 0px;
        }
    </style>
    <%--Input Start--%>
    <div class="row">
        <div class="col-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <p class="card-description">
                        <asp:Label runat="server" ID="lblMsg" CssClass="text-danger"></asp:Label>
                    </p>
                    <div class="row basic-form-row">
                        <div class="col-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group has-validation">
                                <span class="validation-wrap">
                                    <label class="form-label">Wallet Address :</label>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="validation" ValidationGroup="a" ControlToValidate="txtWalletAdd" ErrorMessage="Enter Wallet Address" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </span>
                                <asp:TextBox runat="server" ID="txtWalletAdd" CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group has-validation">
                                <span class="validation-wrap">
                                    <label class="form-label">Private Key :</label>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" CssClass="validation" ValidationGroup="a" ControlToValidate="txtWalletAdd2" ErrorMessage="Enter Private Key" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </span>
                                <asp:TextBox runat="server" ID="txtWalletAdd2" CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group has-validation">
                                <span class="validation-wrap">
                                    <label class="form-label">Date :</label>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" CssClass="validation" ValidationGroup="a" ControlToValidate="txtDate" ErrorMessage="Enter Date" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </span>
                                <div id="datepicker-from" class="input-group date datepicker">
                                    <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" AutoComplete="off" ValidationGroup="a" placeholder="DD/MM/YYYY"></asp:TextBox>
                                    <span class="input-group-addon input-group-append border-left">
                                        <span class="ti-calendar input-group-text"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="form-label">Select Status :</label>
                                <asp:DropDownList runat="server" ID="DDlStatustype" CssClass="form-control" ValidationGroup="a">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>In-Active</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row basic-form-row">
                        <div class="col-12 col-sm-12 col-md-12 col-lg-12">
                            <asp:Button runat="server" ID="btnpass" ValidationGroup="a" OnClick="btnpass_Click" Text="SUBMIT" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br />
    <%--Input Ends--%>
    <%--Table Start--%>
    <div class="row">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="GridView2" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="id" EnableTheming="True" HorizontalAlign="Center" OnRowDeleting="GridView2_RowDeleting" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" Width="100%" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="Server" ID="linkbtn" CausesValidation="false" CommandName="delete" Text="REMOVE"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkbtnEdit" Text="EDIT" CausesValidation="false" CommandName="Edit" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkbtnUpdate" Text="UPDATE" CausesValidation="false" CommandName="Update" />
                                        <asp:LinkButton runat="server" ID="lnkbtnCancel" Text="CANCEL" CausesValidation="false" CommandName="Cancel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Entry Date">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox runat="server" ID="TxnDt" CssClass="form-control min-w-100" Text='<%#Eval("TxnDt")%>'></asp:TextBox>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <%#Eval("TxnDt") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Wallet Address">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="WalletAdds" CssClass="form-control min-w-100" Text='<%#Eval("WalletAdds")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <a href="https://bscscan.com/address/<%#Eval("WalletAdds")%>" target="_blank"><%#Eval("WalletAdds")%></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Private Key">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="WalletAdds2" CssClass="form-control min-w-100" Text='<%# Eval("WalletAdds2") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <%--<ItemTemplate>
                                        <%# Eval("WalletAdds2").ToString().Substring(0, Eval("WalletAdds2").ToString().Length / 3) + "............." %>
                                    </ItemTemplate>--%>
                                    <ItemTemplate>
                                        <%# Eval("WalletAdds2").ToString().Substring(0, Eval("WalletAdds2").ToString().Length / 7) + 
                                            "..................." + 
                                            Eval("WalletAdds2").ToString().Substring(Eval("WalletAdds2").ToString().Length - Eval("WalletAdds2").ToString().Length / 7) %>
                                    </ItemTemplate>
                                    <%--<ItemTemplate>
                                        <%# GetDecodedMiddleEllipsis(Eval("WalletAdds2")) %>
                                    </ItemTemplate>--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <EditItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Visible="false" CssClass="form-control mw-150" Text='<%#Eval("WalletStatus")%>'></asp:Label>
                                        <asp:DropDownList ID="WalletStatus" CssClass="form-select min-w-100" runat="server">
                                            <asp:ListItem Text="Active">Active</asp:ListItem>
                                            <asp:ListItem Text="In-Active">In-Active</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%#Eval("WalletStatus")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle HorizontalAlign="Center" />
                            <EmptyDataTemplate>
                                <span class="text-danger">---Oooops, Record Not Found---</span>
                            </EmptyDataTemplate>
                            <PagerStyle />
                        </asp:GridView>
                    </div>
                    <div class="row">
                        <asp:ValidationSummary runat="server" ID="ValidationSummary2" ShowMessageBox="True" ShowSummary="False" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Table Ends--%>
    <script language="javascript" type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,right=0,top=0,width=790,height=2000,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            prtContent.innerHTML = strOldOne;
        }
        $(function () {
            $("#<%=txtDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
</asp:Content>
