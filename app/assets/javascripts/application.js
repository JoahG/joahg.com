// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .


$(document).ready(function(){
	$(".sidebar nav ul li a:not(.email)").click(function(){
		$(this).parent().siblings().each(function(){
			$(this).removeClass("active");
		})
		$(this).parent().addClass("active")
	})
});

var oldHTML = null;
var newHTML = null;
var sidebarHTML = null;

$(document).on('page:fetch', function() {
	oldHTML = $(".content").html()
	sidebarHTML = $(".sidebar").html()
});

$(document).on('page:change', function() {
	newHTML = $(".content").html()
	$(".sidebar").html(sidebarHTML)
	if (newHTML != oldHTML) {
		$(".content").html(oldHTML)
		$(".content").fadeOut(250, function(){
			$(".content").html(newHTML)
			$(".content").fadeIn(250)
		})
	}
});