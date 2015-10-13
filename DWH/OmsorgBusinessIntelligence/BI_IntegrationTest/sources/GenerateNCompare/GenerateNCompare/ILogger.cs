using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    public interface ILogger
    {
        void SetLogPath(string folder, string logfilename);
        void Add(string line);
        // Despose - close logger - necessary?
    }
}
