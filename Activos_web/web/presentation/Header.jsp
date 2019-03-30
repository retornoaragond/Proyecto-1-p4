<%@ page errorPage="/presentation/Error.jsp"%>

<%@page import="activos.logic.Usuario"%>

<% Usuario loggeado = (Usuario) session.getAttribute("logged");%> 

<section class="container-fluid slider d-flex justify-content-center align-items-center">
    <h1 class="display-4">Sistema de Activos</h1>
</section>

<nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark ">
    <a class="navbar-brand " href="#">
        <img src="image/logo_1.png" width="100" height="70" class="d-inline-block align-center" alt="">
        Activos
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end " id="navbarNavDropdown">
        <ul class="navbar-nav text-center">
            <li class="nav-item active">
                <a class="nav-link" href="Inicio.jsp"> Principal <span class="sr-only">(current)</span></a>
            </li>
            <% if (loggeado != null) {%>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="usuario" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        <%=loggeado.getLabor().getPuesto().getPuesto()%>
                    </a>
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Administrador")
                          || loggeado.getLabor().getPuesto().getPuesto().equals("Jefe OCCB")) { %>
                        <div class="dropdown-menu text-center" aria-labelledby="usuario">
                            <a class="dropdown-item" href="presentation/solicitud/list">Ver Solicitudes</a>
                            <a class="dropdown-item" href="presentation/activos/list/View.jsp">Ver Activos</a>
                        </div>
                    <% } %>
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Secretariado")) { %> 
                        <div class="dropdown-menu text-center" aria-labelledby="usuario">
                            <a class="dropdown-item" href="presentation/solicitud/list">Ver Solicitudes</a>
                        </div>
                    <% } %>
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Registrador")) { %>
                        <div class="dropdown-menu text-center" aria-labelledby="usuario">
                            <a class="dropdown-item" href="presentation/solicitud/list">Ver Solicitudes</a>
                            <a class="dropdown-item" href="presentation/activos/list/View.jsp">Ver Activos</a>
                            <a class="dropdown-item" href="presentation/categorias/list/View.jsp">Ver Categorias</a>
                        </div>
                    <% } %>
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Jefe RRHH")) { %> 
                        <div class="dropdown-menu text-center" aria-labelledby="usuario">
                            <a class="dropdown-item" href="presentation/funcionarios/list/View.jsp">Ver Funcionarios</a>
                            <a class="dropdown-item" href="presentation/dependencias/list/View.jsp">Ver Dependencias</a>
                        </div>
                    <% } %>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="usuario" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <%=loggeado.getLabor().getFuncionario().getNombre()%>
                    </a>
                    <div class="dropdown-menu text-center" aria-labelledby="usuario">
                        <a class="dropdown-item" href="presentation/login/logout">Log out</a>
                    </div>
                </li>
            <% }%>
            <% if (loggeado == null) { %>
                <li>
                    <a class="nav-link" href="presentation/login/prepareLogin">Ingresar</a> 
                </li>
            <% }%> 
        </ul>
    </div>
</nav>