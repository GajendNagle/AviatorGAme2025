using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for SearchReports
/// </summary>
public class SearchReports
{
    SqlCommand cmd;
    SqlConnection cn;
    SqlDataAdapter adp;
    string str;
    DB objdb = new DB();
    DataSet ds;
    public SearchReports()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataSet ShowInvoiceReports(string Uid, string txtPinNo, string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ShowInvoiceReports", cn);
            cmd.Parameters.Add("@Uid", SqlDbType.VarChar).Value = Uid;
            cmd.Parameters.Add("@txtPinNo", SqlDbType.VarChar).Value = txtPinNo;
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet PayoutDetailReports(string FromDate, string ToDate, string MemId, string Pair)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("PayoutDetailReports", cn);
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.Parameters.Add("@MemId", SqlDbType.VarChar).Value = MemId;
            cmd.Parameters.Add("@Pair", SqlDbType.VarChar).Value = Pair;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet PayoutSummaryReports(string MemID, string payoutID)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("PayoutSummaryReports", cn);
            cmd.Parameters.Add("@MemID", SqlDbType.VarChar).Value = MemID;
            cmd.Parameters.Add("@payoutID", SqlDbType.VarChar).Value = payoutID;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet UserPinDetails(string userId, string frdate, string todate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("UserPairDetails", cn);
            cmd.Parameters.Add("@frdate", SqlDbType.VarChar).Value = frdate;
            cmd.Parameters.Add("@todate", SqlDbType.VarChar).Value = todate;
            cmd.Parameters.Add("@userId", SqlDbType.VarChar).Value = userId;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet TDSForUser(string MemId, string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("TDSReports", cn);
            cmd.Parameters.Add("@MemId", SqlDbType.VarChar).Value = MemId;
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet PayOutAmtRequest(string status, string mode, string frdate, string todate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("getFundReq", cn);
            cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;
            cmd.Parameters.Add("@frdate", SqlDbType.VarChar).Value = frdate;
            cmd.Parameters.Add("@todate", SqlDbType.VarChar).Value = todate;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet ViewRequest(string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ViewRequest", cn);
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "0";
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet ViewFrenchEnquery(string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ViewRequest", cn);
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "1";
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet ReceivedMsg(string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ViewRequest", cn);
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "2";
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
    public DataSet CreateViewRequest(string ddlStatus, string ddlBank, string txtAmt, string FromDate, string ToDate)
    {
        try
        {
            str = objdb.getconnection();
            cn = new SqlConnection(str);
            cmd = new SqlCommand("ViewCreditRequestReports", cn);
            cmd.Parameters.Add("@ddlStatus", SqlDbType.VarChar).Value = ddlStatus;
            cmd.Parameters.Add("@ddlBank", SqlDbType.VarChar).Value = ddlBank;
            cmd.Parameters.Add("@txtAmt", SqlDbType.VarChar).Value = txtAmt;
            cmd.Parameters.Add("@FromDate", SqlDbType.VarChar).Value = FromDate;
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = ToDate;
            cmd.CommandType = CommandType.StoredProcedure;
            ds = new DataSet();
            adp = new SqlDataAdapter(cmd);
            adp.Fill(ds);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
        catch { }
        finally { ds.Dispose(); adp.Dispose(); cmd.Dispose(); cn.Close(); cn.Dispose(); }
        return ds;
    }
}
