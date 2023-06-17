using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class InterviewContentTwo : Content
{
    [SerializeField]
    private GameObject DebugButton;

    private Story story;

    [SerializeField]
    ConversationNumericPlacement conversation;

    public MatchBase client;

    [SerializeField]
    private Preparation preparation;

    [SerializeField]
    private InterviewStory interview;

    protected override void StartContent()
    {
        if(Debug.isDebugBuild)
        {
            DebugButton.SetActive(true);
        }
        GlobalDataSingleton.setClient(client);
        story = conversation.StartStory();
        preparation.Run(story);
    }

    public void InterviewComplete()
    {
        Stop(StageNames.MATCH);
    }

    public void StartInterview()
    {
        if(preparation.CanInterviewStart())
        {
            interview.Run(story, preparation.QuestionsToAsk, InterviewComplete);
        }
    }
}
