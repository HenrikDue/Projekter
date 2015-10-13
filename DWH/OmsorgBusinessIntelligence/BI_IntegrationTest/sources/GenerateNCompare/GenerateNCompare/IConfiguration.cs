using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace GenerateNCompare
{
    public interface IConfiguration
    {
        string GetConfigValue(string key);
        string GetAppSettings(string key);
        string GetConnectionString(string connStringName);
        List<XElement> GetQueries(bool baseline);
    }
}
