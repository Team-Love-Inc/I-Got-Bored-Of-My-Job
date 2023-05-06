using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class DateContentOne : Content
{
    private Story story;

    [SerializeField]
    private ConversationNumericPlacement conversation;

    [SerializeField]
    private Canvas StoryCanvas = null;

    [SerializeField]
    private List<Button> TempButtons = new List<Button>();
    private bool startButtonPressed = false;
    [SerializeField]
    private Text Client = null;
    [SerializeField]
    private Text Match = null;
    [SerializeField]
    private Text Narration = null;

    protected override void StartContent()
    {
        StoryCanvas.enabled = true;
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
        ContinueStory(StoryCanvas);
    }

    private void StartButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);
        foreach(var button in TempButtons)
        {
            GameObject.Destroy(button.gameObject);
        }
        startButtonPressed = true;
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

    private void ContinueStory(Canvas canvas)
    {
        Match.text = "";
        Client.text = "";
        Narration.text = "";
        while (story.canContinue)
        {
            string text = story.Continue();
            var tags = story.currentTags;
            if (tags.Count == 0)
            {
                Narration.text = text.Trim();
                continue;
            }
            foreach (var tag in tags)
            {
                if(tag.Trim().ToLower().StartsWith("pause"))
                {
                    var pause = tag.Split('-');
                    if(pause.Length != 2)
                    {
                        Debug.Log("DateContentOne - ContinueStory: pause tag '" + tag.Trim() + "'with invalid format found.");
                        continue;
                    }
                    StartCoroutine(StorySleep(pause[1]));
                    return;
                }
                switch(tag.Trim().ToLower())
                {
                    case "match":
                        Match.text = "match: " + text.Trim();
                        break;
                    case "client":
                        Client.text = "client: " + text.Trim();
                        break;
                    case "narrator":
                        Narration.text = text.Trim();
                        break;
                    default:
                        Debug.Log("DateContentOne - ContinueStory: unknown tag " + tag.Trim() + " found.");
                        break;
                }
            }
        }

        // Temporary, only used to start the self running conversation.
        if (!startButtonPressed && story.currentChoices.Count > 0)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = conversation.CreateAndPlaceButton(choice.text.Trim(), canvas, new Vector3(-112.5f * (conversation.numberOfButtons % 2), -120, 0));
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate
                {
                    StartButton(choice);
                });
                TempButtons.Add(button);
            }
        }
    }
}
