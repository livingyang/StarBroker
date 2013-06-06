class TimeRecoverProperty
    constructor: (options) ->
        {@maxRecoverTime, @timeToValueRate, @curRecoverTime, @timeStamp} = options
        @curRecoverTime = 0 if not @curRecoverTime?
        @timeToValueRate = 1 if @timeToValueRate is 0
        @timeStamp = (new Date()).getTime() if not @timeStamp?

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