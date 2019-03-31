<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:48 AM
    Author     : ExtremeTech
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="activos.logic.Bien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Usuario loge = (Usuario) session.getAttribute("loggeado");%> 
<% ArrayList<Bien> model = (ArrayList<Bien>) session.getAttribute("listaBien");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/presentation/Head.jsp" %>
        <title>Crear solicitud</title>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>

        <div class="card-content"></div>
        <div class="container grey lighten-4" >
            <div class="row">
                <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/agregarSolicitud">
                    <div class="col s12">
                        <h5 class="center-align">Agregar nueva solicitud</h5>
                    </div>
                    <div class="col s3 l3 left-align">
                        <p>N&uacute;mero de comprobante</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <input type="text" id="campoNumcomp" name="campoNumcomp" class="validate">
                    </div>

                    <div class="col s3 l3 left-align">
                        <p>Fecha de adquisici&oacute;n</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <input type="date" class="datepicker" id="campoFechaAdq" name="campoFechaAdq">
                    </div>

                    <div class="col s3 l3 left-align">
                        <p>Tipo de adquisici&oacute;n</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <select name="options">
                            <option value="Donacion">Donaci&oacute;n</option>
                            <option value="Compra">Compra</option>
                            <option value="Generado">Generado</option>
                        </select>
                    </div>

                    <div class="input-field col s3 l3">
                        <input type="submit" value="Agregar" name="agregar">
                    </div>
                </form>


                <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/agregarBien">




                    <h5 class="center-align">Bienes</h5>
                    <div class="container">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Serial</th>                            
                                    <th>Descripci&oacute;n</th>
                                    <th>Marca</th>
                                    <th>Modelo</th>
                                    <th>Precio</th>
                                    <th>Cant</th>
                                </tr>
                            </thead>
                            <tbody>
                            <td><input type="text" id="serial" name="serial" size=15 maxlength=20"></td>
                            <td><input type="text" id="desc" name="desc" size=15 maxlength=20"></td>
                            <td><input type="text" id="marca" name="marca" size=15 maxlength=20"></td>
                            <td><input type="text" id="mod" name="mod" size=15 maxlength=20"></td>
                            <td><input type="text" id="precio" name="precio" size=15 maxlength=20"></td>
                            <td><input type="text" id="cant" name="cant" size=15 maxlength=20"></td>
                            <td><input type="submit" value="Agregar" name="agregar"></td>
                                <% if (loge != null) {%>
                                <% if (model != null) {%>
                                <% for (Bien p : model) {%>
                            <tr>
                                <td><%= p.getSerial()%></td>
                                <td><%= p.getDescripcion()%></td>
                                <td><%= p.getMarca()%></td>
                                <td><%= p.getModelo()%></td>
                                <td><%= p.getPrecioU()%></td>
                                <td><%= p.getCantidad()%></td>
                                <% } %>
                            </tr>
                            <% } %>  
                            <% }%>
                            </tbody>
                        </table>
                    </div>
                </form>

            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
