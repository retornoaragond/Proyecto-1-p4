<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="activos.logic.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>

    <body>

        <%@ include file="/presentation/Header.jsp" %>

        <% Usuario model = (Usuario) request.getAttribute("model"); %>
        <% Map<String, String> errors = (Map<String, String>) request.getAttribute("errors"); %>        
        <% Map<String, String[]> values = (errors == null) ? this.getValues(model) : request.getParameterMap();%>

        <div class="container">  
            <h3>Login</h3>
            <form method="POST" name="formulario" action="presentation/login/login">
                <table border=0 cellpadding=3 cellspacing=4 >
                    <tr>
                        <td id="nom">Id</td>
                        <td ><input type="text" name="id" size=15 maxlength=20 class="<%=validity("id", errors)%>" value="<%=value("id", values)%>"></td>
                    </tr>
                    <tr>
                        <td>Clave</td>
                        <td><input type="password" name="clave" size=15 maxlength=20 class="<%=validity("clave", errors)%>" value="<%=value("clave", values)%>"></td>
                    </tr>		
                    <tr>
                        <td height="55" colspan="2" align="center">
                            <input type="submit" name="Submit" value="Login"> 
                        </td>
                    </tr>
                </table>
            </form>
        </div>  

    </body>
</html>
<%!
    private String validity(String field, Map<String, String> errors) {
        if ((errors != null) && (errors.get(field) != null)) {
            return "is-invalid";
        } else {
            return "";
        }
    }

    private String value(String field, Map<String, String[]> values) {
        return values.get(field)[0];
    }

    private Map<String, String[]> getValues(Usuario model) {
        Map<String, String[]> values = new HashMap<>();
        values.put("id", new String[]{model.getId()});
        values.put("clave", new String[]{model.getPass()});
        return values;
    }

%>