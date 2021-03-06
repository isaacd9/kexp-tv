function init()
    track = m.top.findNode("track")
    track.opacity = m.top.opacity
end function

function updateMetadata()
    track = createObject("roSGNode", "Track")
    track.opacity = m.top.opacity
    if m.top.metadata.play_type = "airbreak"
        airbreak = createObject("roSGNode", "Airbreak")
        m.top.replaceChild(airbreak, 0)
        return true
    else
        child = m.top.getChild(0)

        if same(child)
            return false
        end if

        track.artist = m.top.metadata.artist
        track.album = m.top.metadata.album
        track.title = m.top.metadata.song
        track.opacity = m.top.opacity
    end if

    m.top.replaceChild(track, 0)
end function

function same(child) as boolean
    if child["artist"] <> m.top.metadata.artist then return false
    if child["album"] <> m.top.metadata.album then return false
    if child["title"] <> m.top.metadata.song then return false
    return true
end function