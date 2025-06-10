using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
/// <summary>
/// Summary description for DB
/// </summary>
public class DB
{
    SqlCommand cmd;
    SqlConnection cn;
    SqlDataAdapter adp;
    DataSet ds;

    string Result;

    public DB()
    {

        // TODO: Add constructor logic here
        //
    }
    public string getconnection()
    {
        string Cn = System.Configuration.ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        return Cn;
    }
    public static string GetTopUserId()
    {

        return new DB().ByDataSet("select MemID from memdetail where acmemid in(select min(acmemid) from memdetail)").Tables[0].Rows[0][0].ToString();
    }
    public DataSet SelectRows(DataSet dataset, string queryString)
    {
        using (SqlConnection connection = new SqlConnection(new DB().getconnection().ToString()))
        {
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            {
                adapter.SelectCommand = new SqlCommand(queryString, connection);
                adapter.Fill(dataset);
                return dataset;
            }
        }
    }
    public void ByText(string Query)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand(Query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { throw; }
        finally
        {
            cn.Close();
            cn.Dispose();
            cmd.Dispose();
        }
    }
    public DataSet ByProcedure(string ProcedureName, string Memid)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand(ProcedureName, cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Memid", SqlDbType.VarChar).Value = Memid;
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
        }
        catch { throw; }
        finally
        {
            adp.Dispose();
            ds.Dispose();
            cn.Dispose();
            cmd.Dispose();
        }
        return ds;
    }
    public DataSet CheckReCommitStatus(string Memid)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ProcRecommit", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MemID", SqlDbType.VarChar).Value = Memid;
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
        }
        catch { throw; }
        finally
        {
            adp.Dispose();
            ds.Dispose();
            cn.Dispose();
            cmd.Dispose();
        }
        return ds;
    }
    public DataSet ByProcedureTwoVle(string ProcedureName, string AssignNo)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand(ProcedureName, cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@AssignNo", SqlDbType.VarChar).Value = AssignNo;

            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
        }
        catch { throw; }
        finally
        {
            adp.Dispose();
            ds.Dispose();
            cn.Dispose();
            cmd.Dispose();
        }
        return ds;
    }
    public DataSet CheckCommitStatus(string Memid)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ProcCheckCommitStatus", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Memid", SqlDbType.VarChar).Value = Memid;
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
        }
        catch { throw; }
        finally
        {
            adp.Dispose();
            ds.Dispose();
            cn.Dispose();
            cmd.Dispose();
        }
        return ds;
    }
    public DataSet ByDataSet(string Query)
    {
        try
        {
            string str = getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand(Query, cn);
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);

        }
        catch { throw; }
        finally
        {

            cn.Dispose();
            cmd.Dispose();
            ds.Dispose();
        }
        return ds;
    }
    public string ChkMemDownlineStatus(string MemID, string DownID)
    {
        try
        {

            using (SqlConnection connection = new SqlConnection(new DB().getconnection().ToString()))
            {
                string str = getconnection();
                cn = new SqlConnection(str);
                cn.Open();
                cmd = new SqlCommand("Select COUNT(*) from downlinedetails where DownID='" + DownID + "' AND MemID='" + MemID + "'", cn);
                Result = cmd.ExecuteScalar().ToString();
            }

        }
        catch { }

        finally
        {
            cn.Close();
            cn.Dispose();
            cmd.Dispose();
        }
        return Result;
    }




    public string GetMemDesignation(string MemID)
    {
        try
        {

            using (SqlConnection connection = new SqlConnection(new DB().getconnection().ToString()))
            {
                string str = getconnection();
                cn = new SqlConnection(str);
                cn.Open();
                cmd = new SqlCommand("select Designation from Memdetail  where MemID='" + MemID.Trim() + "'", cn);
                Result = cmd.ExecuteScalar().ToString();
            }

        }
        catch { }

        finally
        {
            cn.Close();
            cn.Dispose();
            cmd.Dispose();
        }
        return Result;
    }



    public string OuterUpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='UserPanel_Icon/sucess.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string OuterErrorMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='UserPanel_Icon/Error.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string OuterEmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='UserPanel_Icon/Empty_Message.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }




    public string UpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/sucess.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string ErrorMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/Error.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string EmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/Empty_Message.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:15px;;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminUpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/sucess.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminErrorMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/Error.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminEmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Icon/Empty_Message.png' alt='' align='absmiddle'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }


    public static void WriteLog(string _msg)
    {
        string filepath;
        filepath = HttpContext.Current.Server.MapPath("~/Acc54_ErrLogFile.aspx");
        if (System.IO.File.Exists(filepath))
        {
            using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath("~/Acc54_ErrLogFile.aspx"), true))
            {
                //for writing time....

                writer.Write("<br>" + "[<b style='color:Red;'>Date:</b> " + DateTime.Now.ToLongDateString() + "] & [<b style='color:Red;'>Time:</b> " + DateTime.Now.ToLongTimeString() + "]");
                writer.WriteLine();
                //actual write cintent.....            

                writer.Write("<br>" + ReplaceVal(_msg));
                writer.WriteLine();
                //For Record Sepration....            

                writer.WriteLine("<br><hr>");
                writer.Close();
            }
        }
        else
        {
            System.IO.StreamWriter sw = System.IO.File.CreateText(filepath);
            //for writing time....            

            using (StreamWriter writer = new StreamWriter(HttpContext.Current.Server.MapPath("~/Acc54_ErrLogFile.aspx"), true))
            {

                //for writing time....

                writer.Write("[<b style='color:Red;'>Date:</b> " + DateTime.Now.ToLongDateString() + "] & [<b style='color:Red;'>Time:</b> " + DateTime.Now.ToLongTimeString() + "]");
                writer.WriteLine();

                //actual write cintent.....            

                writer.Write("<br>" + ReplaceVal(_msg));
                writer.WriteLine();
                //For Record Sepration....            

                writer.WriteLine("<br><hr>");
                writer.Close();
            }
        }
    }
    public static string ReplaceVal(string msg)
    {
        string Msg = "";
        Msg = msg;
        Msg.Replace(@"at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()", "").Replace("Error Msg :", "<b style='color:Red;'>Error Msg :</b>").Replace("Event Info :", "<b style='color:Red;'>Event Info :</b>");

        return Msg;
    }
    public static string base64Encode(string sData)
    {
        try
        {
            byte[] encData_byte = new byte[sData.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(sData);
            string encodedData = Convert.ToBase64String(encData_byte);
            return encodedData;
        }
        catch (Exception ex)
        {
            throw new Exception("Error in base64Encode" + ex.Message);
        }
    }
    public static string base64Decod(string sData)
    {
        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        System.Text.Decoder utf8Decode = encoder.GetDecoder();
        byte[] todecode_byte = Convert.FromBase64String(sData);
        int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
        char[] decoded_char = new char[charCount];
        utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
        string result = new String(decoded_char);
        return result;
    }



}
