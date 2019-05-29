<%-- 
    Document   : ViewFC
    Created on : 28/05/2019, 02:17:39 AM
    Author     : ExtremeTech
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-building"></i> </span>
                            </div>
                            <select id="dependencias_select" class="custom-select">
                                <option selected="" disabled hidden>Dependencia...</option>
                            </select>
                        </div> <!-- form-group// -->
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fas fa-briefcase"></i> </span>
                            </div>
                            <select id="puestos_select" class="custom-select">
                                <option selected="" disabled hidden>Puesto...</option>

                            </select>
                        </div> <!-- form-group end.// -->

                        <div class="card bg-dark" id="log_user" style="padding: 15px; margin-bottom: 10px; display: none;">
                            <div class="form-group input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"> <i class="fas fa-user-tag"></i> </span>
                                </div>
                                <input id="use" class="form-control" placeholder="Usuario" type="text">
                            </div> <!-- form-group// -->
                            <div class="form-group input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                </div>
                                <input id="pass" class="form-control" placeholder="Contraseña" type="password">
                            </div> <!-- form-group// -->     
                        </div>

                        <div class="form-group">
                            <!-- <a href="presentation/funcionarios/list/View.jsp" class="form-control btn btn-primary" id="agregar"><i class="fas fa-user-plus"></i></a> -->
                            <button type="button" class="form-control btn btn-primary" id="agregar"><i class="fas fa-user-plus"></i></button> 
                        </div> <!-- form-group// -->                                                                
                    </form>
                </article>
            </div> <!-- card.// -->
            <br><br>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
        <script>

            function listadep(dependencias) {
                dependencias.forEach((p) => {
                    filad(p);
                });
            }

            function filad(dependencia) {
                $("#dependencias_select").append(new Option(dependencia.nombre, dependencia.codigo));
            }

            function dependencias() {
                $.ajax({type: "GET",
                    url: "api/dependencias?nombre=&codigo=",
                    success: listadep
                });
            }
            
            function listapues(puestos) {
                puestos.forEach((p) => {
                    filap(p);
                });
            }
            
            function filap(puesto) {
                $("#puestos_select").append(new Option(puesto.puesto, puesto.codgo));
            }
            
            function puestos() {
                $.ajax({type: "GET",
                    url: "api/Puestos",
                    success: listapues
                });
            }

            function pageLoad(event) {
                $("#agregar").on("click", agregar);
                dependencias();
                puestos();
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


            $(pageLoad);
            $("#puestos_select").on("change", myFunction);
        </script>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>     
</html>
