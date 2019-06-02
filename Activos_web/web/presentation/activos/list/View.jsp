<%-- 
    Document   : View
    Created on : 19/03/2019, 12:39:24 AM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                        <th>Edici&oacute;n</th>
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
                    </div>
                    <div class="modal-body">
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
                    + "<td><a data-toggle=\"modal\" href=\"#exampleModalCenter\"><i class=\"fas fa-edit\" onclick=\"buscarBienes(" + activo.bien.cantidad + ")\"></i></td>");
            listado.append(tr);
        }
//</BUSCAR>

        $(pageLoad);

    </script>

</html>
