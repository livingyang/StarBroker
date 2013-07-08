setPageNameToList "companyDetail"

updateHandle = null

getUpdatedTimeProperty = (prop) ->
	prop.updateTime getServerTime()
	prop

initTimeProperty = ->
	setCompanyActionPoint getUpdatedTimeProperty new TimeRecoverProperty UserCompany().actionPoint
	setCompanyPromotionPoint getUpdatedTimeProperty new TimeRecoverProperty UserCompany().promotionPoint

getCompanyActionPoint = ->
	new TimeRecoverProperty Session.get "companyActionPoint"

setCompanyActionPoint = (prop) ->
	Session.set "companyActionPoint", prop

getCompanyPromotionPoint = ->
	new TimeRecoverProperty Session.get "companyPromotionPoint"

setCompanyPromotionPoint = (prop) ->
	Session.set "companyPromotionPoint", prop

# Template.companyDetail
Template.companyDetail.hasCompany = ->
	UserCompany()?

Template.companyDetail.events
	"click #createCompany" : ->
		Meteor.call "createCompany", $("#companyName").val(), (error, result) ->
			console.log "CreateCompany result = #{result}"

# Template.company
Template.company.created = ->
	updateHandle = Meteor.setInterval (() ->
		setCompanyActionPoint(getUpdatedTimeProperty getCompanyActionPoint())
		setCompanyPromotionPoint(getUpdatedTimeProperty getCompanyPromotionPoint())
	), 1000

	initTimeProperty()

	console.log "company.created"

Template.company.destroyed = ->
	Meteor.clearInterval updateHandle
	updateHandle = null
	console.log "company.destroyed"

Template.company.company = ->
	UserCompany()

Template.company.actionPoint = ->
	property = getCompanyActionPoint()
	"#{property.getCurValue()}/#{property.getMaxValue()}"

Template.company.remainActionPoint = ->
	second = Math.floor getCompanyActionPoint().getRemainRecoverTime() / 1000
	"#{Math.floor second / 3600} : #{Math.floor (second % 3600) / 60} : #{second % 60}"

Template.company.promotionPoint = ->
	property = getCompanyPromotionPoint()
	"#{property.getCurValue()}/#{property.getMaxValue()}"

Template.company.remainPromotionPoint = ->
	second = Math.floor getCompanyPromotionPoint().getRemainRecoverTime() / 1000
	"#{Math.floor second / 3600} : #{Math.floor (second % 3600) / 60} : #{second % 60}"

Template.company.exp = ->
	UserCompany().exp

Template.company.nextExp = ->
	getCompanyNextLevelExp UserCompany().exp

Template.company.level = ->
	getCompanyLevel UserCompany().exp

Template.company.events "click #useAction" : ->
	console.log "useAction"
	Meteor.call "useActionPoint", 3, (result) ->
		console.log result
		initTimeProperty()

Template.company.events "click #usePromotion" : ->
	console.log "usePromotion"
	Meteor.call "usePromotionPoint", 2, (result) ->
		console.log result
		initTimeProperty()

Template.company.events "click #addExp" : ->
	Meteor.call "addExp", 100, (error, result) ->
		console.log "addExp100 !!"
