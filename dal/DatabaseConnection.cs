using System;
using System.Configuration;

namespace dal
{
    public static class DatabaseConnection
    {
        //Verbindingsreeks uit de configuratie-instellingen door de opgegeven naam => retourneert als string
        public static string Connectionstring(string name)
        {
            return ConfigurationManager.ConnectionStrings[name].ConnectionString;
        }
    }
}