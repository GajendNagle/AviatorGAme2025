<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="mySkin" CodeFile="Admin_Account_Summary.aspx.cs" Inherits="Adm962xts21qtj_Admin_Account_Summary" Title="Account Setting User" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .ui-datepicker-trigger {
            right: 21px;
        }

        table {
            overflow: scroll;
        }

            table tr th, table tr td {
                white-space: nowrap;
                padding: 5px;
            }

        .act-sumry {
            overflow: hidden;
        }

        #divPrint {
            overflow-x: scroll;
        }

        .ComposeTxtBx {
            padding: 6px 7px;
        }

        .Excelrs {
            text-align: right;
            margin-top: 1px;
            margin-bottom: 2rem;
        }
    </style>
    <div class="container-fluid">
        <div class="act-sumry">
            <div class="row">
                <div class="col-md-12 col-12">
                    <div class="Excelrs">
                        <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                        &nbsp;
                        <asp:LinkButton ID="btnPrint" runat="server" CssClass="Uparmenu" Font-Bold="False" OnClientClick="return CallPrint('divPrint')" Style="position: relative; top: 1px;">Print</asp:LinkButton>
                        &nbsp; &nbsp;                           
                        <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                        &nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="Uparmenu" Font-Bold="False" OnClick="btnexporttoexport_Click" Style="position: relative; top: 1px;">Export to Excel</asp:LinkButton>
                    </div>
                </div>
                <div class="col-md-2 col-12">
                    <label class="form-label">Select One:</label>
                    <asp:DropDownList ID="DropDownList1" class="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem Text="By Txn Date" Value="TxnDate"></asp:ListItem>
                        <asp:ListItem Text="By MemID" Value="MemID"></asp:ListItem>
                        <asp:ListItem Text="By ALL MemID" Value="ALLMemID"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-2 col-12">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" CssClass="ComposeTxtBx" AutoComplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
                <div class="col-md-2 col-12">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="ComposeTxtBx" MaxLength="12" Font-Overline="False" AutoComplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
                <div class="col-md-2 col-12">
                    <label>Member ID </label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Member ID"></asp:TextBox>
                </div>
                <div class="col-md-2 col-12">
                    <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input" Text="Submit" OnClick="btnSearch_Click" />
                </div>
                <div class="col-md-4 float-right pt-4 text-right">
                    Total Record :
                    <asp:Label ID="lblRecordNo" runat="server" Font-Bold="True"></asp:Label>
                    &nbsp;
                    <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>
                    <asp:DropDownList ID="ddlGrpageSz" runat="server" CssClass="ComposeTxtBx mr-2" AutoPostBack="true" OnSelectedIndexChanged="PageChangedPz" Width="60px">
                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                        <asp:ListItem Text="25" Value="25"></asp:ListItem>
                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                        <asp:ListItem Text="100" Value="100" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" CssClass="ComposeTxtBx" OnSelectedIndexChanged="PageChanged" Width="60px">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Size="13px" ForeColor="Red"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-12">
                    <div id="divPrint">
                        <asp:GridView ID="gvinvoiceno" runat="server" PagerSettings-Visible="false" PageSize="100" ShowFooter="True" CssClass="table-responsives"></asp:GridView>
                    </div>
                </div>
            </div>
            <div class="row">&nbsp;</div>
        </div>
    </div>
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
        document.addEventListener("DOMContentLoaded", function () {
            var dropdown = document.getElementById('<%= DropDownList1.ClientID %>');
            var fromdatesec = document.getElementById('fromdatesec');
            var todatesec = document.getElementById('todatesec');
            var memIDField = document.getElementById('memIDField');

            function toggleFields() {
                var selectedValue = dropdown.value;
                if (selectedValue === 'TxnDate') {
                    fromdatesec.style.display = 'block';
                    todatesec.style.display = 'block';
                    memIDField.style.display = 'none';
                } else if (selectedValue === 'MemID') {
                    fromdatesec.style.display = 'none';
                    todatesec.style.display = 'none';
                    memIDField.style.display = 'block';
                } else {
                    fromdatesec.style.display = 'none';
                    todatesec.style.display = 'none';
                    memIDField.style.display = 'none';
                }
            }
            dropdown.addEventListener('change', toggleFields);
            // Initial call to set the correct visibility on page load
            toggleFields();
        });
    </script>
</asp:Content>
