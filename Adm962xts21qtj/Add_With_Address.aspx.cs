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
using System.IO;
using System.Diagnostics;
public partial class Adm80bdr753nto_Add_With_Address : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    SqlCommand cmd;
    Random Rnd = new Random();
    string FileName = "", fileExt = "", WalletAdd2Encoded = "";
    DataTable dt; SqlDataAdapter sda;
    DB objdb = new DB();
    DataSet ds;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {
                    fillgrid();
                }
                if (HttpContext.Current.Session["roleid"] != null)
                {
                    string Roleid = Convert.ToString(HttpContext.Current.Session["roleid"]);
                    ds = objgdb.ByProcedure("dbo.GetUpdateMValue",
                        new string[] { "p_FormNameID", "p_RoleId" },
                        new string[] { "Withdraw Wallet Address", Roleid },
                        "ByDataset");
                    if (ds.Tables[0].Rows[0]["Updatedvalue"] != null || ds.Tables[0].Rows[0]["Updatedvalue"].ToString() != "")
                    {
                        string val = Convert.ToString(ds.Tables[0].Rows[0]["Updatedvalue"]);
                        if (val == "1")
                        {
                            GridView2.Columns[0].Visible = true;
                            GridView2.Columns[1].Visible = true;
                        }
                        else
                        {
                            GridView2.Columns[0].Visible = false;
                            GridView2.Columns[1].Visible = false;
                        }
                    }

                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; }
    }
    private void clears()
    {
        txtWalletAdd.Text = txtWalletAdd2.Text = txtDate.Text = "";
    }
    protected void btnpass_Click(object sender, EventArgs e)
    {
        string str = "";
        cn.Open();
        try
        {
            WalletAdd2Encoded = DB.base64Encode(txtWalletAdd2.Text.Trim());

            int TotalRows = 0;
            dt = new DataTable();
            ds = new DataSet();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("dbo.[ProWithAddUpdate]");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@WalletAdd", txtWalletAdd.Text.Trim());
            cmd.Parameters.AddWithValue("@WalletAdd2", WalletAdd2Encoded);
            cmd.Parameters.AddWithValue("@Status", DDlStatustype.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@Date", txtDate.Text);
            cmd.Connection = cn;
            sda.SelectCommand = cmd;

            sda.Fill(ds);
            TotalRows = ds.Tables[0].Rows.Count;
            lblMsg.Text = ds.Tables[0].Rows[0]["Msg"].ToString();

            clears();
            sda.Dispose();
            cmd.Dispose();
            ds.Dispose();
            fillgrid();
        }
        catch (Exception ex) { lblMsg.Visible = true; DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; }
        cn.Close();
    }
    //public string GetDecodedMiddleEllipsis(object value)
    //{
    //    if (value == null) return "";

    //    string decodedValue = DB.base64Decod(value.ToString());
    //    if (decodedValue.Length > 6)
    //    {
    //        int partLength = decodedValue.Length / 6;
    //        string firstPart = decodedValue.Substring(0, partLength);
    //        string lastPart = decodedValue.Substring(decodedValue.Length - partLength);
    //        return firstPart + "..................." + lastPart;
    //    }
    //    return decodedValue;
    //}
    public void fillgrid()
    {
        try
        {
            string oldbselect = "select ID,WalletAdds,WalletAdds2,WalletStatus,TxnDt from tblBonusWallet_Dtls Order by ID desc";
            SqlDataAdapter adp = new SqlDataAdapter(oldbselect, cn);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            GridView2.DataSource = ds;
            GridView2.DataBind();
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Oops, Somthing is wrong, Please try later !";
        }
    }
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
            string oldbdelete = "delete from tblBonusWallet_Dtls where id =" + id + "";
            SqlDataAdapter adp = new SqlDataAdapter(oldbdelete, cn);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            fillgrid();
            lblMsg.Text = "Wallet Address Removed....";
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; }
    }
    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        fillgrid();
    }
    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;
        fillgrid();
    }
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            cn.Open();
            int r;
            int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
            TextBox wa = (TextBox)GridView2.Rows[e.RowIndex].Cells[0].FindControl("WalletAdds");
            TextBox wa2 = (TextBox)GridView2.Rows[e.RowIndex].Cells[1].FindControl("WalletAdds2");
            string WalletAdds2Org = wa2.Text;
            string wa2encoded = DB.base64Encode(WalletAdds2Org);

            DropDownList ws = (DropDownList)GridView2.Rows[e.RowIndex].Cells[3].FindControl("WalletStatus");
            //TextBox td = (TextBox)GridView2.Rows[e.RowIndex].Cells[4].FindControl("TxnDt");
            //, TxnDt = convert(datetime, '" + td.Text.Trim() + "', 103)

            cmd = new SqlCommand("update tblBonusWallet_Dtls set WalletAdds='" + wa.Text.Trim() + "', WalletAdds2='" + wa2encoded.Trim() + "', WalletStatus='" + ws.Text.Trim() + "' where id='" + id + "'", cn);

            r = cmd.ExecuteNonQuery();
            if (r > 0)
            {
                lblMsg.Text = "Field Updated Successfully....";
            }
            else
            {
                lblMsg.Text = "Some Problem Arise....";
            }
            GridView2.EditIndex = -1;
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; }
        fillgrid();
        cn.Close();
    }
}