using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.IO;

namespace GenerateNCompare
{
    class DBConnector : IDBConnector, ILoggable
    {

        ILogger logger;
        string connectionString;

        #region IDBConnector Members

        public void SetConnString(string ConnectionString)
        {
            connectionString = ConnectionString;
        }

        /// <summary>
        /// query has name and value i.e. query statement
        /// name is used to name a dataset
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        public string GetQueryResultAsXML(XElement query)
        {
            //Execute query & get results as Dataset
            SqlConnection dbConn = new SqlConnection(connectionString);

            XAttribute queryNameAtt = query.Attribute("name");

            dbConn.Open();

            SqlDataAdapter adapter = new SqlDataAdapter(query.Value.Trim(), dbConn);

            DataSet ds = new DataSet(queryNameAtt.Value);
            adapter.Fill(ds);

            string xml = ds.GetXml();

            dbConn.Close();

            //return XDocument from Dataset

            return xml;
        }

        public bool GenerateXMLFiles(List<XElement> queries, string folderPath)
        {
            string xmlResultSet;

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string filePath;

            foreach (var query in queries)
            {
                xmlResultSet = GetQueryResultAsXML(query);
                filePath = Path.Combine( folderPath , query.Attribute("name").Value + ".xml");
                File.WriteAllText(filePath, xmlResultSet);
            }
            return true;
        }

        public void SetLogger(ILogger Logger)
        {
            logger = Logger;
        }

        #endregion
    }
}
