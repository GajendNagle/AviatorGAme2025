<%@ WebHandler Language="C#" Class="get_Profile_Details" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;

public class get_Profile_Details : IHttpHandler {
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public static string msg, dtl, strJson, UserID, Role, Filter, SrchTxt, Psize = "20",
    FrmDt = "", ToDt = "", DownPos, SrchByDjGt;
    public static int Pno = 1, Dwn = 0;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {           
            /////////
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            /////////
            int TotalRows = this.BindResult(Pno);
            //this.populateList(TotalRows);
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
        /////////
        //handleRequest();
    }
    private int BindResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = objgdb.ByProcedure("GetUserProfile_NEW", new string[] { "MemID" } , new string[] { UserID }, "BY DATASET");
            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;

                string url = "";
                if (dt.Rows[0]["city"].ToString().Trim() != "")
                {
                    //**************** FOR GOOGLE MAP LATITUDE & LONGITUDE ************************************
                    //string url = "https://maps.google.com/maps/api/geocode/xml?key=AIzaSyDQTpXj82d8UpCi97wzo_nKXL7nYrd4G70&address=" + dt.Rows[0]["city"].ToString() + "&sensor=false";
                    url = "https://maps.google.com/maps/api/geocode/xml?address=" + dt.Rows[0]["city"].ToString() + "&sensor=false";
                }
                else
                {
                    url = "https://maps.google.com/maps/api/geocode/xml?address=Bhopal&sensor=false";
                }
                    //WebRequest request = WebRequest.Create(url);
                    //using (WebResponse response = (HttpWebResponse)request.GetResponse())
                    //{
                    //    using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                    //    {
                    //        DataSet dsResult = new DataSet();
                    //        dsResult.ReadXml(reader);
                    //        //DataTable dtCoordinates = new DataTable();
                    //        dt.Columns.AddRange(new DataColumn[2] { 
                    //    new DataColumn("Latitude",typeof(string)),
                    //    new DataColumn("Longitude",typeof(string)) });
                    //        foreach (DataRow row in dsResult.Tables["result"].Rows)
                    //        {
                    //            string geometry_id = dsResult.Tables["geometry"].Select("result_id = " + row["result_id"].ToString())[0]["geometry_id"].ToString();
                    //            DataRow location = dsResult.Tables["location"].Select("geometry_id = " + geometry_id)[0];
                    //            //dt.Rows.Add( location["lat"], location["lng"]);
                    //            dt.Rows[0]["Latitude"] = location["lat"].ToString();
                    //            dt.Rows[0]["Longitude"] = location["lng"].ToString();
                    //        }

                    //    }
                    //}
                
                //**************** FOR GOOGLE MAP LATITUDE & LONGITUDE ************************************
                
                
                
                
                
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.Response.End();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
    }
    public static string DataTable2Json(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            if (dt.Columns.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }
            jsonBuilder.Append("},");
        }
        if (dt.Rows.Count > 0)
        {
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        }

        return jsonBuilder.ToString();
    }
    public static string Dataset2Json(DataSet ds, int total)
    {
        StringBuilder json = new StringBuilder();

        foreach (DataTable dt in ds.Tables)
        {
            json.Append("[");
            json.Append(DataTable2Json(dt));
            json.Append("]");
        }
        return json.ToString();
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}