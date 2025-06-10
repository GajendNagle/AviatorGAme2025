<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" CodeFile="AdminEditProfile.aspx.cs" Inherits="Adm962xts21qtj_AdminEditProfile" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .ComposeTxtBx:disabled {
            width: 100%;
            height: 33px;
            color: #808081;
            background-color: White;
            border: solid 1px #d1cfcf;
            -webkit-border-radius: 7px;
            -moz-border-radius: 7px;
            border-radius: 4px;
            padding: 0px 7px;
            margin-bottom: 15px;
            font-weight: 300;
        }
        .gvSlt {
            font-family: Poppins !important;
        }
        .profeditsec {
            position: relative;
            padding: 20px 0px;
        }
        .chngpwbtn {
            margin-bottom: 20px;
        }
        .profeditsec .ComposeTxtBx {
            margin-bottom: 0px;
        }
        .BoderHading {
            border-bottom: solid 1px #dddcdc;
            text-transform: uppercase;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            padding: 5px 0px 5px 0px;
            -webkit-border-radius: 7px;
            -moz-border-radius: 7px;
            border-radius: 0;
            color: #1889CF;
            margin-bottom: 15px;
            margin-top: 15px;
        }
        .profeditsec .mrgbtm {
            margin-bottom: 18px !important;
        }
        .ComposeTxtBx {
            width: 100%;
            height: 33px;
            color: #808081;
            background-color: White;
            border: solid 1px #d1cfcf;
            -webkit-border-radius: 7px;
            -moz-border-radius: 7px;
            border-radius: 4px;
            padding: 0px 7px;
            margin-bottom: 15px;
            font-weight: 300;
        }
        label {
            font-weight: 300;
            color: #363636;
            font-size: 14px;
            line-height: 30px;
        }
    </style>
    <script type="text/javascript">
        function EcurncyChange() {
            var isChecked = document.getElementById("<%=chkECurcy.ClientID%>");
            if (isChecked.checked == false) {
                document.getElementById("pnlPerc").style.display = 'none';
            }
            else {
                document.getElementById("pnlPerc").style.display = 'block';
            }
        }
        function BankChange() {
            var isChecked = document.getElementById("<%=chkbankWire.ClientID%>");
            if (isChecked.checked == false) {
                document.getElementById("PanelBnkinfo").style.display = 'none';
            }
            else {
                document.getElementById("PanelBnkinfo").style.display = 'block';
            }
        }
    </script>
    <div class="container">
        <div class="profeditsec">
            <div class="row">
                <div class="col-md-9 col-md-offset-2">
                    <div class="subprofedt">
                        <div class="row">
                            <div class="col-md-12 col-12 mrgbtm">
                                <a href="javascript:history.back();" class="OuterBtn chngpwbtn"><< Go Back</a>
                            </div>
                            <div class="col-md-12 col-12">
                                <asp:Label ID="lblmsg" runat="server"></asp:Label>
                            </div>
                            <div class="col-md-12 col-12">
                                <label>Search Member By ID: </label>
                                <asp:TextBox ID="txtSearchbyMemberID" runat="server" Width="200px" AutoComplete="Off" CssClass="ComposeTxtBx"></asp:TextBox>
                                <asp:Button ID="btnSearchMember" runat="server" Text="GO" CssClass="OuterBtn" OnClick="btnSearchMember_Click" />
                            </div>
                            <div class="col-md-12 col-12">
                                <h6 class="BoderHading">Personal information</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2 col-12">
                                <label>Name:*</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtFirstName" runat="server" MaxLength="150" CssClass="ComposeTxtBx"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFirstName" ErrorMessage="Please enter first name.">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Date of Birth:*</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtDOB" runat="server" MaxLength="10" CssClass="ComposeTxtBx"></asp:TextBox>
                                <%--<asp:Image ID="Image2" runat="server" ImageUrl="~/UserPanel_Images/cal.png" />--%>
                                <asp:Label ID="lblDOB" runat="server" Font-Bold="True" Visible="False"></asp:Label>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtDOB" ErrorMessage="Please Enter Correct DOB" MaximumValue="31/12/2050" MinimumValue="01/01/1920" SetFocusOnError="True">*</asp:RangeValidator>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Email:*</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtEmailid" runat="server" MaxLength="50" CssClass="ComposeTxtBx"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailid" ErrorMessage="Enter Correct MailId." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmailid" ErrorMessage="Please enter email address.">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-2 col-3">
                                <label>Gender:</label>
                            </div>
                            <div class="col-md-4 col-9">
                                <asp:RadioButtonList ID="rdgender" runat="server" CellPadding="0" CellSpacing="0" RepeatDirection="Horizontal" CssClass="mrgbtm">
                                    <asp:ListItem Selected="True" Value="0">Male</asp:ListItem>
                                    <asp:ListItem Value="1">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Country Code:*</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:DropDownList ID="ddlCountryCode" runat="server" CssClass="ComposeTxtBx mrgbtm">
                                    <asp:ListItem Value="+93">Afghanistan (+93)</asp:ListItem>
                                    <asp:ListItem Value="+355">Albania (+355)</asp:ListItem>
                                    <asp:ListItem Value="+213">Algeria (+213)</asp:ListItem>
                                    <asp:ListItem Value="+1">American Samoa (+1)</asp:ListItem>
                                    <asp:ListItem Value="+376">Andorra (+376)</asp:ListItem>
                                    <asp:ListItem Value="+244">Angola (+244)</asp:ListItem>
                                    <asp:ListItem Value="+1">Anguilla (+1)</asp:ListItem>
                                    <asp:ListItem Value="+672">Antarctica (+672)</asp:ListItem>
                                    <asp:ListItem Value="+1268">Antigua, Barbuda (+1268)</asp:ListItem>
                                    <asp:ListItem Value="+54">Argentina (+54)</asp:ListItem>
                                    <asp:ListItem Value="+374">Armenia (+374)</asp:ListItem>
                                    <asp:ListItem Value="+297">Aruba (+297)</asp:ListItem>
                                    <asp:ListItem Value="+247">Ascension (+247)</asp:ListItem>
                                    <asp:ListItem Value="+61">Australia (+61)</asp:ListItem>
                                    <asp:ListItem Value="+43">Austria (+43)</asp:ListItem>
                                    <asp:ListItem Value="+994">Azerbaijan (+994)</asp:ListItem>
                                    <asp:ListItem Value="+1">Bahamas (+1)</asp:ListItem>
                                    <asp:ListItem Value="+973">Bahrain (+973)</asp:ListItem>
                                    <asp:ListItem Value="+880">Bangladesh (+880)</asp:ListItem>
                                    <asp:ListItem Value="+1">Barbados (+1)</asp:ListItem>
                                    <asp:ListItem Value="+375">Belarus (+375)</asp:ListItem>
                                    <asp:ListItem Value="+32">Belgium (+32)</asp:ListItem>
                                    <asp:ListItem Value="+501">Belize (+501)</asp:ListItem>
                                    <asp:ListItem Value="+229">Benin (+229)</asp:ListItem>
                                    <asp:ListItem Value="+1441">Bermuda (+1441)</asp:ListItem>
                                    <asp:ListItem Value="+975">Bhutan (+975)</asp:ListItem>
                                    <asp:ListItem Value="+591">Bolivia (+591)</asp:ListItem>
                                    <asp:ListItem Value="+387">Bosnia &amp; Herzegovina (+387)</asp:ListItem>
                                    <asp:ListItem Value="+267">Botswana (+267)</asp:ListItem>
                                    <asp:ListItem Value="+55">Brazil (+55)</asp:ListItem>
                                    <asp:ListItem Value="+1">British Virgin Islands (+1)</asp:ListItem>
                                    <asp:ListItem Value="+673">Brunei Darussalam (+673)</asp:ListItem>
                                    <asp:ListItem Value="+359">Bulgaria (+359)</asp:ListItem>
                                    <asp:ListItem Value="+226">Burkina Faso (+226)</asp:ListItem>
                                    <asp:ListItem Value="+257">Burundi (+257)</asp:ListItem>
                                    <asp:ListItem Value="+855">Cambodia (+855)</asp:ListItem>
                                    <asp:ListItem Value="+237">Cameroon (+237)</asp:ListItem>
                                    <asp:ListItem Value="+1">Canada (+1)</asp:ListItem>
                                    <asp:ListItem Value="+238">Cape Verde (+238)</asp:ListItem>
                                    <asp:ListItem Value="+1345">Cayman Islands (+1345)</asp:ListItem>
                                    <asp:ListItem Value="+236">Central African Republic (+236)</asp:ListItem>
                                    <asp:ListItem Value="+235">Chad (+235)</asp:ListItem>
                                    <asp:ListItem Value="+56">Chile (+56)</asp:ListItem>
                                    <asp:ListItem Value="+86">China (+86)</asp:ListItem>
                                    <asp:ListItem Value="+57">Colombia (+57)</asp:ListItem>
                                    <asp:ListItem Value="+269">Comoros (+269)</asp:ListItem>
                                    <asp:ListItem Value="+682">Cook Islands (+682)</asp:ListItem>
                                    <asp:ListItem Value="+506">Costa Rica (+506)</asp:ListItem>
                                    <asp:ListItem Value="+385">Croatia (+385)</asp:ListItem>
                                    <asp:ListItem Value="+357">Cyprus (+357)</asp:ListItem>
                                    <asp:ListItem Value="+420">Czech Republic (+420)</asp:ListItem>
                                    <asp:ListItem Value="+45">Denmark (+45)</asp:ListItem>
                                    <asp:ListItem Value="+246">Diego Garcia (+246)</asp:ListItem>
                                    <asp:ListItem Value="+253">Djibouti (+253)</asp:ListItem>
                                    <asp:ListItem Value="+1767">Dominica (+1767)</asp:ListItem>
                                    <asp:ListItem Value="+1806">Dominican Republic (+1806)</asp:ListItem>
                                    <asp:ListItem Value="+670">East Timor (+670)</asp:ListItem>
                                    <asp:ListItem Value="+593">Ecuador (+593)</asp:ListItem>
                                    <asp:ListItem Value="+20">Egypt (+20)</asp:ListItem>
                                    <asp:ListItem Value="+503">El Salvador (+503)</asp:ListItem>
                                    <asp:ListItem Value="+240">Equatorial Guinea (+240)</asp:ListItem>
                                    <asp:ListItem Value="+291">Eritrea (+291)</asp:ListItem>
                                    <asp:ListItem Value="+372">Estonia (+372)</asp:ListItem>
                                    <asp:ListItem Value="+251">Ethiopia (+251)</asp:ListItem>
                                    <asp:ListItem Value="+500">Falkland Islands (+500)</asp:ListItem>
                                    <asp:ListItem Value="+298">Faroe Islands (+298)</asp:ListItem>
                                    <asp:ListItem Value="+679">Fiji Islands (+679)</asp:ListItem>
                                    <asp:ListItem Value="+358">Finland (+358)</asp:ListItem>
                                    <asp:ListItem Value="+33">France (+33)</asp:ListItem>
                                    <asp:ListItem Value="+262">French Dept/Terr in Indian Ocean (+262)</asp:ListItem>
                                    <asp:ListItem Value="+594">French Guiana (+594)</asp:ListItem>
                                    <asp:ListItem Value="+689">French Polynesia (+689)</asp:ListItem>
                                    <asp:ListItem Value="+241">Gabon (+241)</asp:ListItem>
                                    <asp:ListItem Value="+220">Gambia (+220)</asp:ListItem>
                                    <asp:ListItem Value="+995">Georgia (+995)</asp:ListItem>
                                    <asp:ListItem Value="+49">Germany (+49)</asp:ListItem>
                                    <asp:ListItem Value="+233">Ghana (+233)</asp:ListItem>
                                    <asp:ListItem Value="+350">Gibraltar (+350)</asp:ListItem>
                                    <asp:ListItem Value="+30">Greece (+30)</asp:ListItem>
                                    <asp:ListItem Value="+299">Greenland (+299)</asp:ListItem>
                                    <asp:ListItem Value="+1473">Grenada (+1473)</asp:ListItem>
                                    <asp:ListItem Value="+590">Guadeloupe (+590)</asp:ListItem>
                                    <asp:ListItem Value="+1">Guam (+1)</asp:ListItem>
                                    <asp:ListItem Value="+502">Guatemala (+502)</asp:ListItem>
                                    <asp:ListItem Value="+224">Guinea (+224)</asp:ListItem>
                                    <asp:ListItem Value="+245">Guinea-Bissau (+245)</asp:ListItem>
                                    <asp:ListItem Value="+592">Guyana (+592)</asp:ListItem>
                                    <asp:ListItem Value="+509">Haiti (+509)</asp:ListItem>
                                    <asp:ListItem Value="+504">Honduras (+504)</asp:ListItem>
                                    <asp:ListItem Value="+852">Hong Kong (+852)</asp:ListItem>
                                    <asp:ListItem Value="+36">Hungary (+36)</asp:ListItem>
                                    <asp:ListItem Value="+354">Iceland (+354)</asp:ListItem>
                                    <asp:ListItem Value="+91">India (+91)</asp:ListItem>
                                    <asp:ListItem Value="+62">Indonesia (+62)</asp:ListItem>
                                    <asp:ListItem Value="+964">Iraq (+964)</asp:ListItem>
                                    <asp:ListItem Value="+353">Ireland (+353)</asp:ListItem>
                                    <asp:ListItem Value="+972">Israel (+972)</asp:ListItem>
                                    <asp:ListItem Value="+39">Italy (+39)</asp:ListItem>
                                    <asp:ListItem Value="+1876">Jamaica (+1876)</asp:ListItem>
                                    <asp:ListItem Value="+81">Japan (+81)</asp:ListItem>
                                    <asp:ListItem Value="++962">Jordan (+962)</asp:ListItem>
                                    <asp:ListItem Value="+254">Kenya (+254)</asp:ListItem>
                                    <asp:ListItem Value="+686">Kiribati (+686)</asp:ListItem>
                                    <asp:ListItem Value="+965">Kuwait (+965)</asp:ListItem>
                                    <asp:ListItem Value="+996">Kyrgyzstan (+996)</asp:ListItem>
                                    <asp:ListItem Value="+856">Laos (+856)</asp:ListItem>
                                    <asp:ListItem Value="+371">Latvia (+371)</asp:ListItem>
                                    <asp:ListItem Value="+961">Lebanon (+961)</asp:ListItem>
                                    <asp:ListItem Value="+266">Lesotho (+266)</asp:ListItem>
                                    <asp:ListItem Value="+231">Liberia (+231)</asp:ListItem>
                                    <asp:ListItem Value="+423">Liechtenstein (+423)</asp:ListItem>
                                    <asp:ListItem Value="+370">Lithuania (+370)</asp:ListItem>
                                    <asp:ListItem Value="+352">Luxembourg (+352)</asp:ListItem>
                                    <asp:ListItem Value="+853">Macau (+853)</asp:ListItem>
                                    <asp:ListItem Value="+389">Macedonia (+389)</asp:ListItem>
                                    <asp:ListItem Value="+261">Madagascar (+261)</asp:ListItem>
                                    <asp:ListItem Value="+265">Malawi (+265)</asp:ListItem>
                                    <asp:ListItem Value="+60">Malaysia (+60)</asp:ListItem>
                                    <asp:ListItem Value="+960">Maldives (+960)</asp:ListItem>
                                    <asp:ListItem Value="+223">Mali (+223)</asp:ListItem>
                                    <asp:ListItem Value="+356">Malta (+356)</asp:ListItem>
                                    <asp:ListItem Value="+692">Marshall Islands (+692)</asp:ListItem>
                                    <asp:ListItem Value="+596">Martinique (+596)</asp:ListItem>
                                    <asp:ListItem Value="+222">Mauritania (+222)</asp:ListItem>
                                    <asp:ListItem Value="+230">Mauritius (+230)</asp:ListItem>
                                    <asp:ListItem Value="+52">Mexico (+52)</asp:ListItem>
                                    <asp:ListItem Value="+691">Micronesia (+691)</asp:ListItem>
                                    <asp:ListItem Value="+373">Moldova (+373)</asp:ListItem>
                                    <asp:ListItem Value="+377">Monaco (+377)</asp:ListItem>
                                    <asp:ListItem Value="+976">Mongolia (+976)</asp:ListItem>
                                    <asp:ListItem Value="+382">Montenegro (+382)</asp:ListItem>
                                    <asp:ListItem Value="+1664">Montserrat (+1664)</asp:ListItem>
                                    <asp:ListItem Value="+212">Morocco (+212)</asp:ListItem>
                                    <asp:ListItem Value="+258">Mozambique (+258)</asp:ListItem>
                                    <asp:ListItem Value="+264">Namibia (+264)</asp:ListItem>
                                    <asp:ListItem Value="+674">Nauru (+674)</asp:ListItem>
                                    <asp:ListItem Value="+977">Nepal (+977)</asp:ListItem>
                                    <asp:ListItem Value="+31">Netherlands (+31)</asp:ListItem>
                                    <asp:ListItem Value="+599">Netherlands Antilles (+599)</asp:ListItem>
                                    <asp:ListItem Value="+687">New Caledonia (+687)</asp:ListItem>
                                    <asp:ListItem Value="+64">New Zealand (+64)</asp:ListItem>
                                    <asp:ListItem Value="+505">Nicaragua (+505)</asp:ListItem>
                                    <asp:ListItem Value="+227">Niger (+227)</asp:ListItem>
                                    <asp:ListItem Value="+234">Nigeria (+234)</asp:ListItem>
                                    <asp:ListItem Value="+683">Niue (+683)</asp:ListItem>
                                    <asp:ListItem Value="+1">Northern Mariana Islands (+1)</asp:ListItem>
                                    <asp:ListItem Value="+47">Norway (+47)</asp:ListItem>
                                    <asp:ListItem Value="+968">Oman (+968)</asp:ListItem>
                                    <asp:ListItem Value="+92">Pakistan (+92)</asp:ListItem>
                                    <asp:ListItem Value="+680">Palau (+680)</asp:ListItem>
                                    <asp:ListItem Value="+507">Panama (+507)</asp:ListItem>
                                    <asp:ListItem Value="+675">Papua New Guinea (+675)</asp:ListItem>
                                    <asp:ListItem Value="+595">Paraguay (+595)</asp:ListItem>
                                    <asp:ListItem Value="+51">Peru (+51)</asp:ListItem>
                                    <asp:ListItem Value="+63">Philippines (+63)</asp:ListItem>
                                    <asp:ListItem Value="+48">Poland (+48)</asp:ListItem>
                                    <asp:ListItem Value="+351">Portugal (+351)</asp:ListItem>
                                    <asp:ListItem Value="+1">Puerto Rico (+1)</asp:ListItem>
                                    <asp:ListItem Value="+974">Qatar (+974)</asp:ListItem>
                                    <asp:ListItem Value="+262">Reunion (+262)</asp:ListItem>
                                    <asp:ListItem Value="+40">Romania (+40)</asp:ListItem>
                                    <asp:ListItem Value="+7">Russia (+7)</asp:ListItem>
                                    <asp:ListItem Value="+250">Rwanda (+250)</asp:ListItem>
                                    <asp:ListItem Value="+290">Saint Helena (+290)</asp:ListItem>
                                    <asp:ListItem Value="+1">Saint Kitts and Nevis (+1)</asp:ListItem>
                                    <asp:ListItem Value="+1758">Saint Lucia (+1758)</asp:ListItem>
                                    <asp:ListItem Value="+508">Saint Pierre and Miquelon (+508)</asp:ListItem>
                                    <asp:ListItem Value="+1">Saint Vincent and the Grenadines (+1)</asp:ListItem>
                                    <asp:ListItem Value="+685">Samoa (+685)</asp:ListItem>
                                    <asp:ListItem Value="+378">San Marino (+378)</asp:ListItem>
                                    <asp:ListItem Value="+239">Sao Tome and Principe (+239)</asp:ListItem>
                                    <asp:ListItem Value="+966">Saudi Arabia (+966)</asp:ListItem>
                                    <asp:ListItem Value="+221">Senegal (+221)</asp:ListItem>
                                    <asp:ListItem Value="+381">Serbia (+381)</asp:ListItem>
                                    <asp:ListItem Value="+248">Seychelles (+248)</asp:ListItem>
                                    <asp:ListItem Value="+232">Sierra Leone (+232)</asp:ListItem>
                                    <asp:ListItem Value="+65">Singapore (+65)</asp:ListItem>
                                    <asp:ListItem Value="+421">Slovakia (+421)</asp:ListItem>
                                    <asp:ListItem Value="+386">Slovenia (+386)</asp:ListItem>
                                    <asp:ListItem Value="+677">Solomon Islands (+677)</asp:ListItem>
                                    <asp:ListItem Value="+27">South Africa (+27)</asp:ListItem>
                                    <asp:ListItem Value="+82">South Korea (+82)</asp:ListItem>
                                    <asp:ListItem Value="+34">Spain (+34)</asp:ListItem>
                                    <asp:ListItem Value="+94">Sri Lanka (+94)</asp:ListItem>
                                    <asp:ListItem Value="+597">Suriname (+597)</asp:ListItem>
                                    <asp:ListItem Value="+268">Swaziland (+268)</asp:ListItem>
                                    <asp:ListItem Value="+46">Sweden (+46)</asp:ListItem>
                                    <asp:ListItem Value="+41">Switzerland (+41)</asp:ListItem>
                                    <asp:ListItem Value="+886">Taiwan (+886)</asp:ListItem>
                                    <asp:ListItem Value="+992">Tajikistan (+992)</asp:ListItem>
                                    <asp:ListItem Value="+255">Tanzania (+255)</asp:ListItem>
                                    <asp:ListItem Value="+66">Thailand (+66)</asp:ListItem>
                                    <asp:ListItem Value="+228">Togo (+228)</asp:ListItem>
                                    <asp:ListItem Value="+690">Tokelau (+690)</asp:ListItem>
                                    <asp:ListItem Value="+676">Tonga (+676)</asp:ListItem>
                                    <asp:ListItem Value="+1868">Trinidad, Tobago (+1868)</asp:ListItem>
                                    <asp:ListItem Value="+216">Tunisia (+216)</asp:ListItem>
                                    <asp:ListItem Value="+90">Turkey (+90)</asp:ListItem>
                                    <asp:ListItem Value="+993">Turkmenistan (+993)</asp:ListItem>
                                    <asp:ListItem Value="+1649">Turks and Caicos (+1649)</asp:ListItem>
                                    <asp:ListItem Value="+688">Tuvalu (+688)</asp:ListItem>
                                    <asp:ListItem Value="+256">Uganda (+256)</asp:ListItem>
                                    <asp:ListItem Value="+380">Ukraine (+380)</asp:ListItem>
                                    <asp:ListItem Value="+971">United Arab Emirates (+971)</asp:ListItem>
                                    <asp:ListItem Value="+44" Selected="true">United Kingdom (+44)</asp:ListItem>
                                    <asp:ListItem Value="+1">United States (+1)</asp:ListItem>
                                    <asp:ListItem Value="+598">Uruguay (+598)</asp:ListItem>
                                    <asp:ListItem Value="+1">US Virgin Islands (+1)</asp:ListItem>
                                    <asp:ListItem Value="+998">Uzbekistan (+998)</asp:ListItem>
                                    <asp:ListItem Value="+678">Vanuatu (+678)</asp:ListItem>
                                    <asp:ListItem Value="+39">Vatican City State (+39)</asp:ListItem>
                                    <asp:ListItem Value="+58">Venezuela (+58)</asp:ListItem>
                                    <asp:ListItem Value="+84">Vietnam (+84)</asp:ListItem>
                                    <asp:ListItem Value="+681">Wallis and Futuna (+681)</asp:ListItem>
                                    <asp:ListItem Value="+967">Yemen (+967)</asp:ListItem>
                                    <asp:ListItem Value="+260">Zambia (+260)</asp:ListItem>
                                    <asp:ListItem Value="+263">Zimbabwe (+263)</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Mobile No:*</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtMobiUSD" runat="server" MaxLength="10" CssClass="NumberCss ComposeTxtBx"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="txtMobiUSD" runat="server" Display="Dynamic" ErrorMessage="Please Enter Valid 10 digit mobile number." ValidationExpression="\d+"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtMobiUSD" ErrorMessage="Please enter mobile no.">*</asp:RequiredFieldValidator>
                            </div>
                            <div class=" col-12">
                                <asp:Label ID="lblCheck" runat="server" Font-Size="13px" ForeColor="Red" Visible="False">Please select country..!</asp:Label>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Select country:</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:DropDownList ID="ddlcountry" runat="server" CssClass="ComposeTxtBx mrgbtm">
                                    <%--<asp:ListItem Value="--Select Country--">--Select Country--</asp:ListItem>--%>
                                    <asp:ListItem Value="231">Afghanistan</asp:ListItem>
                                    <asp:ListItem Value="244">&#197;land Islands</asp:ListItem>
                                    <asp:ListItem Value="230">Albania</asp:ListItem>
                                    <asp:ListItem Value="38">Algeria</asp:ListItem>
                                    <asp:ListItem Value="39">American Samoa</asp:ListItem>
                                    <asp:ListItem Value="40">Andorra</asp:ListItem>
                                    <asp:ListItem Value="41">Angola</asp:ListItem>
                                    <asp:ListItem Value="42">Anguilla</asp:ListItem>
                                    <asp:ListItem Value="232">Antarctica</asp:ListItem>
                                    <asp:ListItem Value="43">Antigua and Barbuda</asp:ListItem>
                                    <asp:ListItem Value="44">Argentina</asp:ListItem>
                                    <asp:ListItem Value="45">Armenia</asp:ListItem>
                                    <asp:ListItem Value="46">Aruba</asp:ListItem>
                                    <asp:ListItem Value="24">Australia</asp:ListItem>
                                    <asp:ListItem Value="2">Austria</asp:ListItem>
                                    <asp:ListItem Value="47">Azerbaijan</asp:ListItem>
                                    <asp:ListItem Value="48">Bahamas</asp:ListItem>
                                    <asp:ListItem Value="49">Bahrain</asp:ListItem>
                                    <asp:ListItem Value="50">Bangladesh</asp:ListItem>
                                    <asp:ListItem Value="51">Barbados</asp:ListItem>
                                    <asp:ListItem Value="52">Belarus</asp:ListItem>
                                    <asp:ListItem Value="3">Belgium</asp:ListItem>
                                    <asp:ListItem Value="53">Belize</asp:ListItem>
                                    <asp:ListItem Value="54">Benin</asp:ListItem>
                                    <asp:ListItem Value="55">Bermuda</asp:ListItem>
                                    <asp:ListItem Value="56">Bhutan</asp:ListItem>
                                    <asp:ListItem Value="34">Bolivia</asp:ListItem>
                                    <asp:ListItem Value="233">Bosnia and Herzegovina</asp:ListItem>
                                    <asp:ListItem Value="57">Botswana</asp:ListItem>
                                    <asp:ListItem Value="234">Bouvet Island</asp:ListItem>
                                    <asp:ListItem Value="58">Brazil</asp:ListItem>
                                    <asp:ListItem Value="235">British Indian Ocean Territory</asp:ListItem>
                                    <asp:ListItem Value="59">Brunei</asp:ListItem>
                                    <asp:ListItem Value="236">Bulgaria</asp:ListItem>
                                    <asp:ListItem Value="60">Burkina Faso</asp:ListItem>
                                    <asp:ListItem Value="61">Burma (Myanmar)</asp:ListItem>
                                    <asp:ListItem Value="62">Burundi</asp:ListItem>
                                    <asp:ListItem Value="63">Cambodia</asp:ListItem>
                                    <asp:ListItem Value="64">Cameroon</asp:ListItem>
                                    <asp:ListItem Value="4">Canada</asp:ListItem>
                                    <asp:ListItem Value="65">Cape Verde</asp:ListItem>
                                    <asp:ListItem Value="237">Cayman Islands</asp:ListItem>
                                    <asp:ListItem Value="66">Central African Republic</asp:ListItem>
                                    <asp:ListItem Value="67">Chad</asp:ListItem>
                                    <asp:ListItem Value="68">Chile</asp:ListItem>
                                    <asp:ListItem Value="5">China</asp:ListItem>
                                    <asp:ListItem Value="238">Christmas Island</asp:ListItem>
                                    <asp:ListItem Value="239">Cocos (Keeling) Islands</asp:ListItem>
                                    <asp:ListItem Value="69">Colombia</asp:ListItem>
                                    <asp:ListItem Value="70">Comoros</asp:ListItem>
                                    <asp:ListItem Value="71">Congo, Dem. Republic</asp:ListItem>
                                    <asp:ListItem Value="72">Congo, Republic</asp:ListItem>
                                    <asp:ListItem Value="240">Cook Islands</asp:ListItem>
                                    <asp:ListItem Value="73">Costa Rica</asp:ListItem>
                                    <asp:ListItem Value="74">Croatia</asp:ListItem>
                                    <asp:ListItem Value="75">Cuba</asp:ListItem>
                                    <asp:ListItem Value="76">Cyprus</asp:ListItem>
                                    <asp:ListItem Value="16">Czech Republic</asp:ListItem>
                                    <asp:ListItem Value="20">Denmark</asp:ListItem>
                                    <asp:ListItem Value="77">Djibouti</asp:ListItem>
                                    <asp:ListItem Value="78">Dominica</asp:ListItem>
                                    <asp:ListItem Value="79">Dominican Republic</asp:ListItem>
                                    <asp:ListItem Value="80">East Timor</asp:ListItem>
                                    <asp:ListItem Value="81">Ecuador</asp:ListItem>
                                    <asp:ListItem Value="82">Egypt</asp:ListItem>
                                    <asp:ListItem Value="83">El Salvador</asp:ListItem>
                                    <asp:ListItem Value="84">Equatorial Guinea</asp:ListItem>
                                    <asp:ListItem Value="85">Eritrea</asp:ListItem>
                                    <asp:ListItem Value="86">Estonia</asp:ListItem>
                                    <asp:ListItem Value="87">Ethiopia</asp:ListItem>
                                    <asp:ListItem Value="88">Falkland Islands</asp:ListItem>
                                    <asp:ListItem Value="89">Faroe Islands</asp:ListItem>
                                    <asp:ListItem Value="90">Fiji</asp:ListItem>
                                    <asp:ListItem Value="7">Finland</asp:ListItem>
                                    <asp:ListItem Value="8">France</asp:ListItem>
                                    <asp:ListItem Value="241">French Guiana</asp:ListItem>
                                    <asp:ListItem Value="242">French Polynesia</asp:ListItem>
                                    <asp:ListItem Value="243">French Southern Territories</asp:ListItem>
                                    <asp:ListItem Value="91">Gabon</asp:ListItem>
                                    <asp:ListItem Value="92">Gambia</asp:ListItem>
                                    <asp:ListItem Value="93">Georgia</asp:ListItem>
                                    <asp:ListItem Value="1">Germany</asp:ListItem>
                                    <asp:ListItem Value="94">Ghana</asp:ListItem>
                                    <asp:ListItem Value="97">Gibraltar</asp:ListItem>
                                    <asp:ListItem Value="9">Greece</asp:ListItem>
                                    <asp:ListItem Value="96">Greenland</asp:ListItem>
                                    <asp:ListItem Value="95">Grenada</asp:ListItem>
                                    <asp:ListItem Value="98">Guadeloupe</asp:ListItem>
                                    <asp:ListItem Value="99">Guam</asp:ListItem>
                                    <asp:ListItem Value="100">Guatemala</asp:ListItem>
                                    <asp:ListItem Value="101">Guernsey</asp:ListItem>
                                    <asp:ListItem Value="102">Guinea</asp:ListItem>
                                    <asp:ListItem Value="103">Guinea-Bissau</asp:ListItem>
                                    <asp:ListItem Value="104">Guyana</asp:ListItem>
                                    <asp:ListItem Value="105">Haiti</asp:ListItem>
                                    <asp:ListItem Value="106">Heard Island and McDonald Islands</asp:ListItem>
                                    <asp:ListItem Value="108">Honduras</asp:ListItem>
                                    <asp:ListItem Value="22">HongKong</asp:ListItem>
                                    <asp:ListItem Value="143">Hungary</asp:ListItem>
                                    <asp:ListItem Value="109">Iceland</asp:ListItem>
                                    <asp:ListItem Value="111">Indonesia</asp:ListItem>
                                    <asp:ListItem Value="110">India</asp:ListItem>
                                    <asp:ListItem Value="112">Iran</asp:ListItem>
                                    <asp:ListItem Value="113">Iraq</asp:ListItem>
                                    <asp:ListItem Value="26">Ireland</asp:ListItem>
                                    <asp:ListItem Value="29">Israel</asp:ListItem>
                                    <asp:ListItem Value="10">Italy</asp:ListItem>
                                    <asp:ListItem Value="32">Ivory Coast</asp:ListItem>
                                    <asp:ListItem Value="115">Jamaica</asp:ListItem>
                                    <asp:ListItem Value="11">Japan</asp:ListItem>
                                    <asp:ListItem Value="116">Jersey</asp:ListItem>
                                    <asp:ListItem Value="117">Jordan</asp:ListItem>
                                    <asp:ListItem Value="118">Kazakhstan</asp:ListItem>
                                    <asp:ListItem Value="119">Kenya</asp:ListItem>
                                    <asp:ListItem Value="120">Kiribati</asp:ListItem>
                                    <asp:ListItem Value="121">Korea, Dem. Republic of</asp:ListItem>
                                    <asp:ListItem Value="122">Kuwait</asp:ListItem>
                                    <asp:ListItem Value="123">Kyrgyzstan</asp:ListItem>
                                    <asp:ListItem Value="124">Laos</asp:ListItem>
                                    <asp:ListItem Value="125">Latvia</asp:ListItem>
                                    <asp:ListItem Value="126">Lebanon</asp:ListItem>
                                    <asp:ListItem Value="127">Lesotho</asp:ListItem>
                                    <asp:ListItem Value="128">Liberia</asp:ListItem>
                                    <asp:ListItem Value="129">Libya</asp:ListItem>
                                    <asp:ListItem Value="130">Liechtenstein</asp:ListItem>
                                    <asp:ListItem Value="131">Lithuania</asp:ListItem>
                                    <asp:ListItem Value="12">Luxemburg</asp:ListItem>
                                    <asp:ListItem Value="132">Macau</asp:ListItem>
                                    <asp:ListItem Value="133">Macedonia</asp:ListItem>
                                    <asp:ListItem Value="134">Madagascar</asp:ListItem>
                                    <asp:ListItem Value="135">Malawi</asp:ListItem>
                                    <asp:ListItem Value="136">Malaysia</asp:ListItem>
                                    <asp:ListItem Value="137">Maldives</asp:ListItem>
                                    <asp:ListItem Value="138">Mali</asp:ListItem>
                                    <asp:ListItem Value="139">Malta</asp:ListItem>
                                    <asp:ListItem Value="114">Man Island</asp:ListItem>
                                    <asp:ListItem Value="140">Marshall Islands</asp:ListItem>
                                    <asp:ListItem Value="141">Martinique</asp:ListItem>
                                    <asp:ListItem Value="142">Mauritania</asp:ListItem>
                                    <asp:ListItem Value="35">Mauritius</asp:ListItem>
                                    <asp:ListItem Value="144">Mayotte</asp:ListItem>
                                    <asp:ListItem Value="145">Mexico</asp:ListItem>
                                    <asp:ListItem Value="146">Micronesia</asp:ListItem>
                                    <asp:ListItem Value="147">Moldova</asp:ListItem>
                                    <asp:ListItem Value="148">Monaco</asp:ListItem>
                                    <asp:ListItem Value="149">Mongolia</asp:ListItem>
                                    <asp:ListItem Value="150">Montenegro</asp:ListItem>
                                    <asp:ListItem Value="151">Montserrat</asp:ListItem>
                                    <asp:ListItem Value="152">Morocco</asp:ListItem>
                                    <asp:ListItem Value="153">Mozambique</asp:ListItem>
                                    <asp:ListItem Value="154">Namibia</asp:ListItem>
                                    <asp:ListItem Value="155">Nauru</asp:ListItem>
                                    <asp:ListItem Value="156">Nepal</asp:ListItem>
                                    <asp:ListItem Value="13">Netherlands</asp:ListItem>
                                    <asp:ListItem Value="157">Netherlands Antilles</asp:ListItem>
                                    <asp:ListItem Value="158">New Caledonia</asp:ListItem>
                                    <asp:ListItem Value="27">New Zealand</asp:ListItem>
                                    <asp:ListItem Value="159">Nicaragua</asp:ListItem>
                                    <asp:ListItem Value="160">Niger</asp:ListItem>
                                    <asp:ListItem Value="31">Nigeria</asp:ListItem>
                                    <asp:ListItem Value="161">Niue</asp:ListItem>
                                    <asp:ListItem Value="162">Norfolk Island</asp:ListItem>
                                    <asp:ListItem Value="163">Northern Mariana Islands</asp:ListItem>
                                    <asp:ListItem Value="23">Norway</asp:ListItem>
                                    <asp:ListItem Value="164">Oman</asp:ListItem>
                                    <asp:ListItem Value="165">Pakistan</asp:ListItem>
                                    <asp:ListItem Value="166">Palau</asp:ListItem>
                                    <asp:ListItem Value="167">Palestinian Territories</asp:ListItem>
                                    <asp:ListItem Value="168">Panama</asp:ListItem>
                                    <asp:ListItem Value="169">Papua New Guinea</asp:ListItem>
                                    <asp:ListItem Value="170">Paraguay</asp:ListItem>
                                    <asp:ListItem Value="171">Peru</asp:ListItem>
                                    <asp:ListItem Value="172">Philippines</asp:ListItem>
                                    <asp:ListItem Value="173">Pitcairn</asp:ListItem>
                                    <asp:ListItem Value="14">Poland</asp:ListItem>
                                    <asp:ListItem Value="15">Portugal</asp:ListItem>
                                    <asp:ListItem Value="174">Puerto Rico</asp:ListItem>
                                    <asp:ListItem Value="175">Qatar</asp:ListItem>
                                    <asp:ListItem Value="176">Reunion Island</asp:ListItem>
                                    <asp:ListItem Value="36">Romania</asp:ListItem>
                                    <asp:ListItem Value="177">Russian Federation</asp:ListItem>
                                    <asp:ListItem Value="178">Rwanda</asp:ListItem>
                                    <asp:ListItem Value="179">Saint Barthelemy</asp:ListItem>
                                    <asp:ListItem Value="180">Saint Kitts and Nevis</asp:ListItem>
                                    <asp:ListItem Value="181">Saint Lucia</asp:ListItem>
                                    <asp:ListItem Value="182">Saint Martin</asp:ListItem>
                                    <asp:ListItem Value="183">Saint Pierre and Miquelon</asp:ListItem>
                                    <asp:ListItem Value="184">Saint Vincent and the Grenadines</asp:ListItem>
                                    <asp:ListItem Value="185">Samoa</asp:ListItem>
                                    <asp:ListItem Value="186">San Marino</asp:ListItem>
                                    <asp:ListItem Value="187">S&#227;o Tom&#233; and Pr&#237;ncipe</asp:ListItem>
                                    <asp:ListItem Value="188">Saudi Arabia</asp:ListItem>
                                    <asp:ListItem Value="189">Senegal</asp:ListItem>
                                    <asp:ListItem Value="190">Serbia</asp:ListItem>
                                    <asp:ListItem Value="191">Seychelles</asp:ListItem>
                                    <asp:ListItem Value="192">Sierra Leone</asp:ListItem>
                                    <asp:ListItem Value="25">Singapore</asp:ListItem>
                                    <asp:ListItem Value="37">Slovakia</asp:ListItem>
                                    <asp:ListItem Value="193">Slovenia</asp:ListItem>
                                    <asp:ListItem Value="194">Solomon Islands</asp:ListItem>
                                    <asp:ListItem Value="195">Somalia</asp:ListItem>
                                    <asp:ListItem Value="30">South Africa</asp:ListItem>
                                    <asp:ListItem Value="196">South Georgia and the South Sandwich Islands</asp:ListItem>
                                    <asp:ListItem Value="28">South Korea</asp:ListItem>
                                    <asp:ListItem Value="6">Spain</asp:ListItem>
                                    <asp:ListItem Value="197">Sri Lanka</asp:ListItem>
                                    <asp:ListItem Value="198">Sudan</asp:ListItem>
                                    <asp:ListItem Value="199">Suriname</asp:ListItem>
                                    <asp:ListItem Value="200">Svalbard and Jan Mayen</asp:ListItem>
                                    <asp:ListItem Value="201">Swaziland</asp:ListItem>
                                    <asp:ListItem Value="18">Sweden</asp:ListItem>
                                    <asp:ListItem Value="19">Switzerland</asp:ListItem>
                                    <asp:ListItem Value="202">Syria</asp:ListItem>
                                    <asp:ListItem Value="203">Taiwan</asp:ListItem>
                                    <asp:ListItem Value="204">Tajikistan</asp:ListItem>
                                    <asp:ListItem Value="205">Tanzania</asp:ListItem>
                                    <asp:ListItem Value="206">Thailand</asp:ListItem>
                                    <asp:ListItem Value="33">Togo</asp:ListItem>
                                    <asp:ListItem Value="207">Tokelau</asp:ListItem>
                                    <asp:ListItem Value="208">Tonga</asp:ListItem>
                                    <asp:ListItem Value="209">Trinidad and Tobago</asp:ListItem>
                                    <asp:ListItem Value="210">Tunisia</asp:ListItem>
                                    <asp:ListItem Value="211">Turkey</asp:ListItem>
                                    <asp:ListItem Value="212">Turkmenistan</asp:ListItem>
                                    <asp:ListItem Value="213">Turks and Caicos Islands</asp:ListItem>
                                    <asp:ListItem Value="214">Tuvalu</asp:ListItem>
                                    <asp:ListItem Value="215">Uganda</asp:ListItem>
                                    <asp:ListItem Value="216">Ukraine</asp:ListItem>
                                    <asp:ListItem Value="217">United Arab Emirates</asp:ListItem>
                                    <asp:ListItem Value="17" Selected="True">United Kingdom</asp:ListItem>
                                    <asp:ListItem Value="21">United States</asp:ListItem>
                                    <asp:ListItem Value="218">Uruguay</asp:ListItem>
                                    <asp:ListItem Value="219">Uzbekistan</asp:ListItem>
                                    <asp:ListItem Value="220">Vanuatu</asp:ListItem>
                                    <asp:ListItem Value="107">Vatican City State</asp:ListItem>
                                    <asp:ListItem Value="221">Venezuela</asp:ListItem>
                                    <asp:ListItem Value="222">Vietnam</asp:ListItem>
                                    <asp:ListItem Value="223">Virgin Islands (British)</asp:ListItem>
                                    <asp:ListItem Value="224">Virgin Islands (U.S.)</asp:ListItem>
                                    <asp:ListItem Value="225">Wallis and Futuna</asp:ListItem>
                                    <asp:ListItem Value="226">Western Sahara</asp:ListItem>
                                    <asp:ListItem Value="227">Yemen</asp:ListItem>
                                    <asp:ListItem Value="228">Zambia</asp:ListItem>
                                    <asp:ListItem Value="229">Zimbabwe</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>State:</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:DropDownList ID="txtState" runat="server" CssClass="ComposeTxtBx mrgbtm">
                                    <asp:ListItem>Andhra Pradesh</asp:ListItem>
                                    <asp:ListItem>Arunachal Pradesh</asp:ListItem>
                                    <asp:ListItem>Assam</asp:ListItem>
                                    <asp:ListItem>Bihar</asp:ListItem>
                                    <asp:ListItem>Chhattisgarh</asp:ListItem>
                                    <asp:ListItem>Goa</asp:ListItem>
                                    <asp:ListItem>Gujarat </asp:ListItem>
                                    <asp:ListItem>Haryana</asp:ListItem>
                                    <asp:ListItem>Himachal Pradesh</asp:ListItem>
                                    <asp:ListItem>Jammu and Kashmir</asp:ListItem>
                                    <asp:ListItem>Jharkhand</asp:ListItem>
                                    <asp:ListItem>Karnataka</asp:ListItem>
                                    <asp:ListItem>Kerala</asp:ListItem>
                                    <asp:ListItem>Madhya Pradesh</asp:ListItem>
                                    <asp:ListItem>Maharashtra</asp:ListItem>
                                    <asp:ListItem>Manipur</asp:ListItem>
                                    <asp:ListItem>Meghalaya</asp:ListItem>
                                    <asp:ListItem>Mizoram</asp:ListItem>
                                    <asp:ListItem>Nagaland</asp:ListItem>
                                    <asp:ListItem>Odisha</asp:ListItem>
                                    <asp:ListItem>Punjab</asp:ListItem>
                                    <asp:ListItem>Rajasthan</asp:ListItem>
                                    <asp:ListItem>Sikkim</asp:ListItem>
                                    <asp:ListItem>Tamil Nadu</asp:ListItem>
                                    <asp:ListItem>Telangana</asp:ListItem>
                                    <asp:ListItem>Tripura</asp:ListItem>
                                    <asp:ListItem>Uttar Pradesh</asp:ListItem>
                                    <asp:ListItem>Uttarakhand</asp:ListItem>
                                    <asp:ListItem>West Bengal</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>City:</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtCity" runat="server" MaxLength="50" CssClass="ComposeTxtBx mrgbtm"></asp:TextBox>
                            </div>
                            <div class="col-md-2 col-12">
                                <label>Pin Code:</label>
                            </div>
                            <div class="col-md-4 col-12">
                                <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6" CssClass="ComposeTxtBx"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="txtPinCode" ErrorMessage="Enter Only PinCode" Operator="GreaterThan" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-9 offset-md-2 col-12">
                                <asp:Button ID="btnSubmit" runat="server" Text="Save Continue" CssClass="OuterBtn" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-12">
                                <h6 class="BoderHading">Change Password</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="chngpwd">
                                    <div class="row">
                                        <div class="col-md-12 col-12">
                                            <label>Old Login Pw:</label>
                                            <asp:TextBox ID="txtLoginOldPass" runat="server" MaxLength="25" Enabled="false" BackColor="#dddddd" CssClass="ComposeTxtBx mrgbtm"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-12">
                                            <label>New Login Pw:</label>
                                            <asp:TextBox ID="txtLoginNewPass" runat="server" MaxLength="25" class="ComposeTxtBx mrgbtm"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-12">
                                            <asp:Button ID="btnloginPass" runat="server" Text="Save Login Password" CssClass="OuterBtn chngpwbtn" ValidationGroup="pl" OnClick="btnloginPass_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-12">
                                <div class="chngpwd">
                                    <div class="row">
                                        <div class="col-md-12 col-12">
                                            <label>Old Txn Pw:</label>
                                            <asp:TextBox ID="txtTransOldPassword" runat="server" MaxLength="25" Enabled="false" BackColor="#dddddd" CssClass="ComposeTxtBx mrgbtm"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-12">
                                            <label>New Txn Pw:</label>
                                            <asp:TextBox ID="txtTransNewpass" runat="server" MaxLength="25" class="ComposeTxtBx mrgbtm"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12 col-12">
                                            <asp:Button ID="btnTransPass" runat="server" Text="Save Transaction Password" CssClass="OuterBtn chngpwbtn" ValidationGroup="pt" OnClick="btnTransPass_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="MyCnt" style="display: none;">
        <center>
            <table cellpadding="0" cellspacing="0" class="MtblCntReg">
                <tr>
                    <%--<td class="lbl">
                        <a href="javascript:history.back();" class="OuterBtn"><< Go Back</a>
                    </td>--%>
                    <%--<td colspan="2" class="lbl">&nbsp;&nbsp;&nbsp;<b>Search Member By ID</b>
                        <br />
                        <asp:TextBox ID="txtSearchbyMemberID" runat="server" Width="200px" AutoComplete="Off"></asp:TextBox>
                        <asp:Button ID="btnSearchMember" runat="server" Text="GO" CssClass="OuterBtn" OnClick="btnSearchMember_Click" />
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl" colspan="3">
                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>--%>
                </tr>
                <%--<tr>
                    <td colspan="2" class="BoderHading">Personal information</td>
                </tr>--%>
                <tr>
                    <td class="lbl"></td>
                    <td colspan="2" class="lbl"></td>
                </tr>
                <tr>
                    <%--<td class="lbl">Name:*<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFirstName" ErrorMessage="Please enter first name.">*</asp:RequiredFieldValidator></td>--%>
                    <%--<td class="lbl" colspan="2">Date of Birth:*</td>--%>
                </tr>
                <tr>
                    <%--<td>
                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="150"></asp:TextBox>
                    </td>--%>
                    <%--<td colspan="2">&nbsp;<asp:TextBox ID="txtDOB" runat="server" MaxLength="10"></asp:TextBox>
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/UserPanel_Images/cal.png" />
                        <asp:Label ID="lblDOB" runat="server" Font-Bold="True" Visible="False"></asp:Label>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtDOB" ErrorMessage="Please Enter Correct DOB" MaximumValue="31/12/2050" MinimumValue="01/01/1920" SetFocusOnError="True">*</asp:RangeValidator>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl">
                        Email:*
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailid" ErrorMessage="Enter Correct MailId." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmailid" ErrorMessage="Please enter email address.">*</asp:RequiredFieldValidator>
                    </td>--%>
                    <%--<td class="lbl" colspan="2">Gender:</td>--%>
                </tr>
                <tr>
                    <%--<td>
                        <asp:TextBox ID="txtEmailid" runat="server" MaxLength="50"></asp:TextBox>
                    </td>--%>
                    <%--<td colspan="2" class="lbl">
                        <asp:RadioButtonList ID="rdgender" runat="server" CellPadding="0" CellSpacing="0"
                            RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="0">Male</asp:ListItem>
                            <asp:ListItem Value="1">Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl">Country Code:*</td>--%>
                    <%--<td class="lbl" colspan="2">Mobile No:*<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtMobiUSD" Display="Dynamic" ErrorMessage="Please Enter Valid 10 digit mobile number." ValidationExpression="^[\s\S]{10,10}$">*</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtMobiUSD" ErrorMessage="Please enter mobile no.">*</asp:RequiredFieldValidator>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td style="padding-left: 10px;">
                        <asp:DropDownList ID="ddlCountryCode" runat="server" Width="248px">
                            <asp:ListItem Value="+93">Afghanistan (+93)</asp:ListItem>
                            <asp:ListItem Value="+355">Albania (+355)</asp:ListItem>
                            <asp:ListItem Value="+213">Algeria (+213)</asp:ListItem>
                            <asp:ListItem Value="+1">American Samoa (+1)</asp:ListItem>
                            <asp:ListItem Value="+376">Andorra (+376)</asp:ListItem>
                            <asp:ListItem Value="+244">Angola (+244)</asp:ListItem>
                            <asp:ListItem Value="+1">Anguilla (+1)</asp:ListItem>
                            <asp:ListItem Value="+672">Antarctica (+672)</asp:ListItem>
                            <asp:ListItem Value="+1268">Antigua, Barbuda (+1268)</asp:ListItem>
                            <asp:ListItem Value="+54">Argentina (+54)</asp:ListItem>
                            <asp:ListItem Value="+374">Armenia (+374)</asp:ListItem>
                            <asp:ListItem Value="+297">Aruba (+297)</asp:ListItem>
                            <asp:ListItem Value="+247">Ascension (+247)</asp:ListItem>
                            <asp:ListItem Value="+61">Australia (+61)</asp:ListItem>
                            <asp:ListItem Value="+43">Austria (+43)</asp:ListItem>
                            <asp:ListItem Value="+994">Azerbaijan (+994)</asp:ListItem>
                            <asp:ListItem Value="+1">Bahamas (+1)</asp:ListItem>
                            <asp:ListItem Value="+973">Bahrain (+973)</asp:ListItem>
                            <asp:ListItem Value="+880">Bangladesh (+880)</asp:ListItem>
                            <asp:ListItem Value="+1">Barbados (+1)</asp:ListItem>
                            <asp:ListItem Value="+375">Belarus (+375)</asp:ListItem>
                            <asp:ListItem Value="+32">Belgium (+32)</asp:ListItem>
                            <asp:ListItem Value="+501">Belize (+501)</asp:ListItem>
                            <asp:ListItem Value="+229">Benin (+229)</asp:ListItem>
                            <asp:ListItem Value="+1441">Bermuda (+1441)</asp:ListItem>
                            <asp:ListItem Value="+975">Bhutan (+975)</asp:ListItem>
                            <asp:ListItem Value="+591">Bolivia (+591)</asp:ListItem>
                            <asp:ListItem Value="+387">Bosnia &amp; Herzegovina (+387)</asp:ListItem>
                            <asp:ListItem Value="+267">Botswana (+267)</asp:ListItem>
                            <asp:ListItem Value="+55">Brazil (+55)</asp:ListItem>
                            <asp:ListItem Value="+1">British Virgin Islands (+1)</asp:ListItem>
                            <asp:ListItem Value="+673">Brunei Darussalam (+673)</asp:ListItem>
                            <asp:ListItem Value="+359">Bulgaria (+359)</asp:ListItem>
                            <asp:ListItem Value="+226">Burkina Faso (+226)</asp:ListItem>
                            <asp:ListItem Value="+257">Burundi (+257)</asp:ListItem>
                            <asp:ListItem Value="+855">Cambodia (+855)</asp:ListItem>
                            <asp:ListItem Value="+237">Cameroon (+237)</asp:ListItem>
                            <asp:ListItem Value="+1">Canada (+1)</asp:ListItem>
                            <asp:ListItem Value="+238">Cape Verde (+238)</asp:ListItem>
                            <asp:ListItem Value="+1345">Cayman Islands (+1345)</asp:ListItem>
                            <asp:ListItem Value="+236">Central African Republic (+236)</asp:ListItem>
                            <asp:ListItem Value="+235">Chad (+235)</asp:ListItem>
                            <asp:ListItem Value="+56">Chile (+56)</asp:ListItem>
                            <asp:ListItem Value="+86">China (+86)</asp:ListItem>
                            <asp:ListItem Value="+57">Colombia (+57)</asp:ListItem>
                            <asp:ListItem Value="+269">Comoros (+269)</asp:ListItem>
                            <asp:ListItem Value="+682">Cook Islands (+682)</asp:ListItem>
                            <asp:ListItem Value="+506">Costa Rica (+506)</asp:ListItem>
                            <asp:ListItem Value="+385">Croatia (+385)</asp:ListItem>
                            <asp:ListItem Value="+357">Cyprus (+357)</asp:ListItem>
                            <asp:ListItem Value="+420">Czech Republic (+420)</asp:ListItem>
                            <asp:ListItem Value="+45">Denmark (+45)</asp:ListItem>
                            <asp:ListItem Value="+246">Diego Garcia (+246)</asp:ListItem>
                            <asp:ListItem Value="+253">Djibouti (+253)</asp:ListItem>
                            <asp:ListItem Value="+1767">Dominica (+1767)</asp:ListItem>
                            <asp:ListItem Value="+1806">Dominican Republic (+1806)</asp:ListItem>
                            <asp:ListItem Value="+670">East Timor (+670)</asp:ListItem>
                            <asp:ListItem Value="+593">Ecuador (+593)</asp:ListItem>
                            <asp:ListItem Value="+20">Egypt (+20)</asp:ListItem>
                            <asp:ListItem Value="+503">El Salvador (+503)</asp:ListItem>
                            <asp:ListItem Value="+240">Equatorial Guinea (+240)</asp:ListItem>
                            <asp:ListItem Value="+291">Eritrea (+291)</asp:ListItem>
                            <asp:ListItem Value="+372">Estonia (+372)</asp:ListItem>
                            <asp:ListItem Value="+251">Ethiopia (+251)</asp:ListItem>
                            <asp:ListItem Value="+500">Falkland Islands (+500)</asp:ListItem>
                            <asp:ListItem Value="+298">Faroe Islands (+298)</asp:ListItem>
                            <asp:ListItem Value="+679">Fiji Islands (+679)</asp:ListItem>
                            <asp:ListItem Value="+358">Finland (+358)</asp:ListItem>
                            <asp:ListItem Value="+33">France (+33)</asp:ListItem>
                            <asp:ListItem Value="+262">French Dept/Terr in Indian Ocean (+262)</asp:ListItem>
                            <asp:ListItem Value="+594">French Guiana (+594)</asp:ListItem>
                            <asp:ListItem Value="+689">French Polynesia (+689)</asp:ListItem>
                            <asp:ListItem Value="+241">Gabon (+241)</asp:ListItem>
                            <asp:ListItem Value="+220">Gambia (+220)</asp:ListItem>
                            <asp:ListItem Value="+995">Georgia (+995)</asp:ListItem>
                            <asp:ListItem Value="+49">Germany (+49)</asp:ListItem>
                            <asp:ListItem Value="+233">Ghana (+233)</asp:ListItem>
                            <asp:ListItem Value="+350">Gibraltar (+350)</asp:ListItem>
                            <asp:ListItem Value="+30">Greece (+30)</asp:ListItem>
                            <asp:ListItem Value="+299">Greenland (+299)</asp:ListItem>
                            <asp:ListItem Value="+1473">Grenada (+1473)</asp:ListItem>
                            <asp:ListItem Value="+590">Guadeloupe (+590)</asp:ListItem>
                            <asp:ListItem Value="+1">Guam (+1)</asp:ListItem>
                            <asp:ListItem Value="+502">Guatemala (+502)</asp:ListItem>
                            <asp:ListItem Value="+224">Guinea (+224)</asp:ListItem>
                            <asp:ListItem Value="+245">Guinea-Bissau (+245)</asp:ListItem>
                            <asp:ListItem Value="+592">Guyana (+592)</asp:ListItem>
                            <asp:ListItem Value="+509">Haiti (+509)</asp:ListItem>
                            <asp:ListItem Value="+504">Honduras (+504)</asp:ListItem>
                            <asp:ListItem Value="+852">Hong Kong (+852)</asp:ListItem>
                            <asp:ListItem Value="+36">Hungary (+36)</asp:ListItem>
                            <asp:ListItem Value="+354">Iceland (+354)</asp:ListItem>
                            <asp:ListItem Value="+91">India (+91)</asp:ListItem>
                            <asp:ListItem Value="+62">Indonesia (+62)</asp:ListItem>
                            <asp:ListItem Value="+964">Iraq (+964)</asp:ListItem>
                            <asp:ListItem Value="+353">Ireland (+353)</asp:ListItem>
                            <asp:ListItem Value="+972">Israel (+972)</asp:ListItem>
                            <asp:ListItem Value="+39">Italy (+39)</asp:ListItem>
                            <asp:ListItem Value="+1876">Jamaica (+1876)</asp:ListItem>
                            <asp:ListItem Value="+81">Japan (+81)</asp:ListItem>
                            <asp:ListItem Value="++962">Jordan (+962)</asp:ListItem>
                            <asp:ListItem Value="+254">Kenya (+254)</asp:ListItem>
                            <asp:ListItem Value="+686">Kiribati (+686)</asp:ListItem>
                            <asp:ListItem Value="+965">Kuwait (+965)</asp:ListItem>
                            <asp:ListItem Value="+996">Kyrgyzstan (+996)</asp:ListItem>
                            <asp:ListItem Value="+856">Laos (+856)</asp:ListItem>
                            <asp:ListItem Value="+371">Latvia (+371)</asp:ListItem>
                            <asp:ListItem Value="+961">Lebanon (+961)</asp:ListItem>
                            <asp:ListItem Value="+266">Lesotho (+266)</asp:ListItem>
                            <asp:ListItem Value="+231">Liberia (+231)</asp:ListItem>
                            <asp:ListItem Value="+423">Liechtenstein (+423)</asp:ListItem>
                            <asp:ListItem Value="+370">Lithuania (+370)</asp:ListItem>
                            <asp:ListItem Value="+352">Luxembourg (+352)</asp:ListItem>
                            <asp:ListItem Value="+853">Macau (+853)</asp:ListItem>
                            <asp:ListItem Value="+389">Macedonia (+389)</asp:ListItem>
                            <asp:ListItem Value="+261">Madagascar (+261)</asp:ListItem>
                            <asp:ListItem Value="+265">Malawi (+265)</asp:ListItem>
                            <asp:ListItem Value="+60">Malaysia (+60)</asp:ListItem>
                            <asp:ListItem Value="+960">Maldives (+960)</asp:ListItem>
                            <asp:ListItem Value="+223">Mali (+223)</asp:ListItem>
                            <asp:ListItem Value="+356">Malta (+356)</asp:ListItem>
                            <asp:ListItem Value="+692">Marshall Islands (+692)</asp:ListItem>
                            <asp:ListItem Value="+596">Martinique (+596)</asp:ListItem>
                            <asp:ListItem Value="+222">Mauritania (+222)</asp:ListItem>
                            <asp:ListItem Value="+230">Mauritius (+230)</asp:ListItem>
                            <asp:ListItem Value="+52">Mexico (+52)</asp:ListItem>
                            <asp:ListItem Value="+691">Micronesia (+691)</asp:ListItem>
                            <asp:ListItem Value="+373">Moldova (+373)</asp:ListItem>
                            <asp:ListItem Value="+377">Monaco (+377)</asp:ListItem>
                            <asp:ListItem Value="+976">Mongolia (+976)</asp:ListItem>
                            <asp:ListItem Value="+382">Montenegro (+382)</asp:ListItem>
                            <asp:ListItem Value="+1664">Montserrat (+1664)</asp:ListItem>
                            <asp:ListItem Value="+212">Morocco (+212)</asp:ListItem>
                            <asp:ListItem Value="+258">Mozambique (+258)</asp:ListItem>
                            <asp:ListItem Value="+264">Namibia (+264)</asp:ListItem>
                            <asp:ListItem Value="+674">Nauru (+674)</asp:ListItem>
                            <asp:ListItem Value="+977">Nepal (+977)</asp:ListItem>
                            <asp:ListItem Value="+31">Netherlands (+31)</asp:ListItem>
                            <asp:ListItem Value="+599">Netherlands Antilles (+599)</asp:ListItem>
                            <asp:ListItem Value="+687">New Caledonia (+687)</asp:ListItem>
                            <asp:ListItem Value="+64">New Zealand (+64)</asp:ListItem>
                            <asp:ListItem Value="+505">Nicaragua (+505)</asp:ListItem>
                            <asp:ListItem Value="+227">Niger (+227)</asp:ListItem>
                            <asp:ListItem Value="+234">Nigeria (+234)</asp:ListItem>
                            <asp:ListItem Value="+683">Niue (+683)</asp:ListItem>
                            <asp:ListItem Value="+1">Northern Mariana Islands (+1)</asp:ListItem>
                            <asp:ListItem Value="+47">Norway (+47)</asp:ListItem>
                            <asp:ListItem Value="+968">Oman (+968)</asp:ListItem>
                            <asp:ListItem Value="+92">Pakistan (+92)</asp:ListItem>
                            <asp:ListItem Value="+680">Palau (+680)</asp:ListItem>
                            <asp:ListItem Value="+507">Panama (+507)</asp:ListItem>
                            <asp:ListItem Value="+675">Papua New Guinea (+675)</asp:ListItem>
                            <asp:ListItem Value="+595">Paraguay (+595)</asp:ListItem>
                            <asp:ListItem Value="+51">Peru (+51)</asp:ListItem>
                            <asp:ListItem Value="+63">Philippines (+63)</asp:ListItem>
                            <asp:ListItem Value="+48">Poland (+48)</asp:ListItem>
                            <asp:ListItem Value="+351">Portugal (+351)</asp:ListItem>
                            <asp:ListItem Value="+1">Puerto Rico (+1)</asp:ListItem>
                            <asp:ListItem Value="+974">Qatar (+974)</asp:ListItem>
                            <asp:ListItem Value="+262">Reunion (+262)</asp:ListItem>
                            <asp:ListItem Value="+40">Romania (+40)</asp:ListItem>
                            <asp:ListItem Value="+7">Russia (+7)</asp:ListItem>
                            <asp:ListItem Value="+250">Rwanda (+250)</asp:ListItem>
                            <asp:ListItem Value="+290">Saint Helena (+290)</asp:ListItem>
                            <asp:ListItem Value="+1">Saint Kitts and Nevis (+1)</asp:ListItem>
                            <asp:ListItem Value="+1758">Saint Lucia (+1758)</asp:ListItem>
                            <asp:ListItem Value="+508">Saint Pierre and Miquelon (+508)</asp:ListItem>
                            <asp:ListItem Value="+1">Saint Vincent and the Grenadines (+1)</asp:ListItem>
                            <asp:ListItem Value="+685">Samoa (+685)</asp:ListItem>
                            <asp:ListItem Value="+378">San Marino (+378)</asp:ListItem>
                            <asp:ListItem Value="+239">Sao Tome and Principe (+239)</asp:ListItem>
                            <asp:ListItem Value="+966">Saudi Arabia (+966)</asp:ListItem>
                            <asp:ListItem Value="+221">Senegal (+221)</asp:ListItem>
                            <asp:ListItem Value="+381">Serbia (+381)</asp:ListItem>
                            <asp:ListItem Value="+248">Seychelles (+248)</asp:ListItem>
                            <asp:ListItem Value="+232">Sierra Leone (+232)</asp:ListItem>
                            <asp:ListItem Value="+65">Singapore (+65)</asp:ListItem>
                            <asp:ListItem Value="+421">Slovakia (+421)</asp:ListItem>
                            <asp:ListItem Value="+386">Slovenia (+386)</asp:ListItem>
                            <asp:ListItem Value="+677">Solomon Islands (+677)</asp:ListItem>
                            <asp:ListItem Value="+27">South Africa (+27)</asp:ListItem>
                            <asp:ListItem Value="+82">South Korea (+82)</asp:ListItem>
                            <asp:ListItem Value="+34">Spain (+34)</asp:ListItem>
                            <asp:ListItem Value="+94">Sri Lanka (+94)</asp:ListItem>
                            <asp:ListItem Value="+597">Suriname (+597)</asp:ListItem>
                            <asp:ListItem Value="+268">Swaziland (+268)</asp:ListItem>
                            <asp:ListItem Value="+46">Sweden (+46)</asp:ListItem>
                            <asp:ListItem Value="+41">Switzerland (+41)</asp:ListItem>
                            <asp:ListItem Value="+886">Taiwan (+886)</asp:ListItem>
                            <asp:ListItem Value="+992">Tajikistan (+992)</asp:ListItem>
                            <asp:ListItem Value="+255">Tanzania (+255)</asp:ListItem>
                            <asp:ListItem Value="+66">Thailand (+66)</asp:ListItem>
                            <asp:ListItem Value="+228">Togo (+228)</asp:ListItem>
                            <asp:ListItem Value="+690">Tokelau (+690)</asp:ListItem>
                            <asp:ListItem Value="+676">Tonga (+676)</asp:ListItem>
                            <asp:ListItem Value="+1868">Trinidad, Tobago (+1868)</asp:ListItem>
                            <asp:ListItem Value="+216">Tunisia (+216)</asp:ListItem>
                            <asp:ListItem Value="+90">Turkey (+90)</asp:ListItem>
                            <asp:ListItem Value="+993">Turkmenistan (+993)</asp:ListItem>
                            <asp:ListItem Value="+1649">Turks and Caicos (+1649)</asp:ListItem>
                            <asp:ListItem Value="+688">Tuvalu (+688)</asp:ListItem>
                            <asp:ListItem Value="+256">Uganda (+256)</asp:ListItem>
                            <asp:ListItem Value="+380">Ukraine (+380)</asp:ListItem>
                            <asp:ListItem Value="+971">United Arab Emirates (+971)</asp:ListItem>
                            <asp:ListItem Value="+44" Selected="true">United Kingdom (+44)</asp:ListItem>
                            <asp:ListItem Value="+1">United States (+1)</asp:ListItem>
                            <asp:ListItem Value="+598">Uruguay (+598)</asp:ListItem>
                            <asp:ListItem Value="+1">US Virgin Islands (+1)</asp:ListItem>
                            <asp:ListItem Value="+998">Uzbekistan (+998)</asp:ListItem>
                            <asp:ListItem Value="+678">Vanuatu (+678)</asp:ListItem>
                            <asp:ListItem Value="+39">Vatican City State (+39)</asp:ListItem>
                            <asp:ListItem Value="+58">Venezuela (+58)</asp:ListItem>
                            <asp:ListItem Value="+84">Vietnam (+84)</asp:ListItem>
                            <asp:ListItem Value="+681">Wallis and Futuna (+681)</asp:ListItem>
                            <asp:ListItem Value="+967">Yemen (+967)</asp:ListItem>
                            <asp:ListItem Value="+260">Zambia (+260)</asp:ListItem>
                            <asp:ListItem Value="+263">Zimbabwe (+263)</asp:ListItem>
                        </asp:DropDownList>
                    </td>--%>
                    <%--<td colspan="2">
                        <asp:TextBox ID="txtMobiUSD" runat="server" MaxLength="10" CssClass="NumberCss"></asp:TextBox>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl" style="padding-left: 10px">Select your country:</td>--%>
                    <%--<td class="lbl" colspan="2">State:</td>--%>
                </tr>
                <tr>
                    <%--<td style="padding-left: 10px; height: 24px;">
                        <asp:DropDownList ID="ddlcountry" runat="server">
                            <asp:ListItem Value="--Select Country--">--Select Country--</asp:ListItem>
                            <asp:ListItem Value="231">Afghanistan</asp:ListItem>
                            <asp:ListItem Value="244">&#197;land Islands</asp:ListItem>
                            <asp:ListItem Value="230">Albania</asp:ListItem>
                            <asp:ListItem Value="38">Algeria</asp:ListItem>
                            <asp:ListItem Value="39">American Samoa</asp:ListItem>
                            <asp:ListItem Value="40">Andorra</asp:ListItem>
                            <asp:ListItem Value="41">Angola</asp:ListItem>
                            <asp:ListItem Value="42">Anguilla</asp:ListItem>
                            <asp:ListItem Value="232">Antarctica</asp:ListItem>
                            <asp:ListItem Value="43">Antigua and Barbuda</asp:ListItem>
                            <asp:ListItem Value="44">Argentina</asp:ListItem>
                            <asp:ListItem Value="45">Armenia</asp:ListItem>
                            <asp:ListItem Value="46">Aruba</asp:ListItem>
                            <asp:ListItem Value="24">Australia</asp:ListItem>
                            <asp:ListItem Value="2">Austria</asp:ListItem>
                            <asp:ListItem Value="47">Azerbaijan</asp:ListItem>
                            <asp:ListItem Value="48">Bahamas</asp:ListItem>
                            <asp:ListItem Value="49">Bahrain</asp:ListItem>
                            <asp:ListItem Value="50">Bangladesh</asp:ListItem>
                            <asp:ListItem Value="51">Barbados</asp:ListItem>
                            <asp:ListItem Value="52">Belarus</asp:ListItem>
                            <asp:ListItem Value="3">Belgium</asp:ListItem>
                            <asp:ListItem Value="53">Belize</asp:ListItem>
                            <asp:ListItem Value="54">Benin</asp:ListItem>
                            <asp:ListItem Value="55">Bermuda</asp:ListItem>
                            <asp:ListItem Value="56">Bhutan</asp:ListItem>
                            <asp:ListItem Value="34">Bolivia</asp:ListItem>
                            <asp:ListItem Value="233">Bosnia and Herzegovina</asp:ListItem>
                            <asp:ListItem Value="57">Botswana</asp:ListItem>
                            <asp:ListItem Value="234">Bouvet Island</asp:ListItem>
                            <asp:ListItem Value="58">Brazil</asp:ListItem>
                            <asp:ListItem Value="235">British Indian Ocean Territory</asp:ListItem>
                            <asp:ListItem Value="59">Brunei</asp:ListItem>
                            <asp:ListItem Value="236">Bulgaria</asp:ListItem>
                            <asp:ListItem Value="60">Burkina Faso</asp:ListItem>
                            <asp:ListItem Value="61">Burma (Myanmar)</asp:ListItem>
                            <asp:ListItem Value="62">Burundi</asp:ListItem>
                            <asp:ListItem Value="63">Cambodia</asp:ListItem>
                            <asp:ListItem Value="64">Cameroon</asp:ListItem>
                            <asp:ListItem Value="4">Canada</asp:ListItem>
                            <asp:ListItem Value="65">Cape Verde</asp:ListItem>
                            <asp:ListItem Value="237">Cayman Islands</asp:ListItem>
                            <asp:ListItem Value="66">Central African Republic</asp:ListItem>
                            <asp:ListItem Value="67">Chad</asp:ListItem>
                            <asp:ListItem Value="68">Chile</asp:ListItem>
                            <asp:ListItem Value="5">China</asp:ListItem>
                            <asp:ListItem Value="238">Christmas Island</asp:ListItem>
                            <asp:ListItem Value="239">Cocos (Keeling) Islands</asp:ListItem>
                            <asp:ListItem Value="69">Colombia</asp:ListItem>
                            <asp:ListItem Value="70">Comoros</asp:ListItem>
                            <asp:ListItem Value="71">Congo, Dem. Republic</asp:ListItem>
                            <asp:ListItem Value="72">Congo, Republic</asp:ListItem>
                            <asp:ListItem Value="240">Cook Islands</asp:ListItem>
                            <asp:ListItem Value="73">Costa Rica</asp:ListItem>
                            <asp:ListItem Value="74">Croatia</asp:ListItem>
                            <asp:ListItem Value="75">Cuba</asp:ListItem>
                            <asp:ListItem Value="76">Cyprus</asp:ListItem>
                            <asp:ListItem Value="16">Czech Republic</asp:ListItem>
                            <asp:ListItem Value="20">Denmark</asp:ListItem>
                            <asp:ListItem Value="77">Djibouti</asp:ListItem>
                            <asp:ListItem Value="78">Dominica</asp:ListItem>
                            <asp:ListItem Value="79">Dominican Republic</asp:ListItem>
                            <asp:ListItem Value="80">East Timor</asp:ListItem>
                            <asp:ListItem Value="81">Ecuador</asp:ListItem>
                            <asp:ListItem Value="82">Egypt</asp:ListItem>
                            <asp:ListItem Value="83">El Salvador</asp:ListItem>
                            <asp:ListItem Value="84">Equatorial Guinea</asp:ListItem>
                            <asp:ListItem Value="85">Eritrea</asp:ListItem>
                            <asp:ListItem Value="86">Estonia</asp:ListItem>
                            <asp:ListItem Value="87">Ethiopia</asp:ListItem>
                            <asp:ListItem Value="88">Falkland Islands</asp:ListItem>
                            <asp:ListItem Value="89">Faroe Islands</asp:ListItem>
                            <asp:ListItem Value="90">Fiji</asp:ListItem>
                            <asp:ListItem Value="7">Finland</asp:ListItem>
                            <asp:ListItem Value="8">France</asp:ListItem>
                            <asp:ListItem Value="241">French Guiana</asp:ListItem>
                            <asp:ListItem Value="242">French Polynesia</asp:ListItem>
                            <asp:ListItem Value="243">French Southern Territories</asp:ListItem>
                            <asp:ListItem Value="91">Gabon</asp:ListItem>
                            <asp:ListItem Value="92">Gambia</asp:ListItem>
                            <asp:ListItem Value="93">Georgia</asp:ListItem>
                            <asp:ListItem Value="1">Germany</asp:ListItem>
                            <asp:ListItem Value="94">Ghana</asp:ListItem>
                            <asp:ListItem Value="97">Gibraltar</asp:ListItem>
                            <asp:ListItem Value="9">Greece</asp:ListItem>
                            <asp:ListItem Value="96">Greenland</asp:ListItem>
                            <asp:ListItem Value="95">Grenada</asp:ListItem>
                            <asp:ListItem Value="98">Guadeloupe</asp:ListItem>
                            <asp:ListItem Value="99">Guam</asp:ListItem>
                            <asp:ListItem Value="100">Guatemala</asp:ListItem>
                            <asp:ListItem Value="101">Guernsey</asp:ListItem>
                            <asp:ListItem Value="102">Guinea</asp:ListItem>
                            <asp:ListItem Value="103">Guinea-Bissau</asp:ListItem>
                            <asp:ListItem Value="104">Guyana</asp:ListItem>
                            <asp:ListItem Value="105">Haiti</asp:ListItem>
                            <asp:ListItem Value="106">Heard Island and McDonald Islands</asp:ListItem>
                            <asp:ListItem Value="108">Honduras</asp:ListItem>
                            <asp:ListItem Value="22">HongKong</asp:ListItem>
                            <asp:ListItem Value="143">Hungary</asp:ListItem>
                            <asp:ListItem Value="109">Iceland</asp:ListItem>
                            <asp:ListItem Value="111">Indonesia</asp:ListItem>
                            <asp:ListItem Value="110">India</asp:ListItem>
                            <asp:ListItem Value="112">Iran</asp:ListItem>
                            <asp:ListItem Value="113">Iraq</asp:ListItem>
                            <asp:ListItem Value="26">Ireland</asp:ListItem>
                            <asp:ListItem Value="29">Israel</asp:ListItem>
                            <asp:ListItem Value="10">Italy</asp:ListItem>
                            <asp:ListItem Value="32">Ivory Coast</asp:ListItem>
                            <asp:ListItem Value="115">Jamaica</asp:ListItem>
                            <asp:ListItem Value="11">Japan</asp:ListItem>
                            <asp:ListItem Value="116">Jersey</asp:ListItem>
                            <asp:ListItem Value="117">Jordan</asp:ListItem>
                            <asp:ListItem Value="118">Kazakhstan</asp:ListItem>
                            <asp:ListItem Value="119">Kenya</asp:ListItem>
                            <asp:ListItem Value="120">Kiribati</asp:ListItem>
                            <asp:ListItem Value="121">Korea, Dem. Republic of</asp:ListItem>
                            <asp:ListItem Value="122">Kuwait</asp:ListItem>
                            <asp:ListItem Value="123">Kyrgyzstan</asp:ListItem>
                            <asp:ListItem Value="124">Laos</asp:ListItem>
                            <asp:ListItem Value="125">Latvia</asp:ListItem>
                            <asp:ListItem Value="126">Lebanon</asp:ListItem>
                            <asp:ListItem Value="127">Lesotho</asp:ListItem>
                            <asp:ListItem Value="128">Liberia</asp:ListItem>
                            <asp:ListItem Value="129">Libya</asp:ListItem>
                            <asp:ListItem Value="130">Liechtenstein</asp:ListItem>
                            <asp:ListItem Value="131">Lithuania</asp:ListItem>
                            <asp:ListItem Value="12">Luxemburg</asp:ListItem>
                            <asp:ListItem Value="132">Macau</asp:ListItem>
                            <asp:ListItem Value="133">Macedonia</asp:ListItem>
                            <asp:ListItem Value="134">Madagascar</asp:ListItem>
                            <asp:ListItem Value="135">Malawi</asp:ListItem>
                            <asp:ListItem Value="136">Malaysia</asp:ListItem>
                            <asp:ListItem Value="137">Maldives</asp:ListItem>
                            <asp:ListItem Value="138">Mali</asp:ListItem>
                            <asp:ListItem Value="139">Malta</asp:ListItem>
                            <asp:ListItem Value="114">Man Island</asp:ListItem>
                            <asp:ListItem Value="140">Marshall Islands</asp:ListItem>
                            <asp:ListItem Value="141">Martinique</asp:ListItem>
                            <asp:ListItem Value="142">Mauritania</asp:ListItem>
                            <asp:ListItem Value="35">Mauritius</asp:ListItem>
                            <asp:ListItem Value="144">Mayotte</asp:ListItem>
                            <asp:ListItem Value="145">Mexico</asp:ListItem>
                            <asp:ListItem Value="146">Micronesia</asp:ListItem>
                            <asp:ListItem Value="147">Moldova</asp:ListItem>
                            <asp:ListItem Value="148">Monaco</asp:ListItem>
                            <asp:ListItem Value="149">Mongolia</asp:ListItem>
                            <asp:ListItem Value="150">Montenegro</asp:ListItem>
                            <asp:ListItem Value="151">Montserrat</asp:ListItem>
                            <asp:ListItem Value="152">Morocco</asp:ListItem>
                            <asp:ListItem Value="153">Mozambique</asp:ListItem>
                            <asp:ListItem Value="154">Namibia</asp:ListItem>
                            <asp:ListItem Value="155">Nauru</asp:ListItem>
                            <asp:ListItem Value="156">Nepal</asp:ListItem>
                            <asp:ListItem Value="13">Netherlands</asp:ListItem>
                            <asp:ListItem Value="157">Netherlands Antilles</asp:ListItem>
                            <asp:ListItem Value="158">New Caledonia</asp:ListItem>
                            <asp:ListItem Value="27">New Zealand</asp:ListItem>
                            <asp:ListItem Value="159">Nicaragua</asp:ListItem>
                            <asp:ListItem Value="160">Niger</asp:ListItem>
                            <asp:ListItem Value="31">Nigeria</asp:ListItem>
                            <asp:ListItem Value="161">Niue</asp:ListItem>
                            <asp:ListItem Value="162">Norfolk Island</asp:ListItem>
                            <asp:ListItem Value="163">Northern Mariana Islands</asp:ListItem>
                            <asp:ListItem Value="23">Norway</asp:ListItem>
                            <asp:ListItem Value="164">Oman</asp:ListItem>
                            <asp:ListItem Value="165">Pakistan</asp:ListItem>
                            <asp:ListItem Value="166">Palau</asp:ListItem>
                            <asp:ListItem Value="167">Palestinian Territories</asp:ListItem>
                            <asp:ListItem Value="168">Panama</asp:ListItem>
                            <asp:ListItem Value="169">Papua New Guinea</asp:ListItem>
                            <asp:ListItem Value="170">Paraguay</asp:ListItem>
                            <asp:ListItem Value="171">Peru</asp:ListItem>
                            <asp:ListItem Value="172">Philippines</asp:ListItem>
                            <asp:ListItem Value="173">Pitcairn</asp:ListItem>
                            <asp:ListItem Value="14">Poland</asp:ListItem>
                            <asp:ListItem Value="15">Portugal</asp:ListItem>
                            <asp:ListItem Value="174">Puerto Rico</asp:ListItem>
                            <asp:ListItem Value="175">Qatar</asp:ListItem>
                            <asp:ListItem Value="176">Reunion Island</asp:ListItem>
                            <asp:ListItem Value="36">Romania</asp:ListItem>
                            <asp:ListItem Value="177">Russian Federation</asp:ListItem>
                            <asp:ListItem Value="178">Rwanda</asp:ListItem>
                            <asp:ListItem Value="179">Saint Barthelemy</asp:ListItem>
                            <asp:ListItem Value="180">Saint Kitts and Nevis</asp:ListItem>
                            <asp:ListItem Value="181">Saint Lucia</asp:ListItem>
                            <asp:ListItem Value="182">Saint Martin</asp:ListItem>
                            <asp:ListItem Value="183">Saint Pierre and Miquelon</asp:ListItem>
                            <asp:ListItem Value="184">Saint Vincent and the Grenadines</asp:ListItem>
                            <asp:ListItem Value="185">Samoa</asp:ListItem>
                            <asp:ListItem Value="186">San Marino</asp:ListItem>
                            <asp:ListItem Value="187">S&#227;o Tom&#233; and Pr&#237;ncipe</asp:ListItem>
                            <asp:ListItem Value="188">Saudi Arabia</asp:ListItem>
                            <asp:ListItem Value="189">Senegal</asp:ListItem>
                            <asp:ListItem Value="190">Serbia</asp:ListItem>
                            <asp:ListItem Value="191">Seychelles</asp:ListItem>
                            <asp:ListItem Value="192">Sierra Leone</asp:ListItem>
                            <asp:ListItem Value="25">Singapore</asp:ListItem>
                            <asp:ListItem Value="37">Slovakia</asp:ListItem>
                            <asp:ListItem Value="193">Slovenia</asp:ListItem>
                            <asp:ListItem Value="194">Solomon Islands</asp:ListItem>
                            <asp:ListItem Value="195">Somalia</asp:ListItem>
                            <asp:ListItem Value="30">South Africa</asp:ListItem>
                            <asp:ListItem Value="196">South Georgia and the South Sandwich Islands</asp:ListItem>
                            <asp:ListItem Value="28">South Korea</asp:ListItem>
                            <asp:ListItem Value="6">Spain</asp:ListItem>
                            <asp:ListItem Value="197">Sri Lanka</asp:ListItem>
                            <asp:ListItem Value="198">Sudan</asp:ListItem>
                            <asp:ListItem Value="199">Suriname</asp:ListItem>
                            <asp:ListItem Value="200">Svalbard and Jan Mayen</asp:ListItem>
                            <asp:ListItem Value="201">Swaziland</asp:ListItem>
                            <asp:ListItem Value="18">Sweden</asp:ListItem>
                            <asp:ListItem Value="19">Switzerland</asp:ListItem>
                            <asp:ListItem Value="202">Syria</asp:ListItem>
                            <asp:ListItem Value="203">Taiwan</asp:ListItem>
                            <asp:ListItem Value="204">Tajikistan</asp:ListItem>
                            <asp:ListItem Value="205">Tanzania</asp:ListItem>
                            <asp:ListItem Value="206">Thailand</asp:ListItem>
                            <asp:ListItem Value="33">Togo</asp:ListItem>
                            <asp:ListItem Value="207">Tokelau</asp:ListItem>
                            <asp:ListItem Value="208">Tonga</asp:ListItem>
                            <asp:ListItem Value="209">Trinidad and Tobago</asp:ListItem>
                            <asp:ListItem Value="210">Tunisia</asp:ListItem>
                            <asp:ListItem Value="211">Turkey</asp:ListItem>
                            <asp:ListItem Value="212">Turkmenistan</asp:ListItem>
                            <asp:ListItem Value="213">Turks and Caicos Islands</asp:ListItem>
                            <asp:ListItem Value="214">Tuvalu</asp:ListItem>
                            <asp:ListItem Value="215">Uganda</asp:ListItem>
                            <asp:ListItem Value="216">Ukraine</asp:ListItem>
                            <asp:ListItem Value="217">United Arab Emirates</asp:ListItem>
                            <asp:ListItem Value="17" Selected="True">United Kingdom</asp:ListItem>
                            <asp:ListItem Value="21">United States</asp:ListItem>
                            <asp:ListItem Value="218">Uruguay</asp:ListItem>
                            <asp:ListItem Value="219">Uzbekistan</asp:ListItem>
                            <asp:ListItem Value="220">Vanuatu</asp:ListItem>
                            <asp:ListItem Value="107">Vatican City State</asp:ListItem>
                            <asp:ListItem Value="221">Venezuela</asp:ListItem>
                            <asp:ListItem Value="222">Vietnam</asp:ListItem>
                            <asp:ListItem Value="223">Virgin Islands (British)</asp:ListItem>
                            <asp:ListItem Value="224">Virgin Islands (U.S.)</asp:ListItem>
                            <asp:ListItem Value="225">Wallis and Futuna</asp:ListItem>
                            <asp:ListItem Value="226">Western Sahara</asp:ListItem>
                            <asp:ListItem Value="227">Yemen</asp:ListItem>
                            <asp:ListItem Value="228">Zambia</asp:ListItem>
                            <asp:ListItem Value="229">Zimbabwe</asp:ListItem>
                        </asp:DropDownList></td>--%>
                    <%--<td colspan="2" style="height: 24px">
                        <asp:TextBox ID="txtState" runat="server" MaxLength="50"></asp:TextBox>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl" style="padding-left: 10px">City:</td>--%>
                    <%--<td class="lbl" colspan="2">Pin Code:</td>--%>
                </tr>
                <tr>
                    <%--<td>
                        <asp:TextBox ID="txtCity" runat="server" MaxLength="50"></asp:TextBox>
                    </td>--%>
                    <%--<td colspan="2">
                        <asp:TextBox ID="txtPinCode" runat="server" MaxLength="6"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="txtPinCode" ErrorMessage="Enter Only PinCode" Operator="GreaterThan" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator>
                    </td>--%>
                </tr>
                <tr>
                 <%--<td class="lbl" style="padding-left: 10px; height: 20px;">Block ROI:</td>--%>
                    <td class="lbl" colspan="2" style="height: 20px; display: none;">Designation:</td>
                    <td class="lbl" colspan="2" style="height: 20px; display: none;">Reference Code</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlBockRoi" runat="server" Visible="false" class="form-control">
                            <asp:ListItem>NO</asp:ListItem>
                            <asp:ListItem>YES</asp:ListItem>
                        </asp:DropDownList></td>
                    <%--<td colspan="2" style="text-align: center; padding-top: 5px">
                        <asp:Button ID="btnSubmit" runat="server" Text="Save Continue" CssClass="OuterBtn" OnClick="btnSubmit_Click" />
                    </td>--%>
                    <td class="lbl" style="padding-left: 10px; height: 20px; display: none;">
                        <asp:DropDownList ID="ddlDesignation" runat="server" class="form-control">
                            <asp:ListItem>Member</asp:ListItem>
                            <asp:ListItem>Affiato</asp:ListItem>
                            <asp:ListItem>Affibian</asp:ListItem>
                            <asp:ListItem>Afficorn</asp:ListItem>
                            <asp:ListItem>Affiduke</asp:ListItem>
                            <asp:ListItem>Affien</asp:ListItem>
                            <asp:ListItem>Affifion</asp:ListItem>
                            <asp:ListItem>Affigate</asp:ListItem>
                            <asp:ListItem>AffiZion</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtCardNo" Visible="false" runat="server" class="form-control" MaxLength="10" placeholder="Reference Code" pattern=".{10,}" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" required title="eneter 10 digit"></asp:TextBox>
                    </td>
                </tr>
                <tr style="display: none;">
                    <td class="BoderHading" colspan="3">e-Currency Account</td>
                </tr>
                <tr style="display: none;">
                    <td class="lbl">
                        <table cellpadding="0" cellspacing="0" align="left">
                            <tr>
                                <td style="padding-right: 5px; font-size: 14px;">E-Currency</td>
                                <td style="padding-top: 4px;">
                                    <asp:CheckBox ID="chkECurcy" runat="server" onchange="EcurncyChange();" CssClass="form-control" OnCheckedChanged="chkECurcy_CheckedChanged" Checked="true" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td class="lbl" colspan="3">
                        <div id="pnlPerc">
                            <table cellpadding="0" cellspacing="0" style="display: none;">
                                <tr>
                                    <td class="lbl">Bitcoin Address</td>
                                    <%--<td class="lbl" colspan="2" style="height: 20px">Perfect Money</td>--%>
                                    <td class="lbl" colspan="2" style="height: 20px">Reference Code</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtPerfect" runat="server" class="form-control" MaxLength="34" placeholder="e.g. 9uowLySSpvyiJuNpoySvMecNFWtSfnffT9"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr style="display: none;">
                    <td class="lbl" colspan="3">
                        <table cellpadding="0" cellspacing="0" align="left">
                            <tr>
                                <td style="padding-right: 10px; font-size: 14px;">Bank Wire</td>
                                <td style="padding-top: 4px;">
                                    <asp:CheckBox ID="chkbankWire" runat="server" class="form-control" onchange="BankChange();" OnCheckedChanged="chkbankWire_CheckedChanged" Checked="True" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div id="PanelBnkinfo" style="display: none;">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td class="BoderHading" colspan="3">Bank Information</td>
                                </tr>
                                <tr>
                                    <td class="lbl">Bank Name</td>
                                    <td class="lbl">Account Type</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtBakName" MaxLength="40" runat="server" class="form-control" placeholder="Bank Name" EnableTheming="True"></asp:TextBox></td>
                                    <td>
                                        <asp:DropDownList ID="ddlAccType" runat="server" class="form-control" EnableTheming="True">
                                            <asp:ListItem Text="Saving Account"></asp:ListItem>
                                            <asp:ListItem Text="Current Account"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="lbl">Account No</td>
                                    <td class="lbl">Swift Code</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtAccountNo" MaxLength="30" runat="server" class="form-control" placeholder="Account No" EnableTheming="True"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSwiftCode" MaxLength="20" runat="server" class="form-control" placeholder="Swift Code" EnableTheming="True"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="lbl">IFS Code</td>
                                    <td class="lbl">Pan Card</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtIFSCode" runat="server" MaxLength="20" class="form-control" placeholder="IFS Code" EnableTheming="True"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPanCard" runat="server" MaxLength="10" class="form-control" placeholder="Pan Card" EnableTheming="True"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="BoderHading" colspan="3">Beneficiary Information</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="lbl">First Name</td>
                                    <td class="lbl">Last Name</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtAccFName" runat="server" MaxLength="40" class="form-control" placeholder="First Name"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAccLName" runat="server" MaxLength="40" class="form-control" placeholder="Last Name"></asp:TextBox>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="lbl">City</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtAccCity" runat="server" MaxLength="30" class="form-control" placeholder="City"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="lbl"></td>
                    <td class="lbl" colspan="2" style="text-align: center;"></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 10px"></td>
                </tr>
                <tr>
                    <%--<td colspan="2" class="BoderHading">Change Password</td>--%>
                </tr>

                <tr>
                    <%--<td class="lbl">Login Old Password</td>--%>
                    <%--<td class="lbl" colspan="2">Transaction Old Password</td>--%>
                </tr>
                <tr>
                    <%--<td>
                        <asp:TextBox ID="txtLoginOldPass" runat="server" MaxLength="25" Enabled="false" BackColor="#dddddd"></asp:TextBox>
                    </td>--%>
                    <%--<td colspan="2">&nbsp;<asp:TextBox ID="txtTransOldPassword" runat="server" MaxLength="25" Enabled="false" BackColor="#dddddd"></asp:TextBox></td>--%>
                </tr>
                <tr>
                    <%--<td class="lbl">Login New Password</td>--%>
                    <%--<td class="lbl" colspan="2">Transaction New Password</td>--%>
                </tr>
                <tr>
                    <%--<td>
                        <asp:TextBox ID="txtLoginNewPass" runat="server" MaxLength="25"></asp:TextBox>
                    </td>--%>
                    <%--<td colspan="2">&nbsp;<asp:TextBox ID="txtTransNewpass" runat="server" MaxLength="25"></asp:TextBox></td>--%>
                </tr>
                <tr style="text-align: center;">
                    <%--<td>
                        <asp:Button ID="btnloginPass" runat="server" Text="Save Login Password" CssClass="OuterBtn" ValidationGroup="pl" OnClick="btnloginPass_Click" />
                    </td>--%>
                    <%--<td colspan="2">&nbsp;
                        <asp:Button ID="btnTransPass" runat="server" Text="Save Transaction Password" CssClass="OuterBtn" ValidationGroup="pt" OnClick="btnTransPass_Click" />
                    </td>--%>
                </tr>
                <tr>
                    <td>
                        <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtLoginNewPass" ID="RegularExpressionValidator2" ValidationGroup="pl" ValidationExpression="^[\s\S]{8,}$" runat="server" ErrorMessage="Login Password Minimum 8 Digit required." ForeColor="Red"></asp:RegularExpressionValidator>
                    </td>
                    <td colspan="2">&nbsp;<asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtTransNewpass" ID="RegularExpressionValidator3" ValidationGroup="pt" ValidationExpression="^[\s\S]{8,}$" runat="server" ErrorMessage="Transaction Password Minimum 8 Digit required." ForeColor="Red"></asp:RegularExpressionValidator></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtDOB" TargetControlID="txtDOB"></ajaxToolkit:CalendarExtender>--%>
                        <asp:DropDownList ID="ddlPosition" runat="server" Visible="False">
                            <asp:ListItem>LEFT</asp:ListItem>
                            <asp:ListItem>RIGHT</asp:ListItem>
                        </asp:DropDownList>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
                    </td>
                </tr>
            </table>
        </center>
    </div>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtDOB.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                }
            );
        });
    </script>
</asp:Content>