using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ClientList : MonoBehaviour
{
    public TextMeshProUGUI text;
    public Image portrait;

    public List<MatchBase> Matches = new List<MatchBase>();

    void Start()
    {
        AddMatchesToList();
    }

    public void AddMatchesToList()
    {
        GameObject buttonTemplate = transform.GetChild(0).gameObject;

        foreach (var match in Matches)
        {
            portrait.sprite = match.Picture;
            text.text = match.Summmary;
            Instantiate(buttonTemplate, transform);
        }

        Destroy(buttonTemplate);
    }
}