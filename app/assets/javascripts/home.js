// fade news 

$(function($){
       var quotes = $(".quotes");
       var quoteIndex = -1;
       function showNextQuote() {
           ++quoteIndex;
           quotes.eq(quoteIndex % quotes.length)
               .fadeIn(1000)
               .delay(4000)
               .fadeOut(1000, showNextQuote);
       }
       showNextQuote();
});


// scroll up 

    $(document).ready(function(){
        $(window).scroll(function(){
            if ($(this).scrollTop() > 100) {
                $('.scrollup').fadeIn();
            } else {
                $('.scrollup').fadeOut();
            }
        });
 
        $('.scrollup').click(function(){
            $("html, body").animate({ scrollTop: 0 }, 500);
            return false;
        });
 
    });


/*
// jquery jcarousel 

	jQuery(document).ready(function() {
			jQuery('#mycarousel').jcarousel();
	});
	
	jQuery(document).ready(function() {
			jQuery('#mycarouseltwo').jcarousel();
	});
	
	jQuery(document).ready(function() {
			jQuery('#mycarouselthree').jcarousel();
	});
	
	jQuery(document).ready(function() {
			jQuery('#mycarouselfour').jcarousel();
	});
*/

// REVOLUTION SLIDER 
	var revapi;

	jQuery(document).ready(function() {

		   revapi = jQuery('.tp-banner').revolution(
			{
				delay:9000,
				startwidth:1170,
				startheight:500,
				hideThumbs:10,
				fullWidth:"on",
				forceFullWidth:"on"
			});

	});	//ready


