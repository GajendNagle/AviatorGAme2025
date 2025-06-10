////////////
//$(document).ready(function () {
//GetTicketList();
//GetTicketDetails('');
//});
//////
function saveUser() {
$('#topicId').val('');
$('#EmailAddress').val('');
$('#Msg').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');
$('#Msg').load("Handlers/Save-ticket.ashx");
}
/////
function Showticketdetails(tktno) {

    $('#ticket_viewIn').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');
    $('#ticket_viewIn').load('Handlers/GetTicketDetails.ashx?orderId=' + tktno);
    $('#dlttktno').val(tktno);
    $('#ticket_list').css('display', 'none');
    $('#ticket_viewIn').css('display', 'block');
}
///
function GetTicketList() {
    $('#ticket_list').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');
$('#ticket_list').load("Handlers/GetTicketList.ashx");
}
////
function GetTicketDetails(ticketno,dv) {
    $('#ticket_viewIn').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');
 $('#ticket_viewIn').load("Handlers/GetTicketDetails.ashx?orderId=" + ticketno);

}
var tktid ="";
function clk(id)
{
    
    $('.product-list').on('change', function() {
        $('.product-list').not(this).prop('checked', false);
          
    });
    
    $('.product-list').click(function() {
        
        $(this).siblings('input:checkbox').prop('checked', false);
    });
    tktid = id;
 
}
function ReTicket()
{
    if (tktid == "" || tktid == null || tktid == "undefined")
    {
        swal({
                    title: "Ooops!",
                    text: "Please select Ticket!!!",
                    type: "error"
                    }); 
    }
    else 
    {    
        location.href = "MailBox-View.html?msg=" + tktid+"&Dv=1";
    }
}
function RefLoad()
{
    parent.location.reload(true);
}
function DeleteTitcketr() {
 //var od = new FormData();
 
 if (tktid == "" || tktid == null || tktid == "undefined")
    {
        swal({
                    title: "Ooops!",
                    text: "Please select Ticket!!!",
                    type: "error"
                    }); 
    }
    else 
    {   
 
     $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');

        $.ajax({
            url: "Handlers/Delete-Ticket.ashx?dltord=" + tktid,
            type: "POST",
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    
                    //parent.location.reload(true);
                    
                     swal({
                        title: "Deleted",
                        text: Response.Message,
                        type: "success"
                     },
  function(){
    parent.location.reload(true);
                    });
                    
                }
                else {
                     ///alert(Response.Message);
                     
                      swal({
                    title: "Ooops!",
                    text: Response.Message,
                    type: "error"
                    }); 
                }
            },
            error: function (err) {
             ///alert(err.statusText);
                //$.messager.alert("Failed", err.statusText, 'error');
                
                 swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                    });
            }
        });
        }
}


function placeGiveHelpOrder() {
    document.getElementById("sendQuery").disabled = true;
    $("#sendQuery").html('Please wait...');
    $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" style="width:50px;"/>');
     ////
     
    var od = new FormData();
    ////
    var fileUpload = $("#msgFile").get(0);
    var files = fileUpload.files;
    for (var i = 0; i < files.length; i++) {
    od.append(files[i].name, files[i]);
    }
    ////////   
    var topicId = $("#topicId").val();
    var IssueSummary= $("#IssueSummary").val();
    var IssueDetails= $("#IssueDetails").val();
    ////
    od.append("topicId", topicId);  
    od.append("IssueSummary", IssueSummary);
    od.append("IssueDetails", IssueDetails);
    ////
        $.ajax({
            url: "Handlers/Save-ticket.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
//                    $('#Msgs').html('');  
////                    alert(Response.Message); 
////                    parent.location.reload(true);
                    
                    swal({
                        title: "Congratulation!",
                        text: Response.Message,
                        type: "success"
                     },
  function(){
    //parent.location.reload(true);
    location.href = "Inbox.html";
                        });
                    document.getElementById("sendQuery").disabled = false;
                    $("#sendQuery").html('<i class="fa-regular fa-paper-plane mr-1"></i>Send');
                    
                }
                else {
                   $('#Msgs').html(''); 
                    //alert(Response.Message);
                    swal({
                    title: "Ooops!",
                    text: Response.Message,
                    type: "error"
                    });
                    document.getElementById("sendQuery").disabled = false;
                    $("#sendQuery").html('<i class="fa-regular fa-paper-plane mr-1"></i>Send');
                }
            },
            error: function (err) {
            $('#Msgs').html(''); 
                    //alert(err.statusText);
                    swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                    });
                document.getElementById("sendQuery").disabled = false;
                $("#sendQuery").html('<i class="fa-regular fa-paper-plane mr-1"></i>Send');
            }
        });
     ////
}

function ticketsaddMessage() {
    var fileUpload = $("#msgFile").get(0);
    var files = fileUpload.files;
    var test = new FormData();
    for (var i = 0; i < files.length; i++) {
        test.append(files[i].name, files[i]);
    }
    if (message == '') {

    }
    var message = $("#messageInput").val(); 
    var id = $("#tno").val();
    test.append("message", message);
    test.append("OrderId", id);
    $.ajax({
        url: "Handlers/Reply-Ticket.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: test,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {

                 //$.messager.alert("Success", Response.Message, 'info');
                 $("#messageInput").val('');
               GetTicketDetails(id);
            }
            else {
                $.messager.alert("Failed", Response.Message, 'warning');
            }
        },
        error: function (err) {
            $.messager.alert("Failed", err.statusText, 'error');
        }
    });
}


function ticketsaddMessageRe(tno) {
    $("#myModal").modal("hide");
 /*   $("#myModal").removeClass("modal-backdrop");*/
  
  
/*//        $('.DvReply').css('display','none');*/
     
    var fileUpload = $("#RemsgFile").get(0);
    var files = fileUpload.files;
    var test = new FormData();
    for (var i = 0; i < files.length; i++) {
        test.append(files[i].name, files[i]);
    }
    if (message == '') {

    }
    var message = $("#ReIssueDetails").val(); 
    var id = tno;
    test.append("message", message);
    test.append("OrderId", id);
    $.ajax({
        url: "Handlers/Reply-Ticket.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: test,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {

              
                 
               GetTicketDetails(id);
            }
            else {
                $.messager.alert("Failed", Response.Message, 'warning');
            }
        },
        error: function (err) {
            $.messager.alert("Failed", err.statusText, 'error');
        }
    });
   
} 