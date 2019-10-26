sub init()
  m.apiTask = m.top.findNode("apiTask")
  m.apiTask.observeField("data", "onApiData")
  m.divisionScreen = m.top.findNode("divisionScreen")
  m.apiTask.control = "run"
  m.alRect = m.top.findNode("alRect")
  m.nlRect = m.top.findNode("nlRect")
  m.alRect.observeField("itemSelected", "onDivisionSelected")
  m.nlRect.observeField("itemSelected", "onDivisionSelected")
  m.alRect.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean)
  if key = "left" and press then
    m.alRect.jumpToItem = m.nlRect.itemFocused
    m.alRect.setFocus(true)
  else if key = "right" and press then
    m.nlRect.jumpToItem = m.alRect.itemFocused
    m.nlRect.setFocus(true)
  else if key = "back" and press and m.divisionScreen.isInFocusChain() then
    index = m.divisionScreen.index
    if index < 3
      m.alRect.setFocus(true)
      m.alRect.jumpToItem = index
    else
      m.nlRect.setFocus(true)
      m.nlRect.jumpToItem = index - 3
    end if
    return true
  end if
end function

function onApiData(event)
  data = event.getData()
  if data <> invalid then
    m.alRect.content = data.getChild(0)
    m.nlRect.content = data.getChild(1)
    m.divisionScreen.itemContent = data
  end if
end function

sub onDivisionSelected(event)
  node = event.getRoSGNode()
  index = event.getData()
  if node.id = "nlRect" then
    index = (index + 3)
  end if
  m.divisionScreen.index = index
  m.divisionScreen.visible = true
  m.divisionScreen.setFocus(true)
end sub
