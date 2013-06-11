###
TimeRecoverProperty : 时间恢复属性

维护一个时间戳

记录时间值，并且计算属性值

记录时间到属性的转换比率
###

class TimeRecoverProperty
    constructor: (options) ->
        options = {} if not options?
        options.maxRecoverTime = 1 if not options.maxRecoverTime? or options.maxRecoverTime <= 0
        options.curRecoverTime = 0 if not options.curRecoverTime? or options.curRecoverTime < 0
        options.timeToValueRate = 1 if not options.timeToValueRate? or options.timeToValueRate <= 0
        options.timeStamp = 0 if not options.timeStamp?

        {@maxRecoverTime, @timeToValueRate, @curRecoverTime, @timeStamp} = options

    getMaxValue: -> Math.floor @maxRecoverTime / @timeToValueRate
    getCurValue: -> Math.floor @curRecoverTime / @timeToValueRate

    updateTime: (time) ->
        if typeof time is "number" and time > @timeStamp
            maxTime = if @curRecoverTime > @maxRecoverTime then @curRecoverTime else @maxRecoverTime
            @curRecoverTime += time - @timeStamp
            @curRecoverTime = maxTime if @curRecoverTime > maxTime
            @timeStamp = time
            true
        else
            false

    getRemainRecoverTime: ->
        if @curRecoverTime < @maxRecoverTime then @maxRecoverTime - @curRecoverTime else 0

    upValue: (value) ->
        if typeof value is "number" and value > 0
            @curRecoverTime += value * @timeToValueRate
            true
        else
            false

    downValue: (value) ->
        if typeof value is "number" and value > 0 and value * @timeToValueRate <= @curRecoverTime
            @curRecoverTime -= value * @timeToValueRate
            true
        else
            false

@TimeRecoverProperty = TimeRecoverProperty