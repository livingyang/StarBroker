StarModels = new Meteor.Collection "starModels"
Stars = new Meteor.Collection "stars"

Company = new Meteor.Collection "company"
UserCompany = ->
	findCompany = Company.find {owner: Meteor.userId()}
	if findCompany.count() is 1 then findCompany.fetch()[0] else undefined

@StarModels = StarModels
@Stars = Stars

@Company = Company
@UserCompany = UserCompany