sub RunUserInterface(params as object)
  screen = CreateObject("roSGScreen")
  port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  scene = screen.CreateScene("AppScene")
  screen.show()

  ' if this is debug flavor, do any debug things
  if type(debug) = "Function" then
    debug(params, scene)
  end if
  ' if this is debug flavor, do any debug things
  if type(test) = "Function" then
    test(params, scene)
  end if

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
