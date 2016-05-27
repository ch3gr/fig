/*
LINKS
http://joseph-harrington.com/2012/03/controlling-processingjs-jqueryui/
http://processingjs.org/articles/PomaxGuide.html#jstosketch.html
http://processingjs.nihongoresources.com/interfacing/

*/


// Numeric only control handler
jQuery.fn.ForceNumericOnly =
function()
{
    return this.each(function()
    {
        $(this).keydown(function(e)
        {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
            // home, end, period, and numpad decimal
            return (
                key == 8 || 
                key == 9 ||
                key == 13 ||
                key == 46 ||
                key == 190 ||
                (key >= 35 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));
        });
    });
};




/*
$(function() {
  $('#staticParent').on('keydown', '#child', function(e){
  -1!==$.inArray(e.keyCode,[46,8,9,27,13,110,190]) ||
/65|67|86|88/.test(e.keyCode)&&
(!0===e.ctrlKey||!0===e.metaKey)||
35<=e.keyCode&&40>=e.keyCode||
(e.shiftKey||48>e.keyCode||57<e.keyCode)&&
(96>e.keyCode||105<e.keyCode)&&
e.preventDefault()});
})
*/


$(function() {
  
  $("#uiId").ForceNumericOnly();
  $("#uiId").keyup(function ()
  {                                                     // whenever text is entered into input box...
    
    uivars.id = $(this).val();                       // update word variable,
    var p = Processing.getInstanceById('imgGen');
    //if (p) p.importId();                                // and call updateWord function in pjs sketch.
  });
  $("#uiId").val(uivars.id);                // initialize input textbox contents.
  
  
  
  
  $("#uiIdSlider").on("input change", function()
  {
    uivars.slider = $(this).val();
    var p = Processing.getInstanceById('imgGen');
    //if (p) p.importId();
  });
  $("#uiIdSlider").val(uivars.slider);
  
});


