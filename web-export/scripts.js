
// function to limit the text input only to numbers and copy/past
numbersOnly( document.getElementById('uiId') );

function numbersOnly(elem) {
  elem.onkeypress=function(e) {
    // 0 to 9
    if (e.charCode>=48 && e.charCode<=59) return true;
    // arrows
    if (e.keyCode>=37 && e.keyCode<=40) return true;
    // home
    if (e.keyCode==36) return true;
    // end
    if (e.keyCode==35) return true;
    // backspace
    if (e.keyCode==8) return true;
    // delete
    if (e.keyCode==46) return true;
    // ctrl+v or ctrl+V
    if (e.ctrlKey && (e.charCode==118 || e.charCode==86)) return true;
    // ctrl+a or ctrl+A
    if (e.ctrlKey && (e.charCode==97 || e.charCode==65)) return true;
    // ctrl+c or ctrl+C
    if (e.ctrlKey && (e.charCode==99 || e.charCode==67)) return true;
    // ctrl+x or ctrl+X
    if (e.ctrlKey && (e.charCode==120 || e.charCode==88)) return true;
    //console.dir(e);
    e.preventDefault();
  }
  elem.onkeyup=function(e) {
    this.value=this.value.replace(/[^\d]/g,'');
    Processing.getInstanceById("imgGen").setIdFromTextField(this.value);
  }
};




// make sure the id in the html div is zero when you start
//document.getElementById('uiId').value = 0;
