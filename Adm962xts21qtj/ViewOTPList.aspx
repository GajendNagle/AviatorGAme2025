<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" AutoEventWireup="true" CodeFile="ViewOTPList.aspx.cs" Inherits="Adm962xts21qtj_ViewOTPList" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 col-12 text-left">
                <a href="#" target="_blank" style="color: #ff0033">Search Properties :</a>
                <br />
                <br />
            </div>
            <div class="col-md-12 col-12 text-left">
                <label>Results By:</label>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass=" form-control"  MaxLength="12" AutoComplete="off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass=" form-control"  MaxLength="12" AutoComplete="off" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12">
                    <label>Select One</label>
                    <asp:DropDownList ID="DDLDownPos" runat="server"  CssClass="form-control">
                        <asp:ListItem Value="ALL">All</asp:ListItem>
                        <asp:ListItem Value="MemID">UserID</asp:ListItem>
                        <asp:ListItem Value="Email">Email</asp:ListItem>
                        <asp:ListItem Value="OTP">OTP</asp:ListItem>
                        <asp:ListItem Value="AcType">AcType</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 col-12" id="detsdv" runat="server">
                    <asp:TextBox ID="txtSearch" runat="server" Text="" MaxLength="30" CssClass=" form-control blnk-input"></asp:TextBox>
                    <asp:DropDownList ID="DDLFillItems" runat="server" Visible="False" CssClass="form-control blnk-input">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-1 col-12">
                    <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input"  OnClick="btnSearch_Click" Text="GO" />
                </div>
            </div>
            <div class="col-md-3 col-12">
                <div class="pgsizes">
                    <span>
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
          <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div>&nbsp;</div>
        <div id="divPrint" style="width: 100%;">
            <asp:GridView ID="grdUserDtl" runat="server" PagerSettings-Visible="false" PageSize="100" ShowFooter="True" Width="100%" DataKeyNames="User ID">
                <Columns>
                    <asp:TemplateField HeaderText="SNO.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                            .
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <span style="font: Bold 13px verdana; color: Red; padding: 20px;">---!!! Ooops, Search Record Details Not Found !!!---</span>
                </EmptyDataTemplate>
                <PagerSettings Visible="False" />
                <RowStyle Height="30px" HorizontalAlign="Center" />
                <HeaderStyle Height="30px" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
        <div>&nbsp;</div>
    </div>
    <table width="100%" cellspacing="0" style="display: none;">
        <tr>
            <td>
                <div class="Header_Top1">
                    <samp class="Header_Top">CUSTOMIZE SEARCH</samp>
                </div>
            </td>
        </tr>
    </table>
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image2" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image3" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtFromDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        $(function () {
            $("#<%=txtToDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
</asp:Content>