using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEditor;
public class Controller : MonoBehaviour
{
    public StageStorage Stages;
    [SerializeField]
    private StageNames StartStage;
    private Stage currentStage;

    void Start()
    {
        NextStage(StartStage);
    }

    public void NextStage(StageNames name)
    {
        if(name is StageNames.NONE)
        {
            Debug.Log(new System.Exception("Controller: Round is over"));
            Application.Quit();
            return;
        }

        var found = Stages.TryGetValue(name, out currentStage);
        if (found is false)
        {
            Debug.Log(new System.Exception("Controller: NextStage " + name + " stage not found"));
            return;
        }

        if (currentStage is not null)
        {
            currentStage.StartStage(Stages);
        } 
        else
        {
            Debug.Log(new System.Exception("Controller: currentStage for " + name + " is null"));
        }
    }
}


public enum StageNames
{
    NONE,
    INTERVIEW,
    MATCH,
    DATE
}
