using TMPro;
using UnityEngine.UI;

public class MatchContentTwo : Content
{
    public TextMeshProUGUI Npcname;
    public TextMeshProUGUI age;
    public TextMeshProUGUI desc;
    public Image portrait;

    private void Start()
    {
        var choosenMatch = GlobalDataSingleton.getMatch();
        portrait.sprite = choosenMatch.Picture;
        Npcname.text = $"Name: {choosenMatch.name}";
        age.text = $"Age: {choosenMatch.Age}";
        desc.text = choosenMatch.Description;
    }

    protected override void StartContent()
    {

    }

    public void BtnPressed()
    {
        Stop(2);
    }
}

