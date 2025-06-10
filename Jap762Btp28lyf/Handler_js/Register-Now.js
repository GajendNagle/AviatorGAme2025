var $ = jQuery.noConflict();
$("#CCode").val('');
   var verifyCallback = function(response) {
        
        $("#CCode").val(response);
      };

var onloadCallback = function () {
    grecaptcha.render('captcha_container', {
        'sitekey': '6LecKD4rAAAAAHxdsxyVI2cV-lGPiZviiR4oFtIp',
        'callback': verifyCallback,
        //'theme' : 'dark'
    });
};
//////////
   function RegisterNow() {
     var od = new FormData();
    var firstname_input = $("#firstname_input").val();
    
    var txtDoj="";    
    var email_input = $("#email_input").val();
    //var phone_input= $("#Nubr").val();
       var phone_input = $("#phone1").val();
    
    var invite_input= $("#txtSponserID").val();
    var password_input= $("#password_input").val();
    var password_Sec= $("#txtsecurityPWD").val();
   
       var CountryCode = $("#countryCode").val(); /*"+91";*/
  
       var Country_input = $("#Country_input").val();
    
    /////////
    var email = document.getElementById('email_input');
    var emailfilter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

       $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-please"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
       var CCode = $("#CCode").val();
       if (CCode == '') {
           $('#Msgs').html("<p class='error ' id='not-found' style='display: block;color: red;'>* Captcha validation is required</p>");
           return;
       }
       document.getElementById("submit-Signup").disabled = true;
       $("#submit-Signup").html('Please wait...');

       if ($("#checkbox-signup").prop('checked') == false) {

           // $('#Msgsr').html("<p class='error hide' id='not-found' style='display: block;'>Please accept terms and conditions !</p>");
           $('#Msgs').html('');
           swal({

               title: "Sorry!",
               text: "Please accept terms and conditions !",
               type: "warning",

           });
          
           document.getElementById("submit-Signup").disabled = false;
           $("#submit-Signup").html('Register<i class="fa-solid fa-user-plus ml-2"></i>');
           return;
       }
       /////////& phone_input != ''
   if (firstname_input!='' &  email_input!=''  & password_input !='' & password_Sec!='' & invite_input !='' & Country_input !='' & CountryCode !=''
    & emailfilter.test(email.value))
    {
       /*$('#RMsgs').html('<img src="UserProfileImg/loading2.gif" />');*/
       
    ////////
    if(password_input==password_Sec)
    {
        //$('#RMsgs').html('<span style="color:#f6a821;">Login password & Transaction Password can not be same !</span>');
        $('#Msgs').html('');
        swal({

            title: "Sorry!",
            text: "Login password & Transaction Password can not be same !",
            type: "warning",

        });
     
        document.getElementById("submit-Signup").disabled = false;
        $("#submit-Signup").html('Register<i class="fa-solid fa-user-plus ml-2"></i>');
        return;
    }
        ////////
    
    else
    {
        
    od.append("firstname_input", firstname_input);
    od.append("email_input", email_input);    
    od.append("phone_input", phone_input);
    
    od.append("invite_input", invite_input);
    od.append("password_input",password_input);
    od.append("password_Sec",password_Sec);
    od.append("CountryCode", CountryCode);
    od.append("Country_input", Country_input);
    

    ////////
        $.ajax({
            url: "Jap762Btp28lyf/Handlers/Register-Now.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                   $('#Msgs').html(Response.Message);
                    $("#firstname_input").val('');
                    $("#email_input").val('');
                    $("#phone").val('');
                    $("#password_input").val('');
                    $("#txtsecurityPWD").val('');
                    //$("#Country_input").val('');
                    
                    //// 
                   /* location.href = Response.Message;*/
                   //location.href = "Verify-User.html?phn="+phone_input;
                    $('#Msgs').html('');
                    swal(
                        {
                            title: "Congratulations",
                            text: "Thanks for creating an account. Account details has sent by e-Mail. Please check your spam folder in case email is not received.",
                            type: "success",
                        //}
                    },
                        function () {
                            location.href = 'Verification.html';
                       }
                    );
                    document.getElementById("submit-Signup").disabled = false;
                    $("#submit-Signup").html('Register<i class="fa-solid fa-user-plus ml-2" ></i>');
                }
                else {
                    
                    //$('#RMsgs').html("<span style='color:#f6a821;'>"+Response.Message+"</span>");                    
                    $('#Msgs').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning",

                    });
                    document.getElementById("submit-Signup").disabled = false;
                    $("#submit-Signup").html('Register<i class="fa-solid fa-user-plus ml-2"></i>');
                }
            },
            error: function (err) {
               
                  //$('#RMsgs').html("<span style='color:#f6a821;'>"+err.statusText+"</span>");       
                
                $('#Msgs').html('');
                swal({
                    title: "Sorry!",
                    text: Response.Message,
                    type: "error",

                });
                document.getElementById("submit-Signup").disabled = false;
                $("#submit-Signup").html('Register<i class="fa-solid fa-user-plus ml-2" ></i>');
            }
        });
   }
   }
}
///////////////////
function AccountLogin() {
 
    var od = new FormData();
    var txtPasswordSU= $("#txtPasswordSU").val();
    var txtUserID= $("#txtUserID").val();
    
     var txtCity=$("#txtCity").val();
    var txtCountry=$("#txtCountry").val();
    var txtRegion=$("#txtRegion").val();
    var txtLoginip = $("#txtLoginip").val();

    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-please"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submit-login").disabled = true;
    $("#submit-login").html('Please wait...');

    if (txtUserID!='' & txtPasswordSU !='')
{
    //$('#Msgs').html('<img src="UserProfileImg/loading2.gif" />'); 
       
    od.append("txtPasswordSU", txtPasswordSU);
    od.append("txtUserID",txtUserID);
    ////
    //
    od.append("txtCity",txtCity);
    od.append("txtCountry",txtCountry);
    od.append("txtRegion",txtRegion);
    od.append("txtLoginip",txtLoginip);
    //
         $.ajax({
             url: "Jap762Btp28lyf/Handlers/Account-Login.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) 
                {
                //$('form').attr('action',Response.Message);
                window.location.href=Response.Message; 
                self.undelegateEvents();
                delete self;
                }
                else 
                {
              
               /* $('#Msgs').html( Response.Message);*/
               // toastr.error(Response.Message);
                    $('#Msgs').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning",

                    });
                    document.getElementById("submit-login").disabled = false;
                    $("#submit-login").html('Login<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                }
            },
            error: function (err) {
            
            /*$('#Msgs').html(err.statusText);*/
             
             // toastr.warning(err.statusText);
                $('#Msgs').html('');
                swal({
                    title: "Sorry!",
                    text: err.statusText,
                    type: "error",

                });
                document.getElementById("submit-login").disabled = false;
                $("#submit-login").html('Login<i class="fa-solid fa-right-to-bracket ml-2"></i>');

            }
        });
   }
}

//////////////
//function VerifyAccount(emid) {

//    var od = new FormData();
//    var txtVerifCode = emid;

   
//    /////////
//    if (txtVerifCode != '') {
//        $('#Msgs').html('<img src="UserProfileImg/loading2.gif" />');
//        ////
//        od.append("txtVerifCode", txtVerifCode);
//        /////
//        $.ajax({
//            url: "Jap762Btp28lyf/Handlers/Verify-Account.ashx",
//            type: "POST",
//            contentType: false,
//            processData: false,
//            data: od,
//            dataType: "json",
//            success: function (Response) {
//                if (Response.Success) {
//                    $('#Msgs').html('');
//                    $("#Msgs").html("<div class='alert alert-success border-success'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='icofont icofont-close-line-circled'></i></button><strong>Congratulation !</strong> " + Response.Message + "</div>");
//                    $('#true-div').show();
//                    //swal({
//                    //  title: "Congratulation!",
//                    //  text: Response.Message,
//                    //  type: "success"
//                    //   },
                   
//                    //function(){
//                    //  //parent.location.reload(true);
//                    //    location.href = "Login.html";
//                    //                  });
//                }
//                else {
//                    $('#false-div').show();
//                    $('#Msgs').html('');
                    
//                    $("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='icofont icofont-close-line-circled'></i></button><strong>Ooops! </strong>" + Response.Message + "</div>");

//                }
//            },
//            error: function (err) {
//                $('#Msgs').html('');

//                $("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='icofont icofont-close-line-circled'></i></button><strong>Ooops! </strong>" + err.statusText + "</div>");

//            }
//        });
//    }
//}

function VerifyAccount() {
    var od = new FormData();
    var txtVerifCode = $("#otp").val();

    if (txtVerifCode !== '') {
        $('#Msgs').html('<img src="UserProfileImg/loading2.gif" />');
        od.append("txtVerifCode", txtVerifCode);

        $.ajax({
            url: "Jap762Btp28lyf/Handlers/Verify-Account.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    $('#otpinput').hide();
                    $('#Msgs').html(Response.Message);
                    //location.href = "Sign-In.html";
                } else {
                    $('#Msgs').html(Response.Message);
                }
            },
            error: function (err) {
                $('#Msgs').html(err.statusText);
            }
        });
    }
    return false; // Prevent the form from submitting the default way
}

function Resetmypassword1() {
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-please"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submit-reset").disabled = true;
    $("#submit-reset").html('Please wait...');
        var od = new FormData();
        var recovery_email= $("#txtemailadress").val();
        var recovery_memid= $("#txtmemid").val();
        
        
        /////////
//        var emaila = document.getElementById('txtemailadress');
//        var emailfiltera = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
//        ////
//        if (recovery_email !='' & emailfiltera.test(emaila.value))
//        {
    /* $('#Msg').html('<img src="UserProfileImg/loading2.gif" />');*/
   
        ////
        od.append("recovery_email", recovery_email);
        od.append("recovery_memid", recovery_memid);

        
        /////
        $.ajax({
            url: "Jap762Btp28lyf/Handlers/Reset-Password-Step1.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                  //$('#Msg').html(Response.Message);
                    $('#Msgs').html('');
                    swal({
                        title: "Sent",
                        text: Response.Message,
                        type: "success",

                    });
                    document.getElementById("submit-reset").disabled = false;
                    $("#submit-reset").html('Send Reset Instructions<i class="fa-solid fa-gears ml-2"></i>');
                  //$("#txtemailadress").val('');
                  //  $("#txtmemid").val('');
                    //window.location.href = Response.Message;
                    //self.undelegateEvents();
                    //delete self;
                }
                else {
                    $('#Msgs').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning",

                    });
                    document.getElementById("submit-reset").disabled = false;
                    $("#submit-reset").html('Send Reset Instructions<i class="fa-solid fa-gears ml-2"></i>');
                     //$('#Msg').html('<span style="color:#f6a821;">'+Response.Message+'</span>');
                }
            },
            error: function (err) {   
             //$('#Msg').html('<span style="color:#f6a821;">'+err.statusText+'</span>');     
                $('#Msgs').html('');
                swal({
                    title: "Sorry!",
                    text: err.statusText,
                    type: "error",

                });
                document.getElementById("submit-reset").disabled = false;
                $("#submit-reset").html('Send Reset Instructions<i class="fa-solid fa-gears ml-2"></i>');

            }
        });
  // }
}
//////////////
//function myFunction() {
//   window.location.href="../Login-Your-Account.html";
//}
/////////////

function Resetmysecrtypin() {

    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    //$('#Msgsre').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submit-login").disabled = true;
    $("#submit-login").html('please wait...');
    var od = new FormData();
    //        var recovery_email= $("#txtemailadress").val();
    //        var recovery_memid= $("#txtmemid").val();

    var changing_email = $("#changing_email").val();
    var changing_code = $("#changing_code").val();
    var new_password = $("#inputPassword").val();
    var changing_memid = $("#changing_memid").val();


    //$('#Msgsre').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    ////
    od.append("changing_email", changing_email);
    od.append("changing_code", changing_code);
    od.append("new_password", new_password);
    od.append("changing_memid", changing_memid);
    /////
    if (changing_email != new_password) {
        $('#Msgsf').html('');
        swal({
            title: "Alert!",
            text: "New Transaction Password & confirm Transaction Password must be same !",
            type: "error"

        });
        //function () {
        //    location.href = "Reset-SecurityPin.html";
        //});

        document.getElementById("submit-login").disabled = false;
        $("#submit-login").html('Submit');

        return;
    }
    ///////////
    $.ajax({
        url: "Jap762Btp28lyf/Handlers/Reset-Security-Pin.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                $('#Msgsre').html('');

                //$('#Msgsre').html("<p class='success hide' id='not-found' style='display: block;color: #09a909;'>" + Response.Message + "</p>");
                //<div style='text-align: center;'><span class='alert alert-success alert-dismissable' onclick='hided()' style='display:block;'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button><i class='fa fa-check-circle'></i>"+Response.Message+"</span></div>");
                //$("#Msg").html('');
                swal({
                    title: "Done",
                    text: Response.Message,
                    type: "success"
                },
                    function () {
                        location.href = "Jap762Btp28lyf/game-index.html";
                    });
                document.getElementById("submit-login").disabled = false;
                $("#submit-login").html('Submit');

                $("#txtemailadress").val('');
                $("#txtmemid").val('');
            }
            else {
                $('#Msgsre').html('');
                swal({
                    title: "Alert",
                    text: Response.Message,
                    type: "warning"
                });
                document.getElementById("submit-login").disabled = false;
                $("#submit-login").html('Submit');
                //$('#Msgsre').html("<p class='error hide' id='not-found' style='display: block;color: red;'>" + Response.Message + "</p>");
                //<div style='text-align: center;'><span class='alert alert-danger alert-dismissable' onclick='hided()' style='display:block;'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button><i class='fa fa-times-circle'></i>"+Response.Message+"</span></div>");

            }
        },
        error: function (err) {

            $('#Msgsre').html('');
            //$('#Msgsre').html("<p class='error hide' id='not-found' style='display: block;color: red;'>" + err.statusText + "</p>");
            //<div style='text-align: center;'><span class='alert alert-danger alert-dismissable' onclick='hided()' style='display:block;'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button><i class='fa fa-times-circle'></i>"+err.statusText+"</span></div>");   
            swal({
                title: "Error",
                text: err.statusText,
                type: "warning"
            });
            document.getElementById("submit-login").disabled = false;
            $("#submit-login").html('Submit');
            $('#Msgsre').html('');
        }
    });

}

function Resetmypassword2() {

   
        var od = new FormData();
        var changing_email= $("#changing_email").val();
        var changing_code= $("#changing_code").val();
        var new_password= $("#new_password").val();
        var changing_memid= $("#changing_memid").val();
        
    var confirm_pass = $("#Confirmed_password").val();

    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-please"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submit-login").disabled = true;
    $("#submit-login").html('Please wait...');

        if(confirm_pass != new_password)
        {
         //$('#Msgs').html('<span style="color:#f6a821;">New password & confirm password not same !</span>');
            $('#Msgs').html('');
            swal({

                title: "Sorry!",
                text: "New password & confirm password not same !",
                type: "warning",

            });
            
            document.getElementById("submit-login").disabled = false;
            $("#submit-login").html('Reset Password <i class="fa-solid fa-rotate ml-2"></i>');
            return;
        }
        /////////
//        var emailb = document.getElementById('changing_email');
//        var emailfilterb = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
//        ////
//        if (new_password !='' & emailfilterb.test(emailb.value) & changing_code !='')
//        {
        //$('#Msgs').html('<img src="UserProfileImg/loading2.gif" />');
   
        ////
        od.append("changing_email", changing_email);
        od.append("changing_code", changing_code);
        od.append("new_password", new_password);
        od.append("changing_memid", changing_memid);
        /////
        $.ajax({
            url: "Jap762Btp28lyf/Handlers/Reset-Password-Step2.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                  /*  $('#Msgs').html(Response.Message);*/
                    $('#Msgs').html('');
                    swal({
                        title: "Done",
                        text: Response.Message,
                        type: "success",

                    });
                    document.getElementById("submit-login").disabled = false;
                    $("#submit-login").html('Reset Password <i class="fa-solid fa-rotate ml-2" ></i>');

                  $("#changing_email").val('');
                  $("#Confirmed_password").val('');                  
                  $("#new_password").val('');
                  $("#changing_code").val('');
                  $("#changing_memid").val('');
                  setTimeout(myFunction, 5000);
                }
                else {
                    //$('#Msgs').html(Response.Message);
                    $('#Msgs').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning",

                    });
                    document.getElementById("submit-login").disabled = false;
                    $("#submit-login").html('Reset Password <i class="fa-solid fa-rotate ml-2"></i>');
                }
            },
            error: function (err) {        
               //$('#Msgs').html(err.statusText); 
                $('#Msgs').html('');
                swal({
                    title: "Sorry!",
                    text: err.statusText,
                    type: "error",

                });
                document.getElementById("submit-login").disabled = false;
                $("#submit-login").html('Reset Password <i class="fa-solid fa-rotate ml-2"></i>');

            }
        });
   //}
}

function getLoginDetails() {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.open("GET", "https://ipapi.co/json/", true);
    xmlhttp.send();
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsontext = xmlhttp.responseText;
            var data = JSON.parse(jsontext);
            $("#txtCity").val(data.city);
            $("#txtCountry").html(data.country_name);
            $("#txtRegion").val(data.region_code);
            $("#txtLoginip").val(data.ip);
        }
    }
}

