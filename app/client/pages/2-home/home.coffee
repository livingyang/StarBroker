
Template.home.events "click #store" : ->
	gotoPage "store"

Template.home.events "click #starModelList" : ->
	gotoPage "starModelList"

Template.home.events "click #login" : ->
	gotoPage "login"

Template.home.events "click #userInfo" : ->
	gotoPage "userInfo"

Template.home.events "click #purchase" : ->
	gotoPage "purchase"

Template.backHome.events "click .backHome" : ->
	gotoPage "home"

