/*****************************************************************************
* @author         Chris Poole
* @date           21 July 2015
* @description:   This controller is the controller class for the calendar
******************************************************************************/
public without sharing class CS_LightningCalendarController {

    
    /*******************************************************************************
    * @author         Chris Poole
    * @date           21 July 2014
    * @description    Method to load events
    *******************************************************************************/
    @AuraEnabled
    public static String loadEvents() {
        list<calEvent> events = new list<calEvent>();
        //String dtFormat = 'yyyy-MM-dd';
        String dtFormat = 'yyyy-MM-dd HH:mm:ss';
        
        for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null]){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            calEvent bday = new calEvent();
            
            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = startDT.format(dtFormat);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + cont.Id;
            //bday.className = 'event-birthday';
            events.add(bday);
        }
        
        //Get Campaigns
        for(Campaign camp : [select Id, Name, StartDate, EndDate from Campaign where IsActive = true]){
            DateTime startDT = camp.StartDate;
            DateTime endDT = camp.EndDate;
            calEvent campEvent = new calEvent();
            
            campEvent.title = camp.Name;
            campEvent.allDay = true;
            campEvent.startString = startDT.format(dtFormat);
            campEvent.endString = endDT.format(dtFormat);
            campEvent.url = '/' + camp.Id;
            //campEvent.className = 'event-campaign';
            events.add(campEvent);
        }
        

        for(Event evnt: [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime from Event where OwnerID = :UserInfo.getUserId()]){
            DateTime startDT = evnt.StartDateTime;
            DateTime endDT = evnt.EndDateTime;
            calEvent myEvent = new calEvent();
            
            myEvent.title = evnt.Subject;
            myEvent.allDay = evnt.isAllDayEvent;
            myEvent.startString = startDT.format(dtFormat);
            myEvent.endString = endDT.format(dtFormat);
            myEvent.url = '/' + evnt.Id;
            //myEvent.className = 'event-personal';
            events.add(myEvent);
        }
        return JSON.serialize(events);
    }
    
    /*******************************************************************************
    * @author         Chris Poole
    * @date           21 July 2014
    * @description    Method to create events
    *******************************************************************************/    
    @AuraEnabled
    public static String createEvent() {
        return '';
    } 
    
    /*******************************************************************************
    * @author         Chris Poole
    * @date           21 July 2014
    * @description    Wrapper method
    *******************************************************************************/    
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        //public String className {get;set;}
    }
    
    
}