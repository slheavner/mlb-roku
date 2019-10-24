sub init()
  m.top.layoutDirection = "vert"
  m.top.observeField("league", "onLeagueChange")
  m.top.observeField("width", "onWidthChange")
  m.title = m.top.findNode("leagueName")
  onWidthChange()
end sub

sub onLeagueChange(event)
  data = event.getData()
  m.title.text = data.id
  if data <> invalid then
    for each child in data.getChildren( - 1, 0)
      row = m.top.createChild("DivisionItem")
      row.division = child
    end for
  end if
end sub

sub onWidthChange()
  for each child in m.top.getChildren( - 1, 0)
    if child.hasField("width") then
      child.width = m.top.width
    end if
  end for
end sub

