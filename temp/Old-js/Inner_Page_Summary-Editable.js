$(function () {
    $('.loged-in').load("Handlers/Game-Common-Values.ashx?Vs=CheckCookies");
    DashboardSummary();
})
function DashboardSummary() {
    $.getJSON('Handlers/Inner_Page_Summary.ashx',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                var wa = '';
                for (var i = 0; i < OrjsonDS.length; i++) {
                    $('#newsalert').html(OrjsonDS[i].NewsDtlsAlert);
                    $("#MemberId").html(OrjsonDS[i].MemID);
                    $('#Withbal').html(OrjsonDS[i].cWalletBal);
                    $('#mainwalletBal').val(OrjsonDS[i].cWalletBal);
                    $('#GMwalletBalance').html(OrjsonDS[i].cWalletBal);
                    $('#GMwalletBalance2').html(OrjsonDS[i].cWalletBal);
                    $('#GrowthWalletBal').val(OrjsonDS[i].Wallet2Bal);
                    $('#GrowthWBal').html(OrjsonDS[i].Wallet2Bal);
                    $('#gmwltbalnc').html(OrjsonDS[i].cWalletBal);
                    $('#Diduction').html(OrjsonDS[i].DkbTxnCharge + '<span>%</span>');
                    $('#DkbTxnCharge').html(" (" + OrjsonDS[i].DkbTxnCharge + "%)");
                    $('#transfee').val(OrjsonDS[i].DkbTxnCharge);
                    $('#fmin').html(OrjsonDS[i].Fmin + "<small style='font-size: 14px;'> TRX</small>");
                    $('#fmax').html(OrjsonDS[i].FMax + "<small style='font-size: 14px;'> TRX</small>");
                    $('#fmlt').html(OrjsonDS[i].FMlt + "<small style='font-size: 14px;'> TRX</small>");


                    $('#prof_pic').html("<img width='100' height='100' class='profleImg' style='border-radius: 50%;' src='" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#accstatus').html(OrjsonDS[i].MemSts1);
                    if (OrjsonDS[i].MemSts1 == 'Active') {
                        $('#sts').html("<i class='bx bxs-circle me-1' style='color:#15ca20'></i><span class='text-success font-weight-bold'>" + OrjsonDS[i].MemSts1 + "</span>");
                        $('#prof_pic').addClass("bg-success");
                    } else {
                        $('#sts').html("<i class='bx bxs-circle me-1' style='color:#ff0000'></i><span class='text-danger font-weight-bold'>" + OrjsonDS[i].MemSts1 + "</span>");
                        $('#prof_pic').addClass("bg-danger");
                    }

                    try {
                        var mainbal = $('#mainwalletBal').val();
                        var growthbal = $('#GrowthWalletBal').val();
                        var totalbal = (Number(mainbal) + Number(growthbal));
                        var totmainper = ((Number(mainbal) / Number(totalbal)) * 100).toFixed(2);
                        $('#mainpercent').html(totmainper + "%");

                        var totgrowthper = ((Number(growthbal) / Number(totalbal)) * 100).toFixed(2);
                        $('#growthpercent').html(totgrowthper + "%");

                        if (mainbal == 0 && growthbal == 0) {
                            $('#mainpercent').html("0%");
                            $('#growthpercent').html("0%");
                        }


                        var mainpercircle = ((Number(mainbal) / Number(totalbal)) * 100).toFixed(0);
                        if (mainpercircle == 0) {
                            $('#mainwalletsec').addClass("p0");
                        }
                        else if (mainpercircle == 1) {
                            $('#mainwalletsec').addClass("p1");
                        }
                        else if (mainpercircle == 2) {
                            $('#mainwalletsec').addClass("p2");
                        }
                        else if (mainpercircle == 3) {
                            $('#mainwalletsec').addClass("p3");
                        }
                        else if (mainpercircle == 4) {
                            $('#mainwalletsec').addClass("p4");
                        }
                        else if (mainpercircle == 5) {
                            $('#mainwalletsec').addClass("p5");
                        }
                        else if (mainpercircle >= 5 && mainpercircle <= 7) {
                            $('#mainwalletsec').addClass("p7");
                        }
                        else if (mainpercircle >= 7 && mainpercircle <= 10) {
                            $("#mainwalletsec").addClass("p10");
                        }
                        else if (mainpercircle >= 10 && mainpercircle <= 15) {
                            $("#mainwalletsec").addClass("p15");
                        }
                        else if (mainpercircle >= 15 && mainpercircle <= 20) {
                            $("#mainwalletsec").addClass("p20");
                        }
                        else if (mainpercircle >= 20 && mainpercircle <= 25) {
                            $("#mainwalletsec").addClass("p25");
                        }
                        else if (mainpercircle >= 25 && mainpercircle <= 30) {
                            $("#mainwalletsec").addClass("p30");
                        }
                        else if (mainpercircle >= 30 && mainpercircle <= 35) {
                            $("#mainwalletsec").addClass("p35");
                        }
                        else if (mainpercircle >= 35 && mainpercircle <= 40) {
                            $("#mainwalletsec").addClass("p40");
                        }
                        else if (mainpercircle >= 40 && mainpercircle <= 45) {
                            $("#mainwalletsec").addClass("p45");
                        }
                        else if (mainpercircle >= 45 && mainpercircle <= 50) {
                            $("#mainwalletsec").addClass("p50");
                        }
                        else if (mainpercircle >= 50 && mainpercircle <= 55) {
                            $("#mainwalletsec").addClass("p55");
                        }
                        else if (mainpercircle >= 55 && mainpercircle <= 60) {
                            $("#mainwalletsec").addClass("p60");
                        }
                        else if (mainpercircle >= 60 && mainpercircle <= 65) {
                            $("#mainwalletsec").addClass("p65");
                        }
                        else if (mainpercircle >= 65 && mainpercircle <= 70) {
                            $("#mainwalletsec").addClass("p70");
                        }
                        else if (mainpercircle >= 70 && mainpercircle <= 75) {
                            $("#mainwalletsec").addClass("p75");
                        }
                        else if (mainpercircle >= 75 && mainpercircle <= 80) {
                            $("#mainwalletsec").addClass("p80");
                        }
                        else if (mainpercircle >= 80 && mainpercircle <= 85) {
                            $("#mainwalletsec").addClass("p85");
                        }
                        else if (mainpercircle >= 85 && mainpercircle <= 90) {
                            $("#mainwalletsec").addClass("p90");
                        }
                        else if (mainpercircle >= 90 && mainpercircle <= 95) {
                            $("#mainwalletsec").addClass("p95");
                        }
                        else if (mainpercircle == 96) {
                            $("#mainwalletsec").addClass("p96");
                        }
                        else if (mainpercircle == 97) {
                            $("#mainwalletsec").addClass("p97");
                        }
                        else if (mainpercircle == 98) {
                            $("#mainwalletsec").addClass("p98");
                        }
                        else if (mainpercircle == 99) {
                            $("#mainwalletsec").addClass("p99");
                        }
                        else if (mainpercircle == 100) {
                            $("#mainwalletsec").addClass("p100");
                        }


                        var growthpercircle = ((Number(growthbal) / Number(totalbal)) * 100).toFixed(0);
                        if (growthpercircle == 0) {
                            $('#growthwalletsec').addClass("p0");
                        }
                        else if (growthpercircle == 1) {
                            $("#growthwalletsec").addClass("p1");
                        }
                        else if (growthpercircle == 2) {
                            $("#growthwalletsec").addClass("p2");
                        }
                        else if (growthpercircle == 3) {
                            $("#growthwalletsec").addClass("p3");
                        }
                        else if (growthpercircle == 4) {
                            $("#growthwalletsec").addClass("p4");
                        }
                        else if (growthpercircle == 5) {
                            $("#growthwalletsec").addClass("p5");
                        }
                        else if (growthpercircle >= 5 && growthpercircle <= 7) {
                            $("#growthwalletsec").addClass("p7");
                        }
                        else if (growthpercircle >= 7 && growthpercircle <= 10) {
                            $("#growthwalletsec").addClass("p10");
                        }
                        else if (growthpercircle >= 10 && growthpercircle <= 15) {
                            $("#growthwalletsec").addClass("p15");
                        }
                        else if (growthpercircle >= 15 && growthpercircle <= 20) {
                            $("#growthwalletsec").addClass("p20");
                        }
                        else if (growthpercircle >= 20 && growthpercircle <= 25) {
                            $("#growthwalletsec").addClass("p25");
                        }
                        else if (growthpercircle >= 25 && growthpercircle <= 30) {
                            $("#growthwalletsec").addClass("p30");
                        }
                        else if (growthpercircle >= 30 && growthpercircle <= 35) {
                            $("#growthwalletsec").addClass("p35");
                        }
                        else if (growthpercircle >= 35 && growthpercircle <= 40) {
                            $("#growthwalletsec").addClass("p40");
                        }
                        else if (growthpercircle >= 40 && growthpercircle <= 45) {
                            $("#growthwalletsec").addClass("p45");
                        }
                        else if (growthpercircle >= 45 && growthpercircle <= 50) {
                            $("#growthwalletsec").addClass("p50");
                        }
                        else if (growthpercircle >= 50 && growthpercircle <= 55) {
                            $("#growthwalletsec").addClass("p55");
                        }
                        else if (growthpercircle >= 55 && growthpercircle <= 60) {
                            $("#growthwalletsec").addClass("p60");
                        }
                        else if (growthpercircle >= 60 && growthpercircle <= 65) {
                            $("#growthwalletsec").addClass("p65");
                        }
                        else if (growthpercircle >= 65 && growthpercircle <= 70) {
                            $("#growthwalletsec").addClass("p70");
                        }
                        else if (growthpercircle >= 70 && growthpercircle <= 75) {
                            $("#growthwalletsec").addClass("p75");
                        }
                        else if (growthpercircle >= 75 && growthpercircle <= 80) {
                            $("#growthwalletsec").addClass("p80");
                        }
                        else if (growthpercircle >= 80 && growthpercircle <= 85) {
                            $("#growthwalletsec").addClass("p85");
                        }
                        else if (growthpercircle >= 85 && growthpercircle <= 90) {
                            $("#growthwalletsec").addClass("p90");
                        }
                        else if (growthpercircle >= 90 && growthpercircle <= 95) {
                            $("#growthwalletsec").addClass("p95");
                        }
                        else if (growthpercircle == 96) {
                            $("#growthwalletsec").addClass("p96");
                        }
                        else if (growthpercircle == 97) {
                            $("#growthwalletsec").addClass("p97");
                        }
                        else if (growthpercircle == 98) {
                            $("#growthwalletsec").addClass("p98");
                        }
                        else if (growthpercircle == 99) {
                            $("#growthwalletsec").addClass("p99");
                        }
                        else if (growthpercircle == 100) {
                            $("#growthwalletsec").addClass("p100");
                        }
                    }
                    catch {

                    }


                    $('#txtMobiUSD').html(OrjsonDS[i].MobileNo);
                    $('#txtEmailU').html(OrjsonDS[i].email1);


                    $('#CPAmt').html(OrjsonDS[i].PlanAmt + " " + OrjsonDS[i].CPACType);
                    $('#CPACType').html(OrjsonDS[i].CPACType + " wallet address...");
                    $('#txtBTCAddress1').html(OrjsonDS[i].BTCAddress);
                    $('#CPACType1').val(OrjsonDS[i].CPACType);
                    $('#txtBTCAddress2').val(OrjsonDS[i].BTCAddress);
                    $("#paranew").html("Please make above payment on given Address by your crypto wallets. If all details will be correct then we will accept fund request & credit amount in Main-Wallet!");
                    $('#paybyid').val(OrjsonDS[i].fPaymentID);
                    $('#NewBTC1').html("<img src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + OrjsonDS[i].BTCAddress + "' width='210' height='210'>");


                    $('#RefLink1').html('https://redrakegame.com/register.html?invitation-code=' + OrjsonDS[i].MemID);

                    $('#MemberId').html(OrjsonDS[i].MemID);
                    $('#totalcommision').html(OrjsonDS[i].TotalCommision + '<span style="font-size:20px"> TRX</span>');
                    $('#directreg').html(OrjsonDS[i].DirectReg);
                    $('#directDepoNo').html(OrjsonDS[i].DirectDepoNo);
                    $('#directDepoAmt').html(OrjsonDS[i].DirectDepoAmt);
                    $('#directpeople').html(OrjsonDS[i].DirectPeople);
                    $('#teamregister').html(OrjsonDS[i].TeamRegister);
                    $('#teamDepoNo').html(OrjsonDS[i].TeamDepoNo);
                    $('#teamDepoAmt').html(OrjsonDS[i].TeamDepoAmt);
                    $('#teampeople').html(OrjsonDS[i].TeamPeople);
                    $('#promoWeek').html(OrjsonDS[i].PromoWeek);
                    $('#promoDirect').html(OrjsonDS[i].PromoDirect);
                    $('#promoComm').html(OrjsonDS[i].PromoComm); 1
                    $('#promoTeam').html(OrjsonDS[i].PromoTeam);
                    $('#gamefeededuction').val(OrjsonDS[i].feededuction);





                    $("#sharewt").val(OrjsonDS[i].CompName + " - The most amazing part of becoming our agent is that if the quality of your invited downlines is high, you have the opportunity to offer them free bonuses. " + '' + "https://redrakegame.com/register.html?invitation-code=" + OrjsonDS[i].MemID);

                    $('#loteryNo').html(OrjsonDS[i].LoteryNo);

                    $("#Rbal1").html("$" + OrjsonDS[i].RwBal);
                    $("#Fbal1").html("$" + OrjsonDS[i].FBal);
                    $('#MinAdd').html("$" + OrjsonDS[i].MinAdd);
                    $('#MltAdd').html("$" + OrjsonDS[i].MltAdd);
                    $('#MaxAdd').html("$" + OrjsonDS[i].MaxAdd);
                    $('#MinInvestmnt').html("$" + OrjsonDS[i].MinInvestmnt);
                    $('#MltpleInvestmnt').html("$" + OrjsonDS[i].MltpleInvestmnt);
                    $('#MaxInvestmnt').html("$" + OrjsonDS[i].MaxInvestmnt);
                    $('#TOTAL_DEPOSIT').html(OrjsonDS[i].TOTAL_DEPOSIT + '<span class="vert">TRX</span>');
                    $('#TotWithdrawal').html('' + OrjsonDS[i].WithdrawalTotal + '<span class="vert">TRX</span>');
                    $('#Totbussiness').html(OrjsonDS[i].Teambsns);

                    $('#Lastdpamt').html("$" + OrjsonDS[i].Lastdpamt);
                    $('#TotTeam23').html(OrjsonDS[i].TotTeam2);
                    $('#TotTeam2').html(OrjsonDS[i].TotTeam2);
                    $('#TotTm45').html(OrjsonDS[i].TotTeam2);
                    $('#TotTeambsns').html(OrjsonDS[i].TotTeam);
                    $('#Totbsns34').html(OrjsonDS[i].TotTeam);

                    $('#Active1').html(OrjsonDS[i].TOTACT1);
                    $('#Inactive1').html(OrjsonDS[i].TOTINACT1);

                    $('#Active2').html(OrjsonDS[i].TOTACT1);


                    $('#Inactive2').html(OrjsonDS[i].TOTINACT1);


                    $('#totTspin').html(OrjsonDS[i].Inbalnc);
                    $('#totTspinOut').html(OrjsonDS[i].outbalnc);

                    $('#TspOut').html(OrjsonDS[i].TmPsOut);


                    $('#MName').html(OrjsonDS[i].MemName);
                    $('#MemID11').html(OrjsonDS[i].MemID);
                    $('#MemID12').html(OrjsonDS[i].MemID);
                    $('#MemID13').html(OrjsonDS[i].MemID);
                    $('#MemID14').html(OrjsonDS[i].MemID);
                    $('#MemID20').html(OrjsonDS[i].MemID);
                    $('#MemID25').html(OrjsonDS[i].MemID);
                    $('#defaultid').val(OrjsonDS[i].MemID);
                    $('#sndbywallet').val(OrjsonDS[i].AcAddress);

                    $('#TxnKey').val(OrjsonDS[i].TxnKey);

                    $('#AcAddress').val(OrjsonDS[i].AcAddress)
                    $('#Block1').html(OrjsonDS[i].totBlock1);


                    $('#acttm').val(OrjsonDS[i].TOTACT1);
                    $('#ttlactv34').html(OrjsonDS[i].TOTACT1);
                    $('#incttm').val(OrjsonDS[i].TOTINACT1);
                    $('#ttlinactv').html(OrjsonDS[i].TOTINACT1);
                    $('#bltm').val(OrjsonDS[i].totBlock1);
                    $('#ttlblk').html(OrjsonDS[i].totBlock1);
                    $('#actrf').val(OrjsonDS[i].ACTIVE_REFERAL);
                    $('#inctrf').val(OrjsonDS[i].INACTIVE_REFERAL);
                    $('#blrf').val(OrjsonDS[i].Block_REFERAL);


                    $('#TOTAL_REFERRALS').html(OrjsonDS[i].TOTAL_REFERRALS);

                    $('#Mem_Profl_Pic').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic11').html("<img width='' height='' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic12').html("<img width='' height='' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic13').html("<img width='' height='' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic14').html("<img width='' height='' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic20').html("<img width='' height='' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic1').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");



                    $('#Mem_Profl_Pic21').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic22').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic23').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic24').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic25').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic26').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic27').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#Mem_Profl_Pic147').html("<img width='44' height='44' src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");
                    $('#RefLink789').html("<a href='#" + OrjsonDS[i].MemID + "' target='_blank'>..." + OrjsonDS[i].MemID + "</a>");


                    $('#MsgCunt').html(OrjsonDS[i].Tot_Msg_Cunt);
                    $('#MsgCunt2').html(OrjsonDS[i].Tot_Msg_Cunt);

                    $('#Tot_Msg_Cunt').html(OrjsonDS[i].Tot_Msg_Cunt);

                    $('#totaldepsoitpayment').html("" + OrjsonDS[i].TOTAL_DEPOSIT);
                    $('#ConfirmedDeposit').html(OrjsonDS[i].CntCnfFnd_cp);
                    $('#PendingDeposit').html(OrjsonDS[i].PendngFnd_cp);
                    $('#btcadd').val(OrjsonDS[i].BTCAddress);
                    $('#TRXrt').val(OrjsonDS[i].InrTRXrt);
                    $('#BNBrt').val(OrjsonDS[i].BNBrate);
                    $('#Tokenrt').val(OrjsonDS[i].Tokenrate);
                    $('#Deductioncharge1').val(OrjsonDS[i].DedWith);

                    $('#fwalletBal').html("$" + OrjsonDS[i].cWalletBal);
                    $('#FndReqConfm').html("$" + OrjsonDS[i].CntCnfFnd);
                    $('#FndReqPndg').html("$" + OrjsonDS[i].PendngFnd);
                    $("#FndReqPndg1").html("$" + OrjsonDS[i].PendngFnd),


                        $('#cWalletBal').html(OrjsonDS[i].cWalletBal);
                    $('#WallBal').val(OrjsonDS[i].cWalletBal);

                    $('#Mem_Name').html(OrjsonDS[i].MemName);
                    $('#MemName').html(OrjsonDS[i].MemName);



                    $('#MemNam2').html(OrjsonDS[i].MemName);
                    $('#MemNam11').html(OrjsonDS[i].MemName);
                    $('#MemNam12').html(OrjsonDS[i].MemName);
                    $('#MemNam13').html(OrjsonDS[i].MemName);
                    $('#MemNam14').html(OrjsonDS[i].MemName);
                    $('#MemNam20').html(OrjsonDS[i].MemName);
                    $('#MName25').html(OrjsonDS[i].MemName);
                    $('#MName26').html(OrjsonDS[i].MemName);

                    $('#Lastdpamt').text("$" + OrjsonDS[i].LastDepAmt);




                    $('#Totte').html("Team " + OrjsonDS[i].TotTeam);

                    $('#MemID4').html(OrjsonDS[i].Mem_Name.toUpperCase() + ' (' + OrjsonDS[i].MemID + ')');

                    $('#TotRef').html("Directs " + OrjsonDS[i].TOTAL_REFERRALS);

                    $('#mememail').html(OrjsonDS[i].email1);
                    $('#mememail1').html(OrjsonDS[i].email1);


                    $('#memid1').html(OrjsonDS[i].MemID);
                    $('#RefLink99').val(OrjsonDS[i].MemID);

                    $('#MemIDC_ID').html(OrjsonDS[i].MemID);
                    $('#MemIDC_Name').html(OrjsonDS[i].MemName);
                    $('#MemIDC_GEN').html(OrjsonDS[i].Gender);
                    $('#MemIDC_DOB').html(OrjsonDS[i].DOB);
                    $('#MemIDC_BGR').html(OrjsonDS[i].BGROUP);
                    $('#MemIDC_MON').html(OrjsonDS[i].Mobile);
                    $('#MemIDC_EML').html(OrjsonDS[i].email);
                    $('#MemIDC_Adrs').html(OrjsonDS[i].Address);
                    $('#MemIDC_City').html(OrjsonDS[i].City);
                    $('#MemIDC_State').html(OrjsonDS[i].State);
                    $('#MemIDC_ComNm').html(OrjsonDS[i].CompanyNameWLCML);
                    $('#MemIDC_ComNm1').html(OrjsonDS[i].CompanyNameWLCML);
                    $('#MemIDC_ComNm2').html(OrjsonDS[i].CompanyNameWLCML);
                    $('#MemIDC_ComMail').html(OrjsonDS[i].CompanyMail);
                    $('#MemIDC_DRank').html(OrjsonDS[i].DRank);
                    $('#MemIDC_Profl_Pic').html("<img src='../" + OrjsonDS[i].Mem_Profl_Pic + "' alt='user'/>");

                    $('#profJoin').html("You have join system on - " + OrjsonDS[i].Sign_UpOn + " & Actived on : " + OrjsonDS[i].Actived_On);

                    if (OrjsonDS[i].Actived_On == "Not Active") {
                        $('#Activeon').html("....");

                    }
                    else {
                        $('#Activeon').html(OrjsonDS[i].Actived_On);
                    }

                    $('#DOJ').html(OrjsonDS[i].Sign_UpOn);
                    $('#Actived_On1').html(OrjsonDS[i].Actived_On);
                    $('#signon').html(OrjsonDS[i].Sign_UpOn);
                    $('#TOTAL_DEPOSITBTC').html(OrjsonDS[i].TOTAL_DEPOSITBTC);
                    $('#TOTAL_DEPOSITBTC1').html(OrjsonDS[i].TOTAL_DEPOSITBTC);

                    if (OrjsonDS[i].TOTAL_DEPOSITeth > 0) {
                        $('#TOTAL_DEPOSITeth').html('<span class="sky-skin"><i class="fa fa-usd"></i></span><p><i class="fa  fa-arrow-up up"></i>Deposit By ETH </p><h3 > $' + OrjsonDS[i].TOTAL_DEPOSITeth + '</h3>');
                    }
                    else {
                        $('#TOTAL_DEPOSITeth').html('<span class="sky-skin"><i class="fa fa-usd"></i></span><p><i class="fa  fa-arrow-down down"></i>Deposit By ETH </p><h3 > $' + OrjsonDS[i].TOTAL_DEPOSITeth + '</h3>');
                    }



                    $('#TOTAL_DEPOSITWALLET').html(OrjsonDS[i].TOTAL_DEPOSITWALLET);
                    $('#TOTAL_DEPOSITWALLET1').html(OrjsonDS[i].TOTAL_DEPOSITWALLET);



                    $('#Totteamdep').html(OrjsonDS[i].TOTAL_downlindeposit);



                    $('#TotalRef').html(OrjsonDS[i].TOTAL_REFERRALS);
                    $('#Active').html(OrjsonDS[i].ActTeam);
                    $('#Inactive').html(OrjsonDS[i].Inactive);
                    $('#Block').html(OrjsonDS[i].totBlock);
                    $('#Topup').html(OrjsonDS[i].TotTeamDeposit);
                    $('#Bonus').html(OrjsonDS[i].TotTeamBonus);
                    $('#footertext').html(OrjsonDS[i].CompanyName);

                    $('#LastDepositOn').html(OrjsonDS[i].LastDepositOn);

                    $('#Msg_Cunt').html(OrjsonDS[i].Msg_Cunt);

                    $('#Msg_CuntTP').html(OrjsonDS[i].Msg_Cunt);


                    $('#ACTIVE_REFERAL').html(OrjsonDS[i].ACTIVE_REFERAL);
                    $('#INACTIVE_REFERAL').html(OrjsonDS[i].INACTIVE_REFERAL);
                    $('#Block_REFERAL').html(OrjsonDS[i].Block_REFERAL);

                    $('#RBalpr1').html(OrjsonDS[i].RBal);

                    $('#RBal').html(OrjsonDS[i].RBal);
                    $('#ProfitBal').val(OrjsonDS[i].RBal);
                    $('#RBalsh').html(OrjsonDS[i].RBal);
                    $('#Rcr').html("$" + OrjsonDS[i].Rcr);
                    $('#Rdr').html(OrjsonDS[i].Rdr);

                    $('#FBal').html(OrjsonDS[i].FBal);
                    $('#FBald').html(OrjsonDS[i].FBal + "<span style='font-size:12px'> TRX</span>");
                    $('#FBald58').html(OrjsonDS[i].FBal);
                    $('#FBald62').html(OrjsonDS[i].FBal);
                    $('#Fcr').html(OrjsonDS[i].Fcr);
                    $('#Fdr').html(OrjsonDS[i].Fdr);

                    $('#Fbal20').html("$" + OrjsonDS[i].FBal);
                    $('#Fbalin20').html("$" + OrjsonDS[i].Fcr);
                    $('#Fbalout20').html("$" + OrjsonDS[i].Fdr);
                    $('#Rbal20').html("$" + OrjsonDS[i].RwBal);
                    $('#Rbalin20').html("$" + OrjsonDS[i].RwCr);
                    $('#Rbalout20').html("$" + OrjsonDS[i].RwDr);

                    $('#Fbalin22').html(OrjsonDS[i].Fcr);
                    $('#Fbalout22').html(OrjsonDS[i].Fdr);

                    $('#IBal').html(OrjsonDS[i].IBal);
                    $('#BonusBal').val(OrjsonDS[i].IBal);
                    $('#IBalsh').html(OrjsonDS[i].IBal);
                    $('#Icr').html("$" + OrjsonDS[i].Icr);
                    $('#Idr').html(OrjsonDS[i].Idr);

                    $('#SiIcr').html("$" + OrjsonDS[i].Income5);
                    $('#TbiIcr').html("$" + OrjsonDS[i].TbiIcr);

                    $('#Totcnffr').html(OrjsonDS[i].Totcnffr);
                    $('#Totfr').html(OrjsonDS[i].Totfr);

                    $('#DBal').html(OrjsonDS[i].TmPsBal);

                    $('#Dcr').html("$" + OrjsonDS[i].Dcrinc);
                    $('#Ddr').html(OrjsonDS[i].TmPsOut);


                    $('#PIBal').html(OrjsonDS[i].PIBal);
                    $('#PIDcr').html(OrjsonDS[i].PIDcr);
                    $('#PIDdr').html(OrjsonDS[i].PIDdr);


                    $('#PLBal').html(OrjsonDS[i].PLBal);
                    $('#PLcr').html(OrjsonDS[i].PLcr);
                    $('#PLdr').html(OrjsonDS[i].PLdr);

                    $('#PRcr').html("$" + OrjsonDS[i].Rcr);
                    $('#SRin22').html("$" + OrjsonDS[i].Rcr);
                    $('#SRout22').html(+OrjsonDS[i].Rdr);

                    $('#Prshrgin').html("$" + OrjsonDS[i].Rcr);
                    $('#Prshrgout').html(+OrjsonDS[i].Rdr);


                    $('#Icr1').html("$" + OrjsonDS[i].Icr);
                    $('#Idr1').html(OrjsonDS[i].Idr);
                    $('#IBal1').html(OrjsonDS[i].IBal);

                    $('#rankbonusin').html("$" + OrjsonDS[i].Icr);
                    $('#rankbonusout').html(OrjsonDS[i].Idr);


                    $('#royalbalin').html(+OrjsonDS[i].Srcr);
                    $('#royalbalout').html(+OrjsonDS[i].Srdr)

                    $('#Srcr').html(OrjsonDS[i].Srcr);
                    $('#Srdr').html(OrjsonDS[i].Srdr);
                    $('#SrBal').html(OrjsonDS[i].SrBal);
                    $('#SrBal22').html(+ OrjsonDS[i].SrBal);
                    $('#Sro2').html(+OrjsonDS[i].Srcr);
                    $('#Sro1').html(+ OrjsonDS[i].Srdr)

                    $('#SRin').html("$" + OrjsonDS[i].Income2);
                    $('#SRout').html(OrjsonDS[i].Srdr);
                    $('#TmPsIn').html("$" + OrjsonDS[i].TmPsIn);
                    $('#TmPsIn2').html("$" + OrjsonDS[i].TmPsIn);
                    $('#TmPsOut').html("$" + OrjsonDS[i].TmPsOut);

                    $('#TmPsBal1').html("$" + OrjsonDS[i].TmPsBal1);
                    $('#TotalStakBal').html("Appreciation Bonus Balance: $" + OrjsonDS[i].TmPsBal1);
                    $('#LvlRwdBal').html("Level Incone + Reward Balance: $" + OrjsonDS[i].TmPsBal);
                    $('#TmPsIn1').html("$" + OrjsonDS[i].TmPsIn1);
                    $('#TmPsOut1').html("$" + OrjsonDS[i].TmPsOut1);

                    $('#RlupBal').html(OrjsonDS[i].RlupBal);
                    $('#RlupIn').html(OrjsonDS[i].RlupIn);
                    $('#RlupOut').html(OrjsonDS[i].RlupOut);


                    $('#RlupBal1').html(OrjsonDS[i].RlupBal);
                    $('#RlupIn1').html(OrjsonDS[i].RlupIn);
                    $('#RlupOut1').html(OrjsonDS[i].RlupOut);

                    $('#magicin').html(OrjsonDS[i].RlupIn);
                    $('#magicout').html(OrjsonDS[i].RlupOut);
                    $('#transferamt').html("$" + OrjsonDS[i].transferamt);
                    $('#transferbln').html(OrjsonDS[i].transferamt);


                    $('#RoyalBal').html(OrjsonDS[i].SrBal + '<span class="vert"></span>');
                    $('#dirwaltBal').html(+ OrjsonDS[i].DBal + '<span class="vert"></span>');
                    $('#profwalBal').html("$" + OrjsonDS[i].RBal + '<span class="vert"></span>');

                    $('#MaccBal').html('<span>$</span>' + OrjsonDS[i].TmPsBal2);

                    $('#teamprofsharingBal').html(OrjsonDS[i].TmPsBal + '<span class="vert"></span>');
                    $('#rankbonBal').html(OrjsonDS[i].IBal + '<span class="vert"></span>');


                    $('#hdRoyaltyBal').val(OrjsonDS[i].IBal);
                    $('#hddirectbonusBal').val(OrjsonDS[i].DBal);
                    $('#hdProfitSharing').val(OrjsonDS[i].RBal);
                    $('#hdteamprofitsharing').val(OrjsonDS[i].TmPsBal);
                    $('#RoyalBonus').val(OrjsonDS[i].SrBal);

                    try {
                        if (OrjsonDS[i].newscount > 0) {
                            var modal = document.getElementById('onload');
                            modal.style.display = "block";
                            modal.classList.add("show");
                            $('#notifications').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
                            $("#notifications").load("Handlers/GetPopupNews.ashx")

                        }
                        else {
                            var modal = document.getElementById('onload');
                            modal.style.display = "none";
                        }
                    }
                    catch { }


                    try {
                        if (OrjsonDS[i].DRank == "VIP-1") {
                            $('#DRank').html(' <img src="img/outerpages-icons/vip1.png" style="width:60px;"/>');
                        }
                        else if (OrjsonDS[i].DRank == "VIP-2") {
                            $('#DRank').html(' <img src="img/outerpages-icons/vip2.png" style="width:60px;"/>');
                        }
                        else if (OrjsonDS[i].DRank == "VIP-3") {
                            $('#DRank').html(' <img src="img/outerpages-icons/vip3.png" style="width:60px;"/>');
                        }
                        else {
                            $('#DRank').html('');
                        }
                    }
                    catch { }

                    if (OrjsonDS[i].MemSts == "GREEN") {
                        $('#AwalletList').show();
                        $('#AwalletListmsg').html("");
                    }
                    else {
                        $('#AwalletList').hide();
                        $('#AwalletListmsg').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> No Tips found</div>");
                    }
                    $('#Deductioncharge').html(OrjsonDS[i].DedWith + "%");
                    $('#Minwith').html(OrjsonDS[i].Minwith + " TRX");
                    $('#MltWith').html(OrjsonDS[i].MltWith + " TRX");
                    $('#TodayWith').html(OrjsonDS[i].TodayWith);
                    $('#betwithdraw').html(OrjsonDS[i].betwithdraw + " TRX");
                    $('#txtTRONAddress').val(OrjsonDS[i].WithWalletAddressTRC20);


                    $('#MinAmt').html(OrjsonDS[i].MinAmt + "<span style='font-size:12px'> TRX</span>");

                    $('#botrInc').html(OrjsonDS[i].Dcrinc + "<span style='font-size:12px'> TRX</span>");
                    $('#totwbalnc').html(OrjsonDS[i].TmPsBal + "<span style='font-size:12px'> TRX</span>");
                    $('#transferuserDeduc').val(OrjsonDS[i].transferuserDeduc);
                }
            }
        });
}



function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}
function delete_cookie(name) {
    document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function forgotsecpin() {
    swal({
        title: "Are you sure!",
        text: "you want to reset your transaction password",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes",
        closeOnConfirm: false
    },
        function () {

            document.getElementById("submitfgsecpin").disabled = true;
            $("#submitfgsecpin").html('please wait...');

            $.ajax({
                url: "Handlers/Account-Settings.ashx?SaveTp=fgSSecPWD",
                type: "POST",
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        swal({
                            title: "Mail Sent!",
                            text: Response.Message,
                            type: "success",

                        });
                        document.getElementById("submitfgsecpin").disabled = false;
                        $("#submitfgsecpin").html('<i class="fa fa-lock mr-1"></i>Forgot Txn Password');
                    }
                    else {
                        swal({
                            title: "Oops!",
                            text: Response.Message,
                            type: "error"

                        });

                        document.getElementById("submitfgsecpin").disabled = false;
                        $("#submitfgsecpin").html('<i class="fa fa-lock mr-1"></i>Forgot Txn Password');
                    }
                },
                error: function (err) {
                    $('#SSecPWD').html('');
                    swal({
                        title: "Oops!",
                        text: err.statusText,
                        type: "error"

                    });

                    document.getElementById("submitfgsecpin").disabled = false;
                    $("#submitfgsecpin").html('<i class="fa fa-lock mr-1"></i>Forgot Txn Password');
                }
            });
        });
}