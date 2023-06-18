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

    [SerializeField] private EventReference ButtonClick;
    [SerializeField] private EventReference InterviewSound;
    [SerializeField] private EventReference BackgroundDate;
    [SerializeField] private EventReference ChooseMatchSound;

    public enum soundEffect
    {
        ButtonClick,
        InterviewSound,
        BackgroundDate,
        ChooseMatchSound,
    }

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

    private void PlayMusic(string name, EventReference reference)
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
        PlayMusic("intro", IntroMusic);
    }

    public void PlayInterviewMusic()
    {
        PlayMusic("interview", InterviewMusic);
    }

    public void PlayDateMusic()
    {
        PlayMusic("date", DateMusic);
    }

    public void PlaySoundeffect(soundEffect sound)
    {
        switch(sound)
        {
            case soundEffect.ButtonClick:
                RuntimeManager.CreateInstance(ButtonClick).start();
                break;
            case soundEffect.InterviewSound:
                RuntimeManager.CreateInstance(InterviewSound).start();
                break;
            case soundEffect.BackgroundDate:
                RuntimeManager.CreateInstance(BackgroundDate).start();
                break;
            case soundEffect.ChooseMatchSound:
                RuntimeManager.CreateInstance(ChooseMatchSound).start();
                break;
        }
    }
}
