using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContentOne : Content
{
    [SerializeField]
    private List<Animator> Animators;

    private List<string> Emotes = new List<string>() { "Happy", "Excited", "Angry", "Nervous", "Sad" };

    protected override void StartContent()
    {
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

    public void NextScene()
    {
        Stop(1);
    }

    public void Quit()
    {
        Stop(StageNames.NONE);
    }
}
