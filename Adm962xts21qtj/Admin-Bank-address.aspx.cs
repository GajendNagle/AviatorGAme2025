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
using System.Net.Mail;
using System.IO;

public partial class Adm962xts21qtj_Admin_Bank_address : System.Web.UI.Page
{
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    SqlConnection cn;
    public int PageNo;
    DataSet ds;
    public string Mem_email = "", MName = "", UserID = "";
    DB objdb = new DB();
    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    DynamicDtls objgdb = new DynamicDtls();
    public static string fname, chkfileEx, SDbFilePath = "", SDbFilePathand = "", imgpath = "", AcFileName, FileNameDB = "", FileNameDBad = "", fnamead, chkfileExad, AcFileNamead, SDbFilePathad = "";
    ArrayList id = new ArrayList();
    SendEmail objSendEmail = new SendEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                UserID = DB.base64Decod(Session["Khbfy897ft36Gv"].ToString()).ToString();
                if (!IsPostBack)
                {

                    if (Request.QueryString["MemId"] != null && Request.QueryString["MemId"] != string.Empty)
                    {
                        DDLDownPos.SelectedValue = "Screen";
                        //DDLDownPos_SelectedIndexChanged(sender, e);
                        //txtSearch.Text = Request.QueryString["MemId"].ToString();
                    }

                    ddlJumpToPage.Items.Clear();
                    int TotalRows = this.BindResult(1, "0");
                    this.populateList(TotalRows);
                    Qrcode.Visible = false;

                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        UploadImg();
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1, "1");
        this.populateList(TotalRows);
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridView1.PageIndex = e.NewPageIndex;
        //BindResult();
    }
    private int BindResult(int currentPage, string type)
    {
        int TotalRows = 0;
        try
        {
            cn = new SqlConnection(new DB().getconnection());
            dt = new DataTable();
            ds = new DataSet();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("Admin_DepositAddress_Bank");
            cmd.Parameters.AddWithValue("@MemId", UserID);
            cmd.Parameters.AddWithValue("@AccountNo", txtwltaddress.Text);
            cmd.Parameters.AddWithValue("@AccType", DDLDownPos.SelectedItem.Text);//Bank
            cmd.Parameters.AddWithValue("@Mode", ddlmode.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@AcMode", ddlActctype.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@Acname", txtAcname.Text);
            cmd.Parameters.AddWithValue("@IFSC", txtifsccode.Text);
            cmd.Parameters.AddWithValue("@Date", txtFromDate.Text);
            cmd.Parameters.AddWithValue("@Qrcode", FileNameDB);
            cmd.Parameters.AddWithValue("@AdminPwd", txtpassword.Text);
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
            cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(ds);

            TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;

            if (TotalRows == 0)
            {
                lblMsg.Text = new DB().EmptyMessage("Sorry ... No Records found !!");
            }

            if (ds.Tables[1].Rows[0]["Rslt"].ToString() == "ISOk")
            {
                lblMsg.Text = ds.Tables[1].Rows[0]["Msg"].ToString();
            }
            else if (ds.Tables[1].Rows[0]["Rslt"].ToString() == "Ok")
            {
                txtwltaddress.Text = "";
                txtpassword.Text = "";
                txtFromDate.Text = "";
                lblMsg.Text = objdb.UpdateMessage(ds.Tables[1].Rows[0]["Msg"].ToString());
            }
            else
            {
                lblMsg.Text = objdb.ErrorMessage(ds.Tables[1].Rows[0]["Msg"].ToString());
            }
            GridView1.DataSource = ds;
            GridView1.DataBind();
            sda.Dispose();
            cmd.Dispose();
            ds.Dispose();
            cn.Dispose();
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
        return TotalRows;
    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = Convert.ToString(TotalRows);
        int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
        for (int i = 1; i <= PageCount; i++)
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

    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page, "2");
        CountingShow();
    }
    protected void SendResetCnfirmCodeEmail(string UserId, string EmailId, string Name, string ConfirmCode)
    {
        try
        {
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }
    protected void lnkDelete_Deleting(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDelete = (LinkButton)sender;
            GridViewRow GVR = (GridViewRow)lnkDelete.NamingContainer;
            Label lblMemId = (Label)GVR.FindControl("lblMemId");
            CheckBox chkbox = (CheckBox)GVR.FindControl("chkMemID");

            if (chkbox.Checked == true)
            {
                cn = new SqlConnection(new DB().getconnection());
                cmd = new SqlCommand("Admin_DepositAddress_Bank", cn);
                cmd.Parameters.AddWithValue("@MemId", lblMemId.Text);
                cmd.Parameters.AddWithValue("@AccountNo", txtwltaddress.Text);
                cmd.Parameters.AddWithValue("@AccType", DDLDownPos.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Mode", ddlmode.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@AcMode", ddlActctype.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Acname", txtAcname.Text);
                cmd.Parameters.AddWithValue("@IFSC", txtifsccode.Text);
                cmd.Parameters.AddWithValue("@Date", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@Qrcode", FileNameDB);
                cmd.Parameters.AddWithValue("@AdminPwd", txtpassword.Text);
                cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = "2";
                cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
                cmd.Parameters.AddWithValue("@intCurrentPage", "1");
                cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
                cn.Dispose();
                cmd.Dispose();

                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1, "0");
                this.populateList(TotalRows);
                lblMsg.Text = objgdb.UpdateMessage("Record Deleted Successfully.");
            }
            else
            {
                lblMsg.Text = objgdb.ErrorMsg("please select checkbox");
            }
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }

    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        try
        {
            string fromEmail = "";
            fromEmail = ConfigurationManager.AppSettings["Email"].ToString();
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chkMemID = (CheckBox)row.FindControl("chkMemID");
                if (chkMemID.Checked)
                {
                    Label lblEMAIL = (Label)row.FindControl("lblEMAIL");
                    try
                    {
                        // objSendEmail.SendMailMessage(fromEmail, txtSubject.Text, txtEmailMsg.Text, lblEMAIL.Text);
                    }
                    catch
                    {
                    }
                }

            }
            lblMsg.Text = objgdb.UpdateMessage("Email Sent Sucessfully to the selected EMAIL IDs !!");

        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }

    protected void SendEmailToUser(string EmailId, string Subjects, string Message)
    {
        objgdb.FillWebSiteEmailCompany();
        MailSenderByEmail mailsend = new MailSenderByEmail();

        try
        {
            mailsend.SendMailMessage(DynamicDtls.Email, Subjects, Message, EmailId);
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

    protected void ddlmode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlmode.SelectedValue == "QRCode")
        {
            Qrcode.Visible = true;
        }
        else
        {
            Qrcode.Visible = false;
        }
    }
    public static string GenerateRandom()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
    }
    private void UploadImg()
    {
        SDbFilePathand = "";
        imgpath = "";
        if (FileUploadImg.HasFile == true)
        {
            fname = FileUploadImg.FileName;
            chkfileEx = Path.GetExtension(fname).ToLower();
            if (chkfileEx.ToString().Trim() == ".jpg" || chkfileEx.ToString().Trim() == ".gif" ||
            chkfileEx.ToString().Trim() == ".bmp" || chkfileEx.ToString().Trim() == ".jpeg" ||
            chkfileEx.ToString().Trim() == ".png")
            //|| chkfileEx.ToString().Trim() == ".pdf")
            {
                AcFileName = GenerateRandom();

                SDbFilePath = "uploads/QRCode/" + AcFileName + chkfileEx;
                fname = Path.Combine(Server.MapPath("~/uploads/QRCode/"), AcFileName + chkfileEx);
                FileUploadImg.SaveAs(fname);
                FileNameDB = AcFileName + chkfileEx;
                SDbFilePathand = "uploads/QRCode/" + AcFileName + chkfileEx;


                FileUploadImg.Attributes.Clear();
                FileUploadImg.Dispose();
            }
            else
            {
                lblMsg.Text = "Only GIF, JPEG, PNG, BMP files are allowed !";

            }

        }
        else
        {
            lblMsg.Text = "Only GIF, JPEG, PNG, BMP files are allowed !";

        }
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindResult(1, "0");
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindResult(1, "0");
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            //LinkButton lnkEdit = (LinkButton)sender;
            //GridViewRow GVR = (GridViewRow)lnkEdit.NamingContainer;
            //Label lblMemId = (Label)GVR.FindControl("lblMemId");
            //Label lblaccno = (Label)GVR.FindControl("lblaccno");
            //DropDownList ddlStatus = (DropDownList)GVR.FindControl("ddlStatus");
            Label lblaccno = (Label)GridView1.Rows[e.RowIndex].Cells[6].FindControl("lblaccno");
            Label lblMemId = (Label)GridView1.Rows[e.RowIndex].Cells[2].FindControl("lblMemId");
            DropDownList ddlStatus = (DropDownList)GridView1.Rows[e.RowIndex].Cells[4].FindControl("ddlStatus");
            var s = ddlStatus.SelectedItem.Text;
            var type = 3;
            cn = new SqlConnection(new DB().getconnection());
            dt = new DataTable();
            ds = new DataSet();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("Admin_DepositAddress_Bank");
            cmd.Parameters.AddWithValue("@MemId", lblMemId.Text);
            cmd.Parameters.AddWithValue("@AccountNo", lblaccno.Text);
            cmd.Parameters.AddWithValue("@AccType", "");//Bank
            cmd.Parameters.AddWithValue("@Mode", ddlStatus.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@AcMode", "");
            cmd.Parameters.AddWithValue("@Acname", "");
            cmd.Parameters.AddWithValue("@IFSC", "");
            cmd.Parameters.AddWithValue("@Date", "");
            cmd.Parameters.AddWithValue("@Qrcode", "");
            cmd.Parameters.AddWithValue("@AdminPwd", "");
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.AddWithValue("@intPageSize", "");
            cmd.Parameters.AddWithValue("@intCurrentPage", "");
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(ds);
            //ds = objgdb.ByProcedure("ProcInvsAppSetting", new string[] { "id", "Code", "Value", "Remark", "Status", "type" },
            //     new string[] { id.ToString(), "", txtValue.Text, txtRemarks.Text, ddlStatus.SelectedItem.Text, "1" }, "Bydateset");
            //lblMsg.Text = ds.Tables[0].Rows[0][0].ToString();
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ; }
        GridView1.EditIndex = -1;
        BindResult(1, "0");
    }
}