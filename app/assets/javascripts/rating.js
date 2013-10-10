if ($('#starVenue').length) {
    $('#starVenue').raty({
        hints: $('#ratingHint:hidden').attr('value').split("; "),
        target: '#starVenueHint',
        targetKeep: true,
        cancel : true,
        score: function() {
            return $('#review_rating_venue:hidden').attr('value');
        },
        click: function(score, evt) {
            starClick('venue', score);
        }
    });
}

if ($('#starFood').length) {
    $('#starFood').raty({
        hints: $('#ratingHint:hidden').attr('value').split("; "),
        target: '#starFoodHint',
        targetKeep: true,
        cancel : true,
        score: function() {
            return $('#review_rating_food:hidden').attr('value');
        },
        click: function(score, evt) {
            starClick('food', score);
        }
    });
}

if ($('#starServices').length) {
    $('#starServices').raty({
        hints: $('#ratingHint:hidden').attr('value').split("; "),
        target: '#starServicesHint',
        targetKeep: true,
        cancel : true,
        score: function() {
            return $('#review_rating_services:hidden').attr('value');
        },
        click: function(score, evt) {
            starClick('services', score);
        }
    });
}

if ($('#starFacilities').length) {
    $('#starFacilities').raty({
        hints: $('#ratingHint:hidden').attr('value').split("; "),
        target: '#starFacilitiesHint',
        targetKeep: true,
        cancel : true,
        score: function() {
            return $('#review_rating_facilities:hidden').attr('value');
        },
        click: function(score, evt) {
            starClick('facilities', score);
        }
    });
}

$('#writeReview').focus(function () {
    if ($('#btnPost').attr("disabled") == 'disabled') {
        $('#writeReview').blur();
        $('#login-form').click();
    }
});

function starClick(element, score) {
    if ($('#btnPost').attr("disabled") == 'disabled') {
        $('#login-form').click();
    }
    else {
        $('#review_rating_' + element + ':hidden').attr('value', score);
    }
}