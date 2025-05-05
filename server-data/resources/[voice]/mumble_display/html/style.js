$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var data = event.data;
		if (data.show == false){
			$("body").show();
			if (data.muted) {
				$('.mic1').removeClass('muted');
				$('.mic2').addClass('hide');
				$('.mic1').removeClass('hide');
			} else if (!data.talking) {
				$(".mic2").attr("src","mic_inactive.png");
				$(".circle3").attr("style","background-color:white");
			} else {
				$(".circle3").attr("style","background-color:red");
			}

			if (data.range == '3.0') {
				document.querySelectorAll('.wave3')[0].style.setProperty("--top", `30%`);
			} else if (data.range == '8.0') {
				document.querySelectorAll('.wave3')[0].style.setProperty("--top", `0%`);
			} else if (data.range == '15.0') {
				document.querySelectorAll('.wave3')[0].style.setProperty("--top", `-25%`);
			} else if (data.range == '32.0') {
				document.querySelectorAll('.wave3')[0].style.setProperty("--top", `-50%`);
			}
		} else {
			 $("body").hide();
		}
    });
});