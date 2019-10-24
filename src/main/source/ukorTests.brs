sub checkForUnitTests(params as Object)
  if params.RunTests = "true"
    runner = TestRunner()
    if params.host <> invalid
      runner.logger.SetServer(params.host, params.port)
    else
      runner.logger.SetServerURL(param.url)
    end if
    'other setup if needed
    runner.run()
  end if
end sub
