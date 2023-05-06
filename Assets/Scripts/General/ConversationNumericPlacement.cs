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

    public int numberOfButtons = 0;

    public Story StartStory()
    {
        story = new Story(inkJSONAsset.text);
        if (OnCreateStory != null)
        {
            OnCreateStory(story);
        }
        return story;
    }

    public void GenericContinueStory(Canvas canvas, Func<Choice, bool> function)
    {
        // Remove all the UI on screen
        RemoveChildren(canvas);

        int offset = 0;
        while (story.canContinue)
        {
            // Continue gets the next line of the story
            string text = story.Continue();
            CreateAndPlaceText(text.Trim(), canvas, new Vector3(0, offset, 0));
            offset -= 50;
        }

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0)
        {
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Button button = CreateAndPlaceButton(choice.text.Trim(), canvas, new Vector3(-112.5f*(numberOfButtons%2), -120 , 0));
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate {
                    function(choice);
                });
            }
        }
    }

    // Destroys all the children of this gameobject (all the UI)
    public void RemoveChildren(Canvas canvas)
    {
        int childCount = canvas.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i)
        {
            GameObject.Destroy(canvas.transform.GetChild(i).gameObject);
        }
        childCount = canvas.transform.childCount;
        numberOfButtons = 0;
    }

    public Text CreateAndPlaceText(string text, Canvas canvas, Vector3 Position)
    {
        Text storyText = Instantiate(textPrefab) as Text;
        storyText.text = text;
        storyText.transform.SetParent(canvas.transform, false);
        storyText.GetComponent<RectTransform>().anchoredPosition = Position;
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

        numberOfButtons++;
        return choice;
    }
}
