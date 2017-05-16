$(function() {
    var reviewsFeed = $('#reviewsFeed');

    // Sends a request to the server to load more reviews
    // made by the community
    $(reviewsFeed).on("click", "#loadMorePosts", function() {
        var btn = $(this);

        var postId = btn.attr("value");

        $.ajax({
            url: "/reviews/loadmore",
            type: "post",
            data: {"post_id": postId},
            dataType: "html",
            error: function(err) {
                alert(JSON.stringify(err));
            },
            success: function(res) {
                btn.remove();
                reviewsFeed.append(res);
            }
        });
    });

});
