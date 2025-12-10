using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
    public class DBHelper
    {
        SqlConnection con;
        static string conStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        public void openConnection()
        {
            con = new SqlConnection(conStr);
            con.Open();
        }
        public void closeConnection()
        {
            con.Close();
        }

        public void disposeConnection()
        {
            con.Dispose();
        }

        public DataTable ExeSP(string sp_name, Dictionary<string, dynamic> parametres)
        {
            try
            {
                openConnection();
                SqlCommand cmd = new SqlCommand(sp_name, con);
                cmd.CommandType = CommandType.StoredProcedure;
                if (parametres != null)
                {
                    foreach (var parametre in parametres)
                    {
                        cmd.Parameters.AddWithValue(parametre.Key, parametre.Value);
                    }
                }
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}
