describe "TimeRecoverProperty", ->
	it "用默认参数的进行初始化", ->
    	expect(TimeRecoverProperty).not.toThrow();
		prop = new TimeRecoverProperty()
		expect(prop.maxRecoverTime).toBe(1)
		expect(prop.curRecoverTime).toBe(0)
		expect(prop.timeToValueRate).toBe(1)
		expect(prop.timeStamp).toBe(0)

	it "用错误参数进行初始化", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: -1
			curRecoverTime: -10
			timeToValueRate: -1
			timeStamp: -1
		expect(prop.maxRecoverTime).toBe(1)
		expect(prop.curRecoverTime).toBe(0)
		expect(prop.timeToValueRate).toBe(1)
		expect(prop.timeStamp).toBe(-1)

	it "可以获取恢复值，默认获取当前值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 12
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.getValue()).toBe(12 / 2)
		expect(prop.getValue prop.timeStamp).toBe(12 / 2)

	it "用一个以前的时间，获取恢复值时，以之前的时间点获取恢复值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 12
			timeToValueRate: 2
			timeStamp: 12

		expect(prop.getValue 0).toBe(0)

	it "更新时间戳时，将同步更新恢复值，若时间戳比当前时间戳旧，则不更新", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		prop.updateTime 6
		expect(prop.timeStamp).toBe(6)
		expect(prop.curRecoverTime).toBe(6)


	it "通过时间更新时，恢复值无法超过最大恢复值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		prop.updateTime 12
		expect(prop.timeStamp).toBe(12)
		expect(prop.curRecoverTime).toBe(10)

	it "可以通过直接设置恢复值，此时可以超过最大恢复值", ->
		prop = new TimeRecoverProperty
			maxRecoverTime: 10
			curRecoverTime: 0
			timeToValueRate: 2
			timeStamp: 0

		expect(prop.getValue 12).toBe(10 / 2)
		
		prop.curRecoverTime = 14
		prop.updateTime 12
		expect(prop.timeStamp).toBe(12)
		expect(prop.curRecoverTime).toBe(14)

		expect(prop.getValue 20).toBe(11 / 2)

