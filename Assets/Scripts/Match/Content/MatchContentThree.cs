using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MatchContentThree : Content
{
    protected override void StartContent()
    {

    }

    public void BtnPressed()
    {
        Stop(StageNames.DATE);
    }
}

