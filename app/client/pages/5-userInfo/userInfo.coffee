Template.userInfo.events "click .home" : ->
	gotoPage "home"

Template.userInfo.user = ->
	Meteor.user()

Template.userInfo.emails = ->
	Meteor.user().emails
