using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;


public class Preparation : MonoBehaviour
{
    [SerializeField]
    private Canvas PreparationCanvas = null;

    [SerializeField]
    private List<Button> QuestionButtons;

    [SerializeField]
    private List<Text> PickedQuestions;
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
                button.GetComponentInChildren<Text>().text = question.Value;
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
        if (questionsAdded < totalNumberOfQuestions)
        {
            QuestionsToAsk.Enqueue(question);
            if(questionSlot < PickedQuestions.Count)
            {
                PickedQuestions[questionSlot++].text = question.Value;
            }
            questionsAdded++;
            button.gameObject.SetActive(false);
        }
        if(questionsAdded == totalNumberOfQuestions)
        {
            StartInterview.gameObject.SetActive(true);
        }
    }

    public bool CanInterviewStart()
    {
        if(questionsAdded == totalNumberOfQuestions)
        {
            PreparationCanvas.gameObject.SetActive(false);
            return true;
        }
        return false;
    }

}