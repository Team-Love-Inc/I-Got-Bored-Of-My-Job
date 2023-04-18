using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class EntryPoint : MonoBehaviour
{
    [SerializeField]
    private Camera Camera;
    protected List<Stage> innerStages;
    public bool finished;
    public void Play(List<Stage> stages)
    {
        gameObject.SetActive(true);
        innerStages = stages;
        finished = false;

        // Move camera to location where content is played out.
        Camera.enabled = true;

        StartContent();
       // yield return new WaitUntil(() => finished == true);
    }
    protected abstract void StartContent();

    public Stage Stop()
    {
        gameObject.SetActive(false);
        return GetNextInnerStage();
    }

    protected abstract Stage GetNextInnerStage();

}
