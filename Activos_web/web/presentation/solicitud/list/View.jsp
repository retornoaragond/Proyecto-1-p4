<%--
    Document   : View
    Created on : 19/03/2019, 12:42:53 AM
    Author     : ExtremeTech
--%>

<%@page import="java.util.List"%>
<%@page import="activos.logic.Solicitud"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <%@ include file="/presentation/Header.jsp" %>
    <body>
        <div class="container grey lighten-4" >
            <div class="row">
                <div class="col s12"></div>
                <div class="col s12">
                    <h5 class="center-align">Solicitudes</h5>
                </div>
                <div class="col s4 l4">
                    <p>Comprobante</p>
                </div>

                <div class="input-field col s4 l4">
                    <i class="material-icons prefix">search</i>
                    <input type="text" id="icon_prefix2" class="materialize-textarea">
                </div>

                <div class="col s4 l4">
                    <a href="presentation/solicitud/list"><input type="button" id="btnBuscar" value="Buscar"></a>
                </div>

                <div class="col s3">
                    <p>
                        <label>
                            <input type="checkbox" />
                            <span>Red</span>
                        </label>
                    </p>
                </div>

                <div class="col s3">
                    <p>
                        <label>
                            <input type="checkbox" />
                            <span>Red</span>
                        </label>
                    </p>
                </div>

                <div class="col s3">
                    <p>
                        <label>
                            <input type="checkbox" />
                            <span>Red</span>
                        </label>
                    </p>
                </div>

                <div class="col s3">
                    <p>
                        <label>
                            <input type="checkbox" />
                            <span>Red</span>
                        </label>
                    </p>
                </div>
            </div>
        </div>
    </div>



    <div class="row">
        <div class="col s10 offset-s1">
            <table class="striped" border=0 cellpadding=3 cellspacing=4 >
                <thead>
                    <tr>
                        <th>N°</th>
                        <th>Comprobante</th>
                        <th>fecha</th>
                        <th>Tipo</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>

</div>
</body>
</html>
