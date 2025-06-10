<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CtrlP2nL_Akdvv3jshLG.aspx.cs" Inherits="CtrlP2nL_Akdvv3jshLG" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="icon" type="image/png" sizes="16x16" href="Website-Logo/favicon.svg" />
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="Jap762Btp28lyf/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Jap762Btp28lyf/assets/plugins/sweetalert/sweetalert.css" rel="stylesheet" type="text/css" />
    <link href="Jap762Btp28lyf/css/loading.css" rel="stylesheet" />
    <link href="Jap762Btp28lyf/css/sidebar.css" rel="stylesheet" />
    <link href="Jap762Btp28lyf/css/new-style.css?v=1.3" rel="stylesheet" />
    <link href="Jap762Btp28lyf/css/mobile-menu.css" rel="stylesheet" />
    <link href="Jap762Btp28lyf/css/StyleSheet.css" rel="stylesheet" />
    <link href="Login-css/loginpages.css" rel="stylesheet" />
    <link href="Jap762Btp28lyf/css/NewStyleSheet.css" rel="stylesheet" />

</head>
<body class="fix-header fix-sidebar card-no-border logo-ce}nter">
    <div class="preloader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" />
        </svg>
    </div>
    <div class="container-fluid">
        <div class="row background-body-color">
            <div class="col-lg-4 col-md-6 col-sm-8 col-12 m-auto mobile_screen">
                <div class="main-content">
                    <div class="col-lg-4 col-md-6 col-sm-8 col-12 m-auto mobile-top-bar visible-on-sm-down fixed-top flex flex-ai-c">
                        <a href="Jap762Btp28lyf/game-index.html" class="text-white fs-20">
                            <i class="fa fa-arrow-left-long"></i>
                        </a>
                        <a href="#" class="logo flex flex-ai-c absolute-center">
                            <img src="Website-Logo/logo-top.svg" />
                            <div class="new-bar"></div>
                        </a>
                    </div>

                    <div class="main-wrapper page-margin">
                        <div class="col-12">
                            <div class="login-box">
                                <div class="login-box-body">
                                    <div class="head">
                                        <i class="fa fa-mobile-alt headi"></i>
                                        <h4 class="headh">Login</h4>
                                        <p>Please Login now by E-Mail/Mobile</p>
                                        <hr class="headhr" />
                                    </div>
                                    <form class="mt-5" id="loginform" runat="server">
                                        <div class="form-group has-feedback position-relative">
                                            <asp:TextBox
                                                ID="txtUserID"
                                                runat="server"
                                                MaxLength="50"
                                                CssClass="form-control rounded shadow-input"
                                                Placeholder="Please enter your E-Mail/Mobile"
                                                AutoCompleteType="None">
                                            </asp:TextBox>
                                            <i class="fa-solid fa-envelope icons" aria-hidden="true"></i>
                                        </div>
                                        <div class="form-group has-feedback position-relative">
                                            <asp:TextBox
                                                ID="txtPasswordSU"
                                                runat="server"
                                                TextMode="Password"
                                                CssClass="form-control rounded shadow-input"
                                                Placeholder="Please enter your Password"
                                                MaxLength="15">
                                            </asp:TextBox>
                                            <i class="fa fa-eye-slash icons toggle-password" aria-hidden="true"></i>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 text-center">
                                                <div id="toast-container"></div>
                                            </div>
                                            <div class="col-12 m-auto text-center">
                                                <asp:Button
                                                    ID="btnLogin"
                                                    runat="server"
                                                    Text="Login"
                                                    CssClass="btns-theme btnss-theme btn-block mt-2"
                                                    OnClick="btnsignin_Click" />
                                            </div>
                                            <div class="col-12" id="Msgs"></div>
                                            <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                                            <asp:HiddenField ID="txtCity" runat="server" />
                                            <asp:HiddenField ID="txtCountry" runat="server" />
                                            <asp:HiddenField ID="txtRegion" runat="server" />
                                            <asp:HiddenField ID="txtLoginip" runat="server" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="Jap762Btp28lyf/assets/plugins/jquery/jquery.min.js"></script>
    <script src="Jap762Btp28lyf/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="Jap762Btp28lyf/js/preloader.js"></script>
    <script src="Jap762Btp28lyf/assets/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
        $(".toggle-password").click(function () {
            $(this).toggleClass("fa-eye-slash fa-eye");
            input = $(this).parent().find("input");
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            getLoginDetails();

        });
        function getLoginDetails() {
            var xmlhttp = new XMLHttpRequest();

            xmlhttp.open("GET", "https://ipapi.co/json/", true);
            xmlhttp.send();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var jsontext = xmlhttp.responseText;
                    var data = JSON.parse(jsontext);
                    $("#txtCity").val(data.city);
                    $("#txtCountry").val(data.country_name);
                    $("#txtRegion").val(data.region_code);
                    $("#txtLoginip").val(data.ip);
                }
            }
        }
    </script>
</body>
</html>
