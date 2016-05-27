/* Joseph Harrington  *
 * <dev@jharring.com> *
 * March 2012         */

$(function() {

  
  $("#word_textbox").keyup(function ()
  {                                                     // whenever text is entered into input box...
    uivars.theId = $(this).val();                       // update word variable,
    var p = Processing.getInstanceById('imgGen');
    if (p) p.importId();                                // and call updateWord function in pjs sketch.
  });
  
  $("#word_textbox").val(uivars.theId);                // initialize input textbox contents.

});
