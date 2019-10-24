Function TestSuite__DisplayUtils() as Object

    ' inherit your test suite from BaseTestSuite
    this = BaseTestSuite()

    ' Test suite name for log statistics
    this.Name = "apiTestSuite"

    this.SetUp = apiTest_setup
    'this.TearDown = MainTestSuite__TearDown

    ' Add tests to suite's tests collection
    this.addTest("TestCase__newVideoGridItem", TestCase__newVideoGridItem)

    return this
End Function

function apiTest_setup()

  m.api = api()
End Function

function TestCase__newVideoGridItem() as string

  node = m.api.newVideoGridItem({
    thumb: "thumb.jpg",
    title: "title",
    subtitle: "subtitle"
  }, "root/")
  fields = node.getFields()
  return m.assertAAContains({
    hdposterurl: "root/thumb.jpg",
    shortDescriptionLine1: "title",
    shortDescriptionLine2: "subtitle"
  }, fields)
end Function
