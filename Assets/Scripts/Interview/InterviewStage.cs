using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Interview
{
    public class InterviewStage : Stage
    {
        [SerializeField]
        private Controller.Names Name;

        public override int GetName()
        {
            return (int)Name;
        }

        protected override Stage PickOuterStage()
        {
            return outerStages.Find(x => x.GetName() == (int)Controller.Names.MATCH);
        }
    }

    enum Names
    {
        ONE,
        TWO,
        THREE
    }
}
