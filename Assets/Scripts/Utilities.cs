using UnityEngine;

public static class Utilities
{
    public static void HideClientList(GameObject gameObj)
    {
        if (gameObj == null || gameObj.GetType() != typeof(GameObject)) {
            Debug.Log("HideClientList: gameObj is not of type GameObject, returning");
            return; 
        }    

        if (gameObj.activeSelf)
        {
            gameObj.SetActive(false);
        }
        else
        {
            gameObj.SetActive(true);
        }
    }
}
