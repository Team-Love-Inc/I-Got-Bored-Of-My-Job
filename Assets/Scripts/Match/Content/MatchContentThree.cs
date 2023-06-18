using UnityEngine;

public class MatchContentThree : Content
{
    [SerializeField]
    private AudioManager sound;
    protected override void StartContent()
    {

    }

    public void BtnPressed()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(StageNames.DATE);
    }
}

