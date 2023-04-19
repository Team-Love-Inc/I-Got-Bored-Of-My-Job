using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContentOne : Content
{
    public GameObject panel;
    public ClientList clientList;

    protected override void StartContent()
    {
        //panel.gameObject.SetActive(true);
        clientList.CreateButtons();
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
        Stop(1);
    }
}
