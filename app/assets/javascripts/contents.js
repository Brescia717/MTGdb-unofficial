$(function(){
    var imageContainer = '.card-img-container',
        imageList      = '.hover-img',
        imageClass     = 'hover-img'
        maxWidth       = 'parent', // parent or specific css width/
        defImage       = '/assets/MTG_card_back.jpg';
    var $imageContainer = $(imageContainer).eq(0);
    var $imageList      = $(imageList).eq(0);
    if (maxWidth === 'parent') { maxWidth = $imageContainer.width() + 'px'; }
    //Load images and set hover::
    if ( $('ul').hasClass(imageClass) ) {
      $('ul').find('li').each(function(index) {
        if (typeof $(this).data('image') === 'string') {
            $imageContainer.append(
                "<img id='imageToggle"+index+
                "' src='"+$(this).data('image')+
                "' style='max-width: "+maxWidth+"; display:none;' />"
            );
            $(this).data("image","imageToggle"+index);
            $(this).hover(
                function(){ loadImage($(this).data('image')); },
                function(){ loadImage('imageToggleDef'); }
            );
        }
      });
    }
    //Load default:
    $imageContainer.append(
                "<img id='imageToggleDef"+
                "' src='"+defImage+
                "' style='max-width: "+maxWidth+"' />"
    );
    //Toggle images:
    function loadImage(imageId) {
        $imageContainer.stop(true).fadeOut('fast', function(){
            $(this).find('img').hide();
            $(this).find('img#'+imageId).show();
            $(this).fadeIn('fast');
        });
    }

});
