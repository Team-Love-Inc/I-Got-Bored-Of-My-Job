using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DateContentThree : Content
{
    protected override void StartContent()
    {

    }

    public void MainMenu()
    {
        Stop(StageNames.INTERVIEW);
    }

    public void TryAgain()
    {
        Stop(0);
    }
}
