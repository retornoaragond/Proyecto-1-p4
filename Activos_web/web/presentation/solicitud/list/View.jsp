<%--
    Document   : View
    Created on : 19/03/2019, 12:42:53 AM
    Author     : ExtremeTech
--%>

<%@page import="java.util.List"%>
<%@page import="activos.logic.Solicitud"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="activos.logic.Usuario"%>
<% Usuario logged = (Usuario) session.getAttribute("loggeado");%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>
        <div class="card-content"></div>
        <div class="container grey lighten-4" >
            <div class="row">
                <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/listado">
                    <div class="col s12">
                        <h5 class="center-align">Solicitudes</h5>
                    </div>
                    <div class="col s4 l4 right-align">
                        <p>Comprobante</p>
                    </div>

                    <div class="input-field col s4 l4">
                        <i class="material-icons prefix">search</i>
                        <input type="text" id="filtro" name="filter" class="validate">
                        <label for="filtro">Buscar</label>
                    </div>

                    <div class="col s4 l4">
                        <button class="btn" type="submit"><i class="material-icons">send</i>Buscar</button>
                    </div>
                </form>
            </div>
            <div class="row">
                <div class="col s10 offset-s1">
                    <% List<Solicitud> model = (List<Solicitud>) request.getAttribute("model");%> 
                    <table>
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
                            <% if (logged != null) {%>
                            <% for (Solicitud p : model) {%>
                            <tr>
                                <td><%=p.getNumsol()%></td>
                                <td><a href="presentation/personas/show?numcomp=<%=p.getNumcomp()%>"><%=p.getNumcomp()%></a></td>
                                <td><%=p.getFecha().toString()%></td>
                                <% if (p.getTipoadq().equals("Donacion")) {%>
                                <td><i class="material-icons green-text">redeem</i></td>
                                <% } %>
                                <% if (p.getTipoadq().equals("Compra")) { %>
                                <td><i class="material-icons orange-text">shopping_cart</i></td>
                                <% } %>
                                <% if (p.getTipoadq().equals("Generado")) { %>
                                <td><i class="material-icons blue-text">settings</i></td>
                                <% } %>
                                <% if (p.getEstado().equals("PorVerificar")) {%>
                                <td><i class="material-icons grey-text">hourglass_empty</i></td>
                                <% } %>
                                <% if (p.getEstado().equals("Procesada")) { %>
                                <td><i class="material-icons green-text">done_all</i></td>
                                <% } %>
                                <% if (p.getEstado().equals("Rechazada")) { %>
                                <td><i class="material-icons red-text">do_not_disturb</i></td>
                                <% } %>
                                <% if (p.getEstado().equals("Recibida")) { %>
                                <td><i class="material-icons blue-text darken-2">done</i></td>
                                <% } %>
                            </tr>
                            <% } %>  
                            <% }%> 
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
                        </div>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
