$(document).on('ready page:load', function(){

    // Character counter span element
    var commentCharacterCounter = $("#commentCharacterCounter");
    // Maximum and minimum number of characters
    var maxNumberOfCharacters = 1000;
    var minNumberOfCharacters = 0;

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

});
