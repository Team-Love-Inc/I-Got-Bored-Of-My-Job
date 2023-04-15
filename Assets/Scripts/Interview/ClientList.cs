using TMPro;
using UnityEngine;

public class ClientList : MonoBehaviour
{
    public TextMeshProUGUI text;

    void Start()
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
