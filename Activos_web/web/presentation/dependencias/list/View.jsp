<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:07 AM
    Author     : ExtremeTech
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="activos.logic.Usuario"%>
<% Usuario logged = (Usuario) session.getAttribute("loggeado");%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Dependencias</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>
        <div class="container">
            <div class="row d-flex justify-content-center">
                <div class="jumbotron jumbotron-fluid" style="margin-top: 20px;">
                    <form class="col s12" method="POST" name="formulario">
                        <div class="row">
                            <div class="col-12 d-flex justify-content-center">
                                <h2 class="font-weight-bold">Busqueda</h2>
                            </div>
                            <div class=" col-2">
                                <label for="validationServer11">C&oacute;digo:</label>
                            </div>
                            <div class=" col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="validationTooltipUsernamePrepend"><i class="fas fa-search"></i></span>
                                    </div>
                                    <input type="text"  id="filtro" name="filter" class="form-control" placeholder="Codigo" value="">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class=" col-2">
                                <label for="validationServer11">Nombre:</label>
                            </div>
                            <div class=" col-10">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="validationTooltipUsernamePrepend"><i class="fas fa-search"></i></span>
                                    </div>
                                    <input type="text"  id="filtron" name="filter" class="form-control" placeholder="Nombre" value="">
                                </div>
                            </div>
                        </div>
                        <div class="input-group col-12 mt-2">
                            <button type="button" class="btn btn-primary" onclick="buscar()" id="buscar">Buscar</button>
                        </div>
                    </form>
                    <div class="col-12">
                        <div class="mt-5 d-flex justify-content-center">
                            <a class="btn btn-primary " onclick="myFunction()">Agregar una dependencia</a>
                        </div>
                    </div>

                    <!-- AGREGAR-->
                    <div class="card bg-dark" id="log_user" style="padding: 15px; margin-top: 40px; margin-left: 10px; margin-right: 10px; display: none;">
                        <form class="col s12" method="POST" name="agrega">
                            <div class="form-group input-group">

                                <input id="cod" class="form-control" placeholder="Codigo" type="text">
                            </div> <!-- form-group// -->
                            <div class="form-group input-group">

                                <input id="nom" class="form-control" placeholder="Nombre" type="text">
                            </div> <!-- form-group// -->  
                            <div class="col-12">
                                <div class="mt-5 d-flex justify-content-center">
                                    <a class="btn btn-primary " onclick="agregar()">Guardar</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- AGREGAR-->
                </div>
                <!-- TABLA -->
                <div class="col-5" style="margin-top: 20px;">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>C&oacute;digo</th>
                                    <th>nombre</th>
                                </tr>
                            </thead>
                            <tbody id="listado">
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- TABLA -->
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>

    <script>

        function pageLoad(event) {
            $("#buscar").on("click", buscar);
        }

        function buscar() {
            $.ajax({type: "GET",
                url: "api/dependencias?nombre=" + $("#filtron").val() + "&codigo=" + $("#filtro").val(),
                success: lista
            });
        }

        function lista(dependencias) {
            var listado = $("#listado");
            listado.html("");
            dependencias.forEach((p) => {
                fila(listado, p);
            });
        }

        function fila(listado, dependencia) {
            var tr = $("<tr />");
            tr.html(
                    "<td>" + dependencia.codigo + "</td>"
                    + "<td>" + dependencia.nombre + "</td>");
            listado.append(tr);
        }

        function limpiar() {
            document.getElementById('nom').value = '';
            document.getElementById('cod').value = '';
            buscar();
        }

        function errorMessage(status) {
            switch (status) {
                case 404:
                    return "Registro no encontrado";
                case 403:
                case 405:
                    return "Usuario no autorizado";
            }
        }

        function agregar() {
            dependencia = {
                codigo: $("#cod").val(),
                nombre: $("#nom").val()
            };
            if (validate() == true) {
                $.ajax({type: "POST",
                    url: "api/dependencias",
                    data: JSON.stringify(dependencia),
                    contentType: "application/json",
                    success: function () {
                        buscar();
                    },
                    error: function (jqXHR) {
                    }
                });
                $("#log_user").hide();
                limpiar();
            }
        }

        function validate() {
            var bandera = true;
            if ($("#cod").val() === null || $("#cod").val() === "") {
                $("#cod").addClass("is-invalid");
                alert("debe ingresar un codigo para la dependencia");
                bandera = false;
            } else {
                $("#cod").removeClass("is-invalid");
            }

            if ($("#nom").val() === null || $("#nom").val() === "") {
                $("#nom").addClass("is-invalid");
                alert("debe ingresar un nombre para la dependencia");
                bandera = false;
            } else {
                $("#nom").removeClass("is-invalid");
            }
            return bandera;
        }

        function myFunction() {
            $("#log_user").show();
        }

        $(pageLoad);

    </script>

</html>
