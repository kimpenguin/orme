$(document).ready(function(){
	// alert('hi')
	$(".manual").on('click', function(){
		$("#manual-chronicle").show();
		$("#url-chronicle").hide();
		$(".url-rendered").hide()
	});
	$(".url").on('click', function(){
		$("#url-chronicle").show();
		$(".url-rendered").show();
		$("#manual-chronicle").hide();
	});
})