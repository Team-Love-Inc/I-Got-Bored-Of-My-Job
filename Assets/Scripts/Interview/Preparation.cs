using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using TMPro;


public class Preparation : MonoBehaviour
{
    [SerializeField]
    private AudioManager sound;

    [SerializeField]
    private Canvas PreparationCanvas = null;

    [SerializeField]
    private List<Button> QuestionButtons;

    [SerializeField]
    private List<TextMeshProUGUI> PickedQuestions;
    private int questionSlot = 0;

    [SerializeField]
    private Button StartInterview;

    public int totalNumberOfQuestions = 3;

    private Dictionary<string, string> Questions;
    public Queue<KeyValuePair<string, string>> QuestionsToAsk { get; private set; }
    private int questionsAdded = 0;

    public CharacterSheet characterSheet;

    public void Run(Story story)
    {
        QuestionsToAsk = new Queue<KeyValuePair<string, string>>();
        foreach(var question in PickedQuestions)
        {
            question.text = "";
        }
        questionsAdded = 0;
        questionSlot = 0;
        PreparationCanvas.gameObject.SetActive(true);
        StartInterview.gameObject.SetActive(false);
        Questions = InkReadUtility.GetGlobalTags(story, "Q");

        characterSheet.Set();
        Prepare();
    }

    private void Prepare()
    {
        int count = 0;
        foreach (KeyValuePair<string, string> question in Questions)
        {
            if(count < QuestionButtons.Count)
            {
                var button = QuestionButtons[count];
                button.GetComponentInChildren<TextMeshProUGUI>().text = question.Value;
                button.onClick.AddListener(delegate {
                    SaveQuestion(question, button);
                });
                button.gameObject.SetActive(true);
                count++;
            }
            else
            {
                Debug.LogError("Preparation: Prepare: there are more questions in ink file (" + Questions.Count + ") than there are bottons (" + QuestionButtons.Count + ")in scene");
            }
        }

        for(var i = count; i < QuestionButtons.Count; i ++)
        {
            QuestionButtons[count].gameObject.SetActive(false);
        }
    }

    private void SaveQuestion(KeyValuePair<string, string> question, Button button)
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.InterviewSound);
        if (questionsAdded < totalNumberOfQuestions)
        {
            QuestionsToAsk.Enqueue(question);
            if(questionSlot < PickedQuestions.Count)
            {
                PickedQuestions[questionSlot].text = question.Value;
            }
            ++questionSlot;
            ++questionsAdded;
            button.gameObject.SetActive(false);
        }
        if(questionsAdded == totalNumberOfQuestions)
        {
            StartInterview.gameObject.SetActive(true);
        }
    }

    private void ResetScene()
    {
        //for (var i = 0; i < QuestionButtons.Count; i++)
        //{
        //    QuestionButtons[i].GetComponentInChildren<TextMeshProUGUI>().text = "";
        //    QuestionButtons[i].onClick = null;
        //    QuestionButtons[i].gameObject.SetActive(true);
        //}
    }

    public bool CanInterviewStart()
    {
        if(questionsAdded == totalNumberOfQuestions)
        {
            //ResetScene();
            sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
            PreparationCanvas.gameObject.SetActive(false);
            return true;
        }
        return false;
    }

}