using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Stage : MonoBehaviour
{
    [SerializeField]
    public EntryPointStorage PlayableContent;
    [SerializeField]
    private int StartContent;
    [SerializeField]
    public Controller controller;
    protected StageStorage Stages;

    public void StartStage(StageStorage Stages)
    {
        this.Stages = Stages;
        NextContent(StartContent);
    }

    public void NextContent(int contentNumber)
    {
        Content content;
        var found = PlayableContent.TryGetValue(contentNumber, out content);
        if (found)
        {
            content.Play(this);
        }
        else
        {
            Debug.Log(new System.Exception("Stages: NextContent " + contentNumber + " content not found"));
        }
    }

    public void NextStage(StageNames Name)
    {
        controller.NextStage(Name);
    }
}

[Serializable]
public class StageStorage : SerializableDictionary<StageNames, Stage> { }