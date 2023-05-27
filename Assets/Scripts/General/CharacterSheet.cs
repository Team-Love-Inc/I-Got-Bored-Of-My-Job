using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

[System.Serializable]
public struct CharacterSheet
{
    public GameObject panel;
    public Image image;
    public TextMeshProUGUI Name;
    public TextMeshProUGUI Age;
    public TextMeshProUGUI Description;
    public TextMeshProUGUI Notes;
    public void Set()
    {
        var client = GlobalDataSingleton.getClient();
        image.sprite = client.Picture;
        Name.text = "Name: " + client.Name;
        Age.text = "Age: " + client.Age.ToString();
        Description.text = client.Description;
    }

    public void setActive(bool value)
    {
        panel.SetActive(value);
    }

    public void setNote(string note)
    {
        Notes.text += note + "\n";
    }
}

[System.Serializable]
public struct PlayerSheet
{
    public Sprite image;
}
