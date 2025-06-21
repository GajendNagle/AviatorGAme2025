<%@ WebHandler Language="C#" Class="Update_Get_current_multi" %>

using System;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Collections.Generic;

public class Update_Get_current_multi : IHttpHandler
{
    public string Multi, Type, gameId;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            gameId = context.Request["game_id"];
            Multi = context.Request["Multi"];
            Type = context.Request["Type"];

            if (Type == "Set_Multi")
            {
                GlobalMultiplierStore.SetMultiplier(gameId, Multi);
                Respond(context, "success");
            }
            else if (Type == "Get_Multi")
            {
                string savedMulti = GlobalMultiplierStore.GetMultiplier(gameId);
                Respond(context, savedMulti);
            }
            else if (Type == "Clear_Multi")
            {
                GlobalMultiplierStore.ClearMultiplier(gameId);
                Respond(context, "clear");
            }
            else
            {
                Respond(context, "invalid_type");
            }
        }
        else
        {
            Respond(context, "not_authenticated");
        }
    }

    private void Respond(HttpContext context, string message)
    {
        var resultObj = new { result = message };
        string json = new JavaScriptSerializer().Serialize(resultObj);
        context.Response.Write(json);
    }

    public static class GlobalMultiplierStore
    {
        private class MultiplierInfo
        {
            public string Multiplier { get; set; }
            public DateTime Timestamp { get; set; }
        }

        private static readonly Dictionary<string, MultiplierInfo> gameMultipliers = new Dictionary<string, MultiplierInfo>();
        private static readonly object _lock = new object();

        public static void SetMultiplier(string gameId, string multiplier)
        {
            DateTime newTime = DateTime.UtcNow; 

            lock (_lock)
            {
                if (gameMultipliers.ContainsKey(gameId))
                {
                    var current = gameMultipliers[gameId];
                    if (newTime > current.Timestamp)
                    {
                        gameMultipliers[gameId].Multiplier = multiplier;
                        gameMultipliers[gameId].Timestamp = newTime;
                    }
                }
                else
                {
                    gameMultipliers[gameId] = new MultiplierInfo { Multiplier = multiplier, Timestamp = newTime };
                }
            }
        }

        public static string GetMultiplier(string gameId)
        {
            return gameMultipliers.ContainsKey(gameId) ? gameMultipliers[gameId].Multiplier : "1.00";
        }

        public static void ClearMultiplier(string gameId)
        {
            lock (_lock)
            {
                if (gameMultipliers.ContainsKey(gameId))
                {
                    gameMultipliers.Remove(gameId);
                }
            }
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
