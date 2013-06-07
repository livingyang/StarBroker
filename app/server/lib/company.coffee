
TimeToActionPoint = 1000 * 60
MaxActionPointRecoverTime = TimeToActionPoint * 30

TimeToPromotionPoint = 1000 * 600
MaxPromotionPointRecoverTime = TimeToPromotionPoint * 10

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
				actionPoint : new TimeRecoverProperty
	    			maxRecoverTime: MaxActionPointRecoverTime
	    			timeToValueRate: TimeToActionPoint
	    			curRecoverTime: 0
				promotionPoint : new TimeRecoverProperty
	    			maxRecoverTime: MaxPromotionPointRecoverTime
	    			timeToValueRate: TimeToPromotionPoint
	    			curRecoverTime: 0
			"User: #{Meteor.userId()} create company: #{name} success"
	
	useActionPoint: (point) ->
		console.log "use action point #{point}"
		actionPointProp = new TimeRecoverProperty UserCompany().actionPoint
		actionPointProp.increaseCurValue point
		Company.update {owner: Meteor.userId()}, {$set:{actionPoint: actionPointProp}}
	
	usePromotionPoint: (point) ->
		console.log "use promotion point #{point}"
		promotionPointProp = new TimeRecoverProperty UserCompany().promotionPoint
		promotionPointProp.increaseCurValue point
		Company.update {owner: Meteor.userId()}, {$set:{promotionPoint: promotionPointProp}}
	