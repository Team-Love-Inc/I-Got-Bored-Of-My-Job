using System.Collections.Generic;
using System.Linq;

public static class GlobalDataSingleton
{
    private static MatchBase choosenMatch;
    public static List<MatchBase> Matches = new List<MatchBase>();


    public static void setMatch(MatchBase match)
    {
        choosenMatch = match;
    }

    public static MatchBase getMatch()
    {
        return choosenMatch;
    }

    public static void setMatchByName(string matchName)
    {
        choosenMatch = Matches.FirstOrDefault(x => x.Name == matchName);
    }

    public static void setMatches(MatchBase match)
    {
        Matches.Add(match);
    }
}


