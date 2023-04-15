using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class MainInterview : MonoBehaviour
{
    //UI references
    public GameObject panel;


    void Start()
    {
        HideClientList();
    }

    void HideClientList()
    {
        if (panel.activeSelf)
        {
            panel.SetActive(false);
        }
        else
        {
            panel.SetActive(true);
        }
    }

    public void BtnPressed()
    {
        HideClientList();
        //panel.SetActive(true);
    }
}
