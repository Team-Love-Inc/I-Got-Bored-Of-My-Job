using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class InterviewContentTwo : Content
{
    private Story story;

    [SerializeField]
    private Canvas StoryCanvas = null;

    [SerializeField]
    private Canvas PreparationCanvas = null;

    [SerializeField]
    private int numberOfQuestions = 3;

    [SerializeField]
    ConversationNumericPlacement conversation;
 
    private Dictionary<string, string> Questions = new Dictionary<string, string>();
    private Queue<KeyValuePair<string, string>> QuestionsToAsk = new Queue<KeyValuePair<string, string>>();
    private Text PreparationText = null;
    private int PreparationNum = 0;
    private bool interviewActive = false;

    protected override void StartContent()
    {
        StartStory();
    }
    public void BtnPressed()
    {
        Stop(2);
    }

    private void StartStory()
    {
        story = conversation.StartStory();
        story.allowExternalFunctionFallbacks = true;
        story.BindExternalFunction("InterviewPreparation", InterviewPreparation);
        story.BindExternalFunction("NextQuestion", NextQuestion);
        
        GetQuestions();
        conversation.GenericContinueStory(StoryCanvas, OnClickChoiceButton);
    }

    private void GetQuestions()
    {
        foreach (string tag in story.globalTags)
        {
            if (tag.StartsWith("Q:"))
            {
                var expression = tag.Split("Q:")[1];
                var asd = tag.Split("Q");
                if (expression.Contains("="))
                {
                    var NameAndValue = expression.Split("=");
                    if(NameAndValue.Length != 2)
                    {
                        Debug.Log("InterviewContentTwo: GetQuestions: Global tag contains more then two items around '='. Or there aremultiple '=' in the string.");
                    }
                    if(!Questions.TryAdd(NameAndValue[0].Trim(), NameAndValue[1].Trim()))
                    {
                        Debug.Log("InterviewContentTwo: GetQuestions: Questions named " + NameAndValue[0] + " declared more then once");
                    }
                }
                else
                {
                    Debug.Log("InterviewContentTwo: GetQuestions: Global tag does not contain '='");
                }
            }
        }

    }

    private void InterviewPreparation()
    {
        StoryCanvas.enabled = false;
        int i = 0;
        conversation.CreateAndPlaceButton("Done planning", PreparationCanvas, new Vector3(4, -204, 0)).onClick.AddListener(delegate {
            StartInterview();
        });

        PreparationText = conversation.CreateAndPlaceText("Questions 0/" + numberOfQuestions, PreparationCanvas, new Vector3(4, 80, 0));
        PreparationNum = 0;
        foreach (KeyValuePair<string, string> question in Questions) 
        {
            Button button = conversation.CreateAndPlaceButton(question.Value, PreparationCanvas, new Vector3(-417, 119 - 50*i++, 0));
            button.onClick.AddListener(delegate {
                SaveQuestion(question, button);
            });
        }
        return;
    }

    private void SaveQuestion(KeyValuePair<string, string> question, Button button)
    {
        if(PreparationNum < numberOfQuestions)
        {
            QuestionsToAsk.Enqueue(question);
            conversation.CreateAndPlaceText(question.Value, PreparationCanvas,
            button.GetComponent<RectTransform>().anchoredPosition + new Vector2(700, 0));
            GameObject.Destroy(button.gameObject);
            PreparationText.text = "Question " + ++PreparationNum + "/" + numberOfQuestions;
        }
    }

    private void NextQuestion()
    {
        if (!interviewActive)
        {
            return;
        }
        KeyValuePair<string, string> question;
        if(QuestionsToAsk.TryDequeue(out question))
        {
            story.ChoosePathString(question.Key);
        }
        else
        {
            End();
            interviewActive = false;
        }
    }

    private void StartInterview()
    {
        if(PreparationNum == numberOfQuestions)
        {
            PreparationNum = 0;
            interviewActive = true;
            conversation.RemoveChildren(PreparationCanvas);
            PreparationCanvas.enabled = false;
            StoryCanvas.enabled = true;
            NextQuestion();
            conversation.GenericContinueStory(StoryCanvas, OnClickChoiceButton);
        }
    }

    private void End()
    {
        PreparationCanvas.enabled = true;
        StoryCanvas.enabled = false;
        conversation.CreateAndPlaceText("Interview over", PreparationCanvas, new Vector3(0, 0, 0));
    }

    // When we click the choice button, tell the story to choose that choice!
    bool OnClickChoiceButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);
        NextQuestion();
        conversation.GenericContinueStory(StoryCanvas, OnClickChoiceButton);
        return true;
    }
}
