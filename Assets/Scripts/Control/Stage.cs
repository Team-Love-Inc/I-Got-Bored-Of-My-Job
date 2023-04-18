using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Stage : MonoBehaviour
{
    [SerializeField]
    public EntryPoint PlayableContent;
    [SerializeField]
    public List<Stage> innerStages;
    protected List<Stage> outerStages;
    //protected Stage pickedOuterStage;

    public void StartStage(List<Stage> outerStages)
    {
        this.outerStages = outerStages;
        PlayableContent.Play(innerStages);
        //var nextInternalStage = PlayableContent.GetNextInnerStage();
        //while(nextInternalStage != null)
        //{
        //    nextInternalStage.StartStage(innerStages);
        //    nextInternalStage = nextInternalStage.GetOuterStage();
        //}
        //
    }

    public Stage Continue()
    {
        if(PlayableContent.finished)
        {
            var nextInternalStage = PlayableContent.Stop();
            if(nextInternalStage is not null)
            {
                nextInternalStage.StartStage(innerStages);
            } 
            else
            {
                return PickOuterStage();
            }
        }
        return null;
    }

    public abstract int GetName();
    protected abstract Stage PickOuterStage();
}
