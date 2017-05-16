$(document).on('ready page:load', function(){

    // Character counter span element
    var commentCharacterCounter = $("#commentCharacterCounter");
    // Maximum and minimum number of characters
    var maxNumberOfCharacters = 1000;
    var minNumberOfCharacters = 0;

    // Comments container where all comments are presented
    var commentsContainer = $("#commentsContainer");

    // Displays how many characters more characters can be typed
    // until it hits the maximum number
    $("textarea#comment_comment").on("keyup", function(e) {
        var numberOfCharacters = $(this).val().length;
        if (numberOfCharacters > 0) {
            commentCharacterCounter.show();
            commentCharacterCounter.text(maxNumberOfCharacters - numberOfCharacters);
        } else {
            commentCharacterCounter.hide();
        }
    });

    $(commentsContainer).on("click", "#loadMoreComments", function() {
        var btn = $(this);

        var postId = btn.attr("rel");
        var commentId = btn.attr("value");

        $.ajax({
            url: "/comments/loadmore",
            type: "post",
            data: {"post_id": postId, "comment_id": commentId},
            dataType: "html",
            error: function(err) {
                alert(JSON.stringify(err));
            },
            success: function(res) {
                btn.remove();
                commentsContainer.append(res);
            }
        });
    });

});
