'build a default new roUrlTransfer with system certs
function newRequest(url as string) as object
  request = CreateObject("roUrlTransfer")
  request.setUrl(url)
  request.SetCertificatesFile("common:/certs/ca-bundle.crt")
  request.initClientCertificates()
  return request
end function

'send a GET request with a roUrlTransfer object
function getResponse(request, json = true, timeoutMillis = 20000) as object
  return _doResponse("get", request, invalid, json, timeoutMillis)
end function

function _doResponse(method as string, request as object, body, json, timeoutMillis) as object
  if m._requests = invalid then
    m._requests = []
  end if
  m._requests.push(request)
  port = CreateObject("roMessagePort")
  request.setMessagePort(port)
  request.retainBodyOnError(true)
  if method = "get" then
    didRequest = request.asyncGetToString()
  else if method = "post" then
    didRequest = request.asyncPostFromString(body)
  end if
  if didRequest then
    return _waitForUrlEvent(port, timeoutMillis, json)
  else
    m.global.logutil.log = "Request failed: " + request.getUrl()
  end if
  return invalid
end function
function _waitForUrlEvent(port, timeoutMillis, json) as object
  timer = CreateObject("roTimeSpan")
  timer.mark()
  while true
    msg = wait(0, port)
    if type(msg) = "roUrlEvent" then
      return _buildResponse(msg, json)
    end if
    if timer.totalMilliseconds() > timeoutMillis then
      m.global.logutil.log = "timeout exceeded"
      exit while
    end if
  end while
  return invalid
end function

function _buildResponse(msg as object, json as boolean) as object
  n = msg.getSourceIdentity()
  url = "not found"
  if m._requests <> invalid then
    for i = 0 to m._requests.count()
      if m._requests[i].getIdentity() = n then
        url = m._requests[i].getUrl()
        m._requests.delete(i)
        exit for
      end if
    end for
  end if
  response = {
    status: msg.getResponseCode(),
    statusString: msg.getFailureReason(),
    body: msg,
    headers: msg.getResponseHeaders()
    json: invalid
  }
  if json and response.body <> invalid and response.body <> "" then
    response.json = parseJson(response.body)
  end if
  return response
end function
