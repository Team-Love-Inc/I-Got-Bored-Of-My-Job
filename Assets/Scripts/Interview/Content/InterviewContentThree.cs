using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContentThree : Content
{
    protected override void StartContent()
    {
        
    }

    public void BtnPressed()
    {
        Stop(StageNames.MATCH);
    }
}
