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
	x = e.offsetX
	y = e.offsety
}