function avtar(avtarId) {
    // Create FormData object
    var formData = new FormData();

    formData.append('avtarId', avtarId);

    // Set up the request
    $.ajax({
        url: "Handlers/Upload_Avtar.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: formData, // Use formData instead of test
        dataType: "json",
        success: function (data) {
            if (data.Success) {
                /*$('#Msgs').html("<div class='alert alert-success m-b-10'><strong>Well Done!</strong> " + data.Message + "</div>");*/
                window.location.href = "modify-myinfo.html";
                self.undelegateEvents();
                delete self;
            } else {
                $('#Msgs').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + data.Message + "</div>");
            }
        },
        error: function (err) {
            $('#Msgs').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + err.statusText + "</div>");
        }
    });
}
$(".avtwidth").click(function () {
    // Remove active class from all .avtwidth elements
    $(".avtwidth").removeClass("active");

    // Remove border from all .avtwidth elements
    $(".avtwidth").removeClass("borderactive");

    // Add active class to the clicked .avtwidth element
    $(this).addClass("active");

    // Add border to the clicked .avtwidth element
    $(this).addClass("borderactive");

    // Toggle visibility of the adjacent icon-position span element
    $(this).next(".icon-position").toggle();
});
