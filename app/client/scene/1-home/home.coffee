Template.home.events "click #store" : ->
	# console.log "store!!"
	gotoPage "store"

Template.home.events "click #starList" : ->
	# console.log "star list!!"
	# Session.set "curScene", "starList"
	gotoPage "starList"