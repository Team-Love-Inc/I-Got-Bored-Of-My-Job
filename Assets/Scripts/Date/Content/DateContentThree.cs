using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DateContentThree : Content
{
    [SerializeField]
    private AudioManager sound;

    protected override void StartContent()
    {

    }

    public void MainMenu()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(StageNames.INTERVIEW);
    }

    public void TryAgain()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(0);
    }

    public void Quit()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(StageNames.NONE);
    }
}
