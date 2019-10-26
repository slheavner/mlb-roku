sub init()
  Runner = TestRunner()
  Runner.SetFunctions([
    TestSuite__DivisonItemTestSuite
  ])
end sub

function TestSuite__DivisonItemTestSuite() as object
  this = BaseTestSuite()
  this.Name = "TestSuite__DivisonItemTestSuite"
  this.addTest("TestCase__SetsTitle", TestCase__SetsTitle)
  this.addTest("TestCase__SetsChild0", TestCase__SetsChild0)
  this.addTest("TestCase__SetsChild1", TestCase__SetsChild1)
  this.addTest("TestCase__SetsChild2", TestCase__SetsChild2)
  this.addTest("TestCase__SetsChild3", TestCase__SetsChild3)
  this.addTest("TestCase__SetsChild4", TestCase__SetsChild4)
  this.top = m.top
  this.teams = m.teams
  this.title = m.title
  this.event = {
    getData: function()
      data = CreateObject("roSGNode", "ContentNode")
      data.id = "title"
      for i = 0 to 4
        child = data.createChild("ContentNode")
        child.id = "team-" + i.toStr()
        child.addFields({
          team: "team-" + i.toStr(),
          wins: i,
          losses: i + 1
          percentage: .5,
          gb: 1
        })
      end for
      return data
    end function
  }
  return this
end function

' @Test
function TestCase__SetsTitle() as object
  onDivisionChange(m.event)
  return m.assertEqual(m.title.text, "title")
end function

function TestCase__SetsChild0() as object
  return m.assertEqual(m.teams.getChild(0).itemContent.team, "team-0")
end function
function TestCase__SetsChild1() as object
  return m.assertEqual(m.teams.getChild(1).itemContent.team, "team-1")
end function
function TestCase__SetsChild2() as object
  return m.assertEqual(m.teams.getChild(2).itemContent.team, "team-2")
end function
function TestCase__SetsChild3() as object
  return m.assertEqual(m.teams.getChild(3).itemContent.team, "team-3")
end function
function TestCase__SetsChild4() as object
  return m.assertEqual(m.teams.getChild(4).itemContent.team, "team-4")
end function
