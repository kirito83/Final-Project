// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require custom
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require_self

function main() {
	$('.infos').hide();
	$('.participants').hide();
	$('.btn-bracket').on('click', function() {
		$(this).toggleClass('active');
		$('.infos').hide();
		$('.participants').hide();
		$('.bracket').slideToggle(1000);
	});
	$('.btn-infos').on('click', function() {
		$(this).toggleClass('active');
		$('.bracket').hide();
		$('.participants').hide();
		$('.infos').slideToggle(1000);
	});
	$('.btn-participants').on('click', function() {
		$(this).toggleClass('active');
		$('.presenation').hide();
		$('.infos').hide();
		$('.participants').slideToggle(1000);
	});
}

$(document).ready(main);