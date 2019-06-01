<%-- 
    Document   : ViewJefe
    Created on : 01/06/2019, 11:49:33 AM
    Author     : steve
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
                                        <h1 class="text-center">Solicitudes </h1>
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
                                        <th>N°</th>
                                        <th>Comprobante</th>
                                        <th>fecha</th>
                                        <th>Tipo</th>              
                                        <th>Estado</th>
                                        <th>Dependencia</th>
                                        <th>Edicion</th>
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

        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titulo"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                    <tr>
                                        <th>N°</th>
                                        <th>Comprobante</th>
                                        <th>fecha</th>
                                        <th>Tipo</th>
                                        <th>Dependencia</th>
                                        <th>Estado</th>
                                    </tr>
                                    </tr>
                                </thead>
                                <tbody id="edicionsolicitud">
                                </tbody>
                            </table>
                        </div>

                        <h5 class="text-center"><b>Lista de bienes inclu&iacute;dos</b></h5>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>N°</th>
                                        <th>Serial</th>
                                        <th>Categor&iacute;a</th>
                                        <th>Descripci&oacute;n</th>
                                        <th>Marca</th>
                                        <th>Modelo</th>
                                        <th>Precio</th>
                                        <th>Cant</th>
                                    </tr>
                                </thead>
                                <tbody id="listado2">
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="guarda" data-dismiss="modal">Guardar</button>
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
        }

        function buscar() {
            $.ajax({type: "GET",
                url: "api/comprobantes?comprobante=" + $("#comprobante").val(),
                success: lista
            });
        }

        function lista(solicitudes) {
            var listado = $("#listado");
            listado.html("");
            solicitudes.forEach((p) => {
                fila(listado, p);
            });
        }

        function fila(listado, solicitud) {
            var tr = $("<tr />");
            var cadena = " ";
            var cadena2 = " ";

            switch (solicitud.estado) {
                case "porVerificar":
                    cadena = "<td><i class=\"fas fa-hourglass-half\"></i></td>";
                    break;
                case "procesada":
                    cadena = "<td><i class=\"fas fa-check-double\"></i></td>";
                    break;
                case "rechazada":
                    cadena = "<td><i class=\"fas fa-window-close\"></i></td>";
                    break;
                case "recibida":
                    cadena = "<td><i class=\"fas fa-check\"></i></td>";
                    break;
                default:
                    cadena = "vacia";
                    break;
            }

            switch (solicitud.tipoadq) {
                case "Donacion":
                    cadena2 = "<td><i class=\"fas fa-gift\" tittle:\"holi\"></i></td>";
                    break;
                case "Compra":
                    cadena2 = "<td><i class=\"fas fa-shopping-cart\"></i></td>";
                    break;
                case "Generado":
                    cadena2 = "<td><i class=\"fas fa-praying-hands\"></i></td>";
                    break;
                default:
                    cadena2 = "vacia";
                    break;
            }
            date = new Date(solicitud.fecha);
            tr.html(
                    "<td>" + solicitud.numsol + "</td>"
                    + "<td>" + solicitud.numcomp + "</a>" + "</td>"
                    + "<td>" + date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear() + "</td>"
                    + cadena2
                    + cadena
                    + "<td>" + solicitud.dependencia.nombre + "</td>"
                    + "<td><a data-toggle=\"modal\" href=\"#exampleModalCenter\"><i class=\"fas fa-edit\" onclick=\"buscarBienes(" + solicitud.numsol + ")\"></i></td>");
            listado.append(tr);
        }

        $(pageLoad);

    </script>
</html>
