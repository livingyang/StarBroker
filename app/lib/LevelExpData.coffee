CompanyExpArray = [0, 100, 600, 10000]

getCompanyLevel = (exp) ->
	getLevelFromExpArray CompanyExpArray, exp

getCompanyNextLevelExp = (exp) ->
	getNextLevelExpFromExpArray CompanyExpArray, exp

@getCompanyLevel = getCompanyLevel
@getCompanyNextLevelExp = getCompanyNextLevelExp