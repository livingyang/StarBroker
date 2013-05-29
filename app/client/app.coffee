gotoPage = (name) ->
	if Template[name]? then Session.set "currentPage", name else console.log "Cannot go to page: #{name}" 

@gotoPage = gotoPage

# gotoPage "login"

Template.container.currentPage = ->
	if Template[Session.get "currentPage"]? then Template[Session.get "currentPage"]() else "no page"

Meteor.startup ->
	console.log "Client Start!!"
