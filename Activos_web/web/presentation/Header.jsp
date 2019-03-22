<%@ page errorPage="/presentation/Error.jsp"%>

<%@page import="activos.logic.Usuario"%>

<% Usuario logged = (Usuario) session.getAttribute("logged");%> 
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper background blue-grey">
            <a class="brand-logo left" href="/Inicio.jsp">Logo</a>
            <ul class="right hide-on-small-and-down">
                <li> <a href="Inicio.jsp">Principal</a> </li>
                    <% if (logged != null) {%> 
                <li class="submenu"> <a href="#"> <%=logged.getLabor().getPuesto().getPuesto()%> </a> 
                    <% if (logged.getLabor().getPuesto().getPuesto().equals("Administrador")
                        || logged.getLabor().getPuesto().getPuesto().equals("Jefe OCCB")) { %>  
                    <ul>
                        <li> <a href="presentation/solicitud/list/View.jsp">Ver Solicitudes</a> </li>
                        <li> <a href="presentation/activos/list/View.jsp">Ver Activos</a> </li>
                    </ul>
                    <% } %>
                    <% if (logged.getLabor().getPuesto().getPuesto().equals("Secretariado")) { %> 
                    <ul>
                        <li> <a href="presentation/solicitud/list/View.jsp">Ver Solicitudes</a> </li>
                    </ul>
                    <% } %>

                    <% if (logged.getLabor().getPuesto().getPuesto().equals("Registrador")) { %> 
                    <ul>
                        <li> <a href="presentation/solicitud/list/View.jsp">Ver Solicitudes</a> </li>
                        <li> <a href="presentation/activos/list/View.jsp">Ver Activos</a> </li>
                        <li> <a href="presentation/categorias/list/View.jsp">Ver Categorias</a> </li>
                    </ul>
                    <% } %>    

                    <% if (logged.getLabor().getPuesto().getPuesto().equals("Jefe RRHH")) { %> 
                    <ul>
                        <li> <a href="presentation/funcionarios/list/View.jsp">Ver Funcionarios</a> </li>
                        <li> <a href="presentation/dependencias/list/View.jsp">Ver Dependencias</a> </li>
                    </ul>
                    <% }%> 

                <li class="submenu"> <a href="#"> <%=logged.getLabor().getFuncionario().getNombre()%> </a> 
                    <ul>
                        <li> <a href="presentation/usuarios/login/logout">Log out</a> </li> 
                    </ul>             
                </li>
                <% } %>

                <% if (logged == null) { %>
                <li> <a href="presentation/login/View.jsp">Ingresar</a> </li>
                    <% }%>    
            </ul>
        </div>
    </nav>
</div>