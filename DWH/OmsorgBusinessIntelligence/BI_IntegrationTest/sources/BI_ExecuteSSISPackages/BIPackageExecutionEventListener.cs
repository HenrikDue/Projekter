using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SqlServer.Dts.Runtime;

namespace BI_ExecuteSSISPackages
{
    class BIPackageExecutionEventListener : DefaultEvents
    {
        // check if this does not disable packages OnError event -> sending email!!!
        public override bool OnError(DtsObject source, int errorCode, string subComponent, string description, string helpFile, int helpContext, string idofInterfaceWithError)
        {
            // log error to file - ensure setting log file path first from calling application!
            Logger.Add(source + " " + errorCode + " " + subComponent + " " + description + " " + helpFile + " " + helpContext + " " + idofInterfaceWithError);

            // call base class on error
            return base.OnError(source, errorCode, subComponent, description, helpFile, helpContext, idofInterfaceWithError);
        }
    }
}
