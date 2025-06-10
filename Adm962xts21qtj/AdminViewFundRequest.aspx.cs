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
using System.Text;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Net;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using Nethereum.Hex.HexTypes;
using Nethereum.Util;
using System.Numerics;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;

public partial class ControlSection_AdminViewFundRequest : System.Web.UI.Page
{
    SqlConnection cn;
    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    DataSet ds;
    string SearchText;
    float TotalAmt = 0;
    public string FrmDt, ToDt, strSearchText, strPagesize, currentPage, cPage, ColumnName = "", WthType = "",Mem_email = "", MName = "", amount = "", ReqCurrcy = "", AutoWithNo = "", eMailAddss = "";
    public int PageNo;
    public int Pagesize = 10000;
    DynamicDtls objgdb = new DynamicDtls();

    libCoinPaymentsNET.CoinPayments cp = new libCoinPaymentsNET.CoinPayments("4c2fA1bA8671f92056D0F2497068759c43b727DD5b7C47824f8511A8770586b2", "f9019f2eb2c45b3a3e7d47698b06f12a84a8f1f5157d25d151140e717eff5241"); //private key,public key
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                detsdv.Visible = true;
                if (Request.QueryString["MemId"] != null)
                {
                    DDLDownPos.SelectedValue = "pai.MemID";
                    //DDLSrchByDjGt_SelectedIndexChanged(sender, e);
                    txtSearch.Text = Request.QueryString["MemId"].ToString();
                }
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
                idChangeSts.Visible = false;
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    private int BindResult(int currentPage)
    {



        int TotalRows = 0;
        try
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



            FrmDt = txtFromDate.Text.Trim();
            ToDt = txtToDate.Text.Trim();
            strSearchText = SearchText.Replace("PENDING", "PDG");
            strPagesize = Pagesize.ToString();
            ColumnName = DDLDownPos.SelectedItem.Value;
            //WthType = ddWtp.SelectedItem.Text;
            WthType = "ALL";
            cPage = Convert.ToString(currentPage);
            cn = new SqlConnection(new DB().getconnection());
            dt = new DataTable();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("dbo.Pro_AdminBankPayoutDetails");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@strSearchText", SearchText);
            cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
            cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
            cmd.Parameters.AddWithValue("@SrchByDjGt", SqlDbType.VarChar).Value = DDLTransMode.SelectedItem.Text;
            //cmd.Parameters.AddWithValue("@SrchByDjGt", SqlDbType.VarChar).Value = "ALL";
            cmd.Parameters.AddWithValue("@FrmDt", txtFromDate.Text.Trim());
            cmd.Parameters.AddWithValue("@ToDt", txtToDate.Text.Trim());
            cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = DDLDownPos.SelectedItem.Value;
            cmd.Parameters.AddWithValue("@status", "");
            cmd.Parameters.AddWithValue("@MemId", "");
            cmd.Parameters.AddWithValue("@id", "1");
            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
            if (TotalRows != 0)
            {

                grdUserDtl.Visible = true;
                lblgvrecord.Visible = false;
                grdUserDtl.PageIndex = currentPage - 1;

                grdUserDtl.DataSource = dt;
                grdUserDtl.DataBind();
                lblgvrecord.Text = "";
                idChangeSts.Visible = true;
            }
            else
            {

                lblgvrecord.Visible = true;
                lblgvrecord.Text = new DB().EmptyMessage(dt.Rows[0]["MSG"].ToString());
                grdUserDtl.Visible = false;
                idChangeSts.Visible = false;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
        finally
        {

            if (cn != null && cn.State == ConnectionState.Open)
            {
                cn.Close();
                cn.Dispose();
            }
            if (sda != null) { sda.Dispose(); }
            if (cmd != null) { cmd.Dispose(); }
        }
        return TotalRows;
    }
    protected void chkHeader_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkbox = (CheckBox)grdUserDtl.HeaderRow.FindControl("chkHeader");

        foreach (GridViewRow dr in grdUserDtl.Rows)
        {
            CheckBox chkselect = (CheckBox)dr.FindControl("chkSelect");
            if (chkbox.Checked == true)
            {
                chkselect.Checked = true; idChangeSts.Visible = true;
            }
            else
            {
                chkselect.Checked = false; idChangeSts.Visible = false;

            }
        }
    }

    protected void btnPayByCapi_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow dr in grdUserDtl.Rows)
            {
                CheckBox chek = (CheckBox)dr.FindControl("chkselect");
                Label lblmemberID = (Label)dr.FindControl("lblmemberID");
                Label lblID = (Label)dr.FindControl("lblID");
                Label lblAmt = (Label)dr.FindControl("lblAmount");
                Label lblAutowithNo = (Label)dr.FindControl("lblAutowithNo");
                if (chek.Checked == true)
                {
                    cn = new SqlConnection(new DB().getconnection());
                    dt = new DataTable();
                    sda = new SqlDataAdapter();
                    cmd = new SqlCommand("dbo.ProcWithFromUser_FmUP_CAPI");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", lblID.Text.Trim());
                    cmd.Parameters.AddWithValue("@MemId", lblmemberID.Text.Trim());
                    cmd.Parameters.AddWithValue("@AutowithNo", lblAutowithNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@type", "0");
                    cmd.Connection = cn;
                    sda.SelectCommand = cmd;
                    ds = new DataSet();
                    sda.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Mem_email = ds.Tables[0].Rows[0]["Mem_email"].ToString();
                        MName = ds.Tables[0].Rows[0]["MName"].ToString();
                        try
                        {
                            amount = ds.Tables[0].Rows[0]["Amt"].ToString();
                            ReqCurrcy = ds.Tables[0].Rows[0]["Pm"].ToString();
                            AutoWithNo = lblAutowithNo.Text.Trim();
                            eMailAddss = ds.Tables[0].Rows[0]["PaymentAddress"].ToString();
                            var senderAddress = DynamicDtls.withdraw;
                            var privkey = DynamicDtls.privetkey;
                            var senderPrivateKey = DB.base64Decod(privkey);
                            TransactionComplete(lblAutowithNo.Text.Trim(), amount, senderAddress, senderPrivateKey, eMailAddss, ReqCurrcy);
                        }
                        catch (Exception ex)
                        {
                            DB.WriteLog(this.ToString() + "\n" + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                        }
                        chek.Checked = false;
                        chek.Enabled = false;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Your request could not be completed.";
        }
        finally
        {
            sda.Dispose();
            cmd.Dispose();
            dt.Dispose();
            cn.Close();
            cn.Dispose();
        }
    }
    private void TransactionComplete(string requestID, string amountStr, string fromAddress, string fromPrivateKey, string toAddress, string ReqCurrcy)
    {
        try
        {
            string contractAddress_Token = "0xf58b1e9e4fcab71c9a2edd2b7641253e6aa22283";
            string contractAddress_USDT = "0x55d398326f99059fF775485246999027B3197955";
            string contractAddress = (ReqCurrcy == "Token") ? contractAddress_Token : contractAddress_USDT;

            decimal amountDecimal = Convert.ToDecimal(amountStr);
            string rpcUrl = "https://bsc-dataseed.binance.org/";

            decimal minBNBRequired = 0.002m;
            decimal minTokenRequired = Convert.ToDecimal(amountStr);
            BigInteger maxGasLimit = 300000;
            var account = new Account(fromPrivateKey);
            var web3 = new Web3(account, rpcUrl);
            var bnbBalance = Web3.Convert.FromWei(web3.Eth.GetBalance.SendRequestAsync(account.Address).Result);
            if (bnbBalance < minBNBRequired)
            {
                DB.WriteLog("Insufficient Token Balance: " + bnbBalance + " tokens (need at least " + minBNBRequired + ")");
                return;
            }
            var contractHandler = web3.Eth.GetContractHandler(contractAddress);
            var tokenBalance = contractHandler.QueryAsync<BalanceOfFunction, BigInteger>(new BalanceOfFunction { Owner = account.Address }).Result;
            var tokenBalanceDecimal = Web3.Convert.FromWei(tokenBalance);

            if (tokenBalanceDecimal < minTokenRequired)
            {
                DB.WriteLog("Insufficient Token Balance: " + tokenBalanceDecimal + " tokens (need at least " + minTokenRequired + ")");
                return;
            }
            var gasPriceWei = web3.Eth.GasPrice.SendRequestAsync().Result;
            BigInteger tokenAmount = Web3.Convert.ToWei(amountDecimal);
            var transfer = new TransferFunction
            {
                FromAddress = account.Address,
                To = toAddress,
                TokenAmount = tokenAmount,
                Gas = new HexBigInteger(maxGasLimit),
                GasPrice = new HexBigInteger(gasPriceWei)
            };

            var handler = web3.Eth.GetContractTransactionHandler<TransferFunction>();
            string txnHash = handler.SendRequestAsync(contractAddress, transfer).Result;

            DB.WriteLog(this.ToString() + " Error Msg :" + txnHash + "\n" + "Event Info :" + txnHash);
            BindResultUpdt(requestID, txnHash, "PENDING", "");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + "Transfer Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);

        }
    }

    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string currency2Amt)
    {
        try
        {
            foreach (GridViewRow dr in grdUserDtl.Rows)
            {
                CheckBox chek = (CheckBox)dr.FindControl("chkselect");
                Label lblmemberID = (Label)dr.FindControl("lblmemberID");

                ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
                new string[] { AutoWithNo.ToString(), lblmemberID.Text.Trim(), "", "", Status.ToString(), TxnID.ToString(), "COMPLETE_AGAIN", currency2Amt.ToString(), "" }, "");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //lblMsg.Text = ds.Tables[0].Rows[0]["MSG"].ToString();
                    lblMsg.Text = objgdb.UpdateMessage("Withdraw done Successfully...!");
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
            }
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = Convert.ToString(TotalRows);
        PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
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
            PageNo = 1 + int.Parse(ddlJumpToPage.SelectedItem.Text);
            Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text));
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(PageNo);
        CountingShow();
    }
    protected void ddWtp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
    }
    protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        if (DDLDownPos.SelectedValue == "pai.Status")
        {
            DDLFillItems.Items.Clear();
            DDLFillItems.Items.Insert(0, "PENDING");
            DDLFillItems.Items.Insert(1, "COMPLETED");
            DDLFillItems.Items.Insert(2, "REJECTED");
            DDLFillItems.Visible = true;
            txtSearch.Visible = false;
        }
        else if (DDLDownPos.SelectedValue == "pai.AccType")
        {
            DDLFillItems.Items.Clear();
            DDLFillItems.Items.Insert(0, "By Blockchain");
            DDLFillItems.Items.Insert(1, "Bank Wire");
            DDLFillItems.Visible = true;
            txtSearch.Visible = false;
        }
        //else if (DDLDownPos.SelectedValue == "pai.TransMode")
        //{
        //    DDLFillItems.Items.Clear();
        //    DDLFillItems.Items.Insert(0, "ROI Auto Withdrawal");
        //    DDLFillItems.Items.Insert(1, "Bonus Auto Withdrawal");
        //    DDLFillItems.Visible = true;
        //    txtSearch.Visible = false;
        //}
        else
        {
            txtSearch.TextMode = TextBoxMode.SingleLine;
            DDLFillItems.Visible = false;
            txtSearch.Visible = true;
        }
    }
    protected void grdUserDtl_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblAmt = (Label)e.Row.FindControl("lblAmt");
                try
                {
                    TotalAmt = TotalAmt + float.Parse(lblAmt.Text);
                }
                catch (Exception ex)
                {
                    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
                }
            }

            if (e.Row.Cells.Count > 2)
            {
                //e.Row.Cells[2].Visible = false;
                // e.Row.Cells[6].Visible = false;
            }


            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotalAmt = (Label)e.Row.FindControl("lblTotAmt");
                lblTotalAmt.Text = TotalAmt.ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
    }

    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        if (grdUserDtl.Visible == true)
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Withdrawal-Request.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grdUserDtl.AllowPaging = false;

            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);

            //Change the Header Row back to white color
            grdUserDtl.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < grdUserDtl.HeaderRow.Cells.Count; i++)
            {
                grdUserDtl.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
            }
            grdUserDtl.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }
        else { }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnchangestatus_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow dr in grdUserDtl.Rows)
            {
                CheckBox chek = (CheckBox)dr.FindControl("chkselect");
                Label lblmemberID = (Label)dr.FindControl("lblmemberID");
                Label lblID = (Label)dr.FindControl("lblID");

                if (chek.Checked == true)
                {
                    cn = new SqlConnection(new DB().getconnection());
                    dt = new DataTable();
                    sda = new SqlDataAdapter();
                    cmd = new SqlCommand("dbo.Pro_AdminBankPayoutDetails");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@strSearchText", "");
                    cmd.Parameters.AddWithValue("@intPageSize", "");
                    cmd.Parameters.AddWithValue("@intCurrentPage", "");
                    cmd.Parameters.AddWithValue("@SrchByDjGt", "All");
                    cmd.Parameters.AddWithValue("@FrmDt", "");
                    cmd.Parameters.AddWithValue("@ToDt", "");
                    cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.AddWithValue("@status", ddlchangeStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@MemId", lblmemberID.Text.Trim());
                    cmd.Parameters.AddWithValue("@id", lblID.Text.Trim());
                    cmd.Connection = cn;
                    sda.SelectCommand = cmd;
                    ds = new DataSet();
                    sda.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ddlJumpToPage.Items.Clear();
                        int TotalRows = this.BindResult(1);
                        this.populateList(TotalRows);

                    }

                }

            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Your request could not be completed.";
        }
        finally
        {
            sda.Dispose();
            cmd.Dispose();
            dt.Dispose();
            cn.Close();
            cn.Dispose();
        }

    }

    protected void DDLFillItems_SelectedIndexChanged1(object sender, EventArgs e)
    {

        //DDLFillItems.Items.Clear();
        if (DDLFillItems.SelectedItem.Text == "PENDING")
        {
            ddlchangeStatus.Visible = true;
            btnchangestatus.Visible = true;

        }
        else if (DDLFillItems.SelectedItem.Text == "COMPLETED")
        {
            ddlchangeStatus.Visible = false;
            btnchangestatus.Visible = false;
        }

        else if (DDLFillItems.SelectedItem.Text == "REJECTED")
        {
            ddlchangeStatus.Visible = false;
            btnchangestatus.Visible = false;
        }
    }
    protected void btnWithInc_Click(object sender, EventArgs e)
    {
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("EWalleAutoWithDrawal", new string[] { "WthDt" }, new string[] { txtWithInc.Text.Trim() }, "GetDetail");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = new DB().ErrorMessage("Your request could not be completed.");
        }
        finally
        {
            ds.Dispose();

            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
    }
    //protected void lnkBntCalInc_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        ds = new DataSet();
    //        ds = objgdb.ByProcedure("GenerateAllDlyInc", new string[] { }, new string[] { }, "GetDetail");
    //    }
    //    catch (Exception ex)
    //    {
    //        DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
    //        lblMsg.Text = new DB().ErrorMessage("Your request could not be completed.");
    //    }
    //    finally
    //    {
    //        ds.Dispose();
    //    }

    //}
    protected void btnCoinPayment_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow dr in grdUserDtl.Rows)
            {
                CheckBox chek = (CheckBox)dr.FindControl("chkselect");
                Label lblmemberID = (Label)dr.FindControl("lblmemberID");
                Label lblID = (Label)dr.FindControl("lblID");
                Label lblAmount = (Label)dr.FindControl("lblAmt");
                Label lblaccType = (Label)dr.FindControl("lblaccType");
                Label lblAutoWithNo = (Label)dr.FindControl("lblAutoWithno");
                Label lblAccNo = (Label)dr.FindControl("lblAccno");

                if (chek.Checked == true)
                {
                    ds = new DataSet();
                    ds = objgdb.ByProcedure("Check_Withdrawal", new string[] { "AutoWithNo" }, new string[] { lblAutoWithNo.Text }, "GetDetail");
                    var check = ds.Tables[0].Rows[0]["Rtrn"].ToString();
                    if (check == "OK")
                    {
                        lblTrsMsg.Text = "Current Transaction : Request ID - " + lblID.Text + ", Member ID - " + lblmemberID.Text + ", Transaction Address - " + lblAccNo.Text;
                        CompleteOnlinePayment(lblmemberID.Text, lblAmount.Text, lblaccType.Text, lblAutoWithNo.Text, lblAccNo.Text);
                    }
                }
            }

            lblTrsMsg.Text = "";
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Your request could not be completed.";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            Response.Redirect("AdminViewFundRequest.aspx?mid=User Account&sid=Withdrawal Request's");
        }
    }
    protected void CompleteOnlinePayment(string Memid, string amount, string ReqCurrcy, string AutoWithNo, string eMailAddss)
    {
        try
        {
            //JavaScriptSerializer serializer = new JavaScriptSerializer();
            // dynamic item = serializer.Deserialize<object>(new Block_Chain().ImpsTransaction("173431885160892", mobno, beneficiaryid, amount, orderid,"", ""));
            // dynamic item = serializer.Deserialize<object>(new Block_Chain().ImpsTransaction("173431885160892", mobno, beneficiaryid, CntIFSC, amount, orderid, "BONUS", "", ""));
            SortedList<string, string> parms = new SortedList<string, string>();
            ///

            //string amount = txtAmount.Text;   //ds.Tables[0].Rows[0]["Amt"].ToString();  //context.Request["txtReqAmt"].Trim(); //"1"
            //string ReqCurrcy = ds.Tables[0].Rows[0]["Pm"].ToString(); //"TRX";// context.Request["paymode"].Trim();
            //string AutoWithNo = ds.Tables[0].Rows[0]["AutoWithNo"].ToString();

            //string eMailAddss = ds.Tables[0].Rows[0]["PaymentAddress"].ToString(); //TRXadd;// "TGZdrDUQDF6adwG76iWkEzb6pp9f3ytyLM";// context.Request["eMailAddss"].Trim();
            ///
            parms.Add("amount", amount);
            parms.Add("currency", ReqCurrcy);
            parms.Add("currency2", "$");
            parms.Add("address", eMailAddss);
            parms.Add("ipn_url", "https://presale.USDswap/Jap762Btp28lyf/Handlers/CoinPayments-IPN-WithR.ashx");
            parms.Add("note", Memid);
            parms.Add("auto_confirm", "1");
            //
            dynamic objValue;
            var ret = cp.CallAPI("create_withdrawal", parms);
            Dictionary<string, object> dict = new Dictionary<string, object>();

            ret.TryGetValue("result", out objValue);
            dict = objValue;
            //error = dict["error"].ToString();
            //result = dict["result"].ToString();

            BindResultUpdt(AutoWithNo, dict["id"].ToString(), dict["status"].ToString(), dict["amount"].ToString(), Memid);
            //if (getStatus != "")
            //{
            //    BindResultUpdt();
            //}
        }
        catch (Exception ex)
        {
            //DB.WriteLog(this.ToString() + "\n" + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //context.Response.Write(ex.Message);
            //sc = false;
            //msg = "<div class='alert alert-danger alert-bordered fade in' style='margin:5px;'>" + ds.Tables[0].Rows[0]["Msg"].ToString() + "<span class='close' data-dismiss='alert'>&times;</span></div>";
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Sorry, Something is wrong please try later !";
            //RejectRequest(AutoWithNo);
        }
    }
    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string currency2Amt, string MemID)
    {
        try
        {
            //  ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype", "Mobile", "Benfcid" },
            //    new string[] { wid.ToString(), UserID.ToString(), gettime.ToString(), "IMPS", getStatus.ToString(), gettxid.ToString(), "COMPLETE_AGAIN", getdesc.ToString(), "", getmobiUSD.ToString(), getbeneficiaryid.ToString() }, "");

            ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
               new string[] { AutoWithNo.ToString(), MemID, "", "", Status.ToString(), TxnID.ToString(), "COMPLETE_AGAIN", currency2Amt.ToString(), "" }, "");


            if (ds.Tables[0].Rows.Count > 0)
            {
                string msg = ds.Tables[0].Rows[0]["MSG"].ToString();
                // context.Response.Write("## Payout Sent Details ## PayoutID:" + PayoutIDs + ", Account-No: " + account_number + ", Status: " + PGStatus + ", Msg: " + PGMessage + ", Amount: " + amount);
                //Console.WriteLine(string.Concat("Hi ", data.FirstName, " " + data.LastName)); 
                ///{"status":2,"status_id":2,"utr":"","report_id":2124545,"orderid":"","message":"FAILURE"}
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
    }

}

[Function("transfer", "bool")]
public class TransferFunction : FunctionMessage
{
    [Parameter("address", "_to", 1)]
    public string To { get; set; }

    [Parameter("uint256", "_value", 2)]
    public BigInteger TokenAmount { get; set; }
}

[Function("balanceOf", "uint256")]
public class BalanceOfFunction : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}
