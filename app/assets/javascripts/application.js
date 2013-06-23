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
//= require jquery.ui.all
//= require_tree .

var home = null
var mobile = null; 
var navclearfix = "<span class='nav-clearfix'>&nbsp;</span>"


var gridize = function() {
	a = $("#find ul li a")
	b = []
	while (a.length > 0) {
		b.push(a.splice(0,3))
	}
	$("#find ul").remove()
	html = ""
	for (i in b) {
		o = b[i]
		h = "<div class='row clearfix'>"
		for (j in o) {
			d = o[j]
			if (d != o[o.length-1] && d != o[0]) {
				h += "<div class='four columns logo'><a href='"+d.href+"' target='_blank'><div class='img' style='background-image:url("+d.getAttribute("data-img")+")' /><h6>"+d.text+"</h6></a></div>"
			} else if (d === o[o.length-1]) {
				h += "<div class='four columns omega logo'><a href='"+d.href+"' target='_blank'><div class='img' style='background-image:url("+d.getAttribute("data-img")+")' /><h6>"+d.text+"</h6></a></div>"
			} else if (d === o[0]) {
				h += "<div class='four columns alpha logo'><a href='"+d.href+"' target='_blank'><div class='img' style='background-image:url("+d.getAttribute("data-img")+")' /><h6>"+d.text+"</h6></a></div>"
			}
		}
		h += "</div>"
		html += h
	}
	if (html != "") {
		$("#find").html(html)
	}
}

$(document).ready(function(){
	mobile = $(window).width() <= 767 ? true : false
	$(".sidebar nav ul li a:not(.email)").click(function(){
		$(this).parent().siblings().each(function(){
			$(this).removeClass("active");
		})
		$(this).parent().addClass("active")
		Turbolinks.visit($(this).attr("href"))
	})
	$("a[data-nav-trigger]").click(function(){
		$(".nav_"+$(this).attr("data-nav-trigger")).click()
		return false
	});
	$(".mobile-nav-trigger").click(function(){
		$("nav ul").toggle("blind", {direction: "vertical"}, 300)
	});
	if (mobile) {
		$(".nav-clearfix").remove()
	}
});

var oldHTML = null;
var newHTML = null;
var mobileNavShown = false;

$(document).on('page:fetch', function() {
	oldHTML = $(".content").html()
	if ($("nav ul").css("display") === "block" && $("nav ul").css("display") != "none") {
		mobileNavShown = true;
	}
});

$(document).on('page:change', function() {
	newHTML = $(".content").html()
	if (mobile && mobileNavShown) {
		$("nav ul").show()
		$("nav ul").hide("blind", {direction: "vertical"}, 300)
		mobileNavShown = false
	}
	if (newHTML != oldHTML) {
		$(".content").html(oldHTML)
		$("nav ul").promise().done(function(){
			$(".content").fadeOut(250, function(){
				$(".content").html(newHTML)
				$(".content").fadeIn(250)
			});
		});
	}
});

$(window).resize(function(){
	if ($(window).width() >= 767) {
		$("nav ul").show()
		mobile = false
		if ($(".nav-clearfix").length === 0) {
			$(".sidebar").append(navclearfix)
		}
	}
	if ($(window).width() <= 767) {
		$("nav ul").hide()
		mobile = true
		$(".nav-clearfix").remove()
	}
})