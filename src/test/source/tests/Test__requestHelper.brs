' @BeforeAll
sub ApiTest_Before()
  m.msg = {
    getSourceIdentity: function()
      return 1
    end function
    getResponseCode: function()
      return 200
    end function,
    getFailureReason: function()
      return "failure reason"
    end function,
    getString: function()
      return "{ ""key"": ""value"" }"
    end function,
    getResponseHeaders: function()
      return { header1: "header value" }
    end function
  }
end sub
' @Test
function ApiTest_BuildsResponseWithJson()
  result = _buildResponse(m.msg, true)
  UTF_assertEqual(result.status, 200)
  UTF_assertEqual(result.statusString, "failure reason")
  UTF_assertEqual(result.body, "{ ""key"": ""value"" }")
  UTF_assertEqual(result.json, { key: "value" })
end function
' @Test
function ApiTest_BuildsResponseWithoutJson()
  result = _buildResponse(m.msg, false)
  UTF_assertEqual(result.status, 200)
  UTF_assertEqual(result.statusString, "failure reason")
  UTF_assertEqual(result.body, "{ ""key"": ""value"" }")
  UTF_assertInvalid(result.json)
end function
