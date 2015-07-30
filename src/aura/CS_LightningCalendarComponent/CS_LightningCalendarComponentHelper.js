({
    getEvents : function(component) {
        
        $A.logger.subscribe("INFO", logCustom);

        function logCustom(level, message, error) {
            console.log(getTimestamp(), "logCustom: ", arguments);
		}
        function getTimestamp() {
            return new Date().toJSON();
		}
        
		var ready = component.get("v.ready");
        	if (ready === false) {
        	    return;   
			}
       	var calendarElement = component.find('calendar').getElement();
 		
		var myevents = component.get("c.loadEvents");
        myevents.setCallback(this, function(response) {
            // console.log('In callback response = ' + JSON.stringify(response));
            if (response.getState() === "SUCCESS") {
                //console.log('Return value = ' + response.getReturnValue());
                var parsed = JSON.parse(response.getReturnValue(), function(k, v) {
                    if (k === "startString") 
                        this.start = v;
                    else if (k === "endString")
                        this.end = v;
                    else
                        return v;
                });
                //console.log(JSON.stringify(parsed));
                $(calendarElement).fullCalendar({
                    header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            editable: true,
            selectable: true,
            selectHelper: true,
            select: function(start, end, allDay) {
                //$('#modalTitle').html(eventData.title);
                //$('#modalBody').html(eventData.description);
                //$('#eventUrl').attr('href',eventData.url);
                $('#calendarModal').modal();
                /*var eventData;
                if (title) {
                    eventData = {
                        title: title,
                        start: start,
                        end: end
                    };
                    $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                }*/
                //$('#calendar').fullCalendar('unselect');
               
            },    
            droppable: true, // this allows things to be dropped onto the calendar
           drop:  function(event, jsEvent, view) {
                    $('#modalTitle').html(this.title);
                    $('#calendarModal').modal();
                }, 
           eventClick:  function(event, jsEvent, view) {
                    $('#modalTitle').html(event.title);
                    $('#modalBody').html(event.description);
                    $('#eventUrl').attr('href',event.url);
                    $('#calendarModal').modal();
                },            
                    events: parsed
                });     
                //response.getReturnValue();
            } else if (a.getState() === "ERROR") {
                console.log("Errors", response.getError());
            }
        });
        //console.log(jsonEvents);
        $A.enqueueAction(myevents); 

           
    }
})