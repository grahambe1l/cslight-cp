({
    doInit : function(component, event, helper) {
		helper.getLocation(component, helper);
    },
    maxDistanceChange : function(component, event, helper) {
		helper.findContactsNearby(component);
    },
	maxDistanceChanging : function(component, event) {
        component.set("v.maxDistance", event.target.value);
	}

})