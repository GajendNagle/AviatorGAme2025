<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="MySkin" CodeFile="CustomizeUserSearch.aspx.cs" Inherits="Admin_CustomizeUserSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Script for CheckBox -->
    <style>
        .Dash-ft-box-men {
            padding: 20px 0px;
        }

        .ErrorMsgForUID {
            margin-bottom: 0px;
        }

        #divPrint {
            width: 100%;
            overflow-x: scroll;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function SelectAllCheckboxesMoreSpecific(spanChk) {
            var IsChecked = spanChk.checked;
            var Chk = spanChk;
            Parent = document.getElementById('GridView3');
            for (i = 0; i < Parent.rows.length; i++) {
                var tr = Parent.rows[i];
                //var td = tr.childNodes[0];                                  
                var td = tr.firstChild;
                var item = td.firstChild;
                if (item.id != Chk && item.type == "checkbox") {
                    if (item.checked != IsChecked) {
                        item.click();
                    }
                }
            }
            gv1payout1 = document.getElementById('gv1payout');
            for (i = 0; i < gv1payout1.rows.length; i++) {
                var tr = gv1payout1.rows[i];
                var td = tr.firstChild;
                var item = td.firstChild;
                if (item.id != Chk && item.type == "checkbox") {
                    if (item.checked != IsChecked) {
                        item.click();
                    }
                }
            }
        }
        function HighlightRow(chkB) {
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '#FBFABD';
                chkB.parentElement.parentElement.style.color = 'Black';
            } else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';
            }
        }
    </script>
    <script type="text/javascript">
        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        row.style.backgroundColor = "aqua";
                        inputList[i].checked = true;
                    }
                    else {
                        if (row.rowIndex % 2 == 0) {
                            row.style.backgroundColor = "#C2D69B";
                        }
                        else {
                            row.style.backgroundColor = "white";
                        }
                        inputList[i].checked = false;
                    }
                }
            }
        }
    </script>
    <!-- End Script for CheckBox -->
    <script type="text/javascript" src="../Popup_LightBox/jquery.js"></script>
    <div class="container-fluid">
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Show Results By</label>
                    <asp:DropDownList ID="DDLSrchByDjGt" runat="server" CssClass="form-control">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem>Doj</asp:ListItem>
                        <asp:ListItem>GreenDate</asp:ListItem>
                        <asp:ListItem>Dob</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" MaxLength="12" Font-Overline="False" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>Select One</label>
                    <asp:DropDownList ID="DDLDownPos" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="MName">Name</asp:ListItem>
                        <asp:ListItem Value="MemID">Member ID</asp:ListItem>
                        <asp:ListItem Value="BLOCKROI">ROI Blocked</asp:ListItem>
                        <asp:ListItem>City</asp:ListItem>
                        <asp:ListItem>State</asp:ListItem>
                        <asp:ListItem>Mobile</asp:ListItem>
                        <asp:ListItem>AccNo</asp:ListItem>
                        <asp:ListItem Value="PAN">PAN</asp:ListItem>
                        <asp:ListItem>Status</asp:ListItem>
                        <asp:ListItem>IFSC</asp:ListItem>
                        <asp:ListItem Value="Package">Package</asp:ListItem>
                        <asp:ListItem Value="SponsorID">SponsorID</asp:ListItem>
                        <asp:ListItem Value="LeaderId">Leader Id</asp:ListItem>
                        <%--<asp:ListItem Value="CardNo">ReferenceCode</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <asp:TextBox ID="txtSearch" runat="server" Text="" MaxLength="50" AutoComplete="Off" CssClass="form-control blnk-input"></asp:TextBox>
                    <asp:DropDownList ID="DDLFillItems" runat="server" Visible="False" CssClass="form-control blnk-input"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-1 col-12">
                <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input go" OnClick="btnSearch_Click" Text="GO" />
            </div>
            <div class="col-md-10 col-12">
                <asp:Button ID="btnSendMsg" runat="server" Text="Send SignUp SMS" OnClick="btnSendMsg_Click" CssClass="OuterBtn" Visible="false" />
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
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="PageChanged"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div id="divPrint">
                    <asp:GridView ID="grdUserDtl" runat="server" PagerSettings-Visible="false" PageSize="100" ShowFooter="True" Width="100%" OnSelectedIndexChanging="grdUserDtl_SelectedIndexChanging" DataKeyNames="Member ID">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll(this);" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkMemID" runat="server" onclick="javascript:HighlightRow(this);" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField SelectText="User Panel" ShowSelectButton="True">
                                <ControlStyle Width="70px" />
                            </asp:CommandField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <a href='AdminEditProfile.aspx?mid=My Account&sid=Edit Profile&MemID=<%# Eval("Member ID") %>'>EDIT</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password">
                                <ItemTemplate>
                                    <a href='AdminChangePassworduser.aspx?MemID=<%# Eval("Member ID") %>' onclick="NewWindow(this.href,'MList','600','540','yes','center');return false" onfocus="this.blur()">Change </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Login Pwd">
                            <ItemTemplate>
                                <a href='AdminMemResetPwd.aspx?mid=My Account&sid=Member Reset Pwd&UserId=<%# Eval("Member ID") %>' target="_blank">Change</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Transaction Pwd">
                            <ItemTemplate>
                                <a href='AdminMemResetPwdTrans.aspx?mid=My Account&sid=Member Reset Transaction Pwd&UserId=<%# Eval("Member ID") %>' target="_blank">Change</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Create Role">
                            <ItemTemplate>
                                <a href="CreateStockiest.aspx?Memid=<%# Eval(" Member ID") %>" onclick="NewWindow(this.href,'MList','450','280','yes','center');return false" onfocus="this.blur()">
                                    <%# Eval("StockiestSts") %>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Income">
                            <ItemTemplate>
                                <a href='AdminRefferalIncome.aspx?MemID=<%# Eval("UserName") %>' onclick="NewWindow(this.href,'MList','800','500','yes','center');return false" onfocus="this.blur()">Referral</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Income">
                            <ItemTemplate>
                                <a href='AdminIncome.aspx?UserId=<%# Eval("UserName") %>' onclick="NewWindow(this.href,'MList','800','500','yes','center');return false" onfocus="this.blur()">Reports</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Income">
                            <ItemTemplate>
                                <a href='AdminRoyaltyIncome.aspx?MemID=<%# Eval("UserName") %>' onclick="NewWindow(this.href,'MList','800','500','yes','center');return false" onfocus="this.blur()">ROYALTY</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Invoice">
                            <ItemTemplate>
                                <a href='AdminInvoice.aspx?UserID=<%# Eval("UserName") %>' onclick="NewWindow(this.href,'MList','900','500','yes','center');return false" onfocus="this.blur()">Print</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="Welcome">
                            <ItemTemplate>
                                <a href='../WelcomeLetter.aspx?MemID=<%# Eval("UserName") %>' onclick="NewWindow(this.href,'MList','800','500','yes','center');return false" onfocus="this.blur()">Letter</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Package">
                            <ItemTemplate>
                                <a href='../InvestmentDetail.aspx?Memid=<%#  new EncryDecry().base64Encode(DataBinder.Eval(Container.DataItem, "UserName").ToString())%>' onclick="NewWindow(this.href,'MList','750','350','yes','center');return false" onfocus="this.blur()">Detail</a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <%--<asp:TemplateField HeaderText="SNO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1%>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        </Columns>
                        <EmptyDataTemplate>
                            <span style="font: Bold 13px verdana; color: Red;">---!!! Ooops, Search Record Details Not Found !!!---</span>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image2" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image3" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
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
    <script type="text/javascript">
        $(document).ready(function () {
            //When you click on a link with class of poplight and the href starts with a # 
            $('a.poplight[href^=#]').click(function () {
                var popID = $(this).attr('rel'); //Get Popup Name
                var popURL = $(this).attr('href'); //Get Popup href to define size
                //Pull Query &amp; Variables from href URL
                var query = popURL.split('?');
                var dim = query[1].split('&amp;');
                var popWidth = dim[0].split('=')[1]; //Gets the first query string value
                //Fade in the Popup and add close button
                $('#' + popID).fadeIn().css({ 'width': Number(popWidth) }).prepend('<a href="#" class="close"><img src="../UserPanel_Images/x.png" class="btn_close" title="Close Window" alt="Close" border="0"/></a>');
                //Define margin for center alignment (vertical + horizontal) - we add 80 to the height/width to accomodate for the padding + border width defined in the css
                var popMargTop = ($('#' + popID).height() + 80) / 2;
                var popMargLeft = ($('#' + popID).width() + 80) / 2;
                //Apply Margin to Popup
                $('#' + popID).css({
                    'margin-top': -popMargTop,
                    'margin-left': -popMargLeft
                });
                //Fade in Background
                $('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
                $('#fade').css({ 'filter': 'alpha(opacity=80)' }).fadeIn(); //Fade in the fade layer 
                return false;
            });
            //Close Popups and Fade Layer
            $('a.close, #fade').live('click', function () { //When clicking on the close or fade layer...
                $('#fade , .popup_block').fadeOut(function () {
                    $('#fade, a.close').remove();
                }); //fade them both out
                return false;
            });
        });
    </script>
</asp:Content>
