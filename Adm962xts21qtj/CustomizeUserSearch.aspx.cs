using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

public partial class Admin_CustomizeUserSearch : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    DataSet ds; string SqlFillStatus;
    DynamicDtls objgdb = new DynamicDtls();
    string SearchText;
    DB objd = new DB();
    public string mobile, mname, pwd, ewalletpwd;

    public int PageNo = 1;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!Page.IsPostBack)
            {
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(PageNo);
        this.populateList(TotalRows);
    }

    private int BindResult(int currentPage)
    {

        if (txtSearch.Text == "")
        {
            if (DDLFillItems.Items.Count != 0)
            {
                SearchText = DDLFillItems.SelectedItem.Text;
            }
            else
            {
                SearchText = "";
            }
        }
        else
        {
            SearchText = txtSearch.Text.Trim();
        }
        int TotalRows = 0;
        dt = new DataTable();
        sda = new SqlDataAdapter();
        cmd = new SqlCommand("dbo.CustomizeUserSearch");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@strSearchText", SearchText);
        cmd.Parameters.AddWithValue("@intPageSize", Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]));
        cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
        cmd.Parameters.AddWithValue("@SrchByDjGt", DDLSrchByDjGt.SelectedItem.Text);
        cmd.Parameters.AddWithValue("@FrmDt", txtFromDate.Text.Trim());
        cmd.Parameters.AddWithValue("@ToDt", txtToDate.Text.Trim());
        cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = DDLDownPos.SelectedItem.Value;
        cmd.Connection = cn;
        sda.SelectCommand = cmd;
        sda.Fill(dt);
        TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
        if (TotalRows == 0)
        {
            grdUserDtl.Visible = false;
            lblMsg.Text = objd.EmptyMessage("Sorry ... No Records found !!");
        }
        else
        {
            lblMsg.Text = "";
            grdUserDtl.Visible = true;
            grdUserDtl.PageIndex = currentPage - 1;
            grdUserDtl.DataSource = dt;
            grdUserDtl.DataBind();
        }
        return TotalRows;
        sda.Dispose();
        cmd.Dispose();
        dt.Dispose();

    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = Convert.ToString(TotalRows);
        PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize) + 1)));
        for (int i = 1; i <= PageNo; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        CountingShow();
    }
    public void CountingShow()
    {
        if (ddlJumpToPage.SelectedItem.Text == "1")
        {
            PageNo = 1;
            //Pagesize
        }
        else
        {
            PageNo = 1 + Pagesize * (int.Parse(ddlJumpToPage.SelectedItem.Text) - 1);
            Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text));
        }
    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
        CountingShow();
    }
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        HtmlForm form = new HtmlForm();
        string attachment = "attachment; filename=SearchUserList.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        StringWriter stw = new StringWriter();
        HtmlTextWriter htextw = new HtmlTextWriter(stw);
        form.Controls.Add(grdUserDtl);
        this.Controls.Add(form);
        form.RenderControl(htextw);
        Response.Write(stw.ToString());
        Response.End();
        form.Dispose();
        stw.Dispose();
        htextw.Dispose();
    }
    protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        if (DDLDownPos.SelectedItem.Text == "Status" || DDLDownPos.SelectedItem.Text == "Stockiest" || DDLDownPos.SelectedItem.Text == "ROI Blocked" || DDLDownPos.SelectedItem.Text == "City" || DDLDownPos.SelectedItem.Text == "State" || DDLDownPos.SelectedItem.Text == "Package")
        {
            DDLFillItems.Visible = true;
            txtSearch.Visible = false;
            if (DDLDownPos.SelectedItem.Text.Trim().ToUpper() == "STATUS")
            {
                SqlFillStatus = "select distinct status from memdetail";
            }
            else if (DDLDownPos.SelectedItem.Text.Trim().ToUpper() == "CITY")
            {
                SqlFillStatus = "select distinct city from memdetail";
            }
            else if (DDLDownPos.SelectedItem.Text.Trim().ToUpper() == "STATE")
            {
                SqlFillStatus = "select distinct state from memdetail";
            }

            else if (DDLDownPos.SelectedItem.Text.Trim() == "ROI Blocked")
            {
                SqlFillStatus = "select  'NO'  union select 'YES' ";
            }
            else if (DDLDownPos.SelectedItem.Text.Trim() == "Package")
            {
                SqlFillStatus = "select distinct package from memdetail";
            }
            else
            {
                SqlFillStatus = "select distinct package from memdetail";
            }
            ds = new DataSet();
            DDLFillItems.Items.Clear();

            foreach (DataRow dr in new DB().SelectRows(ds, SqlFillStatus).Tables[0].Rows)
            {
                DDLFillItems.Items.Add(dr[0].ToString());
            }

            ds.Dispose();
        }
        else
        {
            DDLFillItems.Visible = false;
            txtSearch.Visible = true;
        }
    }


    protected void grdUserDtl_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        Response.Cookies["Tap190Nvw92mst"].Value = DB.base64Encode(grdUserDtl.DataKeys[e.NewSelectedIndex].Value.ToString());
        Response.Cookies["Tap190Nvw92mst"].Expires = DateTime.Now.AddHours(2);

        Response.Write("<script>");
        Response.Write("window.open('../Jap762Btp28lyf/game-index.html','_blank')");
        Response.Write("</script>");
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        HtmlForm form = new HtmlForm();
        string attachment = "attachment; filename=Member-List.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        StringWriter stw = new StringWriter();
        HtmlTextWriter htextw = new HtmlTextWriter(stw);
        form.Controls.Add(grdUserDtl);
        this.Controls.Add(form);
        form.RenderControl(htextw);
        Response.Write(stw.ToString());
        Response.End();
        form.Dispose();
        stw.Dispose();
        htextw.Dispose();
    }

    protected void btnSendMsg_Click(object sender, EventArgs e)
    {
        //ArrayList id = new ArrayList();
        //try
        //{
        //    for (Int32 i = 0; i < grdUserDtl.Rows.Count; i++)
        //    {
        //        CheckBox ck = (CheckBox)grdUserDtl.Rows[i].FindControl("chkMemID");
        //        string data = grdUserDtl.DataKeys[i].Value.ToString();
        //        if (ck.Checked == true)
        //        {
        //            string ID = grdUserDtl.DataKeys[i].Value.ToString();
        //            id.Add(ID);
        //        }
        //    }
        //    foreach (string a in id)
        //    {
        //        ds = objgdb.ByProcedure("ProcGetMobiUSDForSMS", new string[] { "memid" }, new string[] { a.ToString() }, "GEtMobileNumber");
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            mobile = ds.Tables[0].Rows[0]["mobile"].ToString();
        //            mname = ds.Tables[0].Rows[0]["mname"].ToString();
        //            pwd = ds.Tables[0].Rows[0]["pwd"].ToString();
        //            ewalletpwd = ds.Tables[0].Rows[0]["ewalletpwd"].ToString();
        //        }
        //        if (mobile.Length == 10)
        //        {
        //            #region Send password by sms

        //            string Text = objgdb.GetCredentialAPI(mname.Trim(), a.Trim(), pwd.Trim(), ewalletpwd.Trim(), "RegistrationText");
        //            try
        //            {
        //                new SendSms().SendSMSToUserIDMob(Text, a.Trim());
        //            }
        //            catch { }
        //            lblMsg.Text = objgdb.UpdateMessage("SMS has sent to Selected Member.");
        //            #endregion
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        //}

        //finally
        //{
        //    ds.Dispose();
        //}
    }
  
}
