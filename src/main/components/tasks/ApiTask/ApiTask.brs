
sub init()
  m.top.functionName = "getContent"
  m.url = "@{api.url}"
  m.divisionOrder = {
    "East": 0,
    "Central": 1
    "West": 2
  }
end sub
' {
' "team": "KCR",
' "wins": 58,
' "losses": 104,
' "league": "AL",
' "division": "Central"
' },

sub getContent()
  request = newRequest(m.url)
  result = getResponse(request)
  _buildContentNodes(result.json)
end sub

function _buildContentNodes(json as object)
  root = createObject("roSGNode", "ContentNode")
  root.id = "root"
  al = root.createChild("ContentNode")
  al.id = "AL"
  nl = root.createChild("ContentNode")
  nl.id = "NL"
  map = {
    "AL": {
      node: al,
      divisions: {

      }
    },
    "NL": {
      node: nl,
      divisions: {

      }
    },
  }
  for each team in json
    league = map[team.league]

    if league.divisions[team.division] = invalid then
      league.divisions[team.division] = createObject("roSGNode", "ContentNode")
      league.divisions[team.division].id = team.division
      league.divisions[team.division].title = team.division
      league.divisions[team.division].contentType = "CONTENT"
      league.node.insertChild(league.divisions[team.division], _findDivisionInsertIndex(team.division, league.node))
    end if

    division = league.divisions[team.division]

    child = createObject("roSGNode", "ContentNode")
    child.addFields({
      team: team.team,
      wins: team.wins,
      losses: team.losses,
      league: team.league,
      division: team.division,
      percentage: Left(Mid(Str(team.wins / (team.wins + team.losses)), 3), 4) ' format to .000
    })
    child.id = team.team
    child.title = team.team
    division.insertChild(child, _findInsertIndex(child.wins, division))
  end for
  m.top.data = root
end function

function _findInsertIndex(wins, division)
  children = division.getChildren( - 1, 0)
  for i = 0 to children.count() - 1
    if wins > children[i].wins then
      return i
    end if
  end for
  return children.count()
end function

function _findDivisionInsertIndex(id, league)
  children = league.getChildren( - 1, 0)
  for i = 0 to children.count() - 1
    if m.divisionOrder[children[i].id] > m.divisionOrder[id] then
      ? i
      return i
    end if
  end for
  return children.count()
end function