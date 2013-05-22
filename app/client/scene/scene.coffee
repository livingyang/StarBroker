gotoPage = (name) ->
	if Template[name]? then Session.set "currentPage", name else console.log "Cannot go to page: #{name}" 

@gotoPage = gotoPage

Template.scene.currentPage = ->
	Template[Session.get "currentPage"]()

Meteor.startup ->
	gotoPage "home"
