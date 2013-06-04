Template.userInfo.user = ->
	Meteor.user()

Template.userInfo.company = ->
	Company.findOne({owner: Meteor.userId()})

Template.userInfo.emails = ->
	Meteor.users.findOne({_id: Meteor.userId()}).emails
