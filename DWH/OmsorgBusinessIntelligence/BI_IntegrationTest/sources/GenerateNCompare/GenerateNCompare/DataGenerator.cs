using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace GenerateNCompare
{
    /// <summary>
    /// Fetches data from database using list of queries provided by configuration
    /// saves results as XML file(s) under folder set in the configuration
    /// </summary>
    class DataGenerator : IDataGenerator, ILoggable, IConfigurable
    {
        //declarations
        IDBConnector dbConnector;
        IConfiguration configuration;
        ILogger logger;

        #region IDataGenerator Members

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public bool GenerateData()
        {
            Initialize();

            string folderPath = this.configuration.GetAppSettings("TestResultsPath");

            return Generate(false, folderPath);
        }


        private bool Generate(bool baseline, string folderPath)
        {
            List<XElement> queries = this.configuration.GetQueries(baseline);

            if (queries != null || queries.Count > 0)
            {
                dbConnector.GenerateXMLFiles(queries, folderPath);

                return true;
            }
            else
                return false;
        }

        //Initialization
        private void Initialize()
        {
            //get configuration
            this.SetConfigProvider(new Configuration());
            //initialize dbconnector
            this.SetDBProvider(new DBConnector());

            //initialize logger
            string path = configuration.GetAppSettings("LogFilePath");
            string logFileName = configuration.GetAppSettings("LogFileName");
            this.SetLogger(new Logger(path, logFileName));

            dbConnector.SetLogger(this.logger);
            dbConnector.SetConnString(configuration.GetConnectionString("DataWarehouse"));
        }


        //closing log file?
        private void Despose()
        {
            
        }

        public bool GenerateBaseline()
        {
            Initialize();

            string folderPath = this.configuration.GetAppSettings("BaselineResultsPath");

            return Generate(true, folderPath);
        }

        public void SetDBProvider(IDBConnector Connector)
        {
            this.dbConnector = Connector;
        }

        public void SetConfigProvider(IConfiguration Configurator)
        {
            this.configuration = Configurator;
        }

        public void SetLogger(ILogger Logger)
        {
            this.logger = Logger;
        }

        #endregion
    }
}
