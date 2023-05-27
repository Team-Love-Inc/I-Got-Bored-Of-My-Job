using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;

public class InkReadUtility
{

   //public static List<string> GetGlobalTags(Story story, string identifier)
   //{

   //}
   public static Dictionary<string, string> GetGlobalTags(Story story, string identifier)
    {
        Dictionary<string, string> storage = new Dictionary<string, string>();
        foreach (string tag in story.globalTags)
        {
            if (tag.StartsWith(identifier + ":"))
            {
                var expression = tag.Split(identifier + ":")[1];
                var asd = tag.Split(identifier);
                if (expression.Contains("="))
                {
                    var NameAndValue = expression.Split("=");
                    if (NameAndValue.Length != 2)
                    {
                        Debug.LogError("InkReadUtility: GetGlobalTags: Global tag contains more then two items around '='. Or there are multiple '=' in the string.");
                    }
                    if (storage.TryAdd(NameAndValue[0].Trim(), NameAndValue[1].Trim()))
                    {
                        continue;
                    }
                    Debug.LogError("InkReadUtility: GetGlobalTags: Item named " + NameAndValue[0] + " declared more then once");
                }
                else
                {
                    Debug.LogError("InkReadUtility: GetGlobalTags: Global tag does not contain '='");
                }
            }
        }
        if (storage.Count == 0)
        {
            Debug.LogError("InkReadUtility: GetGlobalTags: Global tag does not contain '" + identifier + "'");
        }
        return storage;
    }

    class Storage
    {
        public Storage(Dictionary<string, string> storage)
        {

        }
    }
}
