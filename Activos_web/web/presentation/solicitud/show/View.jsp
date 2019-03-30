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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <%@ include file="/presentation/Header.jsp" %>
        <% Solicitud model = (Solicitud) request.getAttribute("model");%>
        <h5 class="center-align">Solicitud</h5>
        <div class="row">
            <div class="col s10 offset-s1">
                <table class="striped" border=0 cellpadding=3 cellspacing=4 >
                    <thead>
                        <tr>
                            <th>N°</th>
                            <th>Dependencia</th>
                            <th>Funcionario</th>
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
                    <table >
                        <tr>
                            <td> <%=model.getNumsol()%> </td>
                            <td> <%=model.getDependencia().getNombre()%></td>
                            <td> <%=model.getDependencia().getNombre()%></td>
                            <td> <%=model.getFuncionario().getNombre()%></td>
                            <td> <%=model.getNumcomp()%></td>
                            <td> <%=model.getFecha()%></td>
                            <td> <%=model.getCantbien()%></td>
                            <td> <%=model.getMontotal()%></td>
                            <td> <%=model.getRazonR()%></td>
                            <td> <%=model.getEstado()%></td>
                            <td> <%=model.getTipoadq()%></td>
                        </tr>
                    </table>
                    </tbody>
                </table>
            </div>
        </div>

        <h5 class="center-align">Bienes</h5>
        <div class="row">
            <div class="col s10 offset-s1">
                <table class="striped" border=0 cellpadding=3 cellspacing=4 >
                    <thead>
                        <tr>
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
            </div>
        </div>
    </body>
</html>
