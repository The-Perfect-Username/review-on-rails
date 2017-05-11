$(document).ready(function() {

    var accountBody = $('#accountBody');

    $(document).on("click", "#loadMoreComments", function() {
        var btn = $(this);

        var commentId = btn.attr("value");

        $.ajax({
            url: "/account/comments/loadmore",
            type: "post",
            data: {"comment_id": commentId},
            dataType: "html",
            error: function(err) {
                alert(JSON.stringify(err));
            },
            success: function(res) {
                btn.remove();
                accountBody.append(res);
            }
        });
    });

    $(document).on("click", "#accountNavContainer a", function(e) {
        e.preventDefault();
        var btn = $(this);
        var url = btn.attr("href");

        $.ajax({
            url: url,
            type: "post",
            dataType: "html",
            error: function(err) {
                console.log(err);
            },
            success: function(res) {
                accountBody.empty();
                accountBody.html(res);
                btn.siblings().removeClass("selected");
                btn.addClass("selected");
            }
        });

    });


});
