<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:27 AM
    Author     : ExtremeTech
--%>

<%@page import="java.util.List"%>
<%@page import="activos.logic.Funcionario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="activos.logic.Usuario"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Personal</title>
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
                                        <h1 >Funcionarios</h1>
                                    </div>
                                    <div class=" col-12">
                                        <label for="validationServer11">N° Comprobante</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="validationTooltipUsernamePrepend"><i class="fas fa-search"></i></span>
                                            </div>
                                            <input type="text"  id="filter" name="filter" class="form-control" id="validationServer11" placeholder="N° Cedula" value="">
                                        </div>
                                    </div>
                                    <div class="input-group col-12 mt-2">
                                        <button type="button" class="form-control btn btn-primary" id="buscar">Buscar</button>
                                    </div>
                                </div>
                            </form>
                            <div class="col-12">
                                <div class="mt-5 d-flex justify-content-center">
                                    <a class="btn btn-primary " href="presentation/funcionarios/create" style="width: 100%;"><i class="fas fa-user-plus"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="table-responsive">           
                    <table class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">N°Cedula</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Editar</th>
                                <th scope="col">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody id="listado">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
        <script>
            function pageLoad(event) {
                $("#buscar").on("click", buscar);
            }
            function buscar() {
                $.ajax({type: "GET",
                    url: "api/funcionarios?id=" + $("#filter").val(),
                    success: lista
                });
            }
            function lista(funcionarios) {
                var listado = $("#listado");
                listado.html("");
                funcionarios.forEach((p) => {
                    fila(listado, p);
                });
            }
            function fila(listado, funcionario) {
                var tr = $("<tr />");
                tr.html(
                        "<td>" + funcionario.id + "</td>"
                        + "<td>" + funcionario.nombre + "</td>"
                        + "<td><a href=\"presentation/funcionario/mostrarEditar?id="+funcionario.id+"\"><i class=\"far fa-edit\"></i></a></td>"
                        + "<td><i class=\"fas fa-user-times\" onclick='eliminar(" + funcionario.id + ");'></i></td>");
                listado.append(tr);
            }
            
            function eliminar(id) {
                $.ajax({type: "DELETE",
                    url: "api/funcionarios/" + id,
                    success: function () {
                        alert("elimino");
                    },
                    error: function (jqXHR) {
                        alert(errorMessage(jqXHR.status));
                    }
                });
            }
            $(pageLoad);
        </script>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
