// offsetx
// offsety

window.addEventListener("load", function() {

	addWaldoListener();
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
}