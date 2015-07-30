({
    // Runs after the scripts and styles have loaded and calls
    // the calendar component in the helper
    doInit : function(component, event, helper) {
        component.set("v.ready", true);
		helper.getEvents(component);
       
        // Action: This needs to be tied into the calendar js to save an event
        $('#external-events div.external-event').each(function() {

            // store data so the calendar knows to render an event upon drop
            $(this).data('event', {
                title: $.trim($(this).text()), // use the element's text as the event title
                stick: true // maintain when user navigates (see docs on the renderEvent method)
            });

            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 1111999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });

        });
        
        
    },
    
    // Method to create the new calendar event
    createEvent : function(component, event, helper) {
    }
})