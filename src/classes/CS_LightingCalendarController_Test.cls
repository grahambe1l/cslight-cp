/*****************************************************************************
* @author         Chris Poole
* @date           21 July 2015
* @description:   This controller is the controller class for the calendar
******************************************************************************/
@isTest(seealldata=true)
public class CS_LightingCalendarController_Test {

    static testmethod void testInsert() {
        //create & insert test data 
        //make sure to include all required fields and that it will pass any active Validation Rules
        Account acct = new Account (Name = 'Acme, Inc.');
        insert acct;

        Contact con = new Contact(
                          FirstName = 'Test',
                          LastName = 'User',
            			  Birthdate = date.today(),
                          AccountId = acct.Id);
        insert con;   

        Campaign camp = new Campaign(
                            Name = 'Test',
            				StartDate = date.today(),
            				EndDate = date.today(),
                            IsActive = TRUE);            
        insert camp;

 
// Let's create a new test user
    Profile testProfile = [SELECT Id 
                           FROM profile
                           WHERE Name = 'System Administrator' 
                           LIMIT 1];

    User testUser = new User(LastName = 'test user 1', 
                             Username = 'test.user.1@example.com', 
                             Email = 'test.1@example.com', 
                             Alias = 'testu1', 
                             TimeZoneSidKey = 'GMT', 
                             LocaleSidKey = 'en_GB', 
                             EmailEncodingKey = 'ISO-8859-1', 
                             ProfileId = testProfile.Id, 
                             LanguageLocaleKey = 'en_US');     
         insert testUser;
        
       	Event event = new Event(
                            Subject = 'Test',
            				isAllDayEvent = true,
            				Type = 'Meeting',
            				WhoId = Con.Id,
            				StartDateTime = system.now(),
            				OwnerID = testUser.Id
							);            
        insert event;
        
        

    	Test.startTest();
        System.runas(testUser)
        {
	
       // This calls the Constructor
       CS_LightningCalendarController testEvent = new CS_LightningCalendarController();
    
       // Call every method in your actual class             
       System.assertNotEquals(null,CS_LightningCalendarController.loadEvents());

       }
       Test.stopTest();        
	}
    
    static testmethod void testCreate() {
    	System.assertNotEquals(null,CS_LightningCalendarController.createEvent());
    }
}