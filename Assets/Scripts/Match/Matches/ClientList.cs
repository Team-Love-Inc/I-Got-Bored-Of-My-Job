using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ClientList : MonoBehaviour
{
    //Script for creating clickable buttons of each existin match in List<MatchBase>.
    //Makes it possible to drag & drop scritable objects of MatchBase of choosable matches before a date

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
            GlobalDataSingleton.setMatches(match);
            buttonTemplate.name = match.Name;
            portrait.sprite = match.Picture;
            text.text = match.Summmary;
            Instantiate(buttonTemplate, transform);
        }

        Destroy(buttonTemplate);
    }

}