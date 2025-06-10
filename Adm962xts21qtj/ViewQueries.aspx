<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="MySkin" CodeFile="ViewQueries.aspx.cs" Inherits="ControlSection_ViewQueries" Title=" View/Send User Reply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" type="text/css" href="css/easyui.css" />
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script src="dashboard.js" type="text/javascript"></script>
    <style>
        body {
            margin: 0px;
            padding: 0 !important;
            font-family: 'poppins', sans-serif;
            background-color: #ddddd4;
            background-image: url(../New-Dashbaord-Images/sep-half.png);
            background-repeat: repeat;
            font-style: normal !important;
        }
        .messageview {
            margin-bottom: 10px;
            padding: 5px;
            border-bottom: solid 1px #818080;
        }
        .messageview b {
            font-size: 13px;
            color: #000;
        }
        .messageview p {
            margin: 0px;
            padding: 0px;
            margin-bottom: 5px;
            line-height: 18px;
        }
        .flex {
            display: flex;
            align-items: center;
        }
        .flex img {
            padding-left: 10px;
            height: 20px;
        }
        .pgsizes {
            float: right;
            /*margin-bottom: 10px !important;*/
            /*margin-top: 20px !important;*/
        }
        .blnk-input {
            margin-top: 28px;
        }
        .reprt-sec{
            padding: 10px 0;
        }
        @media only screen and (max-width :767px) {
            .blnk-input {
                margin-top: 0px;
            }          
            .pgsizes {
                /*margin-top: -20px !important;*/
            }
            .panel.window {
                width: 95% !important;
                left: 10px !important;
            }
            .window-shadow {
                width: 95% !important;
                left: 10px !important;
            }
            .panel-header .window-mask .window-shadow {
                width: auto !important;
            }
            #messageInput {
                width: 310px !important;
            }
        }
        @media(min-width: 600px) {
            .pgsizes {
                margin-top: 23px;
            }
        }
    </style>
    <div class="container-fluid">
        <div class="reprt-sec">
            <div class="row">
                <div class="col-md-2 col-12">
                    <label>From Date</label>
                    <div class="flex">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="ComposeTxtBx" MaxLength="12" Autocomplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                        <%--<asp:Image ID="Image2" runat="server" ImageUrl="~/UserPanel_Images/cal.gif" />--%>
                    </div>
                </div>
                <div class="col-md-2 col-12">
                    <label>To Date</label>
                    <div class="flex">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="ComposeTxtBx" MaxLength="12" Autocomplete="Off" placeholder="DD/MM/YYYY"></asp:TextBox>
                        <%--<asp:Image ID="Image3" runat="server" ImageUrl="~/UserPanel_Images/cal.gif" />--%>
                    </div>
                </div>
                <div class="col-md-2 col-12">
                    <label>Select One</label>
                    <asp:DropDownList ID="DDLSelect" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx" OnSelectedIndexChanged="DDLSelect_SelectedIndexChanged">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem Value="FROMUSER">EMail</asp:ListItem>
                        <asp:ListItem Value="FullName">Name</asp:ListItem>
                        <asp:ListItem Value="MsgTopic">Help Topic</asp:ListItem>
                        <asp:ListItem Value="TicketNo">Ticket No</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 col-12" id="detsdv" runat="server">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="ComposeTxtBx blnk-input"  MaxLength="30" Text="" Visible="False"></asp:TextBox>
                    <asp:DropDownList ID="ddlHelpTopic" runat="server" Visible="false" CssClass="form-control blnk-input">
                        <asp:ListItem>Change of mobile number</asp:ListItem>
                        <asp:ListItem>Correction in name</asp:ListItem>
                        <asp:ListItem>Order confirmation</asp:ListItem>
                        <asp:ListItem>General enquiry</asp:ListItem>
                        <asp:ListItem>Feedback</asp:ListItem>
                        <asp:ListItem>Report a problem</asp:ListItem>
                        <asp:ListItem>Mavro bonus</asp:ListItem>
                        <asp:ListItem>Request for Change Manager</asp:ListItem>
                        <asp:ListItem>Request for manager</asp:ListItem>
                        <asp:ListItem>Request for 100 manager</asp:ListItem>
                        <asp:ListItem>Request for 1k manager</asp:ListItem>
                        <asp:ListItem>Request for 100k manager</asp:ListItem>
                        <asp:ListItem>Request for 1000k manager</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-1 col-3">
                    <asp:Button ID="btnSearch" runat="server" CssClass="Btn blnk-input" OnClick="btnSearch_Click" Text="GO" />
                    <%--<asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Submit" CssClass="Btn blnk-input" Width="82px" />--%>
                </div>
                <div class="col-md-3 col-9" style="float:right; text-align: right; margin-left: auto;">
                    <div class="pgsizes">
                        <%--<%=PageNo%>
                        -
                        <%=Pagesize %>
                        of &nbsp;--%>
                        <asp:Label ID="lblRecordNo" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                        <asp:Label ID="lblTotRec" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                        <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" Width="58px" CssClass="ComposeTxtBx"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 15px; padding: 0 15px;">
        <div class="col-md-12" id="divPrint">
            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red" Width="100%"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" PageSize="1000" AutoGenerateColumns="False" AutoGenerateDeleteButton="True" DataKeyNames="ID" EnableTheming="True" OnRowDeleting="GridView2_RowDeleting" ShowFooter="True" Width="100%" AutoGenerateEditButton="false" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" CssClass="table-acsetng gvMain">
                <Columns>
                    <asp:TemplateField HeaderText="SrNo">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                            <asp:Label ID="LblId" runat="server" Text='<%# Eval("ID")%>' Visible="false"></asp:Label>
                            <br />
                            <a onclick="loadOrderMessage('<%#Eval("TicketNo")%>','MMMForeverAdm')" id='msg<%#Eval("ID") %>' href="javascript:void(0)" class="msgBox" style="text-decoration: none">
                            <%#Eval("Rply")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From User">
                        <ItemTemplate>
                            <%#Eval("FromUser")%><br />
                            <%#Eval("FullName")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Subject">
                        <ItemTemplate>
                            <%#Eval("MsgTopic")%><br />
                            <%#Eval("Subject")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ticket">
                        <ItemTemplate>
                            <%#Eval("TicketNo")%><br />
                            <%#Eval("TktDate")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <span style="font: bold 13px verdana; color: Red;">---Oooops, Record Not Found---</span>
                </EmptyDataTemplate>
            </asp:GridView>
            <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
            <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image2" TargetControlID="txtFromDate"></ajaxToolkit:CalendarExtender>
            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="Image3" TargetControlID="txtToDate"></ajaxToolkit:CalendarExtender>--%>
            <div id="OrderMessageBox" class="easyui-dialog" title="Order Message" data-options="closed:true,modal:true" style="width: 860px; height: 520px;">
                <div class="easyui-layout" data-options="fit:true">
                    <div data-options="region:'east'" style="width: 200px; padding: 10px">
                        <input type="file" name="msgFile" id="msgFile" />
                    </div>
                    <div data-options="region:'center'" style="overflow-y: scroll;">
                        <div id="loadmsgbox"></div>
                    </div>
                    <div data-options="region:'south'" title="Write your message here" style="height: 120px; padding: 10px">
                        <textarea name="messageInput" id="messageInput" style="height: 60px; width: 600px"></textarea>
                    </div>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtFromDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
        $(function () {
            $("#<%=txtToDate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
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