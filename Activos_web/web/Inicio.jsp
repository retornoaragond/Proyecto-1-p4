<%-- 
    Document   : Inicio
    Created on : 19/03/2019, 09:57:00 PM
    Author     : steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
        <title>Bienvenido</title>
    </head>
    <body>

        <%@ include file="/presentation/Header.jsp" %>

        <div class="container">
            <div class="grey lighten-3">
                <h1>Bienvenido al sistema de gesti&oacute;n de archivos</h1>
                <p>
                    El sistema de activos brinda los servicios de informaci&oacute;n para la ejecuci&oacute;n de un conjunto de procesos y actividades realizados por la Oficina Central de Control de Bienes (OCCB) y las Unidades de Apoyo Administrativo adscritas a cada Facultad o Dependencia Central y que permitir&aacute;n:
                </p>
                <ul class="collection">
                    <li class="row collection-item">
                        <i class=" col s1 small material-icons blue-text text-darken-2">label</i>
                        <div class=" col s11">
                            Realizar el control f&iacute;sico de los bienes muebles que forman parte de los activos fijos tangibles de la Universidad.
                        </div>
                    </li>
                    <li class="row collection-item">
                        <i class="col s1 small material-icons green-text text-darken-2">label</i>
                        <div class=" col s11">
                            Ejecutar el registro de todas las adquisiciones de bienes realizados por la instituci&oacute;n por concepto de compra, donac&oacute;n o producci&oacute;n institucional.
                        </div>
                    </li>
                    <li class="row collection-item">
                        <i class="col s1 small material-icons orange-text text-darken-2">label</i>
                        <div class=" col s11">
                            Mantener el registro y control del movimiento de bienes entre las dependencias universitarias.
                        </div>
                    </li>
                    <li class="row collection-item">
                        <i class="col s1 small material-icons yellow-text text-darken-2">label</i>
                        <div class=" col s11">
                            Efectuar el control sobre el estado, uso, conservaci&oacute;n y custodia de los bienes de la instituci&oacute;n.
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <p>
            ACM1PT
        </p>
    </footer>
</html>
