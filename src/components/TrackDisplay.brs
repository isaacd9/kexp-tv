function init()
    m.top.layoutDirection = "vert"
    m.top.itemSpacings = "[20]"
end function

function updateTracks()
    cur_track = m.top.findNode("cur_track")
    prev_track = m.top.findNode("prev_track")
    prev_prev_track = m.top.findNode("prev_prev_track")
    cur_track.metadata = m.top.tracks[0]
    prev_track.metadata = m.top.tracks[1]
    prev_prev_track.metadata = m.top.tracks[2]

    commentText = ""
    if type(m.top.tracks[0].comment) <> "Invalid"
        commentText = m.top.tracks[0].comment
    end if

    comment = m.top.findNode("comment")
    comment.originalText = commentText
end function