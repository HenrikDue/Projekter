using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace BI_ExecuteSSISPackages
{
    public class Logger
    {
        private static string logFolderPath;
        private static string logFileName;

        public static void SetLogPath(string folder, string logfilename)
        {
            logFolderPath = folder;
            logFileName = logfilename;
        }

        public static void Add(string message)
        {
            Add(message,false);
        }

        public static void Add(string message, bool newlines)
        {
            if (!String.IsNullOrEmpty(logFolderPath) || !String.IsNullOrEmpty(logFileName))
            {
                if (!String.IsNullOrEmpty( message)) 
                    message= DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss ") + message;

                if (newlines)
                    message = System.Environment.NewLine+message+System.Environment.NewLine;


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
