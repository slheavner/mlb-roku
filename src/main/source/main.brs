sub RunUserInterface(params as object)
  screen = CreateObject("roSGScreen")
  port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  scene = screen.CreateScene("AppScene")
  screen.show()

  checkForUnitTests(params)

  while(true)
    msg = wait(0, port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent" then
      if msg.isScreenClosed() then
        return
      end if
    end if
  end while
end sub
