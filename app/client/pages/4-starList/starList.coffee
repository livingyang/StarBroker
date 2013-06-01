Stars = new Meteor.Collection "stars"

Template.starList.events "click .home" : ->
	gotoPage "home"

Template.starList.stars = ->
	Stars.find()