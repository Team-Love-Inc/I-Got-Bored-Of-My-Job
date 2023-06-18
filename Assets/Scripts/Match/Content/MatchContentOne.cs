using UnityEngine;
using UnityEngine.EventSystems;

public class MatchContentOne : Content
{
    [SerializeField]
    private AudioManager sound;
    protected override void StartContent()
    {

    }

    public void BtnPressed()
    {
        sound.PlaySoundeffect(AudioManager.soundEffect.ChooseMatchSound);
        var MatchSheetBtn = EventSystem.current.currentSelectedGameObject;
        //remove clone from string button name before using it for searching
        var MatchName = MatchSheetBtn.name.Substring(0, MatchSheetBtn.name.IndexOf("("));
        GlobalDataSingleton.setMatchByName(MatchName);

        Stop(1);
    }

}
