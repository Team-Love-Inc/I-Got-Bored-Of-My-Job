using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class InterviewContentOne : Content
{
    [SerializeField]
    private GameObject MainMenu;
    [SerializeField]
    private GameObject MenuAssets;

    [SerializeField]
    private SpriteRenderer BlackBackground;

    [SerializeField]
    private GameObject IntroScene;
    [SerializeField]
    private TextMeshProUGUI IntroBigText;
    [SerializeField]
    private TextMeshProUGUI IntroNextText;
    [SerializeField]
    private TextMeshProUGUI ConversationText;
    [SerializeField]
    private Button IntroNextButton;

    [SerializeField]
    private List<Animator> Animators;

    private List<string> Emotes = new List<string>() { "Happy", "Excited", "Angry", "Nervous", "Sad" };
    private float timeRemaining = 3f;

    enum IntroState
    {
        MAIN_MENU,
        INTRO_START,
        INTRO_BUTTON_PRESSED_ONCE,
    }
    private IntroState state;


    protected override void StartContent()
    {
        state = IntroState.MAIN_MENU;
        MainMenu.SetActive(true);
        IntroScene.SetActive(false);
        StartCoroutine(Animate());
    }

    private IEnumerator Animate()
    {
        while(true)
        {
            foreach(var animator in Animators)
            {
                if(Random.Range(0, 1f) > 0.5f)
                {
                    animator.SetTrigger(Emotes[Random.Range(0, Emotes.Count)]);
                    yield return new WaitForSeconds(Random.Range(0.1f, 0.5f));
                }
            }
            yield return new WaitForSeconds(4f);
        }
    }

    public void StartGame()
    {
        foreach(Transform child in MainMenu.transform)
        {
            if(child.TryGetComponent(out Image ImageObj))
            {
                ImageObj.CrossFadeAlpha(0f, 2.0f, false);
                foreach(Transform GrandChild in child)
                {
                    if (GrandChild.TryGetComponent(out TextMeshProUGUI TextObj))
                    {
                        TextObj.CrossFadeAlpha(0f, 2.0f, false);
                    }
                }
            } 
            else if(child.TryGetComponent(out TextMeshProUGUI TextObj))
            {
                TextObj.CrossFadeAlpha(0f, 2.0f, false);
            }
        }
        StartCoroutine(FadeBlack());
    }

    private IEnumerator FadeBlack()
    {
        float progress = 0.0f;

        while (progress < 1)
        {
            BlackBackground.color = new Color(BlackBackground.color.r, BlackBackground.color.g, BlackBackground.color.b, Mathf.Lerp(0f, 1f, progress)); 
            progress += Time.deltaTime * 0.5f;
            yield return null;
        }

        MainMenu.SetActive(false);
        MenuAssets.SetActive(false);
        IntroBigText.CrossFadeAlpha(0f, 0f, false);
        IntroScene.SetActive(true);
        IntroNextText.gameObject.SetActive(false);
        IntroBigText.CrossFadeAlpha(1f, 2f, false);
        state = IntroState.INTRO_START;
    }

    private void Update()
    {
        if(state == IntroState.INTRO_START)
        {
            if(timeRemaining > 0)
            {
                timeRemaining -= Time.deltaTime;
            }
            else
            {
                IntroNextText.CrossFadeAlpha(0f, 0f, false);
                IntroNextText.gameObject.SetActive(true);
                IntroNextText.CrossFadeAlpha(1f, 2f, false);
                state = IntroState.INTRO_BUTTON_PRESSED_ONCE;
            }
        }
    }

    public void BackgroundClicked()
    {
        state = IntroState.INTRO_BUTTON_PRESSED_ONCE;

    }


    public void Quit()
    {
        Stop(StageNames.NONE);
    }
}
