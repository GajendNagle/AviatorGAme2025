using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
public class DynamicContent
{

    DataSet ds;
    public static string _compName, _compEmail, _compWeb, _webSite, _topCompName, _email, _CompanyTopID
      , _registration, _currency_type, _busiLinkForJoin, _EMailPort, _EMailPWD, _SysCurncy, _ApiKeyBEP20,
    _ApiKeyTRC20, _webSite2, _CopyWYear,
        _withdraw, _pvtkey;
    DB objdb = new DB();
    public static string WebSite2
    {
        get { return _webSite2; }
        set { _webSite2 = value; }
    }
    public static string SysCurncy
    {
        get { return _SysCurncy; }
        set { _SysCurncy = value; }
    }
    public static string ApiKeyBEP20
    {
        get { return _ApiKeyBEP20; }
        set { _ApiKeyBEP20 = value; }
    }
    public static string ApiKeyTRC20
    {
        get { return _ApiKeyTRC20; }
        set { _ApiKeyTRC20 = value; }
    }
    public static string withdraw
    {
        get { return _withdraw; }
        set { _withdraw = value; }
    }
    public static string privetkey
    {
        get { return _pvtkey; }
        set { _pvtkey = value; }
    }
    public static string EMailPort
    {
        get { return _EMailPort; }
        set { _EMailPort = value; }
    }
    public static string EMailPWD
    {
        get { return _EMailPWD; }
        set { _EMailPWD = value; }
    }
    public static string BusiLinkForJoin
    {
        get { return _busiLinkForJoin; }
        set { _busiLinkForJoin = value; }
    }

    public static string Registration
    {
        get { return _registration; }
        set { _registration = value; }
    }
    public static string CompName
    {
        get { return _compName; }
        set { _compName = value; }
    }
    public static string CompEmail
    {
        get { return _compEmail; }
        set { _compEmail = value; }
    }
    public static string CompanyTopID
    {
        get { return _CompanyTopID; }
        set { _CompanyTopID = value; }
    }
    public static string CompWeb
    {
        get { return _compWeb; }
        set { _compWeb = value; }
    }
    public static string CopyWriteYear
    {
        get { return _CopyWYear; }
        set { _CopyWYear = value; }
    }
    public static string TopCompName
    {
        get { return _topCompName; }
        set { _topCompName = value; }
    }
    public static string WebSite
    {
        get { return _webSite; }
        set { _webSite = value; }
    }
    public static string Email
    {
        get { return _email; }
        set { _email = value; }
    }
    public static string currency_type
    {
        get { return _currency_type; }
        set { _currency_type = value; }
    }
    public void FillWebSiteEmailCompany()
    {
        try
        {
            ds = new DynamicDtls().ByCompProcedure("[Comp_ProFillDetails]", "BY DATASET");
            if (ds.Tables[0].Rows.Count > 0)
            {
                CompName = ds.Tables[0].Rows[0]["CompName"].ToString();
                CompEmail = ds.Tables[0].Rows[0]["CompEmail"].ToString();
                CompWeb = ds.Tables[0].Rows[0]["CompWeb"].ToString();
                WebSite = ds.Tables[0].Rows[0]["WebSite"].ToString();
                WebSite2 = ds.Tables[0].Rows[0]["WebSite2"].ToString();
                TopCompName = ds.Tables[0].Rows[0]["TopCompName"].ToString();
                Email = ds.Tables[0].Rows[0]["Email"].ToString();
                Registration = ds.Tables[0].Rows[0]["RegisEmail"].ToString();
                currency_type = ds.Tables[0].Rows[0]["currency_type"].ToString();
                BusiLinkForJoin = ds.Tables[0].Rows[0]["BusLinkForJoin"].ToString();
                EMailPort = ds.Tables[0].Rows[0]["EMailAddPort"].ToString();
                EMailPWD = ds.Tables[0].Rows[0]["EMailAddPWD"].ToString();
                SysCurncy = ds.Tables[0].Rows[0]["SysCurncy"].ToString();
                ApiKeyBEP20 = ds.Tables[0].Rows[0]["ApiKeyBEP20"].ToString();
                ApiKeyTRC20 = ds.Tables[0].Rows[0]["ApiKeyTRC20"].ToString();
                withdraw = ds.Tables[0].Rows[0]["withdrawAdds"].ToString();
                privetkey = ds.Tables[0].Rows[0]["PvtKey"].ToString();
                CopyWriteYear = ds.Tables[0].Rows[0]["Copyrightyear"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
    }
}

public abstract class AbstDynamicDtls : DynamicContent
{

    public abstract void WriteLog(string _msg);
    public abstract string ReplaceVal(string msg);
    public abstract string base64Encode(string sData);
    public abstract string base64Decod(string sData);
    public abstract void ByText(string Query);
    public abstract void ByText(string Query, SqlConnection Con, SqlTransaction Tran);
    public abstract DataSet ByDataSet(string Query);
    public abstract void ResizeImage(Image ImageId, int ResizeWidth, int ResizeHeight);
    public abstract DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string OutPutParamName, out int TotRecord, string ByDataSetAlert);
    public abstract string uploadFile(FileUpload FileUpload1, string FolderName, int FileSize);
    public abstract DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string ByDataSetAlert);
    public abstract DataTable ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string OutPutParamName, out int TotRecord, string ByDataTableAlert, string PassEmptyText);
    public abstract DataTable ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string ByDataTableAlert, string PassEmptyText);
    public abstract DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, SqlConnection Cnn, SqlTransaction Tran, string ByDataTableAlert);
    public abstract DataSet ByCompProcedure(string ProcedureName, string ByDataSetAlert);
    public abstract DataSet ByProcedure(string ProcedureName, string ByDataSetAlert);
    public abstract void ByProcedure(string ProcedureName, string[] SaveParameter, string[] SaveValues, Char BySaveAlert);
    public abstract void ByProcedure(string ProcedureName, string[] SaveParameter, string[] SaveValues, string byWithTranSaveAlert, SqlConnection Cnn, SqlTransaction Trans);
    public abstract void GetAPI(string CredentialType);
}

public class DynamicDtls : AbstDynamicDtls
{
    DB objdb = new DB();
    public int _NewWidth, _NewHeight;
    public string _ErrorMessage;
    public string _mobiUSD, _textMsg, _firstname, _bymemId, _verificationcode,
      _loginpwd, _transPwd, _amount, _description, _pinqty, _tomemID, _generateAPI, _FileName;

    public string FullFileName
    {
        set
        {
            _FileName = value;
        }
        get
        {
            return _FileName;
        }
    }
    public string TomemID
    {
        get { return string.IsNullOrEmpty(_tomemID) ? "" : _tomemID; }
        set { _tomemID = value; }
    }
    public string Pinqty
    {
        get { return string.IsNullOrEmpty(_pinqty) ? "" : _pinqty; }
        set { _pinqty = value; }
    }
    public string Descrp
    {
        get { return string.IsNullOrEmpty(_description) ? "" : _description; }
        set { _description = value; }
    }
    public string Amt
    {
        get { return string.IsNullOrEmpty(_amount) ? "" : _amount; }
        set { _amount = value; }
    }

    public string TransPwd
    {
        get { return string.IsNullOrEmpty(_transPwd) ? "" : _transPwd; }
        set { _transPwd = value; }
    }
    public string MobiUSD
    {
        get { return string.IsNullOrEmpty(_mobiUSD) ? "" : _mobiUSD; }
        set { _mobiUSD = value; }
    }
    public string TextMsg
    {
        get { return string.IsNullOrEmpty(_textMsg) ? "" : _textMsg; }
        set { _textMsg = value; }
    }

    public string Firstname
    {
        get { return string.IsNullOrEmpty(_firstname) ? "" : _firstname; }
        set { _firstname = value; }
    }
    public string BymemId
    {
        get { return string.IsNullOrEmpty(_bymemId) ? "" : _bymemId; }
        set { _bymemId = value; }
    }
    public string Verificationcode
    {
        get { return string.IsNullOrEmpty(_verificationcode) ? "" : _verificationcode; }
        set { _verificationcode = value; }
    }
    public string Loginpwd
    {
        get { return string.IsNullOrEmpty(_loginpwd) ? "" : _loginpwd; }
        set { _loginpwd = value; }
    }
    public string GenerateAPI
    {
        get { return string.IsNullOrEmpty(_generateAPI) ? "" : _generateAPI; }
        set { _generateAPI = value; }
    }
    public int NewWidth
    {
        get { return _NewWidth; }
        set { _NewWidth = value; }
    }
    public int NewHeight
    {
        get { return _NewHeight; }
        set { _NewHeight = value; }
    }
    public string ErrorMessage
    {
        get { return _ErrorMessage; }
        set { _ErrorMessage = value; }
    }
    public string Cn;
    public DataSet ds;
    public DataTable dt;
    public SqlCommand cmd;
    public string TopId()
    {
        return ByDataSet("select Top (1) memid,'' position from dbo.MemDetail with(NOLOCK) order by acmemid").Tables[0].Rows[0][0].ToString();
    }
    public string Position()
    {
        return ByDataSet("select Top (1) memid,'' position from dbo.MemDetail with(NOLOCK) order by acmemid").Tables[0].Rows[0][1].ToString();
    }
    public string getconnection
    {

        get
        {
            try
            {
                Cn = objdb.getconnection();
            }
            catch { ErrorMessage = "Yes"; throw new Exception("Please Provide Connection Object Name:Conn"); }

            return Cn;
        }
    }
    public override void WriteLog(string _msg)
    {
        string filepath;
        try
        {
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
        catch (Exception ex)
        {
            DB.WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
    }
    public override string ReplaceVal(string msg)
    {
        string Msg = "";
        try
        {
            Msg = msg;
            Msg.Replace(@"at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
   at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()", "").Replace("Error Msg :", "<b style='color:Red;'>Error Msg :</b>").Replace("Event Info :", "<b style='color:Red;'>Event Info :</b>");
        }
        catch (Exception ex)
        {
            DB.WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        return Msg;
    }
    public override string base64Encode(string sData)
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
    public override string uploadFile(FileUpload FileUpload1, string FolderName, int MaxFileSizeInKB)
    {
        string Msg = "", SaveSts = "";
        int NewFileSizeInKB = 0;
        try
        {

            //1 kb =1024 =100*1024=1 MB 
            NewFileSizeInKB = MaxFileSizeInKB * 1024;
            StringBuilder sb = new StringBuilder();
            string dirName = HttpContext.Current.Server.MapPath("~/" + FolderName);
            Random Rnd = new Random();
            //Create Directory if not exist.
            if (!Directory.Exists(dirName))
            {
                Directory.CreateDirectory(dirName);
            }
            else
            {
                HttpFileCollection uploadFilCol = HttpContext.Current.Request.Files;

                for (int i = 0; i < uploadFilCol.Count; i++)
                {
                    HttpPostedFile file = uploadFilCol[i];
                    string fileExt = Path.GetExtension(file.FileName).ToLower();
                    //get file extention like .jpg
                    string FilePath = HttpContext.Current.Server.MapPath("~/" + file.FileName);
                    //Uploaded File Location 
                    int ContentFileSize = file.ContentLength;
                    if (NewFileSizeInKB > ContentFileSize || MaxFileSizeInKB == 0)
                    {
                        //File Extention
                        if (fileExt == ".jpg" || fileExt == ".gif" || fileExt == ".bmp" || fileExt == ".jpeg" || fileExt == ".png" || fileExt == ".pdf")
                        {
                            FullFileName = System.DateTime.Now.ToString("ddMMyyyyhhttss") + "_" + Convert.ToString(Rnd.Next(0, 99999)) + fileExt;
                            file.SaveAs(dirName + "/" + FullFileName);
                            //File save in to Directory With New Name.
                            //FileInfo fileinfo = new FileInfo(dirName + "\\" + FileFullName);
                            //sb.Append(dirName + "\\" + FileFullName + " :: <span style='Color:Green'>File Size : </span>" + fileinfo.Length * 1024 + " <span style='Color:Green'> bytes </span>" + fileinfo.Length / 1024 + " <span style='Color:Green'>KB </span>" + fileinfo.Length / 1024000 + " <span style='Color:Red'>MB </span></br>");
                            SaveSts = "Ok";
                        }
                        else
                        {
                            SaveSts = "NotOk";
                            Msg = "File format not recognised." + " jpg/jpeg/gif/bmp/png/pdf formats";
                        }
                    }
                    else
                    {
                        SaveSts = "NotOk";
                        Msg = "<span style='Color:Red'> Maximum length of uploading profile image should be " + MaxFileSizeInKB + " KB.</span>";
                    }
                }
                if (SaveSts == "Ok" || SaveSts == "NotOk")
                {
                    if (SaveSts == "NotOk")
                    {

                    }
                    else
                    {
                        Msg = SaveSts;
                    }
                }
                else
                {
                    Msg = "Please upload files.";
                }
            }
        }
        catch (Exception ex) { throw ex; }
        return Msg;
    }
    public override string base64Decod(string sData)
    {
        string result = "";
        try
        {
            System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
            System.Text.Decoder utf8Decode = encoder.GetDecoder();
            byte[] todecode_byte = Convert.FromBase64String(sData);
            int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            result = new String(decoded_char);
        }
        catch (Exception ex)
        {
            DB.WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        return result;
    }
    public override void ByText(string Query)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                using (SqlDataAdapter adp = new SqlDataAdapter())
                {
                    adp.SelectCommand = new SqlCommand(Query, cn);
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                //cmd.Dispose();
                ds.Dispose();
            }
        }

    }
    public override void ByText(string Query, SqlConnection Con, SqlTransaction Tran)
    {
        try
        {
            cmd = new SqlCommand(Query, Con, Tran);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally { cmd.Dispose(); }
    }
    public override DataSet ByDataSet(string Query)
    {
        try
        {

            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                using (SqlDataAdapter adp = new SqlDataAdapter())
                {
                    adp.SelectCommand = new SqlCommand(Query, cn);
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }

        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                // cmd.Dispose();
                ds.Dispose();
            }
        }
        return ds;
    }
    public override void ResizeImage(Image ImageId, int ResizeWidth, int ResizeHeight)
    {
        int width = 0, height = 0, newWidth = 0, newHeight = 0, wHStatus = 0, MainWidth = 0, MainHeight = 0;
        try
        {
            System.Drawing.Image image101 = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath(ImageId.ImageUrl));
            width = image101.Width;
            height = image101.Height;

            if (width > height)
            { wHStatus = 1; }
            if (width < height)
            { wHStatus = 2; }
            if (width == height)
            { wHStatus = 3; }

            if (wHStatus == 1)
            {
                if (width > ResizeWidth)
                {
                    MainWidth = ResizeWidth;
                    double ratioX = (double)ResizeWidth / image101.Width;
                    double ratioY = (double)ResizeHeight / image101.Height;
                    double ratio1 = Math.Min(ratioX, ratioY);

                    newWidth = (int)(image101.Width * ratio1);
                    newHeight = (int)(image101.Height * ratio1);
                    MainHeight = newHeight;
                    //check = 1;
                }
                else
                {
                    MainWidth = width;

                    if (height > ResizeHeight)
                    {
                        double ratioX = (double)ResizeWidth / image101.Width;
                        double ratioY = (double)ResizeHeight / image101.Height;
                        double ratio1 = Math.Min(ratioX, ratioY);

                        newWidth = (int)(image101.Width * ratio1);
                        newHeight = (int)(image101.Height * ratio1);
                        MainHeight = newHeight;
                        MainWidth = newWidth;
                    }
                    else
                    {
                        MainHeight = height;
                    }
                }
            }
            if (wHStatus == 2)
            {
                if (height > ResizeHeight)
                {
                    double ratioX = (double)ResizeWidth / image101.Width;
                    double ratioY = (double)ResizeHeight / image101.Height;
                    double ratio1 = Math.Min(ratioX, ratioY);

                    newWidth = (int)(image101.Width * ratio1);
                    newHeight = (int)(image101.Height * ratio1);
                    MainHeight = newHeight;
                    MainWidth = newWidth;
                }
                else
                {
                    MainHeight = height;
                    if (width > ResizeWidth)
                    {
                        MainWidth = ResizeWidth;
                        double ratioX = (double)ResizeWidth / image101.Width;
                        double ratioY = (double)ResizeHeight / image101.Height;
                        double ratio1 = Math.Min(ratioX, ratioY);

                        newWidth = (int)(image101.Width * ratio1);
                        newHeight = (int)(image101.Height * ratio1);
                        MainHeight = newHeight;
                        //check = 1;
                    }
                    else
                    {
                        MainWidth = width;
                    }
                }
            }
            if (wHStatus == 3)
            {
                if (width > ResizeWidth)
                {
                    MainWidth = ResizeWidth;
                    double ratioX = (double)ResizeWidth / image101.Width;
                    double ratioY = (double)ResizeHeight / image101.Height;
                    double ratio1 = Math.Min(ratioX, ratioY);

                    newWidth = (int)(image101.Width * ratio1);
                    newHeight = (int)(image101.Height * ratio1);
                    MainHeight = newHeight;
                    //check = 1;
                }
                else
                {
                    MainWidth = width;

                    if (height > ResizeHeight)
                    {
                        double ratioX = (double)ResizeWidth / image101.Width;
                        double ratioY = (double)ResizeHeight / image101.Height;
                        double ratio1 = Math.Min(ratioX, ratioY);

                        newWidth = (int)(image101.Width * ratio1);
                        newHeight = (int)(image101.Height * ratio1);
                        MainHeight = newHeight;
                        MainWidth = newWidth;
                    }
                    else
                    {
                        MainHeight = height;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        NewWidth = MainWidth;
        NewHeight = MainHeight;

    }
    public override DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string OutPutParamName, out int TotRecord, string ByDataSetAlert)
    {
        try
        {

            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@" + OutPutParamName, SqlDbType.Int).Direction = ParameterDirection.Output;
                for (int i = 0; i < Parameter.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + Parameter[i].ToString(), Values[i].ToString());
                }
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }

        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //throw;
        }
        finally
        {

            if (ErrorMessage != "Yes")
            {
                ds.Dispose();
                cmd.Dispose();
            }
        }
        TotRecord = (int)cmd.Parameters["@" + OutPutParamName].Value;
        return ds;
    }
    public override DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string ByDataSetAlert)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < Parameter.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + Parameter[i].ToString(), Values[i].ToString());
                }
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //throw ex;

        }
        finally
        {
            if (ErrorMessage != "Yes")
            {

                ds.Dispose();
                cmd.Dispose();
            }
        }
        return ds;
    }
    public override DataTable ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string OutPutParamName, out int TotRecord, string ByDataTableAlert, string PassEmptyText)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@" + OutPutParamName, SqlDbType.Int).Direction = ParameterDirection.Output;
                for (int i = 0; i < Parameter.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + Parameter[i].ToString(), Values[i].ToString());
                }
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();
                    adp.Fill(dt);
                }
            }

        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //throw;
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                dt.Dispose();
                cmd.Dispose();
            }
        }
        TotRecord = (int)cmd.Parameters["@" + OutPutParamName].Value;
        return dt;
    }
    public override DataTable ByProcedure(string ProcedureName, string[] Parameter, string[] Values, string ByDataTableAlert, string PassEmptyText)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < Parameter.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + Parameter[i].ToString(), Values[i].ToString());
                }
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                dt.Dispose();
                cmd.Dispose();
            }
        }
        return dt;
    }

    public override DataSet ByProcedure(string ProcedureName, string[] Parameter, string[] Values, SqlConnection Cnn, SqlTransaction Tran, string ByDataTableAlert)
    {
        try
        {
            cmd = new SqlCommand(ProcedureName, Cnn, Tran);
            cmd.CommandType = CommandType.StoredProcedure;
            for (int i = 0; i < Parameter.Length; i++)
            {
                cmd.Parameters.AddWithValue("@" + Parameter[i].ToString(), Values[i].ToString());
            }
            using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
            {
                ds = new DataSet();
                adp.Fill(ds);
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                ds.Dispose();
                cmd.Dispose();
            }
        }
        return ds;
    }
    public override DataSet ByCompProcedure(string ProcedureName, string ByDataSetAlert)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                ds.Dispose();
                cmd.Dispose();
            }
        }
        return ds;
    }
    public override DataSet ByProcedure(string ProcedureName, string ByDataSetAlert)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                ds.Dispose();
                cmd.Dispose();
            }
        }
        return ds;
    }
    public override void ByProcedure(string ProcedureName, string[] SaveParameter, string[] SaveValues, Char BySaveAlert)
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(getconnection))
            {
                cmd = new SqlCommand(ProcedureName, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < SaveParameter.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + SaveParameter[i].ToString(), SaveValues[i].ToString());
                }
                using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                {
                    ds = new DataSet();
                    adp.Fill(ds);
                }
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ErrorMessage != "Yes")
            {
                cmd.Dispose();
                ds.Dispose();
            }
        }

    }
    public override void ByProcedure(string ProcedureName, string[] SaveParameter, string[] SaveValues, string byWithTranSaveAlert, SqlConnection Cnn, SqlTransaction Trans)
    {
        try
        {
            cmd = new SqlCommand(ProcedureName, Cnn, Trans);
            cmd.CommandType = CommandType.StoredProcedure;
            for (int i = 0; i < SaveParameter.Length; i++)
            {
                cmd.Parameters.AddWithValue("@" + SaveParameter[i].ToString(), SaveValues[i].ToString());
            }

            using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
            {
                ds = new DataSet();
                adp.Fill(ds);
            }
        }
        catch (Exception ex)
        {
            WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            cmd.Dispose();
            ds.Dispose();

        }
    }


    public string GetCredentialAPI(string MobiUSD, string textMsg, string SMSAPI)
    {
        MobiUSD = MobiUSD;
        TextMsg = textMsg;
        GetAPI("SMSAPI");
        return GenerateAPI;
    }
    public string GetApprovedAssign(string AssignNo, string Memid, string Status)
    {
        BymemId = Memid;
        Firstname = AssignNo.ToString();
        TextMsg = Status;
        GetAPI("ApprovedAssign");
        return GenerateAPI;
    }
    public string GetCanceledAssign(string AssignNo, string Memid, string Status)
    {
        BymemId = Memid;
        Firstname = AssignNo;
        TextMsg = Status.ToString();
        GetAPI("CanceledAssign");
        return GenerateAPI;
    }
    public string GetCredentialAPI(string FirstName, string MemId, string VerificationCode, string VerifyText)
    {
        Firstname = FirstName;
        BymemId = MemId;
        Verificationcode = VerificationCode;
        GetAPI("VerifyText");
        return GenerateAPI;
    }
    public string GetCredentialAPI(string FirstName, string MemId, string LoginPwd, string TransactionPwd, string RegistrationText)
    {
        Firstname = FirstName;
        BymemId = MemId;
        Loginpwd = LoginPwd;
        TransPwd = TransactionPwd;
        GetAPI("RegistrationText");
        return GenerateAPI;
    }
    public string GetCredentialAPI(string MemId, float Amount, string Description, string GiveHelpText)
    {
        BymemId = MemId;
        Amt = Amount.ToString();
        Descrp = Description;
        GetAPI(GiveHelpText);
        return GenerateAPI;
    }
    public string GetCredentialAPIMemberPayoutEarning(string Name, string MemId, int PayoutId, double Amount, string MemberPayoutEarning)
    {
        Firstname = Name;
        BymemId = MemId;
        Pinqty = PayoutId.ToString();
        Amt = Amount.ToString();
        GetAPI("MemberPayoutEarning");
        return GenerateAPI;
    }
    public string GetCredentialAPIForgetEWalletPwd(string MemId, string EwalletPwd, string ForgetEWalletPwd)
    {

        BymemId = MemId;
        TransPwd = EwalletPwd;
        GetAPI("ForgetEWalletPwd");
        return GenerateAPI;
    }
    public string GetCredentialAPIPinGenerate(string Name, string MemId, int PinQty, string PinGenerate)
    {
        Firstname = Name;
        BymemId = MemId;
        Pinqty = PinQty.ToString();
        GetAPI("PinGenerate");
        return GenerateAPI;
    }
    public string GetCredentialAPI(string ToMemID, float AssignAmt, string ByMemId, string ProvideHlpText, string PassEmptyStr)
    {
        TomemID = ToMemID;
        Amt = AssignAmt.ToString();
        BymemId = ByMemId;
        GetAPI("ProvideHlpText");
        return GenerateAPI;
    }
    public string GetCredentialAPI(string ByMemId, float AssignAmt, string ToMemId, string ToMobile, string ReceiveHlpText, string PassEmptyStr)
    {
        TomemID = ToMemId;
        Amt = AssignAmt.ToString();
        BymemId = ByMemId;
        MobiUSD = ToMobile;
        GetAPI("ReceiveHlpText");
        return GenerateAPI;
    }
    //public string GetCredentialAPI(string MemId, float Amount, string Description, string GiveHelpText)
    //{
    //    BymemId = MemId;
    //    Amt = Amount.ToString();
    //    Descrp = Description;
    //    GetAPI("DepositPayIT");
    //    return GenerateAPI;
    //}
    public override void GetAPI(string CredentialType)
    {
        try
        {
            ds = ByProcedure("ProcDynamicallyCredential", new string[] { "CredentialType","MobiUSD","TextMsg","FirstName","ByMemId","VerificationCode",
"LoginPwd","TransactionPwd","Amount","Description","ToMemID","PinQty"}, new string[] { CredentialType,MobiUSD,TextMsg,Firstname,BymemId,Verificationcode,
Loginpwd,TransPwd,Amt,Descrp,TomemID,Pinqty}, "ByDataset");

            if (ds.Tables[0].Rows.Count > 0)
            {
                GenerateAPI = ds.Tables[0].Rows[0]["GenerateAPI"].ToString();
            }
        }
        catch (Exception ex) { DB.WriteLog(" Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); }
    }


    public string OuterUpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td  align='center'> <div style='float:left;'><img src='UserPanel_Images/sucess.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string OuterErrorMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td  align='center' style='border:1px solid #000; padding:5px; width:100%;'> 
        <div style='float:left;'><img src='UserPanel_Images/button-cross.png' alt='' Width='20' Height='20'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px; color:red; font-size:13px; font-weight:bold;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string OuterCongratsMsg(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td  align='center' style='border:1px solid #000; padding:5px; width:100%;'> 
        <div style='float:left;'><img src='UserPanel_Images/button-check.png' alt='' Width='40' Height='40'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px; color:red; font-size:22px; font-weight:bold;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string OuterEmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td  align='center'> <div style='float:left;'><img src='UserPanel_Images/Empty_Message.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string UpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Images/sucess.png' alt='' style='vertical-align: middle;'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px; font-size:20px; font-weight:bold;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string ErrorMsg(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' width='100%'>        
        <tr> <td class='ErrorMsg'> <div style='float:left;'><img src='../UserPanel_Images/button-cross.png' alt='' Width='20' Height='20'/> </div>
        <div style='float:left;padding-left:5px;padding-top:1px; font-weight: bold; color:Red; font-size:15px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string EmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' width='100%'>        
        <tr> <td class='ErrorMsgForUID'> <div style='float:left;'><img src='../UserPanel_Images/Empty_Message.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminUpdateMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' >        
        <tr> <td class='AdminUpdateMessage'> <div style='float:left;padding-left:20px;'><img src='../User_Panel_Pictures/button-check.png' alt='' width='40' height='40' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminErrorMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Images/Error.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }
    public string AdminEmptyMessage(string message)
    {
        string text = "";
        text = @"<table cellpadding='0' cellspacing='0' class='ErrorMsgForUID'>        
        <tr> <td > <div style='float:left;'><img src='../UserPanel_Images/Empty_Message.png' alt='' /> </div>
        <div style='float:left;padding-left:5px;padding-top:1px;;'>" + message + "</div> </td>        </tr>        </table>";
        return text;
    }


}


