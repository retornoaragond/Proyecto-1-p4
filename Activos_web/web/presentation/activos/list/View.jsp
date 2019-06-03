<%-- 
    Document   : View
    Created on : 19/03/2019, 12:39:24 AM
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

                            <form class="col s12" method="POST" name="formulario" action="buscar()">
                                <div class="row">
                                    <div class="col-12">
                                        <h1 class="text-center">Listado de Activos </h1>
                                    </div>
                                    <div class=" col-12">
                                        <label for="validationServer11">N° Comprobante</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="validationTooltipUsernamePrepend"><i class="fas fa-search"></i></span>
                                            </div>
                                            <input type="text"  id="comprobante" name="filter" class="form-control" id="validationServer11" placeholder="N° Comprobante" value="">
                                        </div>
                                    </div>
                                    <div class="input-group col-12 mt-2">
                                        <button type="button" class="form-control btn btn-primary" id="buscar">Buscar</button>
                                    </div>
                                </div>
                            </form>

                        </div><!-- JUMBOTRON-->

                        <!-- TABLA -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                    <tr>
                                        <th>C&oacute;digo</th>
                                        <th>Descripci&oacute;n</th>
                                        <th>Marca</th>
                                        <th>Modelo</th> 
                                        <th>Categor&iacute;a</th>
                                            <%if (logged != null) {%>
                                            <%if (logged.getLabor().getPuesto().getPuesto() == "Registrador") {%>
                                        <th>Edici&oacute;n</th>
                                            <%}%>
                                            <%}%>
                                    </tr>
                                    </tr>
                                </thead>
                                <tbody id="listado">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModalCenter" tabindex="-2" role="dialog" aria-labelledby="exampleModalCenterTitle"
             aria-hidden="true">
            <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Dependencia y encargado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <input type="text" class="form-control" id="id_id"  value="" disabled>
                        <input type="text" class="form-control" id="id_bien"  value="" disabled>
                        <input type="text" class="form-control" id="cant_bien"  value="" disabled>
                        <select id="dependencia_select" class="custom-select">
                            <option value="" selected disabled hidden>Seleccione una dependencia</option>
                        </select>

                        <div class="card bg-light" id="encargado">                         
                            <div class="form-group input-group">
                                <select id="encargado_select" class="custom-select"  >
                                    <option value="" selected disabled hidden>Seleccione un encargado</option>
                                </select>
                            </div> <!-- form-group// -->      
                        </div>   

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="form-control btn btn-info" id="crear_Ac" onclick="generaactivos();" data-dismiss="modal">Crear Activo(s)</button>
                    </div>
                </div>
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
            $("#buscar").on("click", dependenciaBuscar);
            $("#detalles").on("click", dependenciaBuscar);
        }



//<BUSCAR DEPENDENCIAS>

        function dependenciaBuscar(descripcion, categoria) {
            $.ajax({type: "GET",
                url: "api/dependencia",
                success: function (dependencias) {
                    llenarDependencia(dependencias);
                }
            });

        }

        function cargacampos(descripcion, categoria) {
            $("#id_id").val(descripcion);
            $("#id_bien").val(descripcion);
            $("#cant_bien").val(categoria);
        }

        function llenarDependencia(dependencias) {
            $("#encargado_select").hide();
            var listado = $("#dependencia_select");
            listado.html("");
            listado.html("<option selected value=\"estado\">" + "Seleccione una dependencia" + "</option>");
            //listado.html("<option>" + valor + "</option>");
            dependencias.forEach((p) => {
                llenarComboDependencia(listado, p);
            });
        }

        function llenarComboDependencia(listado, dependencias) {
            var tr = $("<option>");
            tr.html("<option value=\"" + dependencias.codigo + "\">" + dependencias.nombre + "</option>");
            listado.append(tr);
        }


//<BUSCAR>
        function buscar() {
            $.ajax({type: "GET",
                url: "api/activos?codigoid=" + $("#comprobante").val(),
                success: lista
            });
        }

        function lista(activos) {
            var listado = $("#listado");
            listado.html("");
            activos.forEach((p) => {
                fila(listado, p);
            });
        }

        function fila(listado, activo) {
            var tr = $("<tr/>");
            tr.html(
                    "<td>" + activo.codigoId + "</td>"
                    + "<td>" + activo.bien.descripcion + "</td>"
                    + "<td>" + activo.bien.marca + "</td>"
                    + "<td>" + activo.bien.modelo + "</td>"
                    + "<td>" + activo.bien.categoria.descripcion + "</td>"
                    + "<td><a data-toggle=\"modal\" href=\"#exampleModalCenter\"><i class=\"fas fa-edit\" onclick=\"cargacampos(" + activo.codigoId + "," + activo.bien.categoria.descripcion + ")\"></i></td>");
            listado.append(tr);
        }
//</BUSCAR>

        function myFunction() {
            var combo = document.getElementById("dependencia_select");
            var sel = combo.options[combo.selectedIndex].text;
            if (sel === "Seleccione una dependencia") {
                $("#encargado_select").hide();
            } else {
                funcionarioBuscar();
                $("#encargado_select").show();
            }
        }

        function funcionarioBuscar() {
            var opcion = $("#dependencia_select option:selected").text();
            $.ajax({type: "GET",
                url: "api/func?dependencia=" + opcion,
                success: llenarFuncionario
            });
        }

        function llenarFuncionario(funcionarios) {
            var listado = $("#encargado_select");
            listado.html("");
            listado.html("<option selected value=\"estado\">" + "Seleccione un funcionario" + "</option>");
            funcionarios.forEach((p) => {
                llenarComboFuncionario(listado, p);
            });
        }

        function llenarComboFuncionario(listado, funcionarios) {
            var tr = $("<option>");
            tr.html("<option>" + funcionarios.nombre + "</option>");
            listado.append(tr);
        }



        $(pageLoad);
        $("#dependencia_select").on("change", myFunction);

    </script>

</html>
