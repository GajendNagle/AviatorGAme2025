<%@ Page Title=" Parity Summary" Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" StylesheetTheme="mySkin" AutoEventWireup="true" CodeFile="Aviator-Game-Summary.aspx.cs" Inherits="Adm962xts21qtj_Aviator_Game_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 col-12 text-left"></div>
            <div class="col-md-6 col-12">
                <div class="flex-img-link-wrapper">
                    <div class="flex-img-link-in">
                        <span>
                            <asp:Image ID="Image1" runat="server" ImageUrl="../UserPanel_Images/printer-icon.png" />
                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="Uparmenu" OnClientClick="return CallPrint('divPrint')">Print</asp:LinkButton>
                        </span>
                        <span>
                            <asp:Image ID="Image4" runat="server" ImageUrl="../UserPanel_Images/excel.png" />
                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="Uparmenu" OnClick="btnexporttoexport_Click">Export to Excel</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-wrap">
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" MaxLength="12" AutoComplete="Off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <div class="form-group">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" MaxLength="12" CssClass="form-control" placeholder="DD/MM/YYYY" AutoComplete="Off"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-2 col-12">
                <label>Select one</label>
                <asp:DropDownList ID="DDLDownPos" runat="server" AutoPostBack="True" CssClass="ComposeTxtBx form-control" OnSelectedIndexChanged="DDLDownPos_SelectedIndexChanged">
                    <asp:ListItem>All</asp:ListItem>
                    <asp:ListItem Value="MName">Name</asp:ListItem>
                    <asp:ListItem Value="MemID">Member ID</asp:ListItem>
                    <asp:ListItem Value="Status">Status</asp:ListItem>
                    <asp:ListItem Value="TradingType">Color/Number</asp:ListItem>
                    <asp:ListItem Value="JackpotNo">Period No</asp:ListItem>
                    <%--<asp:ListItem Value="PurchaseType">PurchaseType</asp:ListItem>
                    <asp:ListItem Value="Leader-ID">Leader-ID</asp:ListItem>--%>
                </asp:DropDownList>
            </div>
            <div class="col-md-2 col-12" id="detsdv" runat="server">
                <asp:DropDownList ID="DDLFillItems" runat="server" CssClass="ComposeTxtBx blnk-input" Visible="False"></asp:DropDownList>
                <asp:TextBox ID="txtSearch" runat="server" MaxLength="30" Text="" Visible="False" CssClass="ComposeTxtBx blnk-input"></asp:TextBox>
            </div>
            <div class="col-md-2 col-12">
                <asp:Button ID="btnSearch" runat="server" CssClass="OuterBtn blnk-input" OnClick="btnSearch_Click" Text="Submit" CausesValidation="False" />
            </div>
            <div class="col-md-2 col-12">
                <div class="pgsizes">
                    <span>
                        <%=PageNo%>
                        <%=Pagesize %>
                        of
                        <asp:Label ID="lblTotRec" runat="server"></asp:Label>
                        &nbsp;
                    </span>
                    <asp:DropDownList ID="ddlJumpToPage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PageChanged" CssClass="form-control" Width="58px"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12">
                <asp:Label ID="Label1" CssClass="total-record" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>
            </div>
        </div>
        <div class="col-md-12 col-12">
            <%--<asp:Label ID="lblTotalData" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="15px"></asp:Label>--%>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <div id="divPrint">
                    <asp:GridView ID="GvCaptchaWork" runat="server" Font-Bold="False" AutoGenerateColumns="False" Width="100%" ShowFooter="True" OnRowDataBound="GvCaptchaWork_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="SrNo.">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex +1  %>
                                    .
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Member-ID">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "MNAME")%>
                                    <br />
                                    <b><%# DataBinder.Eval(Container.DataItem, "MemId")%></b>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bet Date">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Date")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Bet $">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "BetAmt")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="X">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "Multiple")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Win $">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "WinAmt")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Round Status">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "RoundStatus")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bet Status">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "BetStatus")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Bet Type">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "BetType")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Round Number">
                                <ItemTemplate>
                                    <%# DataBinder.Eval(Container.DataItem, "RoundNo")%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <span style="color: Red;">---!!! Ooops,Deposit History Detail Not Found !!!---</span>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div>&nbsp;</div>
    </div>
    <script language="javascript" type="text/javascript">
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
    <style>
        .ontop {
            z-index: 999;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            display: none;
            position: fixed;
            overflow: auto;
            background-color: #cccccc;
            color: #aaaaaa;
            opacity: .9;
            filter: alpha(opacity = 70);
        }
        #popup {
            width: 300px;
            height: 200px;
            position: absolute;
            color: #ffffff;
            background-color: #ec9806;
            border-top: black thin solid;
            border-right: black thin solid;
            border-bottom: black thin solid;
            border-left: black thin solid;
            /*To align popup window at the center of screen*/
            top: 50%;
            left: 50%;
            margin-top: -100px;
            margin-left: -150px;
        }
    </style>
    <script type="text/javascript">
        //To detect escape button
        document.onkeydown = function (evt) {
            evt = evt || window.event;
            if (evt.keyCode == 27) {
                hide();
            }
        };
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
        function Mesag(msg) {
            document.getElementById('<%=lblMsg.ClientID %>').innerHTML = msg;
        }
    </script>
</asp:Content>