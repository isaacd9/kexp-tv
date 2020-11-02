function init()
    overhang = m.top.findNode("overhang")
    m.top.backgroundUri = ""
    m.top.backgroundColor = "0x111111"

    res = m.top.currentDesignResolution
    disp = m.top.findNode("content")
    disp.translation = [res.width / 2, res.height / 2]

    m.metadataTask = createObject("RoSGNode", "MetadataLoader")

    m.metadataTask.observeField("tracks", "updateTracks")
    m.metadataTask.observeField("album_art", "updateAlbumArt")
    m.metadataTask.observeField("show_info", "updateShow")

    m.metadataTask.control = "RUN"
end function

function updateTracks()
    disp = m.top.findNode("trackDisplay")
    disp.tracks = m.metadataTask.tracks
end function

function updateAlbumArt()
    album_art_node = m.top.findNode("album_cover")
    album_art_uri = m.metadataTask.album_art
    album_art_node.coverArt = album_art_uri
end function

function updateShow()
    overhang = m.top.findNode("overhang")
    show_info = m.metadataTask.show_info
    overhang.clockText = show_info.program_name + " with " + show_info.host_names[0]
end function