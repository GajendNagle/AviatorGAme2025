<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="MySkin" AutoEventWireup="true" CodeFile="ViewContactEnquiry.aspx.cs" Inherits="Admin_ViewContactEnquiry" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .ErrorMsgForUID {
            margin-bottom: 0px;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-12">
                <div class="flex-img-link-wrapper">
                    <div class="flex-img-link-in">
                        <span>
                            <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="Uparmenu" OnClientClick="return CallPrint('divPrint')">Print</asp:LinkButton>
                        </span>
                        <span>
                            <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="Uparmenu" OnClick="btnexporttoexport_Click">Export to Excel</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date </label>
                    <asp:TextBox ID="FromDate" runat="server" ValidationGroup="b" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date </label>
                    <asp:TextBox ID="ToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="imgbtnView" runat="server" ImageUrl="~/Images/Viewbutton.gif" OnClick="imgbtnView_Click" Text="SUBMIT" CssClass="OuterBtn blnk-input" />
            </div>
            <div class="col-md-6 col-12">
                <div class="pgsizes">
                    <span>
                        <%=PageNo%>
                        -
                        <%=Pagesize %>
                        of
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg1" runat="server" Width="100%" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div id="divPrint">
                    <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                    <asp:GridView ID="GridView2" runat="server" OnPageIndexChanging="GridView2_PageIndexChanging" HorizontalAlign="Center" ShowFooter="True" DataKeyNames="id" OnRowDeleting="GridView2_RowDeleting" PageSize="50" OnRowDataBound="GridView2_RowDataBound" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <a href='SendEmails.aspx?mid=User%20Section&sid=E-Mail&Em=<%# new EncryDecry().base64Encode(DataBinder.Eval(Container.DataItem, "Email").ToString())%>'>REPLY</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="linkbtn" runat="Server" CausesValidation="false" CommandName="delete" Text="REMOVE"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%#Eval("srno") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <span class="GridEmpty">---Today , No Enquiry Recieved ---</span>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <%--<table width="100%" cellspacing="0">
        <tr>
            <td align="left" style="width: 100%; height: 30px; text-align: right;" valign="top">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="Uparmenu" Font-Bold="False" Font-Names="Verdana" OnClick="btnexporttoexport_Click" Style="font-size: 12px;">Export to Excel</asp:LinkButton>
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../UserPanel_Images/excel_icon.gif" OnClick="btnexporttoexport_Click" />
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="Uparmenu" Font-Bold="False" Font-Names="Verdana" OnClientClick="return CallPrint('divPrint')" Style="font-size: 12px;">Print</asp:LinkButton>
                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" OnClientClick="return CallPrint('divPrint')" />
            </td>
        </tr>
        <tr>
            <td class="ScrollBar">
                <table cellspacing="0" cellpadding="0" border="0" style="width: 100%" align="center"
                    class="BodyBox">
                    <tbody>
                        <tr>
                            <td align="left" style="height: 13px"></td>
                        </tr>
                        <tr>
                            <td align="left">
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td align="right">From :</td>
                                        <td align="left" style="height: 25px" valign="middle">
                                            <asp:TextBox ID="FromDate" runat="server" ValidationGroup="b" Width="160px" CssClass="ComposeTxtBx"></asp:TextBox>&nbsp;</td>
                                        <td align="right">To :</td>
                                        <td align="left" style="height: 25px">
                                            <asp:TextBox ID="ToDate" runat="server" Width="160px" CssClass="ComposeTxtBx"></asp:TextBox>&nbsp;
                                        </td>
                                        <td align="left" style="width: 100px; height: 25px" valign="middle">
                                            <asp:Button ID="imgbtnView" runat="server" ImageUrl="~/Images/Viewbutton.gif" OnClick="imgbtnView_Click" Text="SUBMIT" CssClass="Btn" />
                                        </td>
                                        <td align="left" style="height: 25px" valign="middle">&nbsp;<%=PageNo%>-
                                            <%=Pagesize %>
                                            of
                                            <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                                            <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" CssClass="ComposeTxtBx" Font-Names="Verdana" Font-Size="11px" OnSelectedIndexChanged="PageChanged" Width="58px"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="font-weight: bold; font-size: 13px; color: #000; height: 25px"></td>
                                        <td align="left" style="height: 25px" valign="middle"></td>
                                        <td align="right" style="font-weight: bold; font-size: 13px; color: #000; height: 25px"></td>
                                        <td align="left" style="height: 25px"></td>
                                        <td align="left" style="width: 100px; height: 25px" valign="middle"></td>
                                        <td align="left" style="height: 25px" valign="middle"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 855px">
                                <asp:Label ID="lblMsg1" runat="server" Width="100%" Font-Names="Verdana" Font-Size="13px" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 855px" align="left"></td>
                        </tr>
                        <tr>
                            <td valign="top" align="left" colspan="3" class="BoardStructure" style="height: 106px">
                                <div id="divPrint">
                                    <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                                    <asp:GridView ID="GridView2" runat="server" OnPageIndexChanging="GridView2_PageIndexChanging" HorizontalAlign="Center" ShowFooter="True" DataKeyNames="id" OnRowDeleting="GridView2_RowDeleting" PageSize="50" OnRowDataBound="GridView2_RowDataBound" Width="100%">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <a href='SendEmails.aspx?mid=User%20Section&sid=E-Mail&Em=<%# new EncryDecry().base64Encode(DataBinder.Eval(Container.DataItem, "Email").ToString())%>'>REPLY</a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="linkbtn" runat="Server" CausesValidation="false" CommandName="delete" Text="REMOVE"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SrNo.">
                                                <ItemTemplate>
                                                    <%#Eval("srno") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <span class="GridEmpty">---Today , No Enquiry Recieved ---</span>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="BoardStructure" colspan="3" style="height: 106px" valign="top">&nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />--%>
                                <%--<asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>--%>
                                <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ToDate" TargetControlID="ToDate"></ajaxToolkit:CalendarExtender>
                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="FromDate" TargetControlID="FromDate"></ajaxToolkit:CalendarExtender>--%>
                            <%--</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>--%>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=FromDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        $(function () {
            $("#<%=ToDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,right=0,top=0,width=790,height=2000,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            prtContent.innerHTML = strOldOne;
        }
    </script>
</asp:Content>