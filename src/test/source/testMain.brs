sub test(params, scene)
  if params.RunTests = "true" then
    Runner = TestRunner()
    Runner.setFunctions([
      ApiTest_Before,
      ApiTest_BuildsResponseWithJson,
      ApiTest_BuildsResponseWithoutJson
    ])
    Runner.Logger.SetVerbosity(3)
    Runner.Logger.SetEcho(false)
    Runner.Logger.SetJUnit(false)

    Runner.Run()
  end if
end sub