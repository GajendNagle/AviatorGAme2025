// JScript File
//////
function UploadProfilePics() {

    
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>'); 
    ////
//    var fileUpload = $("#msgFile").get(0);

 var h1=$("#dataHeight").val();
 var w1=$("#dataWidth").val();
 
 

var fileUpload = $("#inputImage").get(0);

    var files = fileUpload.files;
    var test = new FormData();
if (files.length == 0)   
{
    $('#Msgs').html("<div class='alert alert-danger m-b-10'>Select image for upload.</div>");
//    $('#Msgs').html("<div class='alert  red-skin alert-rounded'><img src='../../images/close-button.png' width='25' heigth='25' alt=''> Select image for upload <button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button> </div> ");
//    swal({
//                        title: "Select image for upload.",
//                        //text: Response.Message,
//                        type: "warning"
//                    });
                    
                     
                    
                    return;
}
else 
{

    if (parseFloat(h1)<250 || parseFloat(w1) <250)
    {
        $('#Msgs').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> Image is too small. </div>");
//        $('#Msgs').html("<div class='alert  red-skin alert-rounded'><img src='../../images/close-button.png' width='25' heigth='25' alt=''> Image is too small. <button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button> </div> ");
//            swal({
//                        title: "Image is too small.",
//                        //text: Response.Message,
//                        type: "warning"
//                    });
        return;
    }
    else
    {

for (var i = 0; i < files.length; i++) {
    test.append(files[i].name, files[i]);
    }
    
    
     
    ///////
//    var x1=$("#x").val();
//    var data = JSON.parse(x1);
//    ////////
//    test.append("x1", Math.round(data['actions']['crop']['x']));
//    test.append("y1", Math.round(data['actions']['crop']['y']));    
//    test.append("h1", Math.round(data['actions']['crop']['height']));
//    test.append("w1", Math.round(data['actions']['crop']['width']));

    
    var x1=$("#dataX").val();
    var y1=$("#dataY").val();
    //var h1=$("#dataHeight").val();
    //var w1=$("#dataWidth").val();
    var fileext= $("#fileext").val(); 

    test.append("x1", Math.round(x1));
    test.append("y1", Math.round(y1));    
    test.append("h1", Math.round(h1));
    test.append("w1", Math.round(w1));
    test.append("fileext", fileext);


    ////////
    $.ajax({
        url: "Handlers/Upload-Profile-Pics.ashx",

        type: "POST",
        contentType: false,
        processData: false,
        data: test,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {

                    //$('#Msgs').html(Response.Message);
                $('#Msgs').html("<div class='alert alert-success m-b-10'><strong>Well Done!</strong> " + Response.Message + "</div>");
//                    $('#Msgs').html("<div class='alert red-skin1 alert-rounded'><img src='../../images/resource/check.png'width='25'  heigth='25'  alt=''> "+Response.Message+"<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");
              //alert(Response.Message);
              parent.location.reload(true);
            }
            else {

                    $('#Msgs').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + Response.Message + "</div>");
//                    $('#Msgs').html("<div class='alert red-skin alert-rounded'><img src='../../images/close-button.png'width='25'  heigth='25'  alt=''>"+Response.Message+"<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");
            }
        },
            error: function (err) { 
//        $('#Msgs').html("<div class='alert  red-skin alert-rounded'><img src='../../images/close-button.png' width='25' heigth='25' alt=''> "+err.statusText+" <button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button> </div> ");
                $('#Msgs').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + err.statusText + "</div>");
                     //$('#Msgs').html('Ooops!!! Upload error!');
        }
    });


}

}
    
}





var file = document.getElementById('inputImage');

file.onchange = function(e){

    var ext = this.value.match(/\.([^\.]+)$/)[1];
    switch(ext)
    {
        case 'jpg':
        case 'bmp':
        case 'png':
        case 'gif':
        case 'jpeg':
        
            
            $("#fileext").val(ext);
            break;
        default:
            
            this.value='';
            $("#fileext").val('');
    }
};