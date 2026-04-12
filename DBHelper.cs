using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

// ============================================
// FILE: App_Code/DBHelper.cs
// PURPOSE: Centralized database access helper
// HOW TO ADD: Right-click project > Add > New Folder "App_Code"
//             Then Add > New Item > Class > Name it DBHelper.cs
// ============================================

public class DBHelper
{
    private static string connStr = ConfigurationManager.ConnectionStrings["FrostAndFlourDB"].ConnectionString;

    // Execute a query that returns rows (SELECT)
    public static DataTable GetData(string query, SqlParameter[] parameters = null)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            if (parameters != null)
                cmd.Parameters.AddRange(parameters);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        return dt;
    }

    // Execute INSERT, UPDATE, DELETE — returns rows affected
    public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            if (parameters != null)
                cmd.Parameters.AddRange(parameters);
            conn.Open();
            return cmd.ExecuteNonQuery();
        }
    }

    // Execute a query that returns a single value (e.g. COUNT, MAX)
    public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            if (parameters != null)
                cmd.Parameters.AddRange(parameters);
            conn.Open();
            return cmd.ExecuteScalar();
        }
    }
}
