using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using System;
using System.Linq;

public class ConversationNumericPlacement : MonoBehaviour
{
    public static event Action<Story> OnCreateStory;

    [SerializeField]
    private TextAsset inkJSONAsset = null;
    public Story story;

    // UI Prefabs
    [SerializeField]
    private Text textPrefab = null;
    [SerializeField]
    private Button buttonPrefab = null;
    
    private List<Transform> temporaryItem = new List<Transform>();
    private int numberOfButtons = 0;

    public Story StartStory()
    {
        story = new Story(inkJSONAsset.text);
        if (OnCreateStory != null)
        {
            OnCreateStory(story);
        }
        return story;
    }

    public void GenericContinueStory(Canvas canvas, Action nextLine, Func<Choice, bool> nextTopic)
    {
        // Remove all the UI on screen
        //RemoveChildren(canvas);

        //int offset = 0;
        if (story.canContinue)
        {
            // Continue gets the next line of the story
            string text = story.Continue();
            //conversationTextBox.text = text.Trim();
            // CreateAndPlaceText(text.Trim(), canvas, new Vector3(0, offset, 0));
            //offset -= 50;

        }

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0 && nextTopic != null)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = CreateAndPlaceButton(choice.text.Trim(), canvas, new Vector3(-112.5f * (numberOfButtons % 2), -120, 0));
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate
                {
                    nextTopic(choice);
                });
            }
        }
        else if (nextLine != null)
        {
            //Button button = CreateAndPlaceButton("next", canvas, new Vector3(-112.5f * (numberOfButtons % 2), -120, 0));
            //button.onClick.AddListener(delegate {
            //    nextLine();
            //});
        }
    }

    // Destroys all the children of this gameobject (all the UI)
    public void RemoveTemporaries(Canvas canvas)
    {
        //int childCount = canvas.transform.childCount;
        //for (int i = childCount - 1; i >= 0; --i)
        foreach(var item in temporaryItem)
        {
            if(item != null)
            {
                GameObject.Destroy(item.gameObject);
            }
        }
        //childCount = canvas.transform.childCount;
        temporaryItem.Clear();
        numberOfButtons = 0;
    }

    public Text CreateAndPlaceText(string text, Canvas canvas, Vector3 Position)
    {
        Text storyText = Instantiate(textPrefab) as Text;
        storyText.text = text;
        storyText.transform.SetParent(canvas.transform, false);
        storyText.GetComponent<RectTransform>().anchoredPosition = Position;
        temporaryItem.Add(storyText.transform);
        return storyText;
    }

    public Button CreateAndPlaceButton(string text, Canvas canvas, Vector3 Position)
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

        temporaryItem.Add(choice.transform);

        numberOfButtons++;
        return choice;
    }
}
