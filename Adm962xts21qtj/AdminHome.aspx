<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="AdminHome.aspx.cs" Inherits="Adm962xts21qtj_AdminHome" Title="Untitled Page" %>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 450px;">
            <tr>
                <td align="center" valign="top" style="padding-top: 20px;">
                    <h2 style="font-size: 30px; color: #1258a0;">
                        Welcome
                    </h2>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <h2 style="font-size: 30px; color: #1258a0;">
                        To
                    </h2>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <h2 style="font-size: 30px; color: #1258a0;">
                        <span style="margin-top: 20px; color: #000000"><%=DynamicDtls.TopCompName %></span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <h2 style="font-size: 30px; color: #1258a0;">
                        Administrator Control Panel..
                    </h2>
                </td>
            </tr>
        </table>
    </center>
</asp:Content>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .div1 {
            padding-bottom: 33px;
            margin-bottom: 20px;
        }
        .font-16 {
            font-size: 16px;
        }
        .fw-500 {
            font-weight: 500;
        }
    </style>
    <div class="container-fluid">
       <%--<div align="center" style="margin-top: 5px;">--%>
            <div class="row">
                <%--<div class="col-md-6 col-12">
                    <div class="left-section">
                        <br />
                        <br />
                        <br />
                        <br />
                        <span style="font-size: 45px;">Welcome</span>
                        <br />
                        <br />
                        <span style="font-size: 30px;">To</span>
                        <br />
                        <br />
                        <span style="font-size: 45px;"><b>Admin Panel</b></span>
                    </div>
                </div>--%>
                <div class="col-md-6 col-12">
                    <div class="div1">
                        <div class="div11">
                            <div class="mt-4">
                                <b class="registrationh">Total Registration</b>
                            </div>
                            <div class="Dash-Earn">
                                <span id="lblTotalReg" class="fsizedynamic"></span>
                            </div>
                        </div>
                        <div class="div12">
                            <div class="Dash-Earn div12row1">
                                <div class="div12row11">
                                    <span>
                                        <b class="fsize">Total Activation</b>
                                    </span>
                                    <span id="lblTotAct" class="fsizedynamic"></span>
                                </div>
                                <span class="partcss"></span>
                                <div class="div12row11">
                                    <span><b class="fsize">Total Deposit</b></span>
                                    <span id="lblTotDep" class="fsizedynamic"></span>
                                </div>
                            </div>
                        </div>
                        <div class="div12">
                            <%--<div style="margin-top: 10px;">
                                <b style="font-size: 18px; font-family: 'Poppins', sans-serif;">Total Withdrawal</b>
                            </div>
                            <div class="Dash-Earn">
                                <span id="lblTotWith" style="font-size: 40px; color: black"></span>
                            </div>--%>
                            <div class="Dash-Earn div12row1">
                                <div class="div12row11">
                                    <span><b class="fsize">Total Growth</b></span>
                                    <span id="lblTotGrowth" class="fsizedynamic"></span>
                                    <%--<a href="Admin_Account_Summary.aspx" style="font-family: 'Poppins', sans-serif; color: #FFFFFF;">Total Winning Amount</a>--%>
                                </div>
                                <span class="partcss"></span>
                                <div class="div12row11">
                                    <span><b class="fsize">Total Withdraw</b></span>
                                    <span id="lblTotWithdraw"class="fsizedynamic"></span>
                                    <%--<a href="Admin_Stake_Account_Summary.aspx"  style="font-family: 'Poppins', sans-serif; color: #FFFFFF;">Stake Account Summary</a>--%>
                                </div>
                            </div>
                            <%--<a href="Admin_Account_Summary.aspx" style="font-family: 'Poppins', sans-serif; color: #FFFFFF;">View Account Summary</a>--%>
                        </div>
                        <div class="div12">
                            <div class="Dash-Earn div12row1">
                                <div class="div12row11">
                                    <span><b class="fsize">Total Winning Amount</b></span>
                                    <span id="lblTotWinAmt" class="fsizedynamic">2000</span>
                                </div>
                                <span class="partcss"></span>
                                <div class="div12row11">
                                    <span>
                                        <b class="fsize">Total Game Play Amount</b>
                                    </span>
                                    <span id="lblTotGamePlayAmt" class="fsizedynamic">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-12">
                    <div class="searchbx">
                        <div class="searchidd">
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Search Member By ID:</h5>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtSearchMember" runat="server" AutoComplete="Off" CssClass="ComposeTxtBx" AutoPostBack="True" OnTextChanged="txtSearchMember_TextChanged"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlSearchPage" runat="server" CssClass="ComposeTxtBx">
                                        <asp:ListItem>--select--</asp:ListItem>
                                        <asp:ListItem>Edit User Profile</asp:ListItem>
                                        <asp:ListItem>Block And UnBlock User</asp:ListItem>
                                        <asp:ListItem>Unverified Users</asp:ListItem>
                                        <asp:ListItem>Payment Request Status</asp:ListItem>
                                        <asp:ListItem>Deposit Address</asp:ListItem>
                                        <%--<asp:ListItem>Fx-Wallet Fund Request</asp:ListItem>--%>
                                        <asp:ListItem>Member Account Address</asp:ListItem>
                                        <%--<asp:ListItem>From V-Down Bonus</asp:ListItem>--%>
                                        <asp:ListItem>Invitation Bonus</asp:ListItem>
                                        <asp:ListItem>Trade Bonus</asp:ListItem>
                                        <asp:ListItem>Level Trade Bonus</asp:ListItem>
                                        <asp:ListItem>Promotion Bonus</asp:ListItem>
                                        <asp:ListItem>Deposit Bonus</asp:ListItem>
                                        <%--<asp:ListItem>From V-Up Bonus</asp:ListItem>--%>
                                        <%--<asp:ListItem>Recycle History</asp:ListItem>--%>
                                        <%--<asp:ListItem>Referral And Earn Income</asp:ListItem>--%>
                                        <%--<asp:ListItem>F-Wallet History</asp:ListItem>--%>
                                        <asp:ListItem>Withdrawal Request</asp:ListItem>
                                        <asp:ListItem>Account Summary</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnSearchMember" runat="server" Text="GO" CssClass="OuterBtn" OnClick="btnSearchMember_Click" />
                                </div>
                                <div class="col-md-12">
                                    <asp:Label ID="lblfrmUser" runat="server" Font-Bold="true" Font-Names="Verdana" Font-Size="13px" ForeColor="DarkGreen"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="right-box">
                        <div style="margin-top: 10px;">
                            <span style="font-size: 20px;">Wallet Summary</span>
                            <br />
                            <span style="font-size: 13px;">user account wallet summary</span>
                            <br />
                            <br />
                        </div>
                        <div style="background: #FFFFFF; background-repeat: no-repeat; margin-left: 2px; margin-right: 2px; height: 1px; margin-bottom: 2px;">
                            <div id="DivLevelBonusWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0%; float: right"></div>
                        </div>
                        <div class="Dash-Earn">
                            <a href="Admin_Fromup_History.aspx?mid=User Account&sid=Wallet-Transaction History&IncType=ALL" style="color: #FFFFFF">View Summary</a>
                        </div>
                    </div>
                    <div class="right-box" style="background-color:#2d353c">
                        <div style="margin-top: 10px;">
                            <span style="font-size: 20px;">Account Daily Txn Summary</span>
                            <br />
                            <span style="font-size: 13px;">Incomes, Deposit, Withdraw, Registration</span>
                            <br />
                            <br />
                        </div>
                        <div style="background: #FFFFFF; background-repeat: no-repeat; margin-top: -11px; margin-left: 2px; margin-right: 2px; height: 1px; margin-bottom: 2px;">
                            <div id="Div1" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0%; float: right"></div>
                        </div>
                        <div class="Dash-Earn">
                            <%--<a class="CrDr" href="#">View Summary</a></div></div>--%>
                            <a href="Admin_Account_Summary.aspx?mid=User Account&sid=Account Summary" style="color: #FFFFFF">View Summary</a>
                        </div>
                    </div>
                    <div class="right-box" style="background-color:#00acac">
                        <div style="margin-top: 10px;">
                            <span style="font-size: 20px;">Registration Summary</span>
                            <br />
                            <span style="font-size: 13px;">Registered User, Active Users, Inactive Users</span>
                            <br />
                            <br />
                        </div>
                        <div style="background: #FFFFFF; background-repeat: no-repeat; margin-left: 2px; margin-right: 2px; height: 1px; margin-bottom: 2px;">
                            <div id="Div2" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0%; float: right"></div>
                        </div>
                        <div class="Dash-Earn">
                            <a href="CustomizeUserSearch.aspx?mid=Top-Up&sid=Member Summary" style="color: #FFFFFF">View Summary</a>
                        </div>
                    </div>
                </div>
            </div>
        <%--</div>--%>
        <div align="center" style="margin-top: 0px;">
            <%--<div class="Das-CantTop">
                <!---- Total Earnings ---->
                <div class="Dash-box-a11">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Level Bonus
                            <br />
                            <b>Rs.<%=Level_Bonus%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins2.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivLevelBonusWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0%; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminGrowthReport.aspx?mid=User+Account&sid=E-Wallet+History">Read More</a>
                    </div>
                    <div class="Das-clear"></div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Your Active Deposits ---->
                <div class="Dash-box1">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Total E-Wallet
                            <br />
                            <b>Rs.<%=Total_EWallet%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivTotalEWalletWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminGrowthReport.aspx?mid=E-Wallet&sid=E-Wallet%20History">Read More</a>
                    </div>
                    <div class="Das-clear"></div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline ---->
                <div class="Dash-box-111">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            E-Wallet Balance
                            <br />
                            <b>Rs.<%=TotalCashWallet%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/gold.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivTotCashWallet" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminGrowthReport.aspx?mid=E-Wallet&sid=E-Wallet History">Read More</a> | 
                        <asp:LinkButton ID="lnkBntCalInc" runat="server" OnClick="lnkBntCalInc_Click">### Calculate ROI ###</asp:LinkButton>
                    </div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline ---->
                <div class="Dash-box-1151" style="margin-right: -2%">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Total Downlines
                            <br />
                            <b>
                                <%=Total_Downlines%>
                            </b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins2.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivTotalDownlinesWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminDownlineList.aspx?mid=Affiliate%20Program&sid=My%20Downline%20list">Read More</a></div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline end---->
                <!---- Total Earnings ---->
                <div class="Dash-box-a1">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Total Withdrawal
                            <br />
                            <b>Rs.<%=Withdrawal_Total%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins2.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivWithdrawalTotalWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminViewFundRequest.aspx?mid=User%20Account&sid=Withdrawal%20Request%27s">Read More</a>
                    </div>
                    <div class="Das-clear"></div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Your Active Deposits ---->
                <div class="Dash-box">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Last Withdral
                            <br />
                            <b>Rs.<%=Pending_Withdrawal%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivPendingWithdrawalWdth" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="Edit-Account-Setting.aspx?mid=Account&sid=Account Setting">$$ Account Setting $$</a>
                    </div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline ---->
                <div class="Dash-box-11">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            Top-Up
                            <br />
                            <b>Rs.<%=TopUpAmt%></b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/gold.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivTopupAmt" runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminDepositHistory.aspx?mid=Deposit Section&sid=Top-Up History">Read More</a>
                    </div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline ---->
                <div class="Dash-box-115" style="margin-right: -2%">
                    <div class="Dash-box-in-bu">
                        <div class="Dash-box-Earnings">
                            TOTAL Direct
                            <br />
                            <b>
                                <%=TOTAL_REFERRALS%>
                            </b>
                        </div>
                    </div>
                    <div class="Dash-box-in-cen">
                        <img src="../New-Dashbaord-Images/coins2.png" alt="" />
                    </div>
                    <div class="Das-clear"></div>
                    <div class="progress-bar">
                        <div id="DivTotDirect"  runat="server" style="background-color: #FFFFFF; height: 1px; width: 0px; float: left;"></div>
                    </div>
                    <div class="Dash-Earn">
                        <a href="AdminCurrentLevelStatus.aspx?mid=Affiliate%20Program&sid=User%20Direct%27s">Read More</a>
                    </div>
                    <div class="Das-clear"></div>
                </div>
                <!---- Total Downline end---->
                <div class="Das-clear"></div>
            </div>--%>
            <div class="Das-clear"></div>
            <div class="Das-clear"></div>
            <div class="Das-clear"></div>
        </div>
        <%--<table border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td align="center" valign="top">
                    <h2 style="font-size: 30px; color: #1258a0">
                        Welcome To
                    </h2>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <b style="color: #1258a0;font-size: 30px;">
                        <span style="color: #000000"><%=DBConnectHP.TopCompName %></span>
                    </b>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <h2 style="font-size: 30px; color: #1258a0">
                        Administrator Control Panel..
                    </h2>
                </td>
            </tr>
        </table>--%>
        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
    </div>
    <script type="text/javascript" language="javascript">
        /*const { fontSize } = require("pdfkit");*/
        $(document).ready(function () {
            /* setInterval(async () => { LoadDashboard(); }, 200);*/
            //
            LoadDashboard();
        });
        async function LoadDashboard() {
            //alert('timer');
            $.getJSON('Load_CountDate_Details.ashx',
                function (Orjson) {
                    if (Orjson.length == 0) {
                    }
                    else {
                        for (var i = 0; i < Orjson.length; i++) {
                            $('#lblTotalReg').html(Orjson[i].TotalRegistration);
                            $('#lblTotDep').html(Orjson[i].TotalDeposit + "<small class='font-16 fw-500'> $</small>");
                            $('#lblTotAct').html(Orjson[i].TotActivation + "<small class='font-16 fw-500'> $</small>");
                            $('#lblTotWithdraw').html(Orjson[i].TotalWithdraw + "<small class='font-16 fw-500'> $</small>");
                            $('#lblTotGrowth').html(Orjson[i].TotalGrowth + "<small class='font-16 fw-500'> $</small>");
                            $('#lblTotWinAmt').html(Orjson[i].TotalWinAmt + "<small class='font-16 fw-500'> $</small>");
                            $('#lblTotGamePlayAmt').html(Orjson[i].TotalGamePlatAmt + "<small class='font-16 fw-500'> $</small>");
                        }
                    }
                }
            );
        }
    </script>
</asp:Content>