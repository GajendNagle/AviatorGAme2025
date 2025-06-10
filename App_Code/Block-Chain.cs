using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.IO;
using System.Text;


/// <summary>
/// Summary description for Block_Chain
/// </summary>
public class Block_Chain
{
    public Block_Chain()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string getCurrencyRate()
    {
        System.Net.WebRequest wreq = System.Net.WebRequest.Create("https://blockchain.info/ticker");
        //System.Net.WebRequest wreq = System.Net.WebRequest.Create("https://blockchain.info/tobtc?currency=USD&value=500");
        HttpWebResponse myResp = (HttpWebResponse)wreq.GetResponse();
        System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        string responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        return responseString;
    }

    public string getNewBTCAddress(string AddIndx)
    {
        string CBUrl = "https%3A%2F%2Fisucces.win%2FBTC-API-457-CB.ashx%3Fsecret%3DSucces24%217H1p%26ODsID%3D" + DB.base64Encode(AddIndx);
        //string CBUrl = "https%3A%2F%2Fisucces.win%2FBTC-API-457-CB.ashx?ODsID=" + AddIndx + "&secret=Succes24!7H1p";
        string BtcApiNA = "https://api.blockchain.info/v2/receive?xpub=xpub6BpYhQWPfJF4aH9yLSRPmHjCM26UuyxEwxtq8JCPARQx2J18wTTEfK5FM2m2g3mxLgALBfJbKkVe9N7NtP3Z9rpxBqTQXxsCVN24q9CDeUD&key=f38981ae-1329-42cf-b02b-0ae9893ecfc8&gap_limit=100&callback=" + CBUrl + "";
        //string BtcApiNA = "https://api.blockchain.info/v2/receive?xpub=xpub6BpYhQWPfJF4aH9yLSRPmHjCM26UuyxEwxtq8JCPARQx2J18wTTEfK5FM2m2g3mxLgALBfJbKkVe9N7NtP3Z9rpxBqTQXxsCVN24q9CDeUD&callback=https%3A%2F%2Fisucces.win%2FBTC-API-457-CB.ashx&index=" + AddIndx + "&key=f38981ae-1329-42cf-b02b-0ae9893ecfc8";
        System.Net.WebRequest wreq = System.Net.WebRequest.Create(BtcApiNA);
        //System.Net.WebRequest wreq = System.Net.WebRequest.Create("https://blockchain.info/tobtc?currency=USD&value=500");
        HttpWebResponse myResp = (HttpWebResponse)wreq.GetResponse();
        System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        string responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        return responseString;
    }
    public string Tokenrate(string Posturl)
    {
        
        string BtcApiNA = "https://www.dextools.io/shared/data/pair?address=0x27da5867bc40002717f4c3dcceaf80c9d9f8fcbf&chain=bsc";
        System.Net.WebRequest wreq = System.Net.WebRequest.Create(BtcApiNA);
        HttpWebResponse myResp = (HttpWebResponse)wreq.GetResponse();
        System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
        string responseString = respStreamReader.ReadToEnd();
        respStreamReader.Close();
        myResp.Close();
        return responseString;
        
    }
}
