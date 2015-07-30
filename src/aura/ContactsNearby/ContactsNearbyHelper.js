({
    getLocation: function(component, helper) {
        navigator.geolocation.getCurrentPosition(function(position) {
            this.latitude = component.set("v.latitude", position.coords.latitude);
            this.longitude = component.set("v.longitude", position.coords.longitude);
            console.log(this);
            helper.findContactsNearby(component);
        });
    },
	findContactsNearby : function(component) {
		var action = component.get("c.findNearby");
        action.setParams({
            "latitude": component.get("v.latitude"),
            "longitude": component.get("v.longitude"),
            "maxDistance": component.get("v.maxDistance")
        });
        action.setCallback(this, function(a) {
            component.set("v.contacts", a.getReturnValue());
        });
        $A.clientService.runActions([action]);
	}
})