<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="Appsetting.aspx.cs" StylesheetTheme="MySkin" Inherits="Admin_Appsetting" Title="Application Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        @media(min-width: 600px) {
            .Dash-ft-box-men {
                padding: 20px 0px;
            }
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-12 text-center">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="table-responsive">
                    <table width="100%" cellspacing="0">
                        <tr>
                            <td class="ScrollBar">
                                <div style="width: 100%; height: 100%; scrollbar-base-color: #ffeaff">
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id" HorizontalAlign="Center" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" Width="100%" ShowFooter="True" OnRowDataBound="GridView2_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="EDIT" CausesValidation="false" CommandName="Edit" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnUpdate" runat="server" Text="UPDATE" ValidationGroup="ll" CommandName="Update" />
                                                    <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="CANCEL" CausesValidation="false" CommandName="Cancel" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Flag">
                                                <ItemTemplate>
                                                    <%#Eval("Code")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Value">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtValue" runat="server" Text='<%#Eval("Value")%>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="ll" ControlToValidate="txtValue" runat="server" Text="*" ErrorMessage="Please enter value."></asp:RequiredFieldValidator>
                                                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="ll" ShowMessageBox="true" ShowSummary="false" runat="server" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <%#Eval("Value")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtRemark" runat="server" Text='<%#Eval("Remark")%>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <%#Eval("Remark")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%#Eval("Status")%>'></asp:Label>
                                                    <asp:DropDownList ID="ddlStatus" runat="server">
                                                        <asp:ListItem Text="Active">Active</asp:ListItem>
                                                        <asp:ListItem Text="DeActive">DeActive</asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <%#Eval("Status")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <span style="font: bold 13px verdana; color: Red;">---Oooops, Record Not Found---</span>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>