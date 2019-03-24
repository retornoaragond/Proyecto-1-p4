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
        <div id="enmedio">
            <%@ include file="/presentation/Header.jsp" %>

            <% Usuario model = (Usuario) request.getAttribute("model"); %>
            <% Map<String, String> errors = (Map<String, String>) request.getAttribute("errors"); %>        
            <% Map<String, String[]> values = (errors == null) ? this.getValues(model) : request.getParameterMap();%>

            <div class="valign-wrapper">
                <div class="container grey lighten-3">
                    <div class="row">
                        <form class="col s12" method="POST" name="formulario" action="presentation/login/login">
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">account_circle</i>
                                    <input type="text" id="ID" name="id" size=15 maxlength=20 class="<%=validity("id", errors)%>" value="<%=value("id", values)%>">
                                    <label for="ID">ID</label>
                                    <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                </div>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">vpn_key</i>
                                    <input id="pass" type="password" name="clave" size=15 maxlength=20 class="<%=validity("clave", errors)%>" value="<%=value("clave", values)%>">
                                    <label for="pass">Clave</label>
                                    <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s11 right-align">
                                    <button class="btn" type="submit">Enviar</button>
                                </div>
                            </div>
                        </form>
                    </div> 
                </div>
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
<%!
    private String validity(String field, Map<String, String> errors) {
        if ((errors != null) && (errors.get(field) != null)) {
            return "invalid";
        } else {
            return "validate";
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