<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URI" %>
<% 
	String xdiMessageEnvelope = (String) request.getAttribute("xdiMessageEnvelope");
	if (xdiMessageEnvelope == null) xdiMessageEnvelope = "";

	String discoveryKey = (String) request.getAttribute("discoveryKey");
	if (discoveryKey == null) discoveryKey = "";

	URI registryEndpointUri = (URI) request.getAttribute("registryEndpointUri");
	
	String xdiMessageResult = (String) request.getAttribute("xdiMessageResult");
	if (xdiMessageResult == null) xdiMessageResult = "";
	
	URI returnUri = (URI) request.getAttribute("returnUri");
	
	String returnText = "";
	if (returnUri.toString().contains("cloud-cards"))
		returnText = "Cloud Card";
	else if (returnUri.toString().contains("acmenews"))
		returnText = "+acmenews Website";
	else if (returnUri.toString().contains("acmepizza"))
		returnText = "+acmepizza Website";
	
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

                <div class="spacer20"></div>

                <form action="<%= returnUri %>" method="post">

                    <input type="hidden" name="xdiMessageResult" value="<%= StringEscapeUtils.escapeHtml(xdiMessageResult) %>">
                    <input type="hidden" name="registryEndpointUri" value="<%= StringEscapeUtils.escapeHtml(registryEndpointUri.toString()) %>">

                    <p><strong>This authorization process is completed, you can return to <%= returnText %></strong>
                    </p>
                    <p class="text-center">
                        <button type="submit" class="btn btn-primary">Return to <%= returnText %></button>
                    </p>
                </form>

                <hr noshade>

                <p>You also have the option to go back one step:</p>

                <form action="/auth" method="post">

                    <input type="hidden" name="xdiMessageEnvelope" value="<%= StringEscapeUtils.escapeHtml(xdiMessageEnvelope) %>">
                    <input type="hidden" name="discoveryKey" value="<%= StringEscapeUtils.escapeHtml(discoveryKey) %>">
                    <input type="hidden" name="registryEndpointUri" value="<%= StringEscapeUtils.escapeHtml(registryEndpointUri.toString()) %>">
                    <p class="text-center">
                        <button type="submit" class="btn btn-default">Go Back</button>
                    </p>
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

                <textarea class="xdi" rows="5"><%= StringEscapeUtils.escapeHtml(xdiMessageResult) %></textarea>
                <div class="spacer10"></div>

                <pre><b>Return URI:</b> <%= returnUri %></pre>

                <div class="spacer15"></div>
            </div>
        </div>
        <div class="spacer20"></div>

    </div>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js "></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js "></script>
</body>

</html>