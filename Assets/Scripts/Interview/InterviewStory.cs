using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using UnityEngine.UI;
using System;
using TMPro;

public class InterviewStory : MonoBehaviour
{
    [SerializeField]
    private AudioManager sound;

    private static string PLAYER = "Player";
    private static string CLIENT = "Client";

    private Story story;

    [SerializeField]
    private Canvas StoryCanvas = null;

    [System.Serializable]
    public struct ConversationWindow
    {
        public GameObject Panel;
        public TextMeshProUGUI TextBox;
        public TextMeshProUGUI Name;
        public Image image;
    }
    public ConversationWindow conversation;

    public CharacterSheet ClientInfo;
    public PlayerSheet PlayerInfo;

    private struct Character
    {
        public string Name;
        public Sprite image;

        public Character(string Name, Sprite image = null)
        {
            this.Name = Name;
            this.image = image;
        }
    }

    private Dictionary<string, Character> Characters = new Dictionary<string, Character>();
    private Queue<KeyValuePair<string, string>> QuestionsToAsk { get; set; }
    private Action interviewDone;

    enum Conversation
    {
        TOPIC_ACTIVE,
        TOPIC_COMPLETE,
        CHARACTER_SHEET_SHOWING,
        COMPLETE
    }
    private Conversation state;

    public void Run(Story story, Queue<KeyValuePair<string, string>> QuestionsToAsk, Action stop)
    {
        state = Conversation.TOPIC_ACTIVE;
        StoryCanvas.gameObject.SetActive(true);
        ClientInfo.Set();

        this.QuestionsToAsk = QuestionsToAsk;
        this.interviewDone = stop;
        this.story = story;

        var Names = InkReadUtility.GetGlobalTags(story, "N");
        ConstructCharacter(Names, CLIENT, ClientInfo.image.sprite);
        ConstructCharacter(Names, PLAYER, PlayerInfo.image);

        ClientInfo.setActive(false);

        SetNextQuestion();
        ContinueStory();
    }

    public void ConstructCharacter(Dictionary<string, string> Names, string name, Sprite image)
    {
        if(Names.TryGetValue(name, out string value))
        {
            Characters.Add(name, new Character(value, image));
        } 
        else
        {
            Debug.LogError("InterviewStory: ConstructCharacters: " + name + " could not be constructed.");
        }
    }

    public void ContinueStory()
    {
        if(state == Conversation.COMPLETE)
        {
            return;
        }
        bool getNameFromTag(string tag, string type)
        {
            if (tag.Trim().StartsWith(type))
            {
                if (Characters.TryGetValue(type, out Character value))
                {
                    conversation.Name.text = value.Name;
                    conversation.image.sprite = value.image;
                    return true;
                }
            }
            return false;
        }

        if (story.canContinue)
        {
            string text = story.Continue();
            var tags = story.currentTags;
            if (tags.Count == 1)
            {
                if (tags[0].Trim() == "End")
                {
                    AddNoteToCharacterSheet(text);
                    state = Conversation.TOPIC_COMPLETE;
                    BackgroundClicked();
                }
                else if (getNameFromTag(tags[0], PLAYER) || getNameFromTag(tags[0], CLIENT))
                {
                    conversation.TextBox.text = text.Trim();
                }
                else
                {
                    Debug.LogError("InterviewContentTwo: ContinueStory: invalid tag.");
                }
            }
            else
            {
                Debug.LogError("InterviewContentTwo: ContinueStory: Invalid number of tags, expected 1 got '" + tags.Count + "'");
            }
        }
        else
        {
            state = Conversation.TOPIC_COMPLETE;
        }
    }
    private void AddNoteToCharacterSheet(string note)
    {
        ClientInfo.setNote(note);
    }

    private void SetNextQuestion()
    {
        KeyValuePair<string, string> question;
        if (QuestionsToAsk.TryDequeue(out question))
        {
            state = Conversation.TOPIC_ACTIVE;
            story.ChoosePathString(question.Key);
        }
        else
        {
            interviewDone();
            ResetScene();
        }
    }

    private void ResetScene()
    {
        story.ResetState();
        state = Conversation.COMPLETE;
        StoryCanvas.gameObject.SetActive(false);
    }

    public void BackgroundClicked()
    {
        switch (state)
        {
            case Conversation.TOPIC_COMPLETE:
                ClientInfo.setActive(true);
                conversation.Panel.SetActive(false);
                state = Conversation.CHARACTER_SHEET_SHOWING;
                return;

            case Conversation.CHARACTER_SHEET_SHOWING:
                ClientInfo.setActive(false);
                conversation.Panel.SetActive(true);
                SetNextQuestion();
                break;
        }
        ContinueStory();
    }
}
