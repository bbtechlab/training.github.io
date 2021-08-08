$(document).ready(function(){
    
    $("#Submit").click(function() {
        $.post("./register", {
            Emmail:$("#textEmail").val(),
            Name:$("#textName").val(),
            Phone:$("#TextPhone").val()
        }, function(data) {
            console.log(data);
        });
    });
});