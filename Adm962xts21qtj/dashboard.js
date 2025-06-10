function SaveMessage(id,emailID) {
    var fileUpload = $("#msgFile").get(0);
    var files = fileUpload.files;
    var test = new FormData();
    for (var i = 0; i < files.length; i++) {
        test.append(files[i].name, files[i]);
    }
    if (message == '') {

    }
    var message = $("#messageInput").val(); 
    test.append("message", message);
    test.append("OrderId", id);
    test.append("emailID", emailID);
    $.ajax({
        url: "sendMessage.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: test,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {

                 //$.messager.alert("Success", Response.Message, 'info');
               loadMsgData(id,emailID);
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
function loadMsgData(id,emailID) {
    $('#msgFile').val('');
    $('#messageInput').val('');
 $('#loadmsgbox').html('<img src="FhHRx-Spinner.gif" />');
 $('#loadmsgbox').load("getMessage.ashx?orderId=" + id+"&email="+emailID);
}
function loadOrderMessage(Id,emailD) {
    //load message json file
   
    loadMsgData(Id,emailD);
    //end formating order message
    $('#OrderMessageBox').dialog({
        title: 'Ticket: #'+Id+' Conversation !',
        closed: false,
        cache: false,
        modal: true,
        buttons: [{
            text: 'Send Reply Message',
            iconCls: 'icon-ok',
            handler: function () {
                SaveMessage(Id,emailD);

            }
        },
             {
                 text: 'Close',
                 iconCls: 'icon-cancel',
                 handler: function () {
                     $('#OrderMessageBox').dialog('close')
                 }
             }]
    });

}
