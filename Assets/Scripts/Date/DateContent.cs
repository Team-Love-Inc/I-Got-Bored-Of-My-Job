using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DateContent : EntryPoint
{
    public GameObject panel;
    protected override void StartContent()
    {
        return;
    }

    protected override Stage GetNextInnerStage()
    {
        return innerStages.Find(x => x.GetName() == (int)Date.Names.TWO);
    }
}
