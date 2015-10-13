using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    public interface IDataComparer
    {
        bool Compare();
        void SetLogger(ILogger Logger);
    }
}
