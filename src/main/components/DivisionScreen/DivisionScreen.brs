sub init()
  header = createObject("roSGNode", "ContentNode")
  header.addFields({
    team: "Team",
    wins: "Wins",
    losses: "Losses",
    percentage: "Pct.",
    gb: "GB"
  })
  m.list = m.top.findNode("list")
  m.top.findNode("header").itemContent = header
  m.top.observeField("itemContent", "onContentChange")
  m.top.observeField("index", "onIndexChange")
  m.title = m.top.findNode("divisionName")
  m.title.font.size = 99
  m.teamGroup = m.top.findNode("teamGroup")
  m.items = []
end sub

function onKeyEvent(key as string, press as boolean)
  if key = "left" and m.top.index > 0 and press then
    m.top.index = m.top.index - 1
    return true
  else if key = "right" and m.top.index < m.items.count() - 1 and press then
    m.top.index = m.top.index + 1
    return true
  else if key = "back" and press then
    m.top.visible = false
    return false
  end if
  return true
end function

sub onContentChange(event)
  data = event.getData()
  if data <> invalid then
    m.items = []
    for each league in data.getChildren( - 1, 0)
      m.items.append(league.getChildren( - 1, 0))
    end for
  end if
end sub

sub onIndexChange(event)
  data = event.getData()
  if data <> invalid and m.items.count() > data then
    item = m.items[data]
    m.title.text = item.title + " (" + item.getParent().id + ")"
    m.teamGroup.removeChildrenIndex(m.teamGroup.getChildCount(), 0)
    for each team in item.getChildren( - 1, 0)
      row = m.teamGroup.createChild("TeamRow")
      row.itemContent = team
      row.width = 1500
      row.height = 99
      row.fontSize = 66
    end for
  end if
end sub


