// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var ready = function() {
  $(function () {
    $('.btn-radio').click(function(e) {
      $('.btn-radio').not(this).removeClass('active')
    		.siblings('input').prop('checked',false)
        .siblings('.img-radio').css('opacity','0.5');
    	$(this).addClass('active')
        .siblings('input').prop('checked',true)
    		.siblings('.img-radio').css('opacity','1');
      if ($(this).siblings('input').attr('id') == 'truck') {
        $('.truck-options').slideDown();
      } else {
        $('.truck-options').slideUp();
      }
    });
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
