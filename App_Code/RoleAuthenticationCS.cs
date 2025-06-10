using System;
using System.Data;
using System.Web;

/// <summary>
/// Summary description for RoleAuthenticationCS
/// </summary>
public class RoleAuthenticationCS
{
    DataSet ds;
    DynamicDtls Objgdb = new DynamicDtls();
    public string _roleExist, _memIdOfSubAdm;
    public bool _saveM, _updateM, _deleteM, _excelM, _printM, _reportM;


    public string MemIdOfSubAdm
    {
        set { _memIdOfSubAdm = value; }
        get { return _memIdOfSubAdm; }
    }
    public bool Save
    {
        set { _saveM = value; }
        get { return _saveM; }
    }
    public bool Update
    {
        set { _updateM = value; }
        get { return _updateM; }
    }
    public bool Delete
    {
        set { _deleteM = value; }
        get { return _deleteM; }
    }
    public bool Excel
    {
        set { _excelM = value; }
        get { return _excelM; }
    }
    public bool Print
    {
        set { _printM = value; }
        get { return _printM; }
    }
    public bool Report
    {
        set { _reportM = value; }
        get { return _reportM; }
    }

    public string RoleExist
    {
        set { _roleExist = value; }
        get { return _roleExist; }
    }
    public string ErrorMessageForRole()
    {
        return "You Can Not Modify Data.";
    }
    public void PageRedirect()
    {
        HttpContext.Current.Response.Cookies["Get563lnr43lbt"].Expires = DateTime.Now.AddDays(-1);
        HttpContext.Current.Session["AID"] = null;
        HttpContext.Current.Response.Cookies["CancelSts"].Value = "No";
        HttpContext.Current.Response.Cookies["CancelSts"].Expires = DateTime.Now.AddDays(-1);
        HttpContext.Current.Response.Cookies["ClientArea"].Expires = DateTime.Now.AddDays(-1);
        HttpContext.Current.Response.Cookies["ewallet"].Expires = DateTime.Now.AddDays(-1);
        HttpContext.Current.Response.Redirect("../Log-in.html");
    }
    public RoleAuthenticationCS()
    {

    }
    public DataSet CheckRole(string MemId)
    {
        ds = Objgdb.ByProcedure("ProcCheckRoleAuthe", new string[] { "Memid", "PageName", "type" }, new string[] { MemId, "", "0" }, "Bydataset");

        return ds;
    }
    public void CheckFormRoleAuthe(string MemId, string PageName)
    {
        ds = Objgdb.ByProcedure("ProcCheckRoleAuthe", new string[] { "Memid", "PageName", "type" }, new string[] { MemId, PageName, "1" }, "Bydataset");
        if (ds.Tables[0].Rows[0]["RoleAlert"].ToString() == "Admin Access")
        {
            RoleExist = ds.Tables[0].Rows[0]["RoleAlert"].ToString();
        }
        else if (ds.Tables[0].Rows[0]["RoleAlert"].ToString() == "Role Exist")
        {
            RoleExist = ds.Tables[0].Rows[0]["RoleAlert"].ToString();
            Save = bool.Parse(ds.Tables[1].Rows[0]["SaveM"].ToString());
            Update = bool.Parse(ds.Tables[1].Rows[0]["UpdateM"].ToString());
            Delete = bool.Parse(ds.Tables[1].Rows[0]["DeleteM"].ToString());
            Excel = bool.Parse(ds.Tables[1].Rows[0]["ExcelM"].ToString());
            Print = bool.Parse(ds.Tables[1].Rows[0]["PrintM"].ToString());
            Report = bool.Parse(ds.Tables[1].Rows[0]["ReportM"].ToString());
            MemIdOfSubAdm = ds.Tables[1].Rows[0]["AllowMemid"].ToString();
        }
        else
        {
            RoleExist = ds.Tables[0].Rows[0]["RoleAlert"].ToString();
        }
    }
}
