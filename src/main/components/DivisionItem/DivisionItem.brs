sub init()
  header = createObject("roSGNode", "ContentNode")
  header.addFields({
    team: "Team",
    wins: "Wins",
    losses: "Losses",
    percentage: "Pct.",
    gb: "GB"
  })
  m.top.findNode("header").itemContent = header
  m.top.layoutDirection = "vert"
  m.top.observeField("itemContent", "onDivisionChange")
  m.top.observeField("width", "onWidthChange")
  m.teams = m.top.findNode("teams")
  m.title = m.top.findNode("divisionName")
  onWidthChange()
end sub

sub onDivisionChange(event)
  data = event.getData()
  if data <> invalid then
    m.title.text = data.id
    for i = 0 to data.getChildCount() - 1
      child = data.getChild(i)
      row = m.teams.getChild(i)
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

