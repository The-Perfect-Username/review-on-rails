$(document).ready(function() {

    var accountBody = $('#accountBody');

    // Loads more comments for the user account
    $(accountBody).on("click", "#loadMoreComments", function() {
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

    // Loads more posts for the user account
    $(accountBody).on("click", "#loadMorePosts", function() {
        var btn = $(this);

        var postId = btn.attr("value");

        $.ajax({
            url: "/account/reviews/loadmore",
            type: "post",
            data: {"post_id": postId},
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

    // Shows the list of comments or reviews made by the user
    $(document).on("click", "#accountNavContainer a", function(e) {
        e.preventDefault();
        var btn = $(this);
        var url = btn.attr("href");
        var userId = btn.attr("rel");

        $.ajax({
            url: url,
            type: "post",
            data: {'user_id': userId},
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
