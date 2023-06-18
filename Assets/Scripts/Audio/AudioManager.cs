using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FMODUnity;
using FMOD.Studio;

public class AudioManager : MonoBehaviour
{
    [SerializeField] private EventReference IntroMusic;
    [SerializeField] private EventReference InterviewMusic;
    [SerializeField] private EventReference DateMusic;

    private Dictionary<string, EventInstance> instances = new Dictionary<string, EventInstance>();

    public static AudioManager instance { get; private set; }

    private void Awake()
    {
        if(instance != null)
        {
            Debug.LogError("Found more than one Audio Manager in the scene.");
        }
        instance = this;
    }

    private void StopMusic()
    {
        foreach(var instance in instances)
        {
            instance.Value.stop(FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
        }
    }

    private void Play(string name, EventReference reference)
    {
        StopMusic();
        if (!instances.ContainsKey(name))
        {
            instances[name] = RuntimeManager.CreateInstance(reference);
        }
        instances[name].start();
    }

    public void PlayIntroMusic()
    {
        Play("intro", IntroMusic);
    }

    public void PlayInterviewMusic()
    {
        Play("interview", InterviewMusic);
    }

    public void PlayDateMusic()
    {
        Play("date", DateMusic);
    }
}
