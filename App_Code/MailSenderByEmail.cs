using System.Data;
using System.Net.Mail;
using System.Web;
/// <summary>
/// Summary description for MailSenderByEShop
/// </summary>
public class MailSenderByEmail
{
    string Format = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    string Name = "", ImagePath = "", DOJ = "", City = "", Age = "";
    string SponserID = "", SpoMName = "", SpoMobile = "", MName = "", Mobile = "", GRname = "", AssignAmt = "", AssignDt = "";
    DB objdb = new DB();

    public MailSenderByEmail()
    {
        //
        // TODO: Add constructor logic here
        //
    }




    public void MailFormat(string Type, string UserID, string FriendUserID, string Amount, string ReqText)
    {
        objgdb.FillWebSiteEmailCompany();
        string UserEmailId = "";
        ds = objdb.ByDataSet("SELECT Email,MName FROM memdetail WITH(NOLOCK) where  (memid= '" + UserID + "')");
        UserEmailId = ds.Tables[0].Rows[0][0].ToString();
        FriendUserID = ds.Tables[0].Rows[0][1].ToString();

        //GetDetailsOfUser(UserID);

        if (Type == "GiveHelpReq")
        {
            ds = objdb.ByDataSet("select count(memid) from Hlp_tblCommitWallet with(nolock) where memid='" + UserID + "'");
            if (ds.Tables[0].Rows[0][0].ToString() == "1")
            {

                Format = @"<html><div style='background-color:white;padding:5px;'>
<table width='100%' style='font-family: 'Poppins', sans-serif; font-size: 12px;' cellpadding='0' cellspacing='0'><tr><td>
  <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>    <img alt='" + DynamicDtls.WebSite + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png'  /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table>  </td></tr><tr><td style='height: 21px'></td></tr><tr><td style='height: 24px'></td></tr><tr><td style='height: 24px'> Hi " + FriendUserID + "  <br> <br></td></tr><tr><td style='height: 24px'>Your Provide help link request of amount: <sUSDSwapg style='color: Red;'>" + Amount + " has been sent. " + ReqText + "</sUSDSwapg></td>        </tr><tr><td style='height: 21px'></td></tr><tr><td><div style='background-color: #f1f1f1; border: solid 1px #cccccc; padding: 7px;'> Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>    <br />  <br />    For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div>            </td></tr><tr><td></td>        </tr>        <tr>            <td style='height: 21px'>            </td>        </tr>        <tr>            <td style='height: 21px'>Regards,</td>        </tr>        <tr>            <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>        </tr>    </table>     </div></html>";
                SendMailMessage(DynamicDtls.Email, "Commitment Notification.", Format, UserEmailId);
            }
            else
            {
                Format = @"<html><div style='background-color:white;padding:5px;'>
<table width='100%' style='font-family: 'Poppins', sans-serif; font-size: 12px;' cellpadding='0' cellspacing='0'><tr><td>
  <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>
    <img alt='" + DynamicDtls.CompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png'  /></div></td> <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table>  </td></tr><tr><td style='height: 21px'></td></tr><tr><td style='height: 24px'></td></tr><tr><td style='height: 24px'> Hi " + FriendUserID + "<br> <br></td></tr>    <tr>        <td style='height: 35px'>        WE ARE SO THANKFUL FOR ALL THOSE WHO UNDERSTANDS US AND GIVES US THIS KIND OF WONDERFUL START..... WE TRY TO SHARE OUR EVERY EXPERIENCE WITH OUR PARTICIPANTS....THANK YOU ALL..............</td>    </tr>    <tr><td style='height: 24px'>Your re-commitment amount Rs. <sUSDSwapg style='color: Red;'>" + Amount + " </sUSDSwapg>With <sUSDSwapg>" + ReqText + "</sUSDSwapg></td>        </tr><tr><td style='height: 21px'></td></tr><tr><td><div style='background-color: #f1f1f1; border: solid 1px #cccccc; padding: 7px;'>    Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>    <br />  <br />    For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div>            </td></tr><tr><td></td>        </tr>        <tr>            <td style='height: 21px'>            </td>        </tr>        <tr>            <td style='height: 21px'>Regards,</td>        </tr>        <tr>            <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>        </tr>    </table>     </div></html>";
                SendMailMessage(DynamicDtls.Email, "Re-Commitment Notification.", Format, UserEmailId);

            }

        }
        if (Type == "ReceivedHelpReq")
        {

            if (Amount == "GiveHelp")
            {
                GiveHelpDetails(UserID, ReqText); //FriendUserID as AssignMent No
                Format = @"<html> <div style='background-color:white;padding:5px;'>
        <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td> 
        <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#f1f1f1;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
        <tr><td style='padding:5px 5px 5px 5px;'><div>   <img alt='' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td>   <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "      <br><br>  </td></tr>    <tr>        <td style='height: 24px'>Please find Provide help link details...</td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>  <tr><td style='height: 21px'><table cellpadding='0' cellspacing='0' style='width: 100%;padding:5px;' >        <tr>        <td style='height: 22px' >Order No/Date:</td>            <td style='height: 22px' >" + ReqText + " (" + AssignDt + ")</td>        </tr><tr><td style='height: 22px' ><b>Participants Name/ID/Mobile:</b></td><td style='height: 22px' >   " + MName + " /" + GRname + "/" + Mobile + "</td>            </tr>            <tr><td style='height: 22px' >    <b>Name</b></td><td style='height: 22px' > " + SpoMName + "</td></tr><tr><td style='height: 22px' >    <b>amount:</b></td><td style='height: 22px' >    <sUSDSwapg style='color:Red;'>    " + AssignAmt + "</sUSDSwapg></td>            </tr>        </table>        </td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table>    </div>       </html>";
                SendMailMessage(DynamicDtls.Email, "Provide help link Request Notification.", Format, UserEmailId);
                /////////
                ds = objdb.ByDataSet("SELECT Email,MName FROM memdetail WITH(NOLOCK) where  (memid= '" + SponserID + "')");
                UserEmailId = ds.Tables[0].Rows[0][0].ToString();
                FriendUserID = ds.Tables[0].Rows[0][1].ToString();
                SendMailMessage(DynamicDtls.Email, "Provide help link Request Notification to your referrals.", Format, UserEmailId);
            }
            if (Amount == "ReceiveHelp")
            {
                RecivedHelpDetails(UserID, ReqText); //FriendUserID as AssignMent No
                                                     ///////////
                Format = @"<html><div style='background-color:white;padding:5px;'>
        <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td> 
        <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#f1f1f1;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
        <tr><td style='padding:5px 5px 5px 5px;'><div> <img alt='" + DynamicDtls.CompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "      <br><br>  </td></tr>    <tr>        <td style='height: 24px'>Please find Help link details...</td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>  <tr><td style='height: 21px'><table cellpadding='0' cellspacing='0' style='width: 100%;padding:5px;' >        <tr>        <td style='height: 22px' ><b>Order No/Date:</b></td>            <td style='height: 22px' >" + ReqText + " (" + AssignDt + ")</td></tr><tr><td style='height: 22px' ><b>Participants Name/ID/Mobile:</b></td><td style='height: 22px' >   " + MName + " /" + GRname + "/" + Mobile + "</td>            </tr>            <tr><td style='height: 22px' ><b>Name</b></td><td style='height: 22px' >" + SpoMName + "</td>            </tr>            <tr><td style='height: 22px' >    <b>amount:</b></td><td style='height: 22px' >    <sUSDSwapg style='color:Red;'>    " + AssignAmt + "</sUSDSwapg></td>            </tr>        </table>        </td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table>    </div>     </html>";
                SendMailMessage(DynamicDtls.Email, "Help link Request Notification.", Format, UserEmailId);
                ////////////////
                ds = objdb.ByDataSet("SELECT Email,MName FROM memdetail WITH(NOLOCK) where  (memid= '" + SponserID + "')");
                UserEmailId = ds.Tables[0].Rows[0][0].ToString();
                FriendUserID = ds.Tables[0].Rows[0][1].ToString();
                SendMailMessage(DynamicDtls.Email, "Help link Request Notification to your referrals.", Format, UserEmailId);
            }

        }

        if (Type == "ChangePassword")
        {
            Format = @"<html> <div style='background-color:white;padding:5px;'>
    <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td>       <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'> <img alt='" + DynamicDtls.CompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td> <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "       <br><br> </td></tr>    <tr>        <td style='height: 24px'>            Your password has been changed successfully.</td>    </tr> <tr><td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>            New password: <span style='color:#0c69b9;'>" + ReqText + " </span><br><br></td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table> </div>     </html>";
            SendMailMessage(DynamicDtls.Email, "Password Notification.", Format, UserEmailId);

        }


        if (Type == "LoginBlock")
        {
            Format = @"<html><div style='background-color:White;'>
    <table width='100%' style='font-family:Verdana;font-size:12px;'>    <tr>        <td>       <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>    <img alt='' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "       <br><br> </td></tr>    <tr>        <td style='height: 24px'>            Your Id [ " + UserID + " ] has been blocked.</td>    </tr> <tr><td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>            Contact your coordinator.</td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table> </div>     </html>";
            SendMailMessage(DynamicDtls.Email, "Login Blocked Notification.", Format, UserEmailId);

        }



        if (Type == "TransPassword")
        {
            Format = @"<html>  <div style='background-color:white;padding:5px;'>
    <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td>   
        <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>    <img alt='" + DynamicDtls.TopCompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "      <br><br>  </td></tr>    <tr>        <td style='height: 24px'>            Your Transactoin Password has been changed successfully.</td>    </tr> <tr><td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px;'>            New Transaction Password : <span style='color:#0c69b9;'>" + ReqText + "</span><br><br></td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://<" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table>   </div>     </html>";
            SendMailMessage(DynamicDtls.Email, "Password Notification.", Format, UserEmailId);

        }

        if (Type == "ForgetPassword")
        {
            Format = @"<html><div style='background-color:white;padding:5px;'>
    <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td>       <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>    <img alt='' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "       <br><br> </td></tr>    <tr>        <td style='height: 24px'>            Recover your password successfully.</td>    </tr> <tr><td style='height: 24px'>        </td>    </tr>            <tr><td style='height: 24px'>      USER ID : <span style='color:#0c69b9;'>" + UserID + " </span></td>        </tr>        <tr>        <td style='height: 24px'>            password: <span style='color:#0c69b9;'>" + ReqText + " </span><br><br></td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.CompName + "</sUSDSwapg></td>    </tr></table> </div>          </html>";
            SendMailMessage(DynamicDtls.Email, "Forgot password details for on " + DynamicDtls.CompName + ".", Format, UserEmailId);

        }
        if (Type == "ForgetTransPassword")
        {
            Format = @"<html><div style='background-color:white;padding:5px;'>
    <table width='100%' style='font-family:Verdana;font-size:12px;' cellpadding='0' cellspacing='0'>    <tr>        <td>       <table cellpadding='0' cellspacing='0' style='width:100%;height:70px;background-color:#ffffff;border:solid 1px #ff0000;Color:White; font-family:Verdana;font-weight:bold;font-size:14px;'>
    <tr><td style='padding:5px 5px 5px 5px;'><div style='background-color:#ffffff;'>    <img alt='" + DynamicDtls.TopCompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png'  /></div></td>    <td align='right'  style='padding:5px;color:#5786be'>" + DynamicDtls.CompName + "</td>    </tr>    </table></td></tr><tr><td style='height: 21px'></td>    </tr>    <tr>        <td style='height: 24px'>        </td>    </tr>    <tr>        <td style='height: 24px'>    Hi " + FriendUserID + "       <br><br> </td></tr>    <tr>        <td style='height: 24px'>            Recover your transaction password successfully.</td>    </tr> <tr><td style='height: 24px'>        </td>    </tr>            <tr>            <td style='height: 24px'>USER ID : <span style='color:#0c69b9;'>" + UserID + " </span></td>        </tr>        <tr>        <td style='height: 24px'>            password: <span style='color:#0c69b9;'>" + ReqText + " </span><br><br></td>    </tr>    <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td >   <div style='background-color:#f1f1f1;border : solid 1px #cccccc;padding:7px; '>   Our web address is <a href='http://" + DynamicDtls.WebSite + "' target='_blank'>http://" + DynamicDtls.WebSite + "</a>   <br />   <br />  For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div> </td>    </tr>    <tr>   <td> </td></tr>  <tr>        <td style='height: 21px'>        </td>    </tr>    <tr>        <td style='height: 21px'>            Regards,</td>    </tr>    <tr>        <td style='height: 21px'><sUSDSwapg>Team " + DynamicDtls.TopCompName + "</sUSDSwapg></td>    </tr></table> </div>               </html>";
            SendMailMessage(DynamicDtls.Email, "Forgot password details for on " + DynamicDtls.CompName + ".", Format, UserEmailId);

        }

        if (Type == "JoinMeassge")
        {

            GetUserDetails(UserID);

            Format = @"<html> <div style='background-color:Transparent;padding:5px;'><table width='100%' style='font-family: 'Poppins', sans-serif; font-size: 12px;'><tr><td><table cellpadding='0' cellspacing='0' style='width: 100%; height: 70px; background-color: #ffffff;border: solid 1px #ff0000; color: White; font-family: 'Poppins', sans-serif; font-weight: bold;font-size: 14px;'><tr><td style='padding: 5px 5px 5px 5px;'>
<div style='background-color: #ffffff; '><img alt='" + DynamicDtls.TopCompName + "' src='http://" + DynamicDtls.WebSite2 + "/website-logo/SendInviLogo.png' /></div></td><td align='right' style='padding: 5px;'>" + DynamicDtls.TopCompName + "</td></tr></table></td></tr><tr><td style='height: 21px'>  </td></tr><tr><td style='height: 24px'></td></tr><tr><td style='height: 24px'>Hello,<br></td></tr><tr><td style='height: 24px'>Your Friend Invited you to join " + DynamicDtls.TopCompName + ", Please Refer below details....</td></tr><tr><td style='height: 24px'></td></tr><tr><td><div style='width: 75px; height: 75px; float: left; border: solid 1px #cbcbcb; padding: 2px;'><img alt='Photo' src='http://" + DynamicDtls.WebSite + "/" + ImagePath + "' style='width: 75px;height: 75px' /></div>   <div style='float: left;'><div style='height: 30px; padding-left: 20px; font-weight: bold; font-size: 14px;text-transform: capitalize;'>" + Name + " (" + UserID + ")</div><div style='height: 30px; padding-left: 20px; font-weight: normal; color: #2e1f1c;'>DOJ:" + DOJ + "</div><div style='height: 30px; padding-left: 20px; font-weight: normal; color: #2e1f1c;'>" + City + "," + Age + "</div></div></td></tr><tr><td style='height: 21px'><a href=" + ReqText + " target='_blank'>Click Here To Join</a></td></tr><tr><td><div style='background-color: #f1f1f1; border: solid 1px #cccccc; padding: 7px;'>Our web address is <a href='http://" + DynamicDtls.WebSite + "/' target='_blank'>http://" + DynamicDtls.WebSite + "</a><br /><br />For any queries and details please feel free to contact us at " + DynamicDtls.CompEmail + ".</div></td></tr><tr><td></td></tr><tr><td style='height: 21px'></td></tr><tr><td style='height: 21px'>Regards,</td></tr><tr><td style='height: 21px'><sUSDSwapg>TEAM " + DynamicDtls.TopCompName + "</sUSDSwapg></td></tr></table></div></html>";
            //objSentJoinMess.SentMailInvite(FriendUserID, "Invitation from " + UserID + " to Join Ecrush.us" + Adsid, Format);
            SendMailMessageWithFile(DynamicDtls.Email, "Invitation from " + UserID + " to Join " + DynamicDtls.TopCompName + ".", Format, Amount);
        }

    }
    public void GetUserDetails(string UserID)
    {
        ds = objdb.ByDataSet(@"select r.memid, convert(varchar, r.DOJ,106) as DOJ,r.City
,DATEDIFF(YYYY,r.DOB,getdate()) as Age,CASE WHEN mp.AdminApproved='NO' THEN 'UserProfileImg/upload-photo.jpg'   
  ELSE isnull('UserProfileImg/'+mp.MemPic,'UserProfileImg/upload-photo.jpg') END  ImagePath,
r.MName as Name,r.Email
 from   Memdetail r with(nolock)
Left join MemProfilePic mp with(nolock) on mp.memid=r.memid
 where r.Memid='" + UserID + "'");
        if (ds.Tables[0].Rows.Count > 0)
        {
            Name = ds.Tables[0].Rows[0]["Name"].ToString();
            DOJ = ds.Tables[0].Rows[0]["DOJ"].ToString();
            City = ds.Tables[0].Rows[0]["City"].ToString();
            Age = ds.Tables[0].Rows[0]["Age"].ToString();
            ImagePath = ds.Tables[0].Rows[0]["ImagePath"].ToString();
            //YourDescription = ds.Tables[0].Rows[0]["YourDescription"].ToString();

        }
    }
    public void RecivedHelpDetails(string MemId, string AssignNo)
    {
        try
        {
            ds = objdb.ByDataSet(@"select lower(spo.SponserID) SponserID, lower(spo.MName) as SpoMName,spo.Mobile as SpoMobile,          
lower(md.MName) MName,md.Mobile,md.email as GRname,  rw.ByMemID, lower(rw.ToMemID)ToMemID, rw.AssignNo,             
rw.AssignAmt,  convert(varchar, rw.AssignDt,103) AssignDt,lower(spo.MemID)MemID 
FROM         Hlp_tblRequestWallet rw WITH(NOLOCK)               
              
INNER JOIN  Hlp_tblRequestBank rb WITH(NOLOCK) ON rw.AssignNo = rb.AssignNo               
INNER JOIN  MemDetail md WITH(NOLOCK) ON rw.ToMemID =  md.MemID               
               
inner join ( select g.SponserID,g.MemID,mds.MName,mds.Mobile,mds.email from Genealogy g WITH(NOLOCK) 
inner join MemDetail mds WITH(NOLOCK)  ON g.SponserID=mds.MemID
where g.MemID in (
select ToMemID from Hlp_tblRequestWallet where ByMemID= '" + MemId + "')) spo on spo.MemID=md.MemID left join tblMessageOnRequest mr with(nolock) on mr.AdsId=rw.AssignNo WHERE rw.ByMemID='" + MemId + "'  and rw.AssignNo ='" + AssignNo + "' order by rw.AssignDt desc");

            SponserID = ds.Tables[0].Rows[0]["SponserID"].ToString();
            SpoMName = ds.Tables[0].Rows[0]["SpoMName"].ToString();
            SpoMobile = ds.Tables[0].Rows[0]["SpoMobile"].ToString();

            MName = ds.Tables[0].Rows[0]["MName"].ToString();
            Mobile = ds.Tables[0].Rows[0]["Mobile"].ToString();
            GRname = ds.Tables[0].Rows[0]["GRname"].ToString();

            AssignNo = ds.Tables[0].Rows[0]["AssignNo"].ToString();
            AssignAmt = ds.Tables[0].Rows[0]["AssignAmt"].ToString();
            AssignDt = ds.Tables[0].Rows[0]["AssignDt"].ToString();
        }
        catch { throw; }
    }

    public void GiveHelpDetails(string MemId, string AssignNo)
    {
        try
        {
            ds = objdb.ByDataSet(@"SELECT lower(spo.SponserID) SponserID, lower(spo.MName) as SpoMName,spo.Mobile as SpoMobile,          
lower(md.MName) MName,md.Mobile,md.email as GRname,  rw.ByMemID, lower(rw.ToMemID)ToMemID, rw.AssignNo,             
rw.AssignAmt,  convert(varchar, rw.AssignDt,103) AssignDt,lower(spo.MemID)MemID
FROM         Hlp_tblRequestWallet rw WITH(NOLOCK) INNER JOIN            
       Hlp_tblRequestBank rb WITH(NOLOCK) ON rw.AssignNo = rb.AssignNo INNER JOIN            
     MemDetail md WITH(NOLOCK) ON rw.ByMemID =  md.MemID            
     inner join (           
select g.SponserID,g.MemID,mds.MName,mds.Mobile,mds.email from Genealogy g WITH(NOLOCK)             
inner join MemDetail mds WITH(NOLOCK)  ON g.SponserID=mds.MemID            
where g.MemID in (            
select ByMemID from Hlp_tblRequestWallet WITH (NOLOCK) where ToMemID= '" + MemId + "')) spo on spo.MemID=md.MemID left join tblMessageOnRequest mr with(nolock) on mr.AdsId=rw.AssignNo WHERE rw.ToMemID='" + MemId + "'  and rw.AssignNo ='" + AssignNo + "' order by rw.AssignDt desc");

            SponserID = ds.Tables[0].Rows[0]["SponserID"].ToString();
            SpoMName = ds.Tables[0].Rows[0]["SpoMName"].ToString();
            SpoMobile = ds.Tables[0].Rows[0]["SpoMobile"].ToString();

            MName = ds.Tables[0].Rows[0]["MName"].ToString();
            Mobile = ds.Tables[0].Rows[0]["Mobile"].ToString();
            GRname = ds.Tables[0].Rows[0]["GRname"].ToString();

            AssignNo = ds.Tables[0].Rows[0]["AssignNo"].ToString();
            AssignAmt = ds.Tables[0].Rows[0]["AssignAmt"].ToString();
            AssignDt = ds.Tables[0].Rows[0]["AssignDt"].ToString();
        }
        catch { throw; }
    }
    public void SendMailMessage(string from, string subject, string body, params string[] to)
    {
        objgdb.FillWebSiteEmailCompany();
        // Instantiate a new instance of MailMessage
        MailMessage mMailMessage = new MailMessage();

        // Set the sender address of the mail message
        mMailMessage.From = new MailAddress(from, DynamicDtls.TopCompName);
        // Set the recepient address of the mail message
        foreach (string s in to)
        {
            mMailMessage.To.Add(new MailAddress(s));
        }
        mMailMessage.Subject = subject;
        // Set the body of the mail message
        mMailMessage.Body = body;
        // Set the format of the mail message body as HTML
        mMailMessage.IsBodyHtml = true;
        // Set the priority of the mail message to normal
        mMailMessage.Priority = MailPriority.Normal;

        // Instantiate a new instance of SmtpClient
        //SmtpClient mSmtpClient = new SmtpClient();
        SmtpClient mSmtpClient = new SmtpClient
        {
            Host = DynamicDtls.EMailPort,
            Port = 25,
            EnableSsl = false,
            Credentials = new System.Net.NetworkCredential(DynamicDtls.Email, DynamicDtls.EMailPWD)
        };
        // Send the mail message
        try
        {
            mSmtpClient.Send(mMailMessage);
        }
        catch
        { }
    }
    public void SendMailMessageWithFile(string from, string subject, string body, params string[] to)
    {
        objgdb.FillWebSiteEmailCompany();
        // Instantiate a new instance of MailMessage
        MailMessage mMailMessage = new MailMessage();

        // Set the sender address of the mail message
        mMailMessage.From = new MailAddress(from, DynamicDtls.TopCompName);
        // Set the recepient address of the mail message
        foreach (string s in to)
        {
            mMailMessage.To.Add(new MailAddress(s));
        }
        //mMailMessage.To.Add(new MailAddress(to));
        // Check if the bcc value is null or an empty string
        //if ((bcc != null) && (bcc != string.Empty))
        //{
        //    // Set the Bcc address of the mail message
        //    mMailMessage.Bcc.Add(new MailAddress(bcc));
        //}

        // Check if the cc value is null or an empty value
        //if ((cc != null) && (cc != string.Empty))
        //{
        //   // Set the CC address of the mail message
        //   mMailMessage.CC.Add(new MailAddress(cc));
        //}       // Set the subject of the mail message

        mMailMessage.Attachments.Add(new Attachment(HttpContext.Current.Server.MapPath("../UserProfileImg/WebSite_Pic.png")));

        // your remote SMTP server IP.


        mMailMessage.Subject = subject;
        // Set the body of the mail message
        mMailMessage.Body = body;
        // Set the format of the mail message body as HTML
        mMailMessage.IsBodyHtml = true;
        // Set the priority of the mail message to normal
        mMailMessage.Priority = MailPriority.Normal;

        // Instantiate a new instance of SmtpClient
        SmtpClient mSmtpClient = new SmtpClient();
        // Send the mail message
        try
        {
            mSmtpClient.Send(mMailMessage);
        }
        catch
        { throw; }
    }

}
