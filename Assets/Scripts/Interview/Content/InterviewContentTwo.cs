using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using System;
using System.Linq;

public class InterviewContentTwo : Content
{
    public static event Action<Story> OnCreateStory;

    [SerializeField]
    private TextAsset inkJSONAsset = null;
    public Story story;

    [SerializeField]
    private Canvas StoryCanvas = null;

    [SerializeField]
    private Canvas PreparationCanvas = null;

    // UI Prefabs
    [SerializeField]
    private Text textPrefab = null;
    [SerializeField]
    private Button buttonPrefab = null;

    private int numberOfButtons = 0;
    private Dictionary<string, string> Questions = new Dictionary<string, string>();
    private Queue<KeyValuePair<string, string>> QuestionsToAsk = new Queue<KeyValuePair<string, string>>();
    private Text PreparationText = null;
    private int PreparationNum = 0;
    private bool interviewActive = false;
    [SerializeField]
    private int numberOfQuestions = 3;

    protected override void StartContent()
    {
        //RemoveChildren(StoryCanvas);
        StartStory();
    }
    public void BtnPressed()
    {
        Stop(2);
    }

    private void StartStory()
    {
        story = new Story(inkJSONAsset.text);
        if (OnCreateStory != null) OnCreateStory(story);
        story.allowExternalFunctionFallbacks = true;
        story.BindExternalFunction("InterviewPreparation", InterviewPreparation);
        story.BindExternalFunction("NextQuestion", NextQuestion);
        
        GetQuestions();
        ContinueStory();
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
        CreateAndPlaceButton("Done planning", PreparationCanvas, new Vector3(4, -204, 0)).onClick.AddListener(delegate {
            StartInterview();
        });

        PreparationText = CreateAndPlaceText("Questions 0/3", PreparationCanvas, new Vector3(4, 80, 0));
        PreparationNum = 0;
        foreach (KeyValuePair<string, string> question in Questions) 
        {
            Button button = CreateAndPlaceButton(question.Value, PreparationCanvas, new Vector3(-417, 119 - 50*i++, 0));
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
            CreateAndPlaceText(question.Value, PreparationCanvas,
                button.GetComponent<RectTransform>().anchoredPosition + new Vector2(700, 0));
            GameObject.Destroy(button.gameObject);
            PreparationText.text = "Question " + ++PreparationNum + "/3";
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
            RemoveChildren(PreparationCanvas);
            PreparationCanvas.enabled = false;
            StoryCanvas.enabled = true;
            NextQuestion();
            ContinueStory();
        }
    }

    private void End()
    {
        PreparationCanvas.enabled = true;
        StoryCanvas.enabled = false;
        CreateAndPlaceText("Interview over", PreparationCanvas, new Vector3(0, 0, 0));
    }

    private void ContinueStory()
    {
        // Remove all the UI on screen
        RemoveChildren(StoryCanvas);

        int offset = 0;
        while (story.canContinue)
        {
            // Continue gets the next line of the story
            string text = story.Continue();
            CreateAndPlaceText(text.Trim(), StoryCanvas, new Vector3(0, offset, 0));
            offset -= 50;
        }

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = CreateAndPlaceButton(choice.text.Trim(), StoryCanvas, new Vector3(0, -120, 0));
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate {
                    OnClickChoiceButton(choice);
                });
            }
        }
    }

    // When we click the choice button, tell the story to choose that choice!
    void OnClickChoiceButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);
        NextQuestion();
        ContinueStory();
    }

    // Destroys all the children of this gameobject (all the UI)
    void RemoveChildren(Canvas canvas)
    {
        int childCount = canvas.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i)
        {
            GameObject.Destroy(canvas.transform.GetChild(i).gameObject);
        }
        childCount = canvas.transform.childCount;
        numberOfButtons = 0;
    }

    // Place somewhere else if used.. 

    private Text CreateAndPlaceText(string text, Canvas canvas, Vector3 Position)
    {
        Text storyText = Instantiate(textPrefab) as Text;
        storyText.text = text;
        storyText.transform.SetParent(canvas.transform, false);
        storyText.GetComponent<RectTransform>().anchoredPosition = Position;
        return storyText;
    }

    private Button CreateAndPlaceButton(string text, Canvas canvas, Vector3 Position)
    {
        // Creates the button from a prefab
        Button choice = Instantiate(buttonPrefab) as Button;
        choice.transform.SetParent(canvas.transform, false);

        // Gets the text from the button prefab
        Text choiceText = choice.GetComponentInChildren<Text>();
        choiceText.text = text;

        // Make the button expand to fit the text
        HorizontalLayoutGroup layoutGroup = choice.GetComponent<HorizontalLayoutGroup>();
        layoutGroup.childForceExpandHeight = false;

        choice.GetComponent<RectTransform>().anchoredPosition = Position;

        numberOfButtons++;
        return choice;
    }
}
