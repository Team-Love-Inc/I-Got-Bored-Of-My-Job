using Ink.Parsed;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class ClientList : MonoBehaviour
{
    public TextMeshProUGUI text;

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
            text.text = match.Description;
            Instantiate(buttonTemplate, transform);
        }

        Destroy(buttonTemplate);
    }
}