using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SqlServer.Dts.Runtime;
using System.Configuration;
using System.IO;

namespace BI_ExecuteSSISPackages
{
    class Program
    {
        static int Main(string[] args)
        {
            try
            {
                // initialize app configuration
                string importPackagePath = ConfigurationManager.AppSettings["ImportPackagePath"];
                string analyticsPackagePath = ConfigurationManager.AppSettings["AnalyticsPackagePath"];
                string logFilePath = ConfigurationManager.AppSettings["LogFilePath"];
                string logFileName = ConfigurationManager.AppSettings["LogFileName"];

                // check if paths for both packages are set
                if ( String.IsNullOrEmpty(logFilePath)
                    || String.IsNullOrEmpty(logFileName))
                {
                    // if it will be used from command line it is better to return ExitCode then throw an exeption
                    return (int)ExitCode.MissingConfiguration;
                }

                Application application;
                Package package;
                Package package2;
                DTSExecResult packageResult;
                DTSExecResult packageResult2;

                BIPackageExecutionEventListener BIEventListener = new BIPackageExecutionEventListener();
                BIPackageExecutionEventListener BIEventListener2 = new BIPackageExecutionEventListener();

                // initialize import package execution
                application = new Application();
                string logPath = Path.Combine(logFilePath, logFileName);
                Logger.SetLogPath(logFilePath, logFileName);

                if (!String.IsNullOrEmpty(importPackagePath))
                {
                    package = application.LoadPackage(importPackagePath, BIEventListener);

                    // execute the import package
                    Console.WriteLine("Starting import package execution.");
                    Logger.Add("Starting import package execution.");
                    packageResult = package.Execute();
                    Console.WriteLine(packageResult.ToString());
                    Logger.Add(packageResult.ToString());


                    // check if import package succeeded - if not log issues and close app
                    if (packageResult == DTSExecResult.Success)
                    {
                        Logger.Add("Finished import package execution. Success.");
                        Logger.Add("import package execution result: "+packageResult.ToString());
                        Console.WriteLine("Finished import package execution. Success.");

                    }
                    else
                    {
                        Logger.Add(packageResult.ToString());
                        Console.WriteLine("There were some issues with {1}, \nplease check log file for details\n {0}", logPath, importPackagePath);

                        foreach (Microsoft.SqlServer.Dts.Runtime.DtsError error in package.Errors)
                        {

                            Console.WriteLine("{0}", error.Description);

                            Logger.Add(error.Description);

                        }

                        return (int)ExitCode.FirebirdImportTaskError;
                    }
                }
                else
                {
                    Console.WriteLine("importPackagePath path is empty");
                    Logger.Add("importPackagePath path is empty");
                }


                if (!String.IsNullOrEmpty(analyticsPackagePath))
                {

                    application = new Application();
                    // prepare analytics package execution
                    package2 = application.LoadPackage(analyticsPackagePath, BIEventListener2);

                    // execute the analytics package
                    Logger.Add("Starting analytics package execution.");
                    Console.WriteLine("Starting analytics package execution.");
                    packageResult2 = package2.Execute();

                    // response to packageResult
                    Console.WriteLine(packageResult2.ToString());


                    if (packageResult2 == DTSExecResult.Success)
                    {
                        Console.WriteLine("Success!");
                    }
                    else
                    {
                        Console.WriteLine("There were some issues with {1}, \nplease check log file for details\n {0}", logPath, analyticsPackagePath);
                        return (int)ExitCode.AnalyticsTaskError;
                    }

                    foreach (Microsoft.SqlServer.Dts.Runtime.DtsError error in package2.Errors)
                    {

                        Console.WriteLine("{0}", error.Description);

                        Logger.Add(error.Description);

                    }
                }
                else
                {
                    Console.WriteLine("analyticsPackagePath path is empty");
                    Logger.Add("analyticsPackagePath path is empty");
                }

                Logger.Add("Execution is finished");

                Console.WriteLine("Execution is finished.\nCheck log file for more information.");
            }
            catch (Exception e)
            {
                Logger.Add(e.ToString());

                Console.WriteLine("Exeception!\nCheck log file for more information.");

                return (int)ExitCode.Exception;
            }

            return (int)ExitCode.Success;
        }
    }
    enum ExitCode : int
    {
        Success = 0,
        MissingConfiguration = 1,
        FirebirdImportTaskError = 10,
        AnalyticsTaskError = 20,
        Exception = 30
    }
}
