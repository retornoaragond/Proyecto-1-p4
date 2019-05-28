<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:22 AM
    Author     : ExtremeTech
--%>

<%@page import="activos.logic.Puesto"%>
<%@page import="activos.logic.Dependencia"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Usuario logged = (Usuario) session.getAttribute("loggeado");%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregación de Personal</title>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>
        <div class="container">
            <br><br>
            <div class="card bg-light">
                <article class="card-body mx-auto" style="max-width: 400px;">
                    <h4 class="card-title mt-3 text-center">Nuevo un Funcionario</h4>
                    <form method="POST" id="newfunc" style="min-width: 350px;">
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fas fa-id-card"></i> </span>
                            </div>
                            <input id="ident" name="ident" class="form-control" placeholder="N° de Cédula" type="text">
                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fas fa-user"></i> </span>
                            </div>
                            <input id="nombre" name="nombre" class="form-control" placeholder="Nombre Completo" type="text">
                        </div> <!-- form-group// -->
                        <% List<Dependencia> depend = (List<Dependencia>) request.getAttribute("dependencias");%>
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-building"></i> </span>
                            </div>
                            <select id="dependencias_select" class="custom-select">
                                <option selected="" disabled hidden>Dependencia...</option>
                                <% if (logged != null) {%>
                                <% if (depend != null) {%>
                                <% for (Dependencia p : depend) {%>
                                <option value="<%= p.getCodigo()%>"><%= p.getNombre()%></option>
                                <% }%>
                                <% } %>  
                                <% }%>
                            </select>
                            <% List<Puesto> puest = (List<Puesto>) request.getAttribute("puestos");%>
                        </div> <!-- form-group// -->
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fas fa-briefcase"></i> </span>
                            </div>
                            <select id="puestos_select" class="custom-select">
                                <option selected="" disabled hidden>Puesto...</option>
                                <% if (logged != null) {%>
                                <% if (puest != null) {%>
                                <% for (Puesto p : puest) {%>
                                <option value="<%= p.getCodgo()%>"><%= p.getPuesto()%></option>
                                <% }%>
                                <% }%>  
                                <% }%>
                            </select>
                        </div> <!-- form-group end.// -->
                        <!--
                        <div class="card bg-dark" id="log_user" style="padding: 15px; margin-bottom: 10px; display: none;">
                            <div class="form-group input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"> <i class="fas fa-user-tag"></i> </span>
                                </div>
                                <input id="use" class="form-control" placeholder="Usuario" type="text">
                            </div> 
                            <div class="form-group input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                </div>
                                <input id="pass" class="form-control" placeholder="Contraseña" type="password">
                            </div>      
                        </div>
                        -->
                        <div class="form-group">
                            <!-- <a href="presentation/funcionarios/list/View.jsp" class="form-control btn btn-primary" id="agregar"><i class="fas fa-user-plus"></i></a> -->
                            <button type="button" class="form-control btn btn-primary" id="agregar"><i class="fas fa-user-plus"></i></button> 
                        </div> <!-- form-group// -->                                                                
                    </form>
                </article>
            </div> <!-- card.// -->
            <br><br>
        </div> 
        <!--container end.//-->

        <%@ include file="/presentation/Complement.jsp" %>
        <script>
            //variables

            var rep_fun;
            var rep_use;

            function pageLoad(event) {
                $("#agregar").on("click", agregar);
            }

            function myFunction() {
                var combo = document.getElementById("puestos_select");
                var sel = combo.options[combo.selectedIndex].text;
                if (sel === "Administrador" || sel === "Secretaria(o) OCCB" || sel === "Registrador" || sel === "Jefe OCCB" || sel === "Jefe RRHH") {
                    console.log("usuario");
                    //document.getElementById("log_user").style.display= "block";
                    $("#log_user").show();
                } else {
                    console.log("no usuario");
                    //document.getElementById("log_user").style.display= "none";
                    $("#log_user").hide();
                }
            }

            function agregar() {
                if (validate()) {
                    $.ajax({
                        type: "POST",
                        url: "api/funcionarios/" + $("#ident").val() + "/" + $("#nombre").val() + "/" + s("#dependencias_select").val() + "/" + s("#puestos_select").val(),
                        success: function () {
                            alert("Se ingreso correctamente el funcionario ");
                            location.href = "presentation/funcionarios/list/View.jsp";
                        },
                        error: function () {
                            alert("Error al tratar de ingresar el funcionario");
                        }
                    });

                }
            }

            function validate() {
                var contador = 0;
                //valida el campo de cedula lleno
                if ($("#ident").val() === null || $("#ident").val() === "") {
                    $("#ident").addClass("is-invalid");
                    alert("debe ingresar una identificacion para el funcionario");
                    contador++;
                } else {
                    $("#ident").removeClass("is-invalid");
                }
                //valida que el funcionario no exista
                checkfuncionario($("#ident").val());
                if (rep_fun === true) {
                    $("#ident").addClass("is-invalid");
                    alert("ERROR: Ya hay un funcionario con esa identificacion, ingrese otra identificacion");
                    contador++;
                }

                //valida el campo de nombre lleno
                if ($("#nombre").val() === null || $("#nombre").val() === "") {
                    $("#nombre").addClass("is-invalid");
                    contador++;
                } else {
                    $("#nombre").removeClass("is-invalid");
                }
                //valida campo de dependecias seleccionado
                if ($("#dependencias_select").val() === null || $("#dependencias_select").val() === "") {
                    $("#dependencias_select").addClass("is-invalid");
                    contador++;
                } else {
                    $("#dependencias_select").removeClass("is-invalid");
                }
                //valida campo de puestos seleccionado
                if ($("#puestos_select").val() === null || $("#puestos_select").val() === "") {
                    $("#puestos_select").addClass("is-invalid");
                    contador++;
                } else {
                    $("#puestos_select").removeClass("is-invalid");
                }
                //valida si el funcionario es usuario del sistema
                /*
                 if ($("#puestos_select option:selected").text() === "Jefe OCCB"
                 || $("#puestos_select option:selected").text() === "Administrador"
                 || $("#puestos_select option:selected").text() === "Secretaria(o) OCCB"
                 || $("#puestos_select option:selected").text() === "Registrador"
                 || $("#puestos_select option:selected").text() === "Jefe RRHH") {
                 //valida el campo de usuario lleno
                 if ($("#use").val() === null || $("#use").val() === "") {
                 $("#use").addClass("is-invalid");
                 contador++;
                 } else {
                 $("#use").removeClass("is-invalid");
                 }
                 //valida el usuario no exista ya
                 checkusuario($("#use").val());
                 if (rep_use === true) {
                 $("#use").addClass("is-invalid");
                 alert("ERROR: Ya existe un funcionario con ese usuario");
                 contador++;
                 }
                 
                 //valida el campo de la clave lleno
                 if ($("#pass").val() === null || $("#pass").val() === "") {
                 $("#pass").addClass("is-invalid");
                 contador++;
                 } else {
                 $("#pass").removeClass("is-invalid");
                 }
                 }
                 */
                if (contador !== 0) {
                    alert("ERROR: hay cambos que estan vacios o con valores no permitidos");
                    return false;
                } else {
                    return true;
                }
            }

            function checkfuncionario(id) {
                $.ajax({
                    type: "GET",
                    async: false,
                    url: "api/funcionarios/" + id,
                    success: rep_func
                });
            }

            function rep_func(aux) {
                if (aux !== null && aux !== undefined) {
                    rep_fun = true;
                } else {
                    rep_fun = false;
                }
            }

            function checkusuario(id) {
                $.ajax({
                    type: "GET",
                    async: false,
                    url: "api/Usuarios/" + id,
                    success: rep_user
                });
            }

            function rep_user(aux) {
                if (aux !== null && aux !== undefined) {
                    rep_use = true;
                } else {
                    rep_use = false;
                }
            }

            function limpiar() {
                $("#newfunc").trigger("reset");
            }

            $.ajax();
            $(pageLoad);
            $("#puestos_select").on("change", myFunction);

        </script>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>
