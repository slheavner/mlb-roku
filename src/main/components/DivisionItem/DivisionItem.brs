sub init()
  header = createObject("roSGNode", "ContentNode")
  header.addFields({
    team: "Team",
    wins: "Wins",
    losses: "Losses",
    percentage: "Pct."
  })
  m.top.findNode("header").itemContent = header
  m.top.layoutDirection = "vert"
  m.top.observeField("itemContent", "onDivisionChange")
  m.top.observeField("width", "onWidthChange")
  m.title = m.top.findNode("divisionName")
  onWidthChange()
end sub

sub onDivisionChange(event)
  data = event.getData()
  if data <> invalid then
    m.title.text = data.id
    for each child in data.getChildren( - 1, 0)
      row = m.top.createChild("TeamRow")
      row.itemContent = child
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

