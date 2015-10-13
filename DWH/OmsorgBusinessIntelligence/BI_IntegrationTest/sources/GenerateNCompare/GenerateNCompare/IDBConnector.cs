using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace GenerateNCompare
{
    public interface IDBConnector : ILoggable
    {
        void SetConnString(string connectionString);
        string GetQueryResultAsXML(XElement query);
        bool GenerateXMLFiles(List<XElement> queries, string folderPath);
    }
}
