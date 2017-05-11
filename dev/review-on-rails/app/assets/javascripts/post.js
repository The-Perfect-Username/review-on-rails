$(document).on('ready page:load', function(){

    // Character counter span elements
    var postCharacterCounter = $("#postCharacterCounter");
    var titleCharacterCounter = $("#titleCharacterCounter");
    // Maximum and minimum number of characters
    var maxNumberOfCharactersForPost = 1000;
    var maxNumberOfCharactersForTitle = 100;
    var minNumberOfCharacters = 0;

    // Displays how many characters more characters can be typed
    // until it hits the maximum number for the title input
    $("input#post_title").on("keyup", function(e) {
        var numberOfCharacters = $(this).val().length;
        if (numberOfCharacters > 0) {
            titleCharacterCounter.show();
            titleCharacterCounter.text(maxNumberOfCharactersForTitle - numberOfCharacters);
        } else {
            titleCharacterCounter.hide();
        }
    });

    // Displays how many characters more characters can be typed
    // until it hits the maximum number for the post textarea
    $("textarea#post_post").on("keyup", function(e) {
        var numberOfCharacters = $(this).val().length;
        if (numberOfCharacters > 0) {
            postCharacterCounter.show();
            postCharacterCounter.text(maxNumberOfCharactersForPost - numberOfCharacters);
        } else {
            postCharacterCounter.hide();
        }
    });

});
