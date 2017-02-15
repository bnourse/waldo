
var timer;
var seconds = 0;

window.addEventListener("load", function() {

	addWaldoListener();
	startTimer();

});

function addWaldoListener() {
	var ww_img = document.getElementById("ww_img");
	ww_img.addEventListener("click", wwImgClicked);

}

function wwImgClicked(e) {
	x = e.offsetX;
	y = e.offsetY;
	checkClick(x,y);
}

// var click = {
// 	check: function(){

// 	}
// }

// click.check()
// click.getX
// check out UPCASE tutorials
// CONNECT reimbursement


function checkClick(x,y) {
	var querystring = "x=" + x + "&y=" + y;
	var xhr = new XMLHttpRequest();
	xhr.open('POST', '/check_click', true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(querystring);
	xhr.addEventListener("load", function (e) {
		waldo_found = e.target.responseText;
		if (waldo_found == "true") {
			var is_high_score = checkHighScore(seconds);
			endGame(is_high_score);
			
		}
		else {
			keepTrying();
		}
	});
}

function endGame(is_high_score) {
	clearInterval(timer);
	high_score_msg = "";
	if (is_high_score == "true") {
		high_score_msg = "Congratulations! You set a new high score!";
	}
	alert("You found waldo in " + seconds + "s");
}

function checkHighScore(seconds_taken) {
	var image_name = getImageName();
	var querystring = "image_name=" + image_name + "&seconds_taken=" + seconds_taken;
	var xhr = new XMLHttpRequest();
	var is_high_score;
	xhr.open('POST', '/check_high_score', true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(querystring);
	xhr.addEventListener("load", function () {
		is_high_score = xhr.responseText;
	});

	return is_high_score;
}

function getImageName() {
	img_src = document.getElementById("ww_img").getAttribute("src");
	image_name = img_src.split("./images/")[1];
	return image_name;
}

function keepTrying() {

}

function startTimer() {
	timer = setInterval(myTimer, 1000);	
}

function myTimer() {
	seconds++;
    document.getElementById("seconds").innerHTML = seconds;

}