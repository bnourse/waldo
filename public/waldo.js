
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

function checkClick(x,y) {
	querystring = "x=" + x + "&y=" + y;
	var xhr = new XMLHttpRequest();
	xhr.open('POST', '/check_click', true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(querystring);
	xhr.addEventListener("load", function () {
		waldo_found = xhr.responseText;
		if (waldo_found == "true") {
			endGame();
			checkHighScore(seconds);
		}
		else {
			keepTrying();
		}
	});
}

function endGame() {
	clearInterval(timer);
	alert("You found waldo in " + seconds + "s");
}

function checkHighScore() {
	image_name = getImageName();
	debugger;
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