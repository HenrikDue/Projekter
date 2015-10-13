using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace GenerateNCompare
{
    public class Logger : ILogger
    {
        private string logFolderPath;
        private string logFileName;

        public void SetLogPath(string folder, string logfilename)
        {
            logFolderPath = folder;
            logFileName = logfilename;
        }

        public Logger(string folder, string logfilename)
        {
            logFolderPath = folder;
            logFileName = logfilename;
        }

        public void Add(string message)
        {
            Add(message, false);
        }

        public void Add(string message, bool newlines)
        {
            if (!String.IsNullOrEmpty(logFolderPath) || !String.IsNullOrEmpty(logFileName))
            {
                if (!String.IsNullOrEmpty(message))
                    message = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss ") + message;

                if (newlines)
                    message = System.Environment.NewLine + message + System.Environment.NewLine;


                string path = logFolderPath;
                string logFilePath = Path.Combine(path, logFileName);

                try
                {
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }

                    File.AppendAllText(logFilePath, message + System.Environment.NewLine, Encoding.UTF8);
                }
                catch { }
            }
            else
                throw new ApplicationException("Log path is not initialized! Make sure that LogPath is set in the configuration");
        }
    }
}
