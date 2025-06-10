using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

/// <summary>
/// Summary description for Class1
/// </summary>
public class SendEmail
{
    SqlConnection Cn = new SqlConnection(new DB().getconnection().ToString());
    SqlCommand Cmd;
    SqlDataAdapter da;
    DataSet ds;
    string EmailID, UserID, Pwd, EwalletPwd, Mname, Message, validdate;
    DynamicDtls objgdb = new DynamicDtls();
    public SendEmail()
    {

        //
        // TODO: Add constructor logic here
        //
    }



    public void SendEmailToUser(string UserID)
    {
        objgdb.FillWebSiteEmailCompany();
        Cmd = new SqlCommand("select memid,mname,MMidName,MLastName,address,Email,city,state,pin,mobile,pwd,ewalletpwd,convert(varchar(12),Doj,13) doj, convert(varchar(10),dateadd(d,365,doj),103) todate,package from memdetail where memid='" + UserID + "'", Cn);
        da = new SqlDataAdapter(Cmd);
        ds = new DataSet();
        da.Fill(ds);
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            EmailID = dr["Email"].ToString().ToUpper();
            Pwd = dr["pwd"].ToString().ToUpper();
            EwalletPwd = dr["ewalletpwd"].ToString().ToUpper();
            Mname = dr["Mname"].ToString().ToUpper() + " " + dr["MMidName"].ToString().ToUpper() + " " + dr["MLastName"].ToString().ToUpper();
            validdate = dr["doj"].ToString();


        }

        string Mid = EmailID;

        if (Mid != "")
        {
            string Msg = "<html style=font-family:verdana;font-size:11px;line-height:20px><div style=width:650px><IMG SRC=http://" + DynamicDtls.WebSite + "//UserPanel_Images/LogoUser.png></br></br><div>Dear <b>" + Mname + ",</b><br /><br />"
            + "We take this opportunity to thank you for choosing to work with us and welcome you to the family of <b>" + DynamicDtls.TopCompName + ".</b> as a business associate.<br>"
            + "Your Login ID is <b>" + UserID + "</b>,Password=<b>" + Pwd + "</b>,Ewallet Password=<b>" + EwalletPwd + "</b> and Registration Date is  <b>" + validdate + "</b>. We request you to quote this Login ID in any correspondence that you may have with us.<br><br> "
            + "<b>For Viewing Your status And To Keep Yourself Updated With The Latest Information, Events And Offers, Do Keep In Touch With <a href=http://" + DynamicDtls.WebSite + " target='blank'>" + DynamicDtls.WebSite + "</a></b><br>"
            + "<br>We Once Again Welcome You To World Of  " + DynamicDtls.TopCompName + " And Thank You For Giving Us An Opportunity To Service You.<br><br><b> "
            + "</b><br><br>HAPPY SPENDING,<br><br>"
            + "Thanks And Regards<br><b>" + DynamicDtls.TopCompName + "</b></b></div>";
            //return Msg;
            SendMailMessage("" + DynamicDtls.Email + "", "" + DynamicDtls.TopCompName + "", Msg, Mid);
        }

    }


    public void SendMailMessage(string from, string subject, string body, params string[] to)
    {
        // Instantiate a new instance of MailMessage
        MailMessage mMailMessage = new MailMessage();

        // Set the sender address of the mail message
        mMailMessage.From = new MailAddress(from);
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
        SmtpClient mSmtpClient = new SmtpClient();
        // Send the mail message
        try
        {
            mSmtpClient.Send(mMailMessage);
        }
        catch (SmtpException se)
        { }
    }
}
