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
        <div class="container minh-50 ">
            <div class="row my-5">
                <div class="col text-justify">
                    <div class="box">
                        <div class="box-content">
                            <h1 class="tag-title">Bienvenido al sistema de gesti&oacute;n de archivos</h1>
                            <hr />
                            <p>
                                El sistema de activos brinda los servicios de informaci&oacute;n para la ejecuci&oacute;n de un conjunto  de procesos y actividades realizados por la Oficina Central de Control de Bienes (OCCB) y las Unidades de Apoyo Administrativo adscritas a cada Facultad o Dependencia Central y que permitir&aacute;n:
                            </p>
                            <ul>
                                <li>
                                    Realizar el control f&iacute;sico de los bienes muebles que forman parte de los activos fijos tangibles de la Universidad.
                                </li>
                                <li>
                                    Ejecutar el registro de todas las adquisiciones de bienes realizados por la instituci&oacute;n por concepto de compra, donac&oacute;n o producci&oacute;n institucional.                                            
                                </li>
                                <li>
                                    Mantener el registro y control del movimiento de bienes entre las dependencias universitarias.  
                                </li>
                                <li>
                                    Efectuar el control sobre el estado, uso, conservaci&oacute;n y custodia de los bienes de la instituci&oacute;n.
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>           
            </div>
        </div>
    </div>
    <%@ include file="/presentation/Complement.jsp" %>
</body>  
<%@ include file="/presentation/Footer.jsp" %>
</html>
