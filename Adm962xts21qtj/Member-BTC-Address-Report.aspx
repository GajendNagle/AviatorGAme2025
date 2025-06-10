<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" CodeFile="Member-BTC-Address-Report.aspx.cs" Inherits="Adm962xts21qtj_Member_BTC_Address_Report" StylesheetTheme="MySkin" Title="C Wallet Fund Request" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 col-12"></div>
            <div class="col-md-6 col-12">
                <div class="flex-img-link-wrapper">
                    <div class="flex-img-link-in">
                        <span>
                            <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="Uparmenu" OnClientClick="return CallPrint('divPrint')">Print</asp:LinkButton>
                        </span>
                        <span>
                            <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="Uparmenu" OnClick="btnexporttoexport_Click">Export to Excel</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="form-group">
                <div class="col-md-1 col-12">
                    <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="OuterBtn blnk-input" Style="position: relative;" OnClientClick="if ( ! UserDeleteConfirmation()) return false;" OnClick="BtnDelete_Click" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>Show Results By</label>
                    <asp:DropDownList ID="ddl_IncType" runat="server" CssClass="ComposeTxtBx" OnSelectedIndexChanged="ColumnFilterChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12" id="detsdv" runat="server">
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="form-control blnk-input" Visible="false">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtSearch" runat="server" Visible="false" Text="" CssClass="form-control blnk-input"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" Style="position: relative;" />
                </div>
            </div>
            <div class="col-md-5 col-12">
                <div class="pgsizes">
                    <span>
                        <%--<%=PageNo%>
                        -
                        <%=Pagesize %>
                        of--%>
                        <asp:Label ID="lblRecordNo" runat="server" Font-Bold="True"></asp:Label>
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                        &nbsp;
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" CssClass="form-control" Width="58px"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
        <div class="col-md-12 col-12">
            <asp:Label ID="lblTotalSum" runat="server" Font-Bold="True" ForeColor="#FF0000"></asp:Label>
            <asp:Label ID="lblmymsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
        </div>
        <div id="divPrint">
            <asp:GridView ID="gvinvoiceno" runat="server" BorderStyle="None" BorderWidth="1px" CellPadding="1" AllowPaging="True" OnPageIndexChanging="gvinvoiceno_PageIndexChanging" PageSize="100" ShowFooter="True" Width="100%" AutoGenerateColumns="False" Style="margin-left: 2px;" OnRowCancelingEdit="gvinvoiceno_RowCancelingEdit" OnRowDataBound="OnRowDataBound" OnRowEditing="gvinvoiceno_RowEditing" OnRowUpdating="gvinvoiceno_RowUpdating">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CausesValidation="false" CommandName="Edit" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="lnkbtnUpdate" runat="server" Text="Update" CausesValidation="false" CommandName="Update" />
                            <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="Cancel" CausesValidation="false" CommandName="Cancel" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="CBDeleteAll" runat="server" onclick="checkAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CBDelete" runat="server" />
                            <asp:Label ID="lb" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "BANKDETAILID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sr.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                            .
                        </ItemTemplate>
                        <ControlStyle Width="100px" />
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "MNAME")%>
                            <br />
                            <b><%# DataBinder.Eval(Container.DataItem, "USERID")%></b>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account Holder">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "PAYEENAME")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPAYEENAME" runat="server" Text='<%#Eval("PAYEENAME")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bank Name">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "BANKNAME")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBANKNAME" runat="server" Text='<%#Eval("BANKNAME")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BTC Address ">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "ACCOUNTNO")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtACCOUNTNO" runat="server" Text='<%#Eval("ACCOUNTNO")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AccountType">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "ACCOUNTTYPE")%>
                            <asp:Label ID="lblACCOUNTTYPE" Visible="False" runat="server" Text='<%#Eval("ACCOUNTTYPE")%>'></asp:Label>
                            <asp:DropDownList ID="ddlStatus" runat="server" Visible="false">
                                <asp:ListItem Value="Saving Account">Saving Account</asp:ListItem>
                                <asp:ListItem Value="Current Account">Current Account</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="IFSC">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "TRANSFERCODE")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTRANSFERCODE" runat="server" Text='<%#Eval("TRANSFERCODE")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PAN">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "PAN")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPAN" runat="server" Text='<%#Eval("PAN")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div>&nbsp;</div>
        </div>
    </div>
    <table width="100%" cellpadding="0" cellspacing="0" style="display: none;">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="ScrollBar">
                            <div style="width: 100%; height: 100%; scrollbar-base-color: #ffeaff">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="MtblCntReg">
                                    <tr>
                                        <td align="center" valign="top">
                                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: White">
                                                <tr>
                                                    <td align="center" valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="font-size: 11px; font-family: 'Poppins', sans-serif; width: 100%;">
                                                            <tr>
                                                                <td></td>
                                                                <td class="lbl" style="width: 79%"></td>
                                                                <td style="width: 15%"></td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                                <td class="lbl" align="right"></td>
                                                            </tr>
                                                        </table>
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td style="width: 20%; height: 19px;"></td>
                                                                <td style="width: 60%; height: 19px; text-align: center;">
                                                                    <td align="right" style="padding-left: 5px; width: 182px; height: 26px;">
                                                                        <div style="text-align: center; float: left;"></div>
                                                                    </td>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%" valign="top" class="BoardStructure"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
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
                        //if(row.rowIndex % 2 == 0)
                        //{
                        //  //Alternating Row Color
                        //  row.style.backgroundColor = "#C2D69B";
                        //}
                        //else
                        //{
                        //  row.style.backgroundColor = "white";
                        //}
                        inputList[i].checked = false;
                    }
                }
            }
        }
        function UserDeleteConfirmation() {
            var checkedCheckBox = false;
            var dataGrid = document.getElementById("<%=gvinvoiceno.ClientID %>");
            var inputList = dataGrid.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && inputList[i].checked == true) {
                    checkedCheckBox = true;
                }
            }
            if (checkedCheckBox == true) {
                return confirm("Are you sure you want to delete?");
            }
            else {
                alert('Please select record for delete.');
                return;
            }
            //return checkedCheckBox;
        }
    </script>
</asp:Content>