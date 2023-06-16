using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContentOne : Content
{
    [SerializeField]
    private List<Animator> Animators;

    private List<string> Emotes = new List<string>() { "Happy", "Excited", "Angry", "Nervous", "Sad" };

    protected override void StartContent()
    {

    }

    public void NextScene()
    {
        Stop(1);
    }

    public void Quit()
    {
        Stop(StageNames.NONE);
    }
}
