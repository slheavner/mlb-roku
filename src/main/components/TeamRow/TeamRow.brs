sub init()
  m.top.layoutDirection = "horiz"
  m.top.observeField("itemContent", "onTeamChange")
  m.top.observeField("width", "onWidthChange")
  m.top.observeField("height", "onHeightChange")
  m.top.observeField("fontSize", "onFontSizeChange")
  m.team = m.top.findNode("name")
  m.wins = m.top.findNode("wins")
  m.losses = m.top.findNode("losses")
  m.percentage = m.top.findNode("percentage")
  m.gb = m.top.findNode("gb")
  onWidthChange()
  onHeightChange()
end sub

sub onTeamChange(event)
  data = event.getData()
  if data <> invalid then
    m.team.text = data.team
    m.wins.text = data.wins
    m.losses.text = data.losses
    m.percentage.text = data.percentage
    m.gb.text = data.gb
  end if
end sub

sub onWidthChange()
  w = m.top.width
  textWidth = w * 0.2
  m.team.width = textWidth * 1.4
  m.wins.width = textWidth
  m.losses.width = textWidth
  m.percentage.width = textWidth
  m.gb.width = textWidth * 0.6
end sub


sub onHeightChange()
  h = m.top.height
  m.team.height = h
  m.wins.height = h
  m.losses.height = h
  m.percentage.height = h
  m.gb.height = h
end sub

sub onFontSizeChange()
  for each child in m.top.getChildren( - 1, 0)
    if child.hasField("font") then
      child.font.size = m.top.fontSize
    end if
  end for
end sub

