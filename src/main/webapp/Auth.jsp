<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="java.net.URI" %>
<% 
	String xdiMessageEnvelope = (String) request.getAttribute("xdiMessageEnvelope");
	if (xdiMessageEnvelope == null) xdiMessageEnvelope = "";

	String discoveryKey = (String) request.getAttribute("discoveryKey");
	if (discoveryKey == null) discoveryKey = "";
	
	URI registryEndpointUri = (URI) request.getAttribute("registryEndpointUri");

	String secretToken = (String) request.getAttribute("secretToken");
	if (secretToken == null) secretToken = "";
%> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>XDI Connect - Personal Cloud</title>

    <link href="bootstrap.cerulean.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <div class="container">

        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <img width="200" src="images/<%= (String) request.getAttribute("cspLogo") %>" />
                <h3><img src="/images/app.png" class="app"> Personal Cloud</h3>
            </div>
        </div>
        <div class="spacer20"></div>

		<% if (request.getAttribute("error") != null) { %>
	
			<div class="row">
	            <div class="col-md-8 col-md-offset-2">
	                <div class="alert alert-danger" role="alert"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></div>
	            </div>
	        </div>
	
		<% } %>

        <div class="row">
            <div class="col-md-8 col-md-offset-2 bg-gray with-border">
                <form class="form-horizontal" role="form" action="/auth" method="post">
                    <input type="hidden" name="xdiMessageEnvelope" value="<%= StringEscapeUtils.escapeHtml(xdiMessageEnvelope) %>">
                    <input type="hidden" name="registryEndpointUri" value="<%= StringEscapeUtils.escapeHtml(registryEndpointUri.toString()) %>">

                    <div class="spacer20"></div>
                    <p><strong>Type your cloud name and password to log in to your personal cloud</strong>
                    </p>

                    <div class="form-group">
                        <label for="discoveryKey" class="col-sm-3 control-label">Cloud Name</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" placeholder="=yourname" id="discoveryKey" name="discoveryKey" value="<%= discoveryKey %>" required autofocus>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="discoveryKey" class="col-sm-3 control-label">Password</label>
                        <div class="col-sm-5">
                            <input type="password" class="form-control" placeholder="Password" id="secretToken" name="secretToken" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-5">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="remember">Remember me
                                </label>
                                <span class="help-block">You will be remembered and this step will be omitted next time.</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-10">
                            <button type="submit" class="btn btn-primary">Continue</button>
                        </div>
                    </div>

                </form>


            </div>
        </div>
        <div class="spacer25"></div>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <button type="button" class="btn btn-default" data-toggle="collapse" data-target="#techinfo">
                    Show Technical Information
                </button>
            </div>
        </div>
        <div class="spacer15"></div>

        <div id="techinfo" class="row collapse">
            <div class="col-md-8 col-md-offset-2 bg-gray with-border">
                <a class="graphit" target="_blank" href="http://neustar.github.io/xdi-grapheditor/xdi-grapheditor/public_html/index.html?input=<%= request.getRequestURL().toString().replaceFirst("/[^/]+$", "/XDIOutput?outputId=" + request.getAttribute("outputId")) %>">Graph It!</a>
                <form class="convertit" id="convertit" target="_blank" action="https://server.xdi2.org/XDIConverter" method="post">
                    <input type="hidden" name="resultFormat" value="XDI DISPLAY">
                    <input type="hidden" name="input" value="<%= StringEscapeUtils.escapeHtml(xdiMessageEnvelope) %>"><a href="#" onclick="document.getElementById('convertit').submit();">Convert It!</a>
                </form>

                <h4>Technical Information</h4>

                <p class="small">The XDI message envelope:</p>

                <textarea class="xdi" rows="5"><%= StringEscapeUtils.escapeHtml(xdiMessageEnvelope) %></textarea>
                <div class="spacer10"></div>
                
                <pre><b>Discovery Service:</b> <%= StringEscapeUtils.escapeHtml(registryEndpointUri.toString()) %> </pre>
                
                <div class="spacer15"></div>
            </div>
        </div>
        <div class="spacer20"></div>

    </div>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js "></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js "></script>
</body>

</html>