<%@ page errorPage="/presentation/Error.jsp"%>

<%@page import="activos.logic.Usuario"%>

<% Usuario loggeado = (Usuario) session.getAttribute("logged");%> 

<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper grey darken-4">
            <a class="brand-logo left" href="Inicio.jsp"><img class="logo" src="image/logo_1.png">Activos</a>
            
            <ul class="menu right hide-on-small-and-down">
                <li> <a href="Inicio.jsp">Principal</a> </li>
                    <% if (loggeado != null) {%> 
                <li class="submenu"> <%=loggeado.getLabor().getPuesto().getPuesto()%> </a> 
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Administrador")
                        || loggeado.getLabor().getPuesto().getPuesto().equals("Jefe OCCB")) { %>  
                    <ul>
                        <li> <a href="presentation/solicitud/list">Ver Solicitudes</a> </li>
                        <li> <a href="presentation/activos/list/View.jsp">Ver Activos</a> </li>
                    </ul>
                    <% } %>
                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Secretariado")) { %> 
                    <ul>
                        <li> <a href="presentation/solicitud/list">Ver Solicitudes</a> </li>
                    </ul>
                    <% } %>

                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Registrador")) { %> 
                    <ul>
                        <li> <a href="presentation/solicitud/list">Ver Solicitudes</a> </li>
                        <li> <a href="presentation/activos/list/View.jsp">Ver Activos</a> </li>
                        <li> <a href="presentation/categorias/list/View.jsp">Ver Categorias</a> </li>
                    </ul>
                    <% } %>    

                    <% if (loggeado.getLabor().getPuesto().getPuesto().equals("Jefe RRHH")) { %> 
                    <ul>
                        <li> <a href="presentation/funcionarios/list/View.jsp">Ver Funcionarios</a> </li>
                        <li> <a href="presentation/dependencias/list/View.jsp">Ver Dependencias</a> </li>
                    </ul>
                    <% }%> 

                <li class="submenu"> <%=loggeado.getLabor().getFuncionario().getNombre()%> </a> 
                    <ul>
                        <li> <a href="presentation/login/logout">Log out</a> </li> 
                    </ul>             
                </li>
                <% } %>

                <% if (loggeado == null) { %>
                <li> <a href="presentation/login/prepareLogin">Ingresar</a> </li>
                    <% }%>    
            </ul>
        </div>
    </nav>
</div>