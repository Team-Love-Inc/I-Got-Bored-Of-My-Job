using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Controller
{
    public class GameController : MonoBehaviour
    {
        [SerializeField]
        private List<Stage> topLevelStages;
        private Stage currentStage;
        private Names StartStage;

        void Start()
        {
            currentStage = topLevelStages.Find(x => x.GetName() == (int)StartStage);
            if (currentStage is null)
            {
                Debug.Log(new System.Exception("GameController: Start " + StartStage + " stage not found"));
                return;
            }

            if (currentStage is not null)
            {
                currentStage.StartStage(topLevelStages);
            }
        }


        private void Update()
        {
            var newStage = currentStage?.Continue();
            if(newStage is not null)
            {
                currentStage = newStage;
                currentStage.StartStage(topLevelStages);
                return;
            }
        }
    }

    enum Names
    {
        INTERVIEW,
        MATCH,
        DATE
    }
}
