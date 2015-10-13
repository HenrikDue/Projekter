using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Xml.Linq;

namespace GenerateNCompare
{
    class Configuration : IConfiguration
    {
        #region IConfiguration Members

        public string GetConfigValue(string key)
        {
            return (string)ConfigurationManager.GetSection(key);
        }

        public string GetAppSettings(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }

        /// <summary>
        /// return list of queries as a strings
        /// </summary>
        /// <returns></returns>
        public List<XElement> GetQueries(bool baseline)
        {
            string location = @"C:\BI_IntegrationTest\sources\GenerateNCompare\GenerateNCompare\bin\Debug\Queries.xml";

            XDocument configXML = XDocument.Load(location);
            string parentQueryNodeName;

            if (baseline)
                parentQueryNodeName = "BaselineQueries";
            else
                parentQueryNodeName = "VerificationQueries";

            var queryNodes = from query
                             in configXML.Elements("Queries").Elements(parentQueryNodeName).Elements("query")
                             select query;

            return queryNodes.ToList<XElement>();
        }


        public string GetConnectionString(string connStringName)
        {
            return ConfigurationManager.ConnectionStrings[connStringName].ConnectionString;
        }

        #endregion
    }
}
