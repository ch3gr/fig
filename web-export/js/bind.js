var uivars =
{
	id: "0"
};


var bound = false;

function bindJavascript()
{
	console.log("1");
	var pjs = Processing.getInstanceById("imgGen");
	if(pjs!=null)
	{
		console.log("2");
		pjs.bindJavascript(this);
		bound = true;
	}
	if(!bound)
	{
// What the fuck!!!
//		setTimeout(bindJavascript, 1000);
		console.log("3");
	}
}


console.log("4");
bindJavascript();
console.log("5");




function HUI_updateDivs( explore, about )
{
	if( explore )
		document.getElementById('idField').style.display = "block";
	else
		document.getElementById('idField').style.display = "none";

	if( about )
		document.getElementById('about').style.display = "block";
	else
		document.getElementById('about').style.display = "none";
}






////////////////////////////
// New stuff
////////////////////////////


function HUI_updateImgInfo( inStep, inX, inY, inCd )
{
	document.getElementById('stepSize').innerHTML = inStep;
	document.getElementById('xSize').innerHTML = inX;
	document.getElementById('ySize').innerHTML = inY;
	document.getElementById('cDepth').innerHTML = inCd;
}

function HUI_updateSlider( theValue )
{
	document.getElementById('uiIdSlider').value = theValue;
}

function HUI_updateId( theId )
{
	document.getElementById('uiId').value = theId;
}






function processingSlider( value )
{
	Processing.getInstanceById("imgGen").slider(value);
}


function processingCall( func )
{
	if( func === "prev" )
		Processing.getInstanceById("imgGen").prev();
	else if( func === "next" )
		Processing.getInstanceById("imgGen").next();
	else if( func === "incUp" )
		Processing.getInstanceById("imgGen").incUp();
	else if( func === "incDown" )
		Processing.getInstanceById("imgGen").incDown();
	else if( func === "rUp" )
		Processing.getInstanceById("imgGen").rUp();
	else if( func === "rDown" )
		Processing.getInstanceById("imgGen").rDown();
	else if( func === "xUp" )
		Processing.getInstanceById("imgGen").xUp();
	else if( func === "xDown" )
		Processing.getInstanceById("imgGen").xDown();
	else if( func === "yUp" )
		Processing.getInstanceById("imgGen").yUp();
	else if( func === "yDown" )
		Processing.getInstanceById("imgGen").yDown();
	else if( func === "cUp" )
		Processing.getInstanceById("imgGen").cUp();
	else if( func === "cDown" )
		Processing.getInstanceById("imgGen").cDown();
	else if( func === "auto" )
		Processing.getInstanceById("imgGen").auto();
	else if( func === "showValues" )
		Processing.getInstanceById("imgGen").showValues();
	else if( func === "randomize" )
		Processing.getInstanceById("imgGen").randomize();
	else if( func === "clearCanvas" )
		Processing.getInstanceById("imgGen").clearCanvas();
	else if( func === "slider" )
		Processing.getInstanceById("imgGen").slider();

}



