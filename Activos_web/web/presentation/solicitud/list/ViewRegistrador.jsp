<%-- 
    Document   : ViewRegistrador
    Created on : 01/06/2019, 03:42:11 PM
    Author     : ExtremeTech
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
                                        <th>Descripci&oacute;n</th>
                                        <th>Marca</th>
                                        <th>Modelo</th>
                                        <th>Precio</th>
                                        <th>Cant</th>
                                        <th>Registro</th>
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

        <!-- Modal -->
        <div class="modal fade" id="sel_categoria" tabindex="-2" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center" id="exampleModalLongTitle">Bien</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="text" class="form-control" id="id_bien"  value="" disabled>
                        <input type="text" class="form-control" id="cant_bien"  value="" disabled>
                        <select id="categoria_select" class="custom-select">
                            <option value="" selected disabled hidden>Elija Categoria...</option>
                        </select>
                        <br><br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="form-control btn btn-info" id="crear_Ac" onclick="generaactivos();" data-dismiss="modal">Crear Activo(s)</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/presentation/Complement.jsp" %>
        <script>
            function pageLoad(event) {
                $("#buscar").on("click", buscar);
                $("#detalles").on("click", buscarBienes);
                $("#guarda").on("click", update);
                $("#categoria_select").on("change", myFunction);
            }

            function myFunction() {
                var combo = $("#categoria_select").val();
                if (combo !== "" || combo !== null) {
                    $.ajax({type: "PUT",
                        url: "api/bienes?id_bien=" + $("#id_bien").val() + "&id_cat=" + $("#categoria_select").val(),
                        success: function () {
                            alert("Categoria Asignada");
                        }
                    });
                }
            }

            function rellenacat(event) {
                $.ajax({type: "GET",
                    url: "api/categorias/filtro",
                    success: enlistado
                });
            }

            function generaactivos() {
                if (validatecat()) {
                    var id = $("#id_bien").val();
                    var cant = $("#cant_bien").val();
                    var cate = $("#categoria_select").val();
                    $.ajax({type: "POST",
                        url: "api/bienes?id_b=" + id + "&cant_b=" + cant + "&cat_b=" + cate,
                        success: function () {
                            $("#categoria_select").val("");
                            alert("se a registrado nuevo(s) activo(s)");
                        },
                        error: function () {
                            $("#categoria_select").val("");
                            alert("error no se pudo crear e lactivo");
                        }
                    });
                }
            }

            function validatecat() {
                if ($("#categoria_select").val() === null || $("#categoria_select").val() === "") {
                    $("#categoria_select").addClass("is-invalid");
                    return false;
                } else {
                    $("#categoria_select").removeClass("is-invalid");
                    return true;
                }
            }

            function buscar() {
                $.ajax({type: "GET",
                    url: "api/comprobantes?comprobante=" + $("#comprobante").val(),
                    success: lista
                });
            }

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

            function lista(solicitudes) {
                var listado = $("#listado");
                listado.html("");
                solicitudes.forEach((p) => {
                    fila(listado, p);
                });
            }

            function enlistado(categorias) {
                categorias.forEach((p) => {
                    $("#categoria_select").append("<option value=\"" + p.id + "\">" + p.descripcion + "</option>");
                });
            }

            function titulo(solicitudes) {
                var tittle = $("#titulo");
                tittle.html("Detalles de la solicitud ");
                tittle.append(solicitudes);
            }

            function lista2(bienes) {
                var listado = $("#listado2");
                listado.html("");
                bienes.forEach((p) => {
                    filasBien(listado, p);
                });
                //llamar al que lelna los campos
            }

            function filasBien(listado, bien) {
                var tr = $("<tr />");
                tr.html(
                        "<td>" + bien.ID + "</td>"
                        + "<td>" + bien.serial + "</td>"
                        + "<td>" + bien.descripcion + "</td>"
                        + "<td>" + bien.marca + "</td>"
                        + "<td>" + bien.modelo + "</td>"
                        + "<td>" + bien.precioU + "</td>"
                        + "<td>" + bien.cantidad + "</td>"
                        + "<td><a data-toggle=\"modal\" href=\"#sel_categoria\"><i class=\"fas fa-edit\" onclick=\"cargacampos(" + bien.ID + "," + bien.precioU + "," + bien.cantidad + ")\"></i></td>");
                listado.append(tr);
            }

            function cargacampos(idbien, preciobien, cantbien) {
                $("#id_bien").val(idbien);
                $("#cant_bien").val(cantbien);
            }

            function filaSol(listado, solicitud) {
                var tr = $("<tr />");
                date = new Date(solicitud.fecha);
                tr.html(
                        "<td id = \"numsol\">" + solicitud.numsol + "</td>"
                        + "<td>" + solicitud.numcomp + "</a>" + "</td>"
                        + "<td>" + date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear() + "</td>"
                        + "<td>" + solicitud.tipoadq + "</td>"
                        + "<td>" + solicitud.dependencia.nombre + "</td>"
                        + "<td><select id=\"selector\">"
                        + "<option selected value=\"estado\">" + solicitud.estado + "</option>"
                        + "<option value=\"estado2\">" + llenarCombo(solicitud.estado) + "</option>" +
                        "</select></td>");
                listado.append(tr);
            }


            function llenarCombo(estado) {
                var valor;
                if (estado === "porVerificar") {
                    valor = "Etiquetado";
                } else {
                    if (estado === "Etiquetado") {
                        valor = "Procesada";
                    } else {
                        valor = "Etiquetado";
                    }
                }
                return valor;
            }


            /*funcion que actualiza el estado de la solicitud despues de tocar el btn guardar*/
            function update() {
                var opcion = $("#selector option:selected").text();
                var numso = $("#numsol").text();

                $.ajax({type: "PUT",
                    url: "api/actualice?nums=" + numso + "&val=" + opcion,
                    success: function () {
                        buscar();
                    }
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

            $(pageLoad);
            $(rellenacat);
        </script>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
