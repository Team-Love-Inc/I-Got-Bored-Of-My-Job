using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class InterviewContentOne : Content
{
    [SerializeField]
    private GameObject SkipButton;

    [SerializeField]
    private GameObject MainMenuCamera;
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
    private List<TextMeshProUGUI> ConversationTexts;
    [SerializeField]
    private List<Light> IntroLights;
    [SerializeField]
    private Transform Juliet;
    
    [SerializeField]
    private GameObject Office;
    [SerializeField]
    private GameObject OfficeCamera;
    [SerializeField]
    private Transform Client;
    [SerializeField]
    private TextMeshProUGUI OfficeText;
    [SerializeField]
    private Image OfficeTextBackground;
    [SerializeField]
    private SpriteRenderer OfficeBlackForeground;

    [SerializeField]
    private List<Animator> Animators;

    private List<string> Emotes = new List<string>() { "Happy", "Excited", "Angry", "Nervous", "Sad" };
    private float timeRemaining = 3f;

    enum IntroState
    {
        MAIN_MENU,
        INTRO_START,
        INTRO_BUTTON_PRESSED_ONCE,
        OFFICE_START,
        OFFICE_RUNNING,
        COMPLETE
    }
    private IntroState state;


    protected override void StartContent()
    {
        if(Debug.isDebugBuild)
        {
            SkipButton.SetActive(true);
        }
        else
        {
            SkipButton.SetActive(false);
        }
        state = IntroState.MAIN_MENU;
        MenuAssets.SetActive(true);
        Office.SetActive(false);
        MainMenu.SetActive(true);
        IntroScene.SetActive(false);
        MainMenuCamera.SetActive(true);
        OfficeCamera.SetActive(false);
        Juliet.gameObject.SetActive(true);
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
        foreach(var obj in ConversationTexts)
        {
            obj.gameObject.SetActive(false);
        }
        foreach (var light in IntroLights)
        {
            light.gameObject.SetActive(true);
        }
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

    private List<string> IntroDialouge = new List<string>(){"The one and only romance loving Succubus." ,
                                                                "We demils live on the second moon.", 
                                                                "We kinda made it from metal as a place of our own when people stopped liking our magic." ,
                                                                "Demils don’t really like romance on the moon. " ,
                                                                "But I loved it so much!" ,
                                                                "My greatest treasure is the disc I have on romance movies from down below." ,
                                                                "And now I came down here to explore, to watch, and to see love with my own eyes rather than on a screen." ,
                                                                "I need to understand love better so I can write the best and only romance novel on the moon!" ,
                                                                "But I need to see love first… " ,
                                                                "So I started a dating agency!" ,
        };
    private int IntroDialougeOrder = 0;
    private int IntroTextOrder = 0;
    private int previousTextOrder = -1;

    private List<string> OfficeDialouge = new List<string>(){"I’m very proud of it, made flyers and everything." ,
                                                             "The place might not be inviting, but at least the law isn’t coming after me here.",
                                                             "And thanks to my expertly made flyers, I’ve gotten my first client! Let’s help them find love!" };
    private int OfficeDialougeOrder = 0;

    public void BackgroundClicked()
    {
        if (IntroDialougeOrder < IntroDialouge.Count && (state == IntroState.INTRO_BUTTON_PRESSED_ONCE || state == IntroState.INTRO_START))
        {
            state = IntroState.INTRO_BUTTON_PRESSED_ONCE;
            IntroBigText.CrossFadeAlpha(0f, 2f, false);
            IntroNextText.CrossFadeAlpha(0f, 2f, false);
            ConversationTexts[IntroTextOrder].CrossFadeAlpha(0f, 0f, false);
            ConversationTexts[IntroTextOrder].text = IntroDialouge[IntroDialougeOrder++];
            ConversationTexts[IntroTextOrder].gameObject.SetActive(true);
            ConversationTexts[IntroTextOrder].CrossFadeAlpha(1f, 2f, false);
            if (previousTextOrder != -1)
            {
                ConversationTexts[previousTextOrder].CrossFadeAlpha(0f, 2f, false);
            }
            previousTextOrder = IntroTextOrder;
            IntroTextOrder = (IntroTextOrder + 1) % ConversationTexts.Count;
        }
        else if (state == IntroState.INTRO_BUTTON_PRESSED_ONCE)
        {
            ConversationTexts[previousTextOrder].CrossFadeAlpha(0f, 1f, false);
            state = IntroState.OFFICE_START;
            StartCoroutine(FadeToOffice());
        }
        else if (state == IntroState.OFFICE_RUNNING)
        {
            if (OfficeDialougeOrder < OfficeDialouge.Count)
            {
                OfficeText.text = OfficeDialouge[OfficeDialougeOrder++];
            }
            else
            {
                OfficeText.CrossFadeAlpha(0f, 1f, false);
                OfficeTextBackground.CrossFadeAlpha(0f, 1f, false);
                StartCoroutine(FadeOfficeClient());
                state = IntroState.COMPLETE;
            }
        }
    }

    private IEnumerator FadeToOffice()
    {
        float progress = 0.0f;
        float oldPosition = Juliet.position.z;
        while (progress < 1)
        {
            Juliet.position = new Vector3(Juliet.position.x, Juliet.position.y, Mathf.Lerp(oldPosition, oldPosition - 3f, progress));
            progress += Time.deltaTime * 0.5f;
            yield return null;
        }

        Juliet.gameObject.SetActive(false);
        Office.SetActive(true);
        MainMenuCamera.SetActive(false);
        OfficeCamera.SetActive(true);
        Client.gameObject.SetActive(false);
        progress = 0.0f;
        while (progress < 1)
        {
            BlackBackground.color = new Color(BlackBackground.color.r, BlackBackground.color.g, BlackBackground.color.b, Mathf.Lerp(1f, 0f, progress));
            progress += Time.deltaTime * 0.5f;
            yield return null;
        }

        OfficeTextBackground.CrossFadeAlpha(0f, 0f, false);
        OfficeTextBackground.gameObject.SetActive(true);
        OfficeTextBackground.CrossFadeAlpha(1f, 2f, false);

        OfficeText.text = OfficeDialouge[OfficeDialougeOrder++];
        OfficeText.CrossFadeAlpha(0f, 0f, false);
        OfficeText.gameObject.SetActive(true);
        OfficeText.CrossFadeAlpha(1f, 2f, false);

        state = IntroState.OFFICE_RUNNING;
    }

    private IEnumerator FadeOfficeClient()
    {
        float finalPosition = Client.position.y;
        Client.position = new Vector3(Client.position.x, Client.position.y - 3f, Client.position.z);
        Client.gameObject.SetActive(true);
        float progress = 0.0f;
        float oldPosition = Client.position.y;
        while (progress < 1)
        {
            Client.position = new Vector3(Client.position.x, Mathf.Lerp(oldPosition, finalPosition, progress),  Client.position.z);
            progress += Time.deltaTime * 0.5f;
            yield return null;
        }

        progress = 0.0f;
        while (progress < 1)
        {
            OfficeBlackForeground.color = new Color(OfficeBlackForeground.color.r, OfficeBlackForeground.color.g, OfficeBlackForeground.color.b, Mathf.Lerp(0f, 1f, progress));
            progress += Time.deltaTime * 0.5f;
            yield return null;
        }
        Stop(1);
    }


    public void Quit()
    {
        Stop(StageNames.NONE);
    }

    public void Skip()
    {
        Stop(1);
    }
}
