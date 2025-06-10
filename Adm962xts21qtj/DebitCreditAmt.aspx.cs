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
public partial class Admin_DebitCreditAmt : System.Web.UI.Page
{
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!Page.IsPostBack)
            {
                TotCrDtBal();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    private void TotCrDtBal()
    {
        try
        {

            ds = objgdb.ByProcedure("ProcGetAllWalletBal", new string[] { "MemId", "Wallet" }, new string[] { txtUserId.Text, ddlWallet.SelectedItem.Value }, "Bydataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblBal.Text = "Balance: <span style='color:red'>" + ds.Tables[0].Rows[0]["TotBalAmt"].ToString() + "</span>" ;
                lblTotalCredit.Text = "Total Credit: <span style='color:red'>" + ds.Tables[0].Rows[0]["TotCreditAmt"].ToString() + "</span> ";
                lblTotalDebit.Text = "Total Debit: <span style='color:red'>" + ds.Tables[0].Rows[0]["TotDebitAmt"].ToString() + "</span> ";
            }
            else
            {
                lblBal.Text = "Balance: <span style='color:red'>0</span> ";
                lblTotalCredit.Text = "Total Credit: <span style='color:red'>0</span> ";
                lblTotalDebit.Text = "Total Debit: <span style='color:red'>0</span> ";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = "Your request could not be completed.";
        }

    }
    protected void btnpass_Click(object sender, EventArgs e)
    {
        try
        {
            objgdb.ByProcedure("ProcCreditDebitAmt", new string[] { "MemId", "Wallet", "CrDrType", "Amt", "Remark" }, new string[] { txtUserId.Text, ddlWallet.SelectedItem.Value, ddlTranType.SelectedItem.Text, txtAmt.Text, txtRemark.Text }, "Bydataset");
            ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "<script type='text/javascript'>redirectPage('Amount has been Credited successfully.','" + ddlWallet.SelectedItem.Text + "'); </script>");
            TotCrDtBal();
            clears();
            lblmsg.Text = objgdb.UpdateMessage("Amount has been Credited successfully.");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = "Your request could not be completed.";
        }
        
    }



    private void clears()
    {
        txtAmt.Text = "";
        ddlTranType.SelectedIndex = 0;
        ddlWallet.SelectedIndex = 0;
    }


    protected void txtUserId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtUserId.Text.Trim() == "")
            {
                lblmsg.Text = "Please Enter Member ID First !!";
            }
            else
            {
                ds = new DB().ByDataSet("select mname from memdetail with(Nolock) where memid='" + txtUserId.Text.Trim() + "'");
                if (ds.Tables[0].Rows.Count>0)
                {
                    lblName.Text = ds.Tables[0].Rows[0]["mname"].ToString();
                    lblName.ForeColor = System.Drawing.Color.Green;
                    TotCrDtBal();
                }
                else
                {
                    txtUserId.Text = "";
                    lblName.Text = "Please Enter Correct Member ID.";
                    lblName.ForeColor = System.Drawing.Color.Red;
                }
            }

            // ClientScript.RegisterStartupScript(this.GetType(), "Vis", "<script type='text/javascript'>RViShow();</script>");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = "Your request could not be completed.";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
       
    }
    protected void ddlWallet_SelectedIndexChanged(object sender, EventArgs e)
    {
        TotCrDtBal();
    }
}
