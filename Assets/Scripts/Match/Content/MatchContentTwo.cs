using TMPro;
using UnityEngine.UI;
using UnityEngine;

public class MatchContentTwo : Content
{
    [SerializeField]
    private AudioManager sound;

    public TextMeshProUGUI Npcname;
    public TextMeshProUGUI age;
    public TextMeshProUGUI desc;
    public Image portrait;

    protected override void StartContent()
    {
        var choosenMatch = GlobalDataSingleton.getMatch();
        portrait.sprite = choosenMatch.Picture;
        Npcname.text = $"Name: {choosenMatch.name}";
        age.text = $"Age: {choosenMatch.Age}";
        desc.text = choosenMatch.Description;
    }

    public void GoOnDate()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(2);
    }

    public void GoBack()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ButtonClick);
        Stop(0);
    }
}

