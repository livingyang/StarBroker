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

if Meteor.isServer
	getCollectionFetchArray = (collection) ->
		collection.find().fetch() if collection?

	getMapFromFetchArray = (fetchArray, key = "_id") ->
		map = {}
		(map[obj[key]] = obj for obj in fetchArray when obj[key]?)
		map

	StarModelMap = getMapFromFetchArray getCollectionFetchArray StarModels
	