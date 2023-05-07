using System;
using UnityEngine;

public abstract class Content : MonoBehaviour
{
    protected Stage Stage;
    public void Play(Stage Stage)
    {
        gameObject.SetActive(true);
        this.Stage = Stage;

        StartContent();
    }
    protected abstract void StartContent();

    protected void Stop()
    {
        gameObject.SetActive(false);
    }

    protected void Stop(int nextContent)
    {
        Stop();
        Stage.NextContent(nextContent);
    }

    protected void Stop(StageNames nextStage)
    {
        Stop();
        Stage.NextStage(nextStage);
    }
}

[Serializable]
public class EntryPointStorage : SerializableDictionary<int, Content> { }

