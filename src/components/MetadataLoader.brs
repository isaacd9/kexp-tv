sub init()
    m.top.functionName = "getmetadata"
end sub

sub getmetadata()
    m.appManager = createObject("roAppManager")

    m.port = CreateObject("roMessagePort")
    m.readInternet = createObject("roUrlTransfer")
    m.readInternet.setMessagePort(m.port)
    ' Dangerous but whatever (we don't appear to bundle the GoDaddy root
    ' cert, which is what this needs)
    m.readInternet.EnablePeerVerification(false)
    m.readInternet.EnableFreshConnection(true)
    m.readInternet.setUrl("https://api.kexp.org/v2/plays/?format=json&limit=3&ordering=-airdate")

    while(true)
        m.appManager.UpdateLastKeyPressTime()
        doRequest()
        sleep(3000)
    end while
end sub

sub doRequest()
    m.readInternet.AsyncGetToString()

    ' DataEvent
    dataEvent = wait(5000, m.port)
    if dataEvent.GetInt() = 2
        print "unexpected event type"
        ' Bail out early to avoid crashing
        return
    end if
    failure = dataEvent.GetFailureReason()
    if failure <> "OK"
        print failure
        return
    end if

    data = dataEvent.GetString()
    result = ParseJSON(data)

    m.top.tracks = result.results
    m.top.album_art = fetchAlbumArt(result)
    m.top.show_info = fetchShow(result)
end sub

sub fetchAlbumArt(result) as object
    curSong = result.results[0]
    imageUri = curSong.image_uri
    if imageUri = ""
        return ""
    end if
    ' Gross to be using path ui here but w/e
    path = CreateObject("roPath", imageUri)
    parts = path.Split()
    filename = "tmp:/" + parts.basename + parts.extension

    fs = createObject("roFileSystem")
    if fs.Exists(filename)
        'print "cache hit for " + filename
        return filename
    end if
    print "cache miss for " + filename

    port = CreateObject("roMessagePort")
    readInternet = createObject("roUrlTransfer")
    readInternet.setMessagePort(port)
    readInternet.EnablePeerVerification(false)

    readInternet.setUrl(imageUri)
    status = readInternet.GetToFile(filename)
    if status <> 200
        print "error downloading album_art" + readInternet.status
    end if

    return filename
end sub

sub fetchShow(result) as object
    curSong = result.results[0]
    showUri = curSong.show_uri
    if showUri = ""
        return ""
    end if

    readInternet = createObject("roUrlTransfer")
    readInternet.EnablePeerVerification(false)

    readInternet.setUrl(showUri)
    showInfo = readInternet.GetToString()
    return ParseJSON(showInfo)
end sub