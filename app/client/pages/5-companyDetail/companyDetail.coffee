Template.companyDetail.hasCompany = ->
	UserCompany()?

Template.companyDetail.events
	"click #createCompany" : ->
		Meteor.call "createCompany", $("#companyName").val(), (error, result) ->
			console.log "CreateCompany result = #{result}"

Template.company.company = ->
	UserCompany()

Template.company.actionPoint = ->
	property = new TimeRecoverProperty(UserCompany().actionPoint)
	"#{property.getCurValue getSynchronizeTime()}/#{property.getMaxValue()}"

Template.company.promotionPoint = ->
	property = new TimeRecoverProperty(UserCompany().promotionPoint)
	"#{property.getCurValue getSynchronizeTime()}/#{property.getMaxValue()}"

Template.company.events "click #useAction" : ->
	console.log "useAction"
	Meteor.call "useActionPoint", 3