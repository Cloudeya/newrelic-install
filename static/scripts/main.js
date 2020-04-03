// nav
$(document).ready(function() {
  $(".navbar a").on('click', function(event) {
    if (this.hash !== "") {
      event.preventDefault();
      var hash = this.hash;
      var ht = $(".navbar-fixed-top").height() - 50;
      var val = $(hash).offset().top;
      $('html, body').unbind().animate({
        scrollTop: val
      }, 500, function() {
        window.location.hash = hash;
      });
    }
  });

  $('.navbar-nav>li>a').on('click', function() {
    $('.navbar-collapse').collapse('hide');
  });

  $('.hidden').fadeIn(4000).removeClass('hidden');
  $('h1').fadeIn(4000).removeClass('hiddenA');
  $('p').fadeIn(4000).removeClass('hiddenB');
});

// cookies
window.addEventListener("load", function(){
  window.wpcc.init({
    "colors":{
    "popup":{
    "background":"#222222",
    "text":"#ffffff",
    "border":"#f9f9f9"
    },
    "button":{
      "background":"#F1D600",
      "text":"#000000"
    }
    },
    "position":"bottom",
    "margin":"none",
    "transparency":"10",
    "content":{
      "message":"This website uses cookies to ensure you get the best experience on our website.",
      "link":"Cookie Policy",
      "button":"Close",
      "href":"/cookie-policy"
    }
  })
});
