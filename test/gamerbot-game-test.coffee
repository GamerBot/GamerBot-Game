Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('src/destiny.coffee')

describe 'gamerbot-game', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to game ident trigger', ->
    @room.user.say('alice', '.dtg').then =>
      expect(@room.messages).to.eql [
        ['alice', '.dtg']
        ['hubot', 'Destiny']
      ]

  it 'hears lfg question', ->
    @room.user.say('alice', '.dtg lfg?').then =>
      expect(@room.messages).to.eql [
        ['alice', '.dtg lfg?']
        ['hubot', 'LFG enabled: true']
      ]

  it 'hears events', ->
    @room.user.say('alice', '.dtg events').then =>
      expect(@room.messages).to.eql [
        ['alice', '.dtg events']
        ['hubot', 'Events:\nCoO ... Court of Oryx\nCoE ... Challenge of Elders\nKFHM ... King\'s Fall - Hard Mode\n']
      ]

  it 'hears platform', ->
    @room.user.say('alice', '.dtg platform').then =>
      expect(@room.messages).to.eql [
        ['alice', '.dtg platform']
        ['hubot', 'Platforms:\nPS4\nXBONE\n']
      ]
