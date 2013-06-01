convertCsvToJsonArray = (csvArray, headerRowIndex, typeRowIndex, startFieldRowIndex) ->

	csvArray = [] if csvArray not instanceof Array
	headerRowIndex = 2 if headerRowIndex not instanceof Number
	typeRowIndex = 1 if typeRowIndex not instanceof Number
	startFieldRowIndex = 3 if startFieldRowIndex not instanceof Number

	result = (convertCsvRowToJson csvArray[headerRowIndex], fields, csvArray[typeRowIndex] for fields in csvArray[startFieldRowIndex..])

convertCsvField = (field, type) ->
	switch type
		when "number" then Number(field)
		when "bool" then Boolean(Number(field))
		else String(field)

convertCsvRowToJson = (csvHeaders, csvFields, csvFieldTypes) ->
	result = {}
	(result[header] = convertCsvField csvFields[i], csvFieldTypes[i] for header, i in csvHeaders if csvHeaders.length is csvFields.length)
	result

getFilePath = (fileDir, fileName) ->
	filePath = fileDir
	filePath = filePath + "/" if fileDir.charAt(fileDir.length - 1) isnt "/"
	filePath + fileName

getCollectionNameFromCsvFileName = (csvFileName) ->
	nameSplit = csvFileName.split(".")

	(nameSplit[0] if nameSplit.length is 2 and nameSplit[1].toLowerCase() is "csv") or undefined

createCollection = (collectionName, jsonArray) ->
	console.log "createCollection : #{collectionName}"
	collection = new Meteor.Collection(collectionName)
	if collection.find().count() is 0
		collection.insert jsonObject for jsonObject in jsonArray
		console.log "#{jsonArray.length} document inserted"
	else
		console.log "cannot insert document because collection: #{collectionName} is not empty"
	collection

createCollectionWithFile = (filePath, collectionName) ->
	fs = Npm.require("fs")

	createCollection collectionName, convertCsvToJsonArray (fs.readFileSync filePath).toString().csvToArray({rSep:"\n"})

createCollectionsWithDir = (dirPath) ->
	fs = Npm.require("fs")
	if fs.existsSync(dirPath)
		(fs.readdirSync dirPath).forEach (fileName) ->
			if (getCollectionNameFromCsvFileName fileName)?
				console.log "\nWarning: Create collection from file: #{getFilePath dirPath, fileName}"
				createCollectionWithFile (getFilePath dirPath, fileName), (getCollectionNameFromCsvFileName fileName)

@createCollectionsWithDir = createCollectionsWithDir