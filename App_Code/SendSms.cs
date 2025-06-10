using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
/// <summary>
/// Summary description for SendSms
/// </summary>
public class SendSms
{
    string createdURLFrom, ToMobiUSD, ToMobNo;
    SqlConnection Cn = new SqlConnection(new DB().getconnection().ToString());
    SqlCommand Cmd;
    SqlDataAdapter da;
    DataSet ds;
    DynamicDtls Objgdb = new DynamicDtls();
    public SendSms()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public void SendSMSPromotional(string ToMob, string TextFrom)
    {
        createdURLFrom = Objgdb.GetCredentialAPI(ToMob, TextFrom, "SMSAPI");
        HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
        myReqfrm.Method = "POST";
        // myReq.ContentLength = Text.Length;
        byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextFrom);
        // Set the ContentType property of the WebRequest.
        myReqfrm.ContentType = "application/x-www-form-urlencoded";
        // Set the ContentLength property of the WebRequest.
        myReqfrm.ContentLength = byteArrayfrm.Length;
        // Get the request stream.
        Stream dataStreamfrm = myReqfrm.GetRequestStream();
        // Write the data to the request stream.
        dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
        // Close the Stream object.
        dataStreamfrm.Close();
    }
    public void SendSMSToUserMob(string ToMob, string TextFrom)
    {
        createdURLFrom = Objgdb.GetCredentialAPI(ToMob, TextFrom, "SMSAPI");
        HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
        myReqfrm.Method = "POST";
        // myReq.ContentLength = Text.Length;
        byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextFrom);
        // Set the ContentType property of the WebRequest.
        myReqfrm.ContentType = "application/x-www-form-urlencoded";
        // Set the ContentLength property of the WebRequest.
        myReqfrm.ContentLength = byteArrayfrm.Length;
        // Get the request stream.
        Stream dataStreamfrm = myReqfrm.GetRequestStream();
        // Write the data to the request stream.
        dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
        // Close the Stream object.
        dataStreamfrm.Close();
    }
    public void SendSMSToUserIDMob(string TextMsg, string UserID)
    {
        Cmd = new SqlCommand("select mobile from memdetail WITH (NOLOCK) where memid='" + UserID + "'", Cn);
        da = new SqlDataAdapter(Cmd);
        ds = new DataSet();
        da.Fill(ds);
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            ToMobNo = dr["mobile"].ToString();
        }
        ToMobiUSD = ToMobNo.Trim();
        if (ToMobiUSD.Length == 10)
        {
            createdURLFrom = Objgdb.GetCredentialAPI(ToMobiUSD, TextMsg, "SMSAPI");
            HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
            myReqfrm.Method = "POST";
            // myReq.ContentLength = Text.Length;
            byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextMsg);
            // Set the ContentType property of the WebRequest.
            myReqfrm.ContentType = "application/x-www-form-urlencoded";
            // Set the ContentLength property of the WebRequest.
            myReqfrm.ContentLength = byteArrayfrm.Length;
            // Get the request stream.
            Stream dataStreamfrm = myReqfrm.GetRequestStream();
            // Write the data to the request stream.
            dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
            // Close the Stream object.
            dataStreamfrm.Close();
        }
    }

    public string SendSMSToUserMobWithCreditMsg(string ToMob, string TextFrom)
    {
        createdURLFrom = Objgdb.GetCredentialAPI(ToMob, TextFrom, "SMSAPI");
        HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
        myReqfrm.Method = "POST";
        // myReq.ContentLength = Text.Length;
        byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextFrom);
        // Set the ContentType property of the WebRequest.
        myReqfrm.ContentType = "application/x-www-form-urlencoded";
        // Set the ContentLength property of the WebRequest.
        myReqfrm.ContentLength = byteArrayfrm.Length;
        // Get the request stream.
        Stream dataStreamfrm = myReqfrm.GetRequestStream();
        // Write the data to the request stream.
        dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
        // Close the Stream object.
        dataStreamfrm.Close();

        HttpWebResponse myResp = (HttpWebResponse)myReqfrm.GetResponse();
        System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        string responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        return responseString;

    }
    //public void SponserSendSMSToUserIDMob(string TextMsg, string Mobile)
    //{
    //    try
    //    {
    //        ToMobiUSD = Mobile.Trim();
    //        if (ToMobiUSD.Length == 10)
    //        {

    //            createdURLFrom = Objgdb.GetCredentialAPI(ToMobiUSD, TextMsg, "SMSAPI");
    //            HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
    //            myReqfrm.Method = "POST";
    //            // myReq.ContentLength = Text.Length;
    //            byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextMsg);
    //            // Set the ContentType property of the WebRequest.
    //            myReqfrm.ContentType = "application/x-www-form-urlencoded";
    //            // Set the ContentLength property of the WebRequest.
    //            myReqfrm.ContentLength = byteArrayfrm.Length;
    //            // Get the request stream.
    //            Stream dataStreamfrm = myReqfrm.GetRequestStream();
    //            // Write the data to the request stream.
    //            dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
    //            // Close the Stream object.
    //            dataStreamfrm.Close();
    //        }
    //    }
    //    catch
    //    { }
    //}
    public void SponserSendSMSToUserIDMob(string TextMsg, string Mobile)
    {
        try
        {
            ToMobiUSD = Mobile.Trim();
            if (ToMobiUSD.Length == 10)
            {

                createdURLFrom = Objgdb.GetCredentialAPI(ToMobiUSD, TextMsg, "SMSAPI");
                //HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
                //myReqfrm.Method = "POST";
                //// myReq.ContentLength = Text.Length;
                //byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextMsg);
                //// Set the ContentType property of the WebRequest.
                //myReqfrm.ContentType = "application/x-www-form-urlencoded";
                //// Set the ContentLength property of the WebRequest.
                //myReqfrm.ContentLength = byteArrayfrm.Length;
                //// Get the request stream.
                //Stream dataStreamfrm = myReqfrm.GetRequestStream();
                //// Write the data to the request stream.
                //dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
                //// Close the Stream object.
                //dataStreamfrm.Close();

                HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(createdURLFrom);
                HttpWebResponse myResponse = (HttpWebResponse)myRequest.GetResponse();

                Stream respStream = myResponse.GetResponseStream();

                MemoryStream memStream = new MemoryStream();
                byte[] buffer = new byte[2048];
                int bytesRead = 0;
                do
                {
                    bytesRead = respStream.Read(buffer, 0, buffer.Length);
                    memStream.Write(buffer, 0, bytesRead);
                } while (bytesRead != 0);
                respStream.Close();
                buffer = memStream.ToArray();
                string html = System.Text.Encoding.ASCII.GetString(buffer);
            }
        }
        catch
        { }
    }


}
