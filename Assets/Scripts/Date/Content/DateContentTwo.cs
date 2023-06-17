using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DateContentTwo : Content
{
    protected override void StartContent() {}
    public void MainMenu()
    {
        Stop(StageNames.INTERVIEW);
    }
}
