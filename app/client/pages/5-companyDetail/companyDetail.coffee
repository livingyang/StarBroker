Template.companyDetail.hasCompany = ->
	Company.find({owner: Meteor.userId()}).count() is 1

Template.companyDetail.events
	"click #createCompany" : ->
		Meteor.call "createCompany", $("#companyName").val(), (error, result) ->
			console.log "CreateCompany result = #{result}"

Template.company.company = ->
	Company.findOne({owner: Meteor.userId()})
