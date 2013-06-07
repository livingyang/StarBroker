TimeRecoverProperty = require("../../lib/TimeRecoverProperty").TimeRecoverProperty
assert = require("assert")

console.log this
describe 'Array', ->
	describe '#indexOf()', ->
		it 'should return -1 when the value is not present', ->
			assert.equal(-1, [1,2,3].indexOf(5));
			assert.equal(-1, [1,2,3].indexOf(0));

			timeProperty = new TimeRecoverProperty
				maxRecoverTime: 1000 * 60
				curRecoverTime: 0
				timeToValueRate: 1000

			assert.equal(60, timeProperty.getMaxValue())
			assert.equal(0, timeProperty.getCurValue())