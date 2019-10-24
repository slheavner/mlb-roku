sub init()
  m.tracker = m.top.createChild("TrackerTask")
  m.apiTask = m.top.findNode("apiTask")
  m.videoPlayer = m.top.findNode("videoPlayer")
  m.apiTask.observeField("data", "onApiData")
  m.img = m.top.findNode("imageViewer")
  m.divisionView = m.top.findNode("divisionView")
  m.divisionGroup = m.top.findNode("divisionGroup")
  m.apiTask.control = "run"
  m.alRect = m.top.findNode("alRect")
  m.nlRect = m.top.findNode("nlRect")
  m.alRect.observeField("itemSelected", "onDivisionSelected")
  m.alRect.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean)
  if key = "left" then
    m.alRect.jumpToItem = m.nlRect.itemFocused
    m.alRect.setFocus(true)
  else if key = "right" then
    m.nlRect.jumpToItem = m.alRect.itemFocused
    m.nlRect.setFocus(true)
  end if
end function

function onApiData(event)
  data = event.getData()
  if data <> invalid then
    m.alRect.content = data.getChild(0)
    m.nlRect.content = data.getChild(1)
  end if
end function

sub onDivisionSelected(event)
  ? "selected division"
  node = event.getRoSGNode()
  index = event.getData()
  m.divisionView.itemContent = node.content.getChild(index)
  m.divisionGroup.visible = true
  m.divisionGroup.setFocus(true)
end sub
