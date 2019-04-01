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
        <title>Listado de Solicitudes</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>
        <div class="card-content"></div>
        <div class="container grey lighten-4" >
            <div class="container my-5">
                <div class="container">
                    <div class="row d-flex justify-content-center"><br>
                        <div class="jumbotron">
                            <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/listado">
                                <div class="row">
                                    <div class="col-12">
                                        <h1>Solicitudes de <%=logged.getLabor().getDependencia().getNombre()%> </h1>
                                    </div>
                                    <div class=" col-12">
                                        <label for="validationServer11">N° Comprobante</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="validationTooltipUsernamePrepend"><i class="fas fa-search"></i></span>
                                            </div>
                                            <input type="text"  id="filtro" name="filter" class="form-control" id="validationServer11" placeholder="N° Comprobante" value="">
                                        </div>
                                    </div>
                                    <div class="input-group col-12 mt-2">
                                        <input type="submit" value="Buscar" class="form-control btn btn-primary" name="">
                                    </div>

                                </div>
                            </form>
                            <div class="col-12">
                                <div class="mt-5 d-flex justify-content-center">
                                    <a class="btn btn-primary " href="presentation/solicitud/create">Agregar una Solicitud</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="table-responsive">
                    <% List<Solicitud> model = (List<Solicitud>) request.getAttribute("model");%>           
                    <table class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                            <tr>
                                <th>N°</th>
                                <th>Comprobante</th>
                                <th>fecha</th>
                                <th>Tipo</th>
                                <th>Estado</th>
                            </tr>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (logged != null) {%>
                            <% if (model != null) {%>
                            <% for (Solicitud p : model) {%>
                            <tr>
                                <td><%=p.getNumsol()%></td>
                                <td><a href="presentation/solicitud/show?numcomp=<%=p.getNumcomp()%>&codDep=<%=p.getCodDependencia()%>"><%=p.getNumcomp()%></a></td>
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
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
