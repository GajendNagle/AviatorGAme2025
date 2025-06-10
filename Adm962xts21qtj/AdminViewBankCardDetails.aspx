<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminViewBankCardDetails.aspx.cs" StylesheetTheme="MySkin" Inherits="Adm962xts21qtj_AdminViewBankCardDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Bank and Card Details</title>
    <link href="../UserPanel_css/User-Css.css" rel="stylesheet" type="text/css" />
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                <tr>
                    <td style="width: 100%; height: 8px; background-color: White;" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="width: 10%; height: 28px; text-align: left;" valign="top">
                                    <asp:ImageButton ID="btnexporttoexport"  runat="server" ImageUrl="../UserPanel_Images/excel_icon.gif" OnClick="btnexporttoexport_Click" />
                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" OnClientClick="return CallPrint('divPrint')" />
                                </td>
                                <td align="center" style="width: 60%; height: 28px;" valign="top">
                                    <asp:Label ID="lblMsg" runat="server" Font-Bold="False" ForeColor="Red" Width="58%"></asp:Label>
                                </td>
                                <td align="right" style="width: 30%; height: 28px" valign="middle">
                                    Leader-ID:
                                    <asp:TextBox ID="txtLeaderID" runat="server" Height="20px" Width="150px"></asp:TextBox>
                                    <asp:Button ID="btnFind" runat="server" OnClick="btnFind_Click" Text="Search" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" valign="top" class="BoardStructure" style="padding-top: 10px;">
                        <div id="divPrint">
                            <asp:GridView ID="grdUserDtl" runat="server" Font-Bold="False" Width="100%" Font-Names="verdana" ShowFooter="True" PageSize="25" AutoGenerateColumns="False" OnRowDataBound="grdUserDtl_RowDataBound">
                                <RowStyle Height="22px" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>
                                <Columns>
                                    <asp:TemplateField HeaderText="SrNo.">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex +1  %>
                                        </ItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Member-ID">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "Memid")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmt" runat="server" Text='<%#Eval("NetAmt")%>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotAmt" runat="server"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Account Holder">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "AccountName")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bank Name">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "bankname")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Account No">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "accno")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="IFS Code">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "IFSC")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Reference Code" Visible="false">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "ReferenceCode")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mobile No">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "Mobile")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Bank City">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "branchname")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField HeaderText="Branch Name">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "branchname")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField HeaderText="Account Type">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "BnkAccType")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Swift Code">
                                        <ItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem, "SwiftCode")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>--%>
                                </Columns>
                                <FooterStyle BorderStyle="None" Height="20px" HorizontalAlign="Center" VerticalAlign="Middle"></FooterStyle>
                                <PagerStyle Font-Size="12px"></PagerStyle>
                                <EmptyDataTemplate>
                                    <span style="color: Red;">---!!! Ooops, Amount Withdrawn Details Not Found !!!---</span>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>