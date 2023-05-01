using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InterviewContentOne : Content
{
    public GameObject panel;

    protected override void StartContent()
    {
        HideClientList(panel);
    }

    void HideClientList(GameObject gameObj)
    {
        if (gameObj.activeSelf)
        {
            gameObj.SetActive(false);
        }
        else
        {
            gameObj.SetActive(true);
        }
    }

    public void ClientListBtn()
    {
        HideClientList(panel);
    }

    public void BtnPressed()
    {
        HideClientList(panel);
        Stop(1);
    }
}
