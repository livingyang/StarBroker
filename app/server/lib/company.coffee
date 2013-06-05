
Meteor.methods
	
	createCompany: (name) ->
		if not name instanceof String or name.length is 0
			"User: #{Meteor.userId()} create company fail"
		else
			Company.insert
				name : name
				owner : Meteor.userId()
				money : 0
				gold : 0
			"User: #{Meteor.userId()} create company: #{name} success"
	