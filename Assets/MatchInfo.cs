using TMPro;
using UnityEngine;

public class MatchInfo : MonoBehaviour
{
    public MatchBase match;
    public TextMeshProUGUI Npcname;
    public TextMeshProUGUI age;
    public TextMeshProUGUI desc;

    void Start()
    {
        Npcname.text = $"Name: {match.name}";
        age.text = $"Age: {match.Age}";
        desc.text = match.Description;
    }
}
