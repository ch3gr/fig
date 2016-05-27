var Minimal = false;
function HUI_minimalToggle()
{
	Minimal = !Minimal;

	var divs = document.getElementsByClassName("minimal");
	var d;
	for (d = 0; d < divs.length; d++)
	{
		if( Minimal )
	    	divs[d].style.display = 'none';
	    else
	    	divs[d].style.display = 'inline';
	}

	if( Minimal )
	{
		document.getElementById('buttonMinimal').classList.add("toggled");
		document.getElementById('canvasDiv').classList.remove("large-7");
		document.getElementById('canvasDiv').classList.add("large-12");
	}
	else
	{
		document.getElementById('buttonMinimal').classList.remove("toggled");
		document.getElementById('canvasDiv').classList.remove("large-12");
		document.getElementById('canvasDiv').classList.add("large-7");
	}


	//console.log("Minimal :" + Minimal);
}







//// BIND FUNCTIONS BETWEEN JAVA SCRIPT AND PROCESSING

// Processing to HTML

function HUI_updateImgInfo( inStep, inRes, inCd, inLimit )
{
	document.getElementById('stepSize').innerHTML = inStep;
	document.getElementById('res').innerHTML = inRes;
	document.getElementById('cDepth').innerHTML = inCd;
	document.getElementById('limit').innerHTML = inLimit + " combinations";
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


function HUI_updateToggle( inAuto, inValues, inSample )
{
	if( inAuto === true )
		document.getElementById('buttonAuto').classList.add("toggled");
	else
		document.getElementById('buttonAuto').classList.remove("toggled");
	
	if( inValues === true )
		document.getElementById('buttonValues').classList.add("toggled");
	else
		document.getElementById('buttonValues').classList.remove("toggled");

	switch( inSample )
	{
		case 1:
			document.getElementById('buttonS1').classList.add("toggled");
			document.getElementById('buttonS2').classList.remove("toggled");
			document.getElementById('buttonS3').classList.remove("toggled");
			document.getElementById('buttonS4').classList.remove("toggled");
			break;
		case 2:
			document.getElementById('buttonS1').classList.remove("toggled");
			document.getElementById('buttonS2').classList.add("toggled");
			document.getElementById('buttonS3').classList.remove("toggled");
			document.getElementById('buttonS4').classList.remove("toggled");
			break;
		case 3:
			document.getElementById('buttonS1').classList.remove("toggled");
			document.getElementById('buttonS2').classList.remove("toggled");
			document.getElementById('buttonS3').classList.add("toggled");
			document.getElementById('buttonS4').classList.remove("toggled");
			break;
		case 4:
			document.getElementById('buttonS1').classList.remove("toggled");
			document.getElementById('buttonS2').classList.remove("toggled");
			document.getElementById('buttonS3').classList.remove("toggled");
			document.getElementById('buttonS4').classList.add("toggled");
			break;
		default:
			document.getElementById('buttonS1').classList.remove("toggled");
			document.getElementById('buttonS2').classList.remove("toggled");
			document.getElementById('buttonS3').classList.remove("toggled");
			document.getElementById('buttonS4').classList.remove("toggled");
	}
}





// HTML JS to Processing

function processingSetId( value )
{
	Processing.getInstanceById("imgGen").setIdFromTextField(value);
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
		Processing.getInstanceById("imgGen").randomImg();
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



