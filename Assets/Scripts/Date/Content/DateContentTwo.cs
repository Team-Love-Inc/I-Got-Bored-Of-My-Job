using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DateContentTwo : Content
{
    [SerializeField]
    private AudioManager sound;

    protected override void StartContent() {}
    public void MainMenu()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(StageNames.INTERVIEW);
    }

    public void Quit()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(StageNames.NONE);
    }
}
