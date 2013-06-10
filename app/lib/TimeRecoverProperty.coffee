class TimeRecoverProperty
    constructor: (options) ->
        options = {} if not options?
        options.maxRecoverTime = 1 if not options.maxRecoverTime? or options.maxRecoverTime <= 0
        options.curRecoverTime = 0 if not options.curRecoverTime? or options.curRecoverTime < 0
        options.timeToValueRate = 1 if not options.timeToValueRate? or options.timeToValueRate <= 0
        options.timeStamp = 0 if not options.timeStamp?

        {@maxRecoverTime, @timeToValueRate, @curRecoverTime, @timeStamp} = options

    getValue: (time) ->
        time = @timeStamp if not time?
        subTime = time - @timeStamp

        if @curRecoverTime > @maxRecoverTime
            @curRecoverTime / @timeToValueRate
        else
            (@curRecoverTime + subTime) / @timeToValueRate


    updateTime: (time) ->
        if time? and time > @timeStamp
            subTime = time - @timeStamp
            @timeStamp = time
            if @curRecoverTime < @maxRecoverTime
                @curRecoverTime += subTime
                @curRecoverTime = @maxRecoverTime if @curRecoverTime > @maxRecoverTime

    getSubTime: (curTime) ->
        curTime = (new Date()).getTime() if not curTime?
        curTime - @timeStamp
    getMaxValue: () -> Math.floor @maxRecoverTime / @timeToValueRate
    getCurValue: (curTime) ->
        curValue = 0
        curTime = curTime or (new Date()).getTime()
        curTime = @timeStamp if curTime < @timeStamp

        if @curRecoverTime > @maxRecoverTime
            curValue = Math.floor @curRecoverTime / @timeToValueRate
        else
            @curRecoverTime = @curRecoverTime + @getSubTime curTime
            @curRecoverTime = @maxRecoverTime if @curRecoverTime > @maxRecoverTime
            curValue = Math.floor @curRecoverTime / @timeToValueRate

        @timeStamp = curTime
        curValue

    getRemainRecoverTime: (curTime) ->
        remainTime = @maxRecoverTime - (@getSubTime curTime) - @curRecoverTime
        remainTime = 0 if remainTime < 0
        remainTime
    
    convertValueToTime: (value) ->
        value = 0 if not value instanceof Number or value < 0
        value * @timeToValueRate

    increaseCurValue: (increaseValue) ->
        if @getCurValue() >= increaseValue and @curRecoverTime >= @convertValueToTime increaseValue
            @curRecoverTime -= @convertValueToTime increaseValue


@TimeRecoverProperty = TimeRecoverProperty