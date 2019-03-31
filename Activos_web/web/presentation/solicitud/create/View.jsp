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
                <div class="container">
                    <div class="row"><br>
                        <div class="jumbotron">
                            <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/agregarSolicitud">
                                <div class="row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <h1>Agregar nueva solicitud</h1>
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer12">N&uacute;mero de comprobante</label>
                                        <input type="text"  id="campoNumcomp" name="campoNumcomp" class="form-control" id="validationServer12" placeholder="N°" value="">
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer13">Fecha de adquisici&oacute;n</label>
                                        <input type="date" class="datepicker form-control"  id="campoFechaAdq" name="campoFechaAdq" id="validationServer13">
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer14">Tipo de adquisici&oacute;n</label>
                                        <select class="custom-select d-block w-100" name="options">
                                            <option value="Donacion">Donaci&oacute;n</option>
                                            <option value="Compra">Compra</option>
                                            <option value="Generado">Generado</option>
                                        </select>
                                    </div>
                                    <div class="col-12 mt-3">
                                        <input type="submit" value="Agregar Solicitud" class="form-control btn btn-primary" name="agregar">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/agregarBien">
                    <h5 class="center-align">Bienes</h5>
                    <div class="container" >
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
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
                            <td><input class="btn btn-primary d-flex justify-content-center" type="submit" value="Agregar" name="agregar"></td>
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
