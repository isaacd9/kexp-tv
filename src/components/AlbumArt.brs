function init()
    m.top.uri = "pkg:/images/kexp-playing.gif"
end function

function updateCoverArt()
    if m.top.coverArt = ""
        m.top.uri = "pkg:/images/kexp-playing.gif"
    else
        m.top.uri = m.top.coverArt
    end if
end function