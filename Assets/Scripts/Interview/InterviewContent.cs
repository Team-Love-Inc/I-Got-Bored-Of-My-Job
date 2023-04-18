using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContent : EntryPoint
{
    public GameObject panel;
    public ClientList clientList;

    protected override void StartContent()
    {
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
        finished = true;
    }

    protected override Stage GetNextInnerStage()
    {
        return innerStages.Find(x => x.GetName() == (int)Interview.Names.TWO);
    }
}
