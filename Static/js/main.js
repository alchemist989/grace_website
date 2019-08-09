$(document).ready(function() {
    $(document).on("click", "#submit-comment", createComment);
});
  
  // Custom Endpoint
  var createComment = function () {
    $.post({
      type: "POST",
      url: "/comments",
      data: {
        "username": $("#nameInput").val(),
        "email": $("#emailInput").val(),
        "comment": $("#commentInput").val()
      },
      success(response) {
        var status = JSON.parse(response)["status"];
        if (status === "Comment Successful") {
          location.reload();
        }
        else {
          error("comment-input");
        }
      }
    });
  };