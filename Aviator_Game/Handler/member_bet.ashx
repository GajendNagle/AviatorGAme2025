<%@ WebHandler Language="C#" Class="member_bet" %>

using System;
using System.Web;

public class member_bet : IHttpHandler {
    
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