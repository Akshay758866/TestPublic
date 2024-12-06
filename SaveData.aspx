<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SaveData.aspx.cs" Inherits="SaveData" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #35424a;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #454d54;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>User Information Form</h2>
    <form method="post">
        <label for="id">User ID:</label>
        <input type="text" id="id" name="id" required>

        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <input type="submit" value="Submit">
    </form>

    <div id="result">
        <%
            if (IsPostBack)
            {
                string userId = Request.Form["id"];
                string name = Request.Form["name"];
                string email = Request.Form["email"];
                
                string connectionString = ConfigurationManager.ConnectionStrings["UserDataDB"].ConnectionString;

                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string query = "INSERT INTO Users (UserID, Name, Email) VALUES (@UserID, @Name, @Email)";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    Response.Write("<h2>Thank you for your submission!</h2>");
                }
                catch (Exception ex)
                {
                    Response.Write("<h2>Error: " + ex.Message + "</h2>");
                }
            }
        %>
    </div>
</div>

</body>
</html>