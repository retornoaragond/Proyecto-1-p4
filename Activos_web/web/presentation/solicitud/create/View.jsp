<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:48 AM
    Author     : ExtremeTech
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Usuario loge = (Usuario) session.getAttribute("loggeado");%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/presentation/Head.jsp" %>
        <title>Crear solicitud</title>
    </head>
    <body>
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>

        <div class="card-content"></div>
        <div class="container grey lighten-4" >
            <div class="row">
                <form class="col s12" method="POST" name="formulario" action="presentation/solicitud/create">
                    <div class="col s12">
                        <h5 class="center-align">Agregar nueva solicitud</h5>
                    </div>
                    <div class="col s3 l3 left-align">
                        <p>N&uacute;mero de comprobante</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <input type="text" id="campoNumcomp" name="campoNumcomp" class="validate">
                    </div>

                    <div class="col s3 l3 left-align">
                        <p>Fecha de adquisici&oacute;n</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <input type="date" class="datepicker" id="campoFechaAdq" name="campoFechaAdq">
                    </div>

                    <div class="col s3 l3 left-align">
                        <p>Tipo de adquisici&oacute;n</p>
                    </div>
                    <div class="input-field col s3 l3">
                        <select name="select">
                            <option value="donacion">Donaci&oacute;n</option>
                            <option value="compra">Compra</option>
                            <option value="generado">Generado</option>
                        </select>
                    </div>

                    <div class="input-field col s3 l3">
                        <input type="submit" value="Agregar" name="agregar">
                    </div>
                </form>

                <h5 class="center-align">Bienes</h5>
                <div class="row">
                    <div class="col s10 offset-s1">
                        <form class="col s12" method="POST" name="formulario" action=" ">
                            <table class="striped" border=0 cellpadding=3 cellspacing=4 >
                                <thead>
                                    <tr>
                                        <th>Serial</th>
                                        <th>Categor&iacute;a</th>
                                        <th>Solicitud</th>
                                        <th>Descripci&oacute;n</th>
                                        <th>Marca</th>
                                        <th>Modelo</th>
                                        <th>Precio</th>
                                        <th>Cant</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="serial" name="serial" size=15 maxlength=20">
                                                <label for="serial">Serial</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="cat" name="cat" size=15 maxlength=20">
                                                <label for="cat">Categoría</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="sol" name="sol" size=15 maxlength=20">
                                                <label for="sol">Solicitud</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="dec" name="desc" size=15 maxlength=20">
                                                <label for="desc">Descripción</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="marca" name="marca" size=15 maxlength=20">
                                                <label for="marca">Marca</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="mod" name="mod" size=15 maxlength=20">
                                                <label for="mod">Modelo</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="precio" name="precio" size=15 maxlength=20">
                                                <label for="precio">Precio</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>
                                        <th>
                                            <div class="input-field col s12">
                                                <input type="text" id="cant" name="cant" size=15 maxlength=20">
                                                <label for="cant">Cantidad</label>
                                                <span class="helper-text" data-error="Debe llenar este campo" data-success=""></span>
                                            </div>
                                        </th>

                                        <th>
                                            <!-- ************** -->
                                            <div class="row">
                                                <div class="input-field col s4 l4">
                                                    <a href=""<i class="material-icons prefix">save</i></a>
                                                </div>
                                            </div>
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        </form>

                    </div>
                </div>

                <h5 class="center-align">Bienes</h5>
                <div class="row">
                    <div class="col s10 offset-s1">
                        <table class="striped" border=0 cellpadding=3 cellspacing=4 >
                            <thead>
                                <tr>
                                    <th>Serial</th>
                                    <th>Categor&iacute;a</th>
                                    <th>Solicitud</th>
                                    <th>Descripci&oacute;n</th>
                                    <th>Marca</th>
                                    <th>Modelo</th>
                                    <th>Precio</th>
                                    <th>Cant</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- For de los bienes -->
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
