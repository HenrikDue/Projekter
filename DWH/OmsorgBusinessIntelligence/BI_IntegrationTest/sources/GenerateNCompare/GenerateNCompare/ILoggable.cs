using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    public interface ILoggable
    {
        void SetLogger(ILogger Logger);
    }
}
