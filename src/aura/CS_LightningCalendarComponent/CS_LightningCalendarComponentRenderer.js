({
	afterRender: function(component, helper) {
		  this.superAfterRender(component, helper);
    		helper.getEvents(component);
   }
})