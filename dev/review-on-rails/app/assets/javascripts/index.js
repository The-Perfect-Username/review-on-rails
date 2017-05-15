$(function() {
    var reviewsFeed = $('#reviewsFeed');

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
