$(document).foundation();

var c = document.getElementById("processing");
var ctx = c.getContext("2d");
c.width=500;
c.height=500;
ctx.fillStyle = "#f0f0f0";
ctx.fillRect(0, 0, 500, 500);
ctx.strokeStyle = "#ff0000";
ctx.moveTo(0, 0);
ctx.lineTo(500, 500);
ctx.stroke();
ctx.moveTo(500, 0);
ctx.lineTo(0, 500);
ctx.stroke();
