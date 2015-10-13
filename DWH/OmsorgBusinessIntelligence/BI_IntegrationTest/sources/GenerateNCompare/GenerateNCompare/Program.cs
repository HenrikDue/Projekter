using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GenerateNCompare
{
    class Program
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="args"></param>
        static int Main(string[] args)
        {
            IDataGenerator generator = new DataGenerator();
            IDataComparer comparer;
            bool identicalResults = false;

            // generate baseline data?
            if (args.Length > 0)
            {
                if (args[0].Equals("-baseline", StringComparison.InvariantCultureIgnoreCase) ||
                    args[0].Equals("-base", StringComparison.InvariantCultureIgnoreCase) ||
                    args[0].Equals("-b", StringComparison.InvariantCultureIgnoreCase))
                {
                    //generate baseline test data
                    bool baselineGenerationSuccess = generator.GenerateBaseline();

                    // success/failure report to console
                    if (baselineGenerationSuccess)
                    {
                        return (int)ExitCode.Success;
                    }
                    else
                    {
                        return (int)ExitCode.FileGenerationFailure;
                    }
                }

                // generate test data?
                else if (args[0].Equals("-generate", StringComparison.InvariantCultureIgnoreCase) ||
                    args[0].Equals("-gen", StringComparison.InvariantCultureIgnoreCase) ||
                    args[0].Equals("-g", StringComparison.InvariantCultureIgnoreCase))
                {
                    //generate test data
                    bool generationSuccess = generator.GenerateData();

                    if (generationSuccess)
                    {
                        //compare ?
                        if (args.Length > 1)
                        {
                            if (args[1].Equals("-compare", StringComparison.InvariantCultureIgnoreCase) ||
                                args[1].Equals("-comp", StringComparison.InvariantCultureIgnoreCase) ||
                                args[1].Equals("-c", StringComparison.InvariantCultureIgnoreCase))
                            {
                                comparer = new DataComparer();
                                identicalResults = comparer.Compare();

                                if (identicalResults)
                                {
                                    return (int)ExitCode.Success;
                                }
                                else
                                {
                                    return (int)ExitCode.ComparisonDifferences;
                                }
                            }
                        }
                        return (int)ExitCode.Success;
                    }
                    else
                    {
                        return (int)ExitCode.FileGenerationFailure;
                    }
                }
                //compare only ?
                else if (args[0].Equals("-compare", StringComparison.InvariantCultureIgnoreCase) ||
                        args[0].Equals("-comp", StringComparison.InvariantCultureIgnoreCase) ||
                        args[0].Equals("-c", StringComparison.InvariantCultureIgnoreCase))
                {
                    comparer = new DataComparer();
                    identicalResults = comparer.Compare();

                    if (identicalResults)
                    {
                        return (int)ExitCode.Success;
                    }
                    else
                    {
                        return (int)ExitCode.ComparisonDifferences;
                    }

                }
                // incorrect arguments
                else
                {
                    return (int)ExitCode.IncorrectArguments;
                    //throw new ArgumentException("Incorrect arguments");
                }
            }
            // incorrect arguments
            return (int)ExitCode.IncorrectArguments;
        }
    }

    enum ExitCode : int
    {
        Success = 0,
        FileGenerationFailure = 1,
        ComparisonDifferences = 2,
        IncorrectArguments = 10
    }
}
