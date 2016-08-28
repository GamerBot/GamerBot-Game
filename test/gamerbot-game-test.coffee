Helper = require('hubot-test-helper')
Profile = require('GamerBot-Profile')
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

  it 'hears play', ->
    profile = new Profile @room.robot
    profile.add_platform('alice','XBONE','malice')
    @room.user.say('alice', '.me plat add XBONE as malice').then =>
      expect(@room.messages).to.eql [
        ['alice', '.me plat add XBONE as malice']
        ['hubot', 'XBONE added to your platforms']
      ]
    @room.user.say('alice', '.dtg i play').then =>
      expect(@room.messages).to.eql [
        ['alice', '.me plat add XBONE as malice']
        ['alice', '.dtg i play']
        ['hubot', 'alice added as player of Destiny']
        ['hubot', 'XBONE added to your platforms']
        ['hubot', 'XBONE added to your platforms']
      ]
    @room.user.say('alice', '.dtg n play').then =>
      expect(@room.messages).to.eql [
        ['alice', '.me plat add XBONE as malice']
        ['alice', '.dtg i play']
        ['alice', '.dtg n play']
        ['hubot', 'alice added as player of Destiny']
        ['hubot', 'alice is no longer a player of Destiny']
        ['hubot', 'XBONE added to your platforms']
        ['hubot', 'XBONE added to your platforms']
      ]
