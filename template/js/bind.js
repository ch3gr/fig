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


function HUI_updateImgInfo( inStep, inX, inY, inCd, inLimit )
{
	document.getElementById('stepSize').innerHTML = inStep;
	document.getElementById('xSize').innerHTML = inX;
	document.getElementById('ySize').innerHTML = inY;
	document.getElementById('cDepth').innerHTML = inCd;
	document.getElementById('limit').innerHTML = inLimit;
}

function HUI_updateSlider( inValue, inSince, inUntil )
{
	document.getElementById('uiIdSlider').value = inValue;
	document.getElementById('since').innerHTML = inSince;
	document.getElementById('until').innerHTML = inUntil;
}

function HUI_updateId( inId )
{
	document.getElementById('uiId').value = inId;
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
	else if( func === "autoMode" )
		Processing.getInstanceById("imgGen").autoMode();
	else if( func === "showValues" )
		Processing.getInstanceById("imgGen").showValues();
	else if( func === "randomize" )
		Processing.getInstanceById("imgGen").randomize();
	else if( func === "clearCanvas" )
		Processing.getInstanceById("imgGen").clearCanvas();
	else if( func === "slider" )
		Processing.getInstanceById("imgGen").slider();
	else if( func === "sample1" )
		Processing.getInstanceById("imgGen").sample(1);
	else if( func === "sample2" )
		Processing.getInstanceById("imgGen").sample(2);
	else if( func === "sample3" )
		Processing.getInstanceById("imgGen").sample(3);
	else if( func === "sample4" )
		Processing.getInstanceById("imgGen").sample(4);

}



