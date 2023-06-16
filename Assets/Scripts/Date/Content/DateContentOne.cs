using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using TMPro;

public class DateContentOne : Content
{
    private Story story;

    [SerializeField]
    private ConversationNumericPlacement conversation;

    [SerializeField]
    private Canvas StoryCanvas = null;

    private List<Button> TempButtons = new List<Button>();
    
    [SerializeField]
    private TextMeshProUGUI ClientSpeech = null;

    [SerializeField]
    private TextMeshProUGUI MatchSpeech = null;

    [SerializeField]
    private TextMeshProUGUI NarrationSpeech = null;

    [SerializeField]
    private GameObject ChoiceAbility = null;

    [SerializeField]
    private ProgressBar ClientBar;
    [SerializeField]
    private ProgressBar MatchBar;
    [SerializeField]
    private ProgressBar AbilityTimerBar;

    private string feedbackResult = "NEUTRAL";

    [SerializeField]
    private Animator ClientAnimator;
    private int clientPreviousLoveValue = 50;

    [SerializeField]
    private Animator MatchAnimator;
    private int matchPreviousLoveValue = 50;

    private List<string> positiveEmotes = new List<string>() { "Happy", "Excited" };
    private List<string> negativeEmotes = new List<string>() { "Angry", "Nervous", "Sad" };

    protected override void StartContent()
    {
        StoryCanvas.enabled = true;
        ChoiceAbility.SetActive(false);
        StartStory();
    }
    public void BtnPressed()
    {
        Stop(1);
    }

    private void StartStory()
    {
        story = conversation.StartStory();
        story.allowExternalFunctionFallbacks = true;
        story.BindExternalFunction("getFeedBack", getFeedBack);
        story.ObserveVariable("clientMood", (string varName, object newValue) => {
            ClientBar.setProgress((int)newValue);
            if ((int)newValue >= clientPreviousLoveValue)
            {
                ClientAnimator.Play(positiveEmotes[Random.Range(0, positiveEmotes.Count)]);
            } 
            else
            {
                ClientAnimator.Play(negativeEmotes[Random.Range(0, negativeEmotes.Count)]);
            }
        });
        story.ObserveVariable("matchMood", (string varName, object newValue) =>
        {
            MatchBar.setProgress((int)newValue);
            if ((int)newValue >= matchPreviousLoveValue)
            {
                MatchAnimator.Play(positiveEmotes[Random.Range(0, positiveEmotes.Count)]);
            }
            else
            {
                MatchAnimator.Play(negativeEmotes[Random.Range(0, negativeEmotes.Count)]);
            }
        });
        ClientBar.reset();
        MatchBar.reset();
        AbilityTimerBar.reset(1f);
        ContinueStory(StoryCanvas, true);
    }

    private void StartButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);
        foreach(var button in TempButtons)
        {
            GameObject.Destroy(button.gameObject);
        }
        TempButtons.Clear();
        ClientBar.reset();
        ContinueStory(StoryCanvas);
    }

    private IEnumerator StorySleep(string sleepInterval)
    {
        decimal interval;
        if(!decimal.TryParse(sleepInterval, out interval))
        {
            interval = 2;
            Debug.Log("DateContentOne - StorySleep: Numeric conversion of " + sleepInterval + " failed.");
        }
        yield return new WaitForSeconds(((float)interval));
        ContinueStory(StoryCanvas);
    }

    private void ContinueStory(Canvas canvas, bool start = false)
    {
        MatchSpeech.text = "";
        ClientSpeech.text = "";
        NarrationSpeech.text = "";
        while (story.canContinue)
        {
            string text = story.Continue();
            var tags = story.currentTags;
            if (tags.Count == 0)
            {
                //NarrationSpeech.text = text.Trim();
                continue;
            }
            foreach (var tag in tags)
            {
                if (tag.Trim().ToLower().StartsWith("enablefeedback"))
                {
                    feedbackResult = "NEUTRAL";
                    var pause = tag.Split('-');
                    if (pause.Length != 2)
                    {
                        Debug.LogError("DateContentOne - ContinueStory: enable feedback pause tag '" + tag.Trim() + "'with invalid format found.");
                        continue;
                    }

                    ChoiceAbility.SetActive(true);
                    if(!AbilityTimerBar.setCountDown(pause[1]))
                    {
                        ChoiceAbility.SetActive(false);
                        continue;
                    }
                    continue;
                }

                if (tag.Trim().ToLower().StartsWith("disablefeedback"))
                {
                    ChoiceAbility.SetActive(false);
                    continue;
                }

                if (tag.Trim().ToLower().StartsWith("pause"))
                {
                    var pause = tag.Split('-');
                    if(pause.Length != 2)
                    {
                        Debug.LogError("DateContentOne - ContinueStory: pause tag '" + tag.Trim() + "'with invalid format found.");
                        continue;
                    }
                    StartCoroutine(StorySleep(pause[1]));
                    return;
                }
                switch(tag.Trim().ToLower())
                {
                    case "match":
                        MatchSpeech.text = text.Trim();
                        break;
                    case "client":
                        ClientSpeech.text = text.Trim();
                        break;
                    case "narrator":
                        NarrationSpeech.text = text.Trim();
                        break;
                    default:
                        Debug.Log("DateContentOne - ContinueStory: unknown tag " + tag.Trim() + " found.");
                        break;
                }
            }
        }

        // Temporary, only used to start the self running conversation.
        if (story.currentChoices.Count > 0)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = conversation.CreateAndPlaceButton(choice.text.Trim(), canvas, new Vector3(0, -120, 0));
                button.onClick.AddListener(delegate
                {
                    StartButton(choice);
                });
                TempButtons.Add(button);
            }
        } 
        else if (!start)
        {
            // No more conversation or choices. Story is over.
            if((bool)story.variablesState["DateSuccess"])
            {
                Debug.Log("Date success");
                Stop(1);
            } else
            {
                Stop(2);
            }
            //story.ResetState();
            //ContinueStory(canvas, true);
        }
    }

    public void getFeedBack()
    {
        var newList = new Ink.Runtime.InkList("FeedBack", story);
        newList.AddItem(feedbackResult);
        story.variablesState["FeedBack"] = newList;
    }

    public void buttonPressed(bool choice)
    {
        if(choice)
        {
            feedbackResult = "YES";
        }
        else
        {
            feedbackResult = "NO";
        }
        ChoiceAbility.SetActive(false);
    }
}
