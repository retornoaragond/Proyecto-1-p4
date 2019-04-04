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

        <div class="container minh-30 d-flex justify-content-center">
            <div class="row "></div>
            <div class="col-md-6 col-sm-12 ml-4">
                <div class="login-box " >
                    <div class="login-header">Login</div>
                    <div class="login-body">
                        <form class="form-group" method="POST" name="formulario" action="presentation/login/login">
                            <label for="validationServer01">ID</label>
                            <input type="text"  name="id" class="form-control <%=validity("id", errors)%>" id="validationServer01" placeholder="ID" value="<%=value("id", values)%>">
                            <div class="invalid-feedback">
                                Debe llenar este campo.
                            </div>
                            <label for="validationServer02">Clave</label>
                            <input type="password"  name="clave" class="form-control <%=validity("clave", errors)%>" id="validationServer02" placeholder="Clave" value="<%=value("clave", values)%>" >
                            <div class="invalid-feedback">
                                Debe llenar este campo.
                            </div>
                            <br/>
                            <button class="form-control btn btn-success " style="font-size: 2rem" type="submit"><i class="fas fa-sign-in-alt"></i></button>
                        </form>
                    </div>
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