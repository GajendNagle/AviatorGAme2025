<%@ WebHandler Language="C#" Class="previous_game_bet_list" %>

using System;
using System.Web;

public class previous_game_bet_list : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}