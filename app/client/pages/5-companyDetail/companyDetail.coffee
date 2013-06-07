Template.companyDetail.hasCompany = ->
	UserCompany()?

Template.companyDetail.events
	"click #createCompany" : ->
		Meteor.call "createCompany", $("#companyName").val(), (error, result) ->
			console.log "CreateCompany result = #{result}"

setTimeProperty = (name, property) ->
	Session.set name, property

getTimeProperty = (name) ->
	Session.get name

updateTimeProperty = (name) ->
	setTimeProperty name, (getTimeProperty name).getCurValue if (getTimeProperty name)

updateHandle = null

Template.company.created = ->
	updateHandle = Meteor.setInterval (() ->
		console.log "created"
	), 1000

	curCompany = UserCompany()
	setTimeProperty "actionTimeProperty", new TimeRecoverProperty curCompany.actionPoint
	console.log "company.created"

Template.company.destroyed = ->
	Meteor.clearInterval updateHandle
	updateHandle = null
	console.log "company.destroyed"

Template.company.company = ->
	UserCompany()

Template.company.actionPoint = ->
	property = new TimeRecoverProperty(UserCompany().actionPoint)
	"#{property.getCurValue getSynchronizeTime()}/#{property.getMaxValue()}"

Template.company.remainActionPoint = ->
	console.log (getTimeProperty "actionTimeProperty")
	(new TimeRecoverProperty getTimeProperty "actionTimeProperty").getRemainRecoverTime()

Template.company.promotionPoint = ->
	property = new TimeRecoverProperty(UserCompany().promotionPoint)
	"#{property.getCurValue getSynchronizeTime()}/#{property.getMaxValue()}"

Template.company.remainPromotionPoint = ->
	20

Template.company.events "click #useAction" : ->
	console.log "useAction"
	Meteor.call "useActionPoint", 3

Template.company.events "click #usePromotion" : ->
	console.log "usePromotion"
	Meteor.call "usePromotionPoint", 2