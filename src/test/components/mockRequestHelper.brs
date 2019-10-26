function newRequest(url as string) as object
  request = CreateObject("roUrlTransfer")
  request.setUrl(url)
  request.SetCertificatesFile("common:/certs/ca-bundle.crt")
  request.initClientCertificates()
  return request
end function

'send a GET request with a roUrlTransfer object
function getResponse(request, json = true, timeoutMillis = 20000) as object
  fixture = readAsciiFile("pkg:/assets/fixtures/teams.json")
  return {
    status: 200,
    statusString: "",
    body: fixture,
    headers: {}
    json: parseJson(fixture)
  }
end function