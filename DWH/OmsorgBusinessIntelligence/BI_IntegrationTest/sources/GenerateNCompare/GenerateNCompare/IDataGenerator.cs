using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    public interface IDataGenerator
    {
        bool GenerateData();
        bool GenerateBaseline();
        void SetDBProvider(IDBConnector Connector);
    }
}
