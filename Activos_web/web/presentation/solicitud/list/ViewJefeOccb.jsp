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
                                        <th>Registrador</th>
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
            $("#detalles").on("click", buscarBienes);
            $("#guarda").on("click", update);
        }

        //<UPDATE>

        function update() {
            var opcion = $("#selector option:selected").text();
            var numso = $("#numsol").text();
            if (opcion !== "Seleccionar") {
                $.ajax({type: "PUT",
                    url: "api/encargado?nums=" + numso + "&val=" + opcion,
                    success: function (data, textStatus, jqXHR) {
                        buscar();
                    }
                });
            } else {
                alert("Por favor seleccione un registrador");
            }
        }

        //</UPDATE>

        //<BIENES>
        function buscarBienes(numsol) {
            $.ajax({type: "GET",
                url: "api/solicitudes?numsol=" + numsol,
                success: function (bienes) {
                    mostrardetalles(numsol);
                    lista2(bienes);
                    titulo(numsol);
                }
            });
        }

        function mostrardetalles(numsol) {
            /*buscar la solicitud e insertarla en la tabla edicionsolicitud*/
            $.ajax({type: "GET",
                url: "api/detalles?numero=" + numsol,
                success: function (objSolicitud) {
                    var edicion = $("#edicionsolicitud");
                    edicion.html("");
                    filaSol(edicion, objSolicitud);
                }
            });
        }

        function filaSol(listado, solicitud) {
            var tr = $("<tr />");

            date = new Date(solicitud.fecha);
            var valor = solicitud.funcionario.nombre;
            if (valor === "") {
                valor = "Seleccionar";
            }

            tr.html(
                    "<td id = \"numsol\">" + solicitud.numsol + "</td>"
                    + "<td>" + solicitud.numcomp + "</a>" + "</td>"
                    + "<td>" + date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear() + "</td>"
                    + "<td>" + solicitud.tipoadq + "</td>"
                    + "<td>" + solicitud.dependencia.nombre + "</td>"
                    + "<td><select id=\"selector\" class=\"custom-select\"></select></td>");
            buscarRegistradores(valor);
            listado.append(tr);
        }

        function titulo(solicitudes) {
            var tittle = $("#titulo");
            tittle.html("Asignación de registrador a la solicitud ");
            tittle.append(solicitudes);
        }

        function lista2(bienes) {
            var listado = $("#listado2");
            listado.html("");
            bienes.forEach((p) => {
                filasBien(listado, p);
            });
        }

        function filasBien(listado, bien) {
            var tr = $("<tr />");

            tr.html(
                    "<td>" + bien.ID + "</td>"
                    + "<td>" + bien.serial + "</td>"
                    + "<td>" + bien.categoria.descripcion + "</td>"
                    + "<td>" + bien.descripcion + "</td>"
                    + "<td>" + bien.marca + "</td>"
                    + "<td>" + bien.modelo + "</td>"
                    + "<td>" + bien.precioU + "</td>"
                    + "<td>" + bien.cantidad + "</td>");
            listado.append(tr);
        }

        function buscarRegistradores(valor) {
            $.ajax({type: "GET",
                url: "api/registrador",
                success: function (funcionarios) {
                    listaRegistradores(funcionarios, valor);
                }
            });
        }

        function listaRegistradores(funcionarios, valor) {
            var listado = $("#selector");
            listado.html("");
            listado.html("<option>" + valor + "</option>");
            funcionarios.forEach((p) => {
                if (valor !== p.nombre) {
                    llenarCombo(listado, p);
                }
            });
        }

        function llenarCombo(listado, funcionarios) {
            var tr = $("<option>");
            tr.html(funcionarios.nombre + "</option>");
            listado.append(tr);
        }
        //BIENES>

//  <BUSCAR>
        function buscar() {
            $.ajax({type: "GET",
                url: "api/jefe?comprobante=" + $("#comprobante").val(),
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
                case "PorVerificar":
                    cadena = "<td><i class=\"fas fa-hourglass-half\"></i></td>";
                    break;
                case "Procesada":
                    cadena = "<td><i class=\"fas fa-check-double\"></i></td>";
                    break;
                case "Rechazada":
                    cadena = "<td><i class=\"fas fa-window-close\"></i></td>";
                    break;
                case "Recibida":
                    cadena = "<td><i class=\"fas fa-check\"></i></td>";
                    break;
                case "Etiquetado":
                    cadena = "<td><i class=\"fas fa-tags\"></i></td>";
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
// </BUSCAR>

        $(pageLoad);

    </script>
</html>
