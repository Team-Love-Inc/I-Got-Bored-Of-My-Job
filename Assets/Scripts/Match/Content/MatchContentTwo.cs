using TMPro;
using UnityEngine.UI;

public class MatchContentTwo : Content
{
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
        Stop(2);
    }

    public void GoBack()
    {
        Stop(0);
    }
}

