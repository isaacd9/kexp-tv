function init()
  m.top.width = 500
  m.top.maxLines = 7

  m.timer = m.top.findNode("commentTimer")
  m.timer.observeField("fire", "nextChunk")
  m.timer.control = "start"

  m.i = 0
  m.chunks = createObject("roList")
  chunk = createObject("roList")
  m.chunks.addTail(chunk)
end function

function updateText()
  text = m.top.originalText
  wordList = text.tokenize(" ")
  wordList.reset()

  chunks = createObject("roList")
  while wordList.isNext()
    i = 0
    chunk = createObject("roList")
    while i < 200
      if not wordList.isNext()
        exit while
      end if

      word = wordList.Next()
      if (i + word.len()) > 220
        exit while
      end if

      chunk.addTail(word)
      i = i + word.len()
    end while
    chunks.addTail(chunk)
  end while
  m.chunks = chunks
  m.i = 0

  'print "updated comment " + text

  nextChunk()
end function

function nextChunk()
  if m.chunks.count() < 1
    m.top.text = ""
    return false
  end if
  i = m.i mod m.chunks.count()
  chunk = m.chunks[i]
  m.i = m.i + 1

  text = chunk.toArray().Join(" ")
  if i < m.chunks.count() - 1
    text = text + "..."
  end if
  m.top.text = text
end function
