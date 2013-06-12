describe "CompanyLevel", ->
	it "是否为有效的等级数据", ->
		expect(isValidLevelExpArray "0, 1, 2").toBe(false)
		expect(isValidLevelExpArray [-1, 0, 10, 1000]).toBe(false)
		expect(isValidLevelExpArray [10, 1000]).toBe(false)
		expect(isValidLevelExpArray [0, 1000, 10]).toBe(false)
		expect(isValidLevelExpArray [0, 10, 10]).toBe(false)
		expect(isValidLevelExpArray [0]).toBe(false)

		expect(isValidLevelExpArray [0, 1]).toBe(true)
		expect(isValidLevelExpArray [0, 10, 1000]).toBe(true)
