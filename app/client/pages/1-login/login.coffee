Template.login.events "click #btnLogout" : ->
	Meteor.logout -> console.log "logout!!"

Template.login.events "click #home" : ->
	gotoPage "home"

Meteor.startup ->
	gotoPage "login"