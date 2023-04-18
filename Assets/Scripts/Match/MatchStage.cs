using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Match
{
    public class MatchStage : Stage
    {
        [SerializeField]
        private Controller.Names Name;

        public override int GetName()
        {
            return (int)Name;
        }

        protected override Stage PickOuterStage()
        {
            return outerStages.Find(x => x.GetName() == (int)Controller.Names.DATE);
        }
    }

    enum Names
    {
        ONE,
        TWO,
        THREE
    }
}
