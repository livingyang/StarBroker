
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
				exp : 0
				actionPoint : new TimeRecoverProperty
	    			maxRecoverTime: MaxActionPointRecoverTime
	    			timeToValueRate: TimeToActionPoint
	    			curRecoverTime: MaxActionPointRecoverTime
	    			timeStamp: (new Date()).getTime()
				promotionPoint : new TimeRecoverProperty
	    			maxRecoverTime: MaxPromotionPointRecoverTime
	    			timeToValueRate: TimeToPromotionPoint
	    			curRecoverTime: MaxPromotionPointRecoverTime
	    			timeStamp: (new Date()).getTime()

			"User: #{Meteor.userId()} create company: #{name} success"
	
	useActionPoint: (point) ->
		actionPointProp = new TimeRecoverProperty UserCompany().actionPoint
		actionPointProp.updateTime (new Date()).getTime()
		if actionPointProp.downValue point
			Company.update {owner: Meteor.userId()}, {$set:{actionPoint: actionPointProp}}
			console.log "use action point:#{point} success"
			"use success!!!"
		else
			console.log "use action point:#{point} failed"
			"use failed!!"
	
	usePromotionPoint: (point) ->
		promotionPointProp = new TimeRecoverProperty UserCompany().promotionPoint
		promotionPointProp.updateTime (new Date()).getTime()
		if promotionPointProp.downValue point
			Company.update {owner: Meteor.userId()}, {$set:{promotionPoint: promotionPointProp}}
			console.log "use promotion point:#{point} success"
			"use success!!!"
		else
			console.log "use promotion point:#{point} failed"
			"use failed!!"

	addExp: (exp) ->
		console.log "user: #{Meteor.userId()} addExp: #{exp}"
		Company.update {owner: Meteor.userId()}, {$inc:{exp: Number(exp)}}
	