'*************************************************************
'** Hello World example
'** Copyright (c) 2015 Roku, Inc.  All rights reserved.
'** Use of the Roku Platform is subject to the Roku SDK License Agreement:
'** https://docs.roku.com/doc/developersdk/en-us
'*************************************************************

sub Main()
    print "in showChannelSGScreen"
    'Indicate this is a Roku SceneGraph application'
    loadingScreen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    loadingScreen.setMessagePort(m.port)

    audioPlayer = CreateObject("roAudioPlayer")
    audioPlayer.SetMessagePort(m.port)
    song = CreateObject("roAssociativeArray")
    song = {
        streamFormat: "mp3",
        streamContentIDs: "kexp128.mp3",
        streamBitrates: [128],
        streamQualities: "128",
        stream: {
            url: "https://kexp-mp3-128.streamguys1.com/kexp128.mp3"
        }
    }
    audioplayer.addcontent(song)
    audioplayer.setloop(true)
    audioPlayer.play()

    'Create a scene and load /components/helloworld.xml'
    loadingScreen.CreateScene("Loading")
    loadingScreen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
        if msgType = "roAudioPlayerEvent"
            if msg.isStatusMessage() then
                print "roAudioPlayerEvent: "; msg.getmessage()
                if msg.getmessage() = "start of play"
                    print "changing screens"
                    playingScreen = CreateObject("roSGScreen")
                    playingScreen.CreateScene("NowPlaying")
                    playingScreen.show()
                end if
            end if
        end if
    end while
end sub