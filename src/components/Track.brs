function init()
    m.top.layoutDirection = "vert"
    m.top.horizAlignment = "left"
    m.top.vertAlignment = "center"
    m.top.itemSpacings = [7.0]
end function

function updateTitleArtist()
    titleArtist = m.top.findNode("titleArtist")
    titleArtist.text = m.top.artist + " - " + m.top.title
end function

function updateAlbum()
    album = m.top.findNode("albumLabel")
    album.text = ucase(m.top.album)
end function