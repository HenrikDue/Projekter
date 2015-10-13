using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    /// <summary>
    /// Compares a list of text files
    /// Uses fc.exe tool
    /// </summary>
    class DataComparer : IDataComparer, ILoggable
    {
        ILogger logger;

        #region IDataComparer Members

        public bool Compare()
        {
            throw new NotImplementedException();
        }

        public void SetLogger(ILogger Logger)
        {
            this.logger = Logger;
        }

        #endregion
    }
}
