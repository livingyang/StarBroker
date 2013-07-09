setPageNameToList "mission"

getHolderImage = (imageName) ->
	image = $(document.createElement("img")).attr("data-src" : imageName)
	Holder.run({
		images: image[0]
	})
	image.attr("src")

cleanCollie = ->
	collie.Renderer.stop()
	collie.Renderer.removeAllLayer()
	collie.Renderer.unload()
	collie.Timer.removeAll()

Template.mission.destroyed = ->
	cleanCollie()

Template.mission.events "click #start" : ->
	console.log "start"

	if collie.Renderer.isPlaying()
		cleanCollie()
	else
		collie.ImageManager.add
			rabbit : "yame_walk.png"
			ground : "ground.png"
			icon : getHolderImage("holder.js/50x50/text:明星") 


		layer = new collie.Layer
			width : 320
			height : 320

		ground = new collie.DisplayObject(
			x: 0
			width: 320 * 2
			height: 88
			velocityX: -50
			backgroundImage: "ground"
			backgroundRepeat: "repeat-x"
			rangeX: [-320, 0]
			positionRepeat: true
		).bottom(0).addTo(layer);

		collie.Timer.cycle ( (oEvent) ->
			console.log "value : #{oEvent.value}"
			# rabbit = new collie.DisplayObject(
			# 	x: 0
			# 	y: "center"
			# 	width: 129.4
			# 	height: 165
			# 	zIndex: 1
			# 	backgroundImage: "rabbit"
			# ).bottom(0).addTo(layer)

			# cycle = collie.Timer.cycle(rabbit, "18fps", {
			# 	from: 0
			# 	to: 7
			# 	loop: 0
			# })
			rabbit = new collie.DisplayObject(
				x: 0
				y: 200
				zIndex: 1
				backgroundImage: "icon"
			).addTo(layer)

			oTimer = collie.Timer.timeline()
			oTimer.add(0, "transition", rabbit, 1000, {
				set : "x"
				to : 100
			})
			oTimer.add(1000, "transition", rabbit, 500, {
				set : "y"
				to : 50
			})
			oTimer.add(1500, "transition", rabbit, 500, {
				set : "y"
				to : 200
			})
			oTimer.add(2000, "transition", rabbit, 1000, {
				set : "x"
				to : 200
				onComplete: -> rabbit.getLayer().removeChild rabbit
			})
			), 2000, { from : 0, to : 1}

		new collie.FPSConsole().load();
		collie.Renderer.addLayer layer
		collie.Renderer.load document.getElementById("fight")
		collie.Renderer.start()