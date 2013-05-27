$(document).ready(function() {
  $.ajax({
    type: 'post',
    url: ('/' + $('span').text())
  }).done(function(data) {
      $('ul li:first-child').remove();
    $.each(data, function(i, val) {
      $('ul').prepend("<li>" + val.tweet.tweet + "</li>");
    } );
  });
});