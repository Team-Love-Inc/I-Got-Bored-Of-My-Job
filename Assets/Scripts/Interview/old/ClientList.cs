using TMPro;
using UnityEngine;

public class ClientList : MonoBehaviour
{
    public TextMeshProUGUI text;

    public void CreateButtons()
    {
        GameObject buttonTemplate = transform.GetChild(0).gameObject;

        for (int i = 0; i < 5; i++)
        {
            text.text = "Client: " + i.ToString();
           Instantiate(buttonTemplate, transform);
        }

        Destroy(buttonTemplate);
    }
}