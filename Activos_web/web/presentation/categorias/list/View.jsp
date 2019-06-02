<%-- 
    Document   : View
    Created on : 19/03/2019, 12:41:41 AM
    Author     : ExtremeTech
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Categorias</title>
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
                                    <input type="text"  id="filt_id" name="filter" class="form-control" placeholder="Id" value="">
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
                                    <input type="text"  id="filt_nombre" name="filter" class="form-control" placeholder="descripcion" value="">
                                </div>
                            </div>
                        </div>
                        <div class="input-group col-12 mt-2">
                            <button type="button" class="btn btn-primary" onclick="buscar()" id="buscar">Buscar</button>
                        </div>
                    </form>
                    <div class="col-12">
                        <div class="mt-5 d-flex justify-content-center">
                            <a class="btn btn-primary " onclick="myFunction()">Agregar Nueva Categoria</a>
                        </div>
                    </div>

                    <!-- AGREGAR-->
                    <div class="card bg-dark" id="nueva_cat" style="padding: 15px; margin-top: 40px; margin-left: 10px; margin-right: 10px; display: none;">
                        <h1 style="color: #fff">Nueva Categoria</h1>
                        <form class="col s12" method="POST" name="agrega">
                            <div class="form-group input-group">
                                <input id="id_cat" class="form-control" placeholder="ID" type="text">
                            </div> <!-- form-group// -->
                            <div class="form-group input-group">
                                <input id="desc_cat" class="form-control" placeholder="Descripci&oacute;n" type="text">
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
                                    <th>ID</th>
                                    <th>Descripci&oacute;n</th>
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
        <script>

            function pageLoad(event) {
                $("#buscar").on("click", buscar);
            }

            function buscar() {
                $.ajax({type: "GET",
                    url: "api/categorias?descripcion=" + $("#filt_nombre").val() + "&id=" + $("#filt_id").val(),
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

            function fila(listado, categoria) {
                var tr = $("<tr />");
                tr.html(
                        "<td>" + categoria.id + "</td>"
                        + "<td>" + categoria.descripcion + "</td>");
                listado.append(tr);
            }

            function limpiar() {
                document.getElementById('id_cat').value = '';
                document.getElementById('desc_cat').value = '';
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
                categoria = {
                    id: $("#id_cat").val(),
                    descripcion: $("#desc_cat").val()
                };
                if (validate() === true) {
                    $.ajax({type: "POST",
                        url: "api/categorias",
                        data: JSON.stringify(categoria),
                        contentType: "application/json",
                        success: function () {
                            alert("se ha agregado correctamente");
                            buscar();
                        },
                        error: function (jqXHR) {
                            alert("no se pudo agregar ");
                        }
                    });
                    $("#nueva_cat").hide();
                    limpiar();
                }
            }

            function validate() {
                var bandera = true;
                if ($("#id_cat").val() === null || $("#id_cat").val() === "") {
                    $("#id_cat").addClass("is-invalid");
                    alert("debe ingresar un codigo para la dependencia");
                    bandera = false;
                } else {
                    $("#id_cat").removeClass("is-invalid");
                }

                if ($("#desc_cat").val() === null || $("#desc_cat").val() === "") {
                    $("#desc_cat").addClass("is-invalid");
                    alert("debe ingresar un nombre para la dependencia");
                    bandera = false;
                } else {
                    $("#desc_cat").removeClass("is-invalid");
                }
                return bandera;
            }

            function myFunction() {
                $("#nueva_cat").show();
            }

            $(pageLoad);

        </script>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
