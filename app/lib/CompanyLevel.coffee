
ExpArray = [200, 400, 600, 1000]

getCompanyLevel = (exp) ->
	result = ExpArray.length;
	for levelUpExp, i in ExpArray
		console.log "exp = #{levelUpExp}, i = #{i}"

@getCompanyLevel = getCompanyLevel

isValidLevelExpArray = (levelExpArray) ->
	if levelExpArray instanceof Array
	then levelExpArray.length > 0 and levelExpArray[0] is 0 and (
		result = true
		for exp, i in levelExpArray[1..]
			result = result and levelExpArray[i - 1] < exp
		result)
	else false

@isValidLevelExpArray = isValidLevelExpArray