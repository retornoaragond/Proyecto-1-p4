<%--
    Document   : View
    Created on : 19/03/2019, 12:43:02 AM
    Author     : ExtremeTech
--%>

<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="activos.logic.Bien"%>
<%@page import="activos.logic.Solicitud"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Usuario logueado = (Usuario) session.getAttribute("loggeado");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <%@ include file="/presentation/Header.jsp" %>
        <% Solicitud model = (Solicitud) request.getAttribute("model");%>
        
        <div class="container my-5">
            <h3 class="d-flex justify-content-center">Solicitud</h3>
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>N°</th>
                            <%if (!logueado.getLabor().getPuesto().getPuesto().equals("Administrador")) {%>
                        <th>Dependencia</th>
                        <th>Registrador</th>
                            <%}%>
                        <th>Comprobante</th>
                        <th>fecha</th>
                        <th>Cantidad bienes</th>
                        <th>Monto total</th>
                        <th>Razón rechazo</th>
                        <th>estado</th>
                        <th>Tipo</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td> <%=model.getNumsol()%> </td>
                        <%if (!logueado.getLabor().getPuesto().getPuesto().equals("Administrador")) {%>
                        <td> <%=model.getDependencia().getNombre()%></td>
                        <td> <%=model.getFuncionario().getNombre()%></td>
                        <%}%>
                        <td> <%=model.getNumcomp()%></td>
                        <td> <%=model.getFecha()%></td>
                        <td> <%=model.getCantbien()%></td>
                        <td> <%=model.getMontotal()%></td>
                        <td> <%=model.getRazonR()%></td>
                        <td> <%=model.getEstado()%></td>
                        <td> <%=model.getTipoadq()%></td>
                    </tr>
                </tbody>
            </table>

        <h3 class="d-flex justify-content-center">Bienes</h3>
            <table class="table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>N°</th>
                        <th>Serial</th>
                        <th>Categor&iacute;a</th>
                        <th>Descripci&oacute;n</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Precio</th>
                        <th>Cant</th>
                    </tr>
                </thead>
                <tbody>
                    <%List<Bien> r = new ArrayList<>();%>
                    <%Set<Bien> hSet = model.getBiens();%>
                    <%for (Bien b : hSet) {%>
                    <%r.add(b);%>
                    <%}%>

                    <% for (Bien b : r) {%>
                    <tr>
                        <td> <%=b.getID()%> </td>
                        <td> <%=b.getSerial()%> </td>
                        <td> <%=b.getCategoria().getDescripcion()%></td>
                        <td> <%=b.getDescripcion()%></td>
                        <td> <%=b.getMarca()%></td>
                        <td> <%=b.getModelo()%></td>
                        <td> <%=b.getPrecioU()%></td>
                        <td> <%=b.getCantidad()%></td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
            <a class="btn btn-primary d-flex justify-content-center" href="presentation/solicitud/listado"><b>Volver a listado</b></a>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
