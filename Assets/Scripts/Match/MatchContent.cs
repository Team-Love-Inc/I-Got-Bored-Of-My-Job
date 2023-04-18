using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MatchContent : EntryPoint
{
    public GameObject panel;
    protected override void StartContent()
    {
        return;
    }

    protected override Stage GetNextInnerStage()
    {
        return innerStages.Find(x => x.GetName() == (int)Match.Names.TWO);
    }
}
