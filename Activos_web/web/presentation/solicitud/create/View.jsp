<%-- 
    Document   : View
    Created on : 19/03/2019, 12:42:48 AM
    Author     : ExtremeTech
--%>

<%@page import="activos.logic.Solicitud"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="activos.logic.Bien"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/presentation/Head.jsp" %>
        <title>Crear solicitud</title>
    </head>
    <body>
        <% Usuario loge = (Usuario) session.getAttribute("loggeado");%> 
        <% ArrayList<Bien> model = (ArrayList<Bien>) session.getAttribute("listaBien");%>
        <% Bien model2 = (Bien) session.getAttribute("model2");%>
        <% Solicitud soli = (Solicitud)session.getAttribute("solicitud"); %>
        <% Map<String, String> errors = (Map<String, String>) request.getAttribute("errors"); %>
        <% Map<String, String> errors2 = (Map<String, String>) request.getAttribute("errors2"); %> 
        <% Map<String, String[]> values = (errors == null) ? this.getValuesBien(model2) : request.getParameterMap();%>
        <% Map<String, String[]> values2 = (errors2 == null) ? this.getValuesSoli(soli) : request.getParameterMap();%>
        <% String habil = (String)session.getAttribute("habilitado"); %>
        
        <header>
            <%@ include file="/presentation/Header.jsp" %>
        </header>

        <div class="card-content"></div>
        <div class="container grey lighten-4" >
            <div class="row">
                <div class="container">
                    <div class="row"><br>
                        <div class="jumbotron">
                            <form class="col-sm-12" method="POST" name="formulario" action="presentation/solicitud/agregarSolicitud">
                                <div class="form-row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <h1>Agregar nueva solicitud</h1>
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer12">N&uacute;mero de comprobante</label>
                                        <input <%=habilitados(habil)%> type="text"  id="campoNumcomp" 
                                                                       name="campoNumcomp" 
                                                                       class="form-control <%=validity("campoNumcomp", errors2)%> " 
                                                                       id="validationServer12" placeholder="N°" 
                                                                       value="<%=value("campoNumcomp", values2)%>">
                                        <div class="invalid-feedback">
                                            <%=validity3("campoNumcomp", errors2)%>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer13">Fecha de adquisici&oacute;n</label>
                                        <input <%=habilitados(habil)%> type="date" 
                                                                       class="datepicker form-control <%=validity("campoFechaAdq", errors2)%> "  
                                                                       id="campoFechaAdq" name="campoFechaAdq" id="validationServer13"
                                                                       value="<%=value("campoFechaAdq", values2)%>" 
                                                                       min="2000-01-01" max="<%=fecha_actual()%>">
                                        <div class="invalid-feedback">
                                            <%=validity3("campoFechaAdq", errors2)%>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label for="validationServer14">Tipo de adquisici&oacute;n</label>
                                        <select <%=habilitados(habil)%> 
                                            class="custom-select d-block w-100 <%=validity("options", errors2)%> " 
                                            name="options">
                                            <option value="" <%=tiposelec("", values2)%> disabled hidden>Seleccione...</option>
                                            <option value="Donacion" <%=tiposelec("Donacion", values2)%> >Donaci&oacute;n</option>
                                            <option value="Compra" <%=tiposelec("Compra", values2)%> >Compra</option>
                                            <option value="Generado" <%=tiposelec("Generado", values2)%> >Generado</option>
                                        </select>
                                            <div class="invalid-feedback">
                                                <%=validity3("options", errors2)%>
                                            </div>
                                    </div>
                                    <div class="col-12 mt-3">
                                        <button <%=habilitados(habil)%> class="form-control btn btn-primary " style="font-size: 2rem" type="submit"><i class="fas fa-save"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="container d-flex justify-content-center" >
                    <form class="" method="POST" name="formulario" action="presentation/solicitud/agregarBien">
                        <div>
                            <h5>Bienes</h5>  
                        </div>
                        <table class="table table-striped table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Serial</th>                            
                                    <th>Descripci&oacute;n</th>
                                    <th>Marca</th>
                                    <th>Modelo</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                            <td>
                                <input class="form-control <%=validity("serial", errors)%>" type="text" id="serial" name="serial" size=15 maxlength=20" value="<%=value("serial", values)%>" >
                                <div class="invalid-feedback">
                                    <%=validity2("serial", errors)%>
                                </div>
                            </td>
                            <td>
                                <input class="form-control <%=validity("desc", errors)%>" type="text" id="desc" name="desc" size=15 maxlength=20" value="<%=value("desc", values)%>">
                                <div class="invalid-feedback">
                                    <%=validity2("desc", errors)%>
                                </div>
                            </td>
                            <td>
                                <input  class="form-control <%=validity("marca", errors)%>" type="text" id="marca" name="marca" size=15 maxlength=20" value="<%=value("marca", values)%>">
                                <div class="invalid-feedback">
                                    <%=validity2("marca", errors)%>
                                </div>
                            </td>
                            <td>
                                <input class="form-control <%=validity("mod", errors)%>" type="text" id="mod" name="mod" size=15 maxlength=20" value="<%=value("mod", values)%>">
                                <div class="invalid-feedback">
                                    <%=validity2("mod", errors)%>
                                </div>
                            </td>
                            <td>
                                <input class="form-control <%=validity("precio", errors)%>" class="form-control" type="text" id="precio" name="precio" size=15 maxlength=20" value="<%=value("precio", values)%>">
                                <div class="invalid-feedback">
                                    <%=validity2("precio", errors)%>
                                </div>
                            </td>
                            <td>
                                <input class="form-control <%=validity("cant", errors)%>" type="text" id="cant" name="cant" size=15 maxlength=20" value="<%=value("cant", values)%>">
                                <div class="invalid-feedback">
                                    <%=validity2("cant", errors)%>
                                </div>
                            </td>
                            <td>
                                <button class="form-control btn btn-primary " style="font-size: 1rem" type="submit"><i class="fas fa-plus"></i></button>
                            </td>
                            <% if (loge != null) {%>
                            <% if (model != null) {%>
                            <% for (Bien p : model) {%>
                            <tr>
                                <td><%= p.getSerial()%></td>
                                <td><%= p.getDescripcion()%></td>
                                <td><%= p.getMarca()%></td>
                                <td><%= p.getModelo()%></td>
                                <td><%= p.getPrecioU()%></td>
                                <td><%= p.getCantidad()%></td>
                            </tr>
                            <% } %>
                            <% } %>  
                            <% }%>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="/presentation/Complement.jsp" %>
    </body>
    <footer class="bottom-sheet background blue-grey">
        <%@ include file="/presentation/Footer.jsp" %>
    </footer>
</html>


<%!
    private String validity(String field, Map<String, String> errors) {
        if ((errors != null) && (errors.get(field) != null)) {
            return "is-invalid";
        }
        return "";
    }

    private String validity2(String field, Map<String, String> errors) {
        if ((errors != null) && (errors.get(field) != null)) {
            return errors.get(field);
        }
        return "";
    }
    
    private String validity3(String field, Map<String, String> errors) {
        if ((errors != null) && (errors.get(field) != null)) {
            return errors.get(field);
        }
        return "";
    }

    private String habilitados(String habilitado){
    if (habilitado.equals("false")) {
            return "disabled";
        }
        return "";
    }

    private String value(String field, Map<String, String[]> values) {
        return values.get(field)[0];
    }
    
    private String valueselect(String field, Map<String, String[]> values) {
        if(values.get(field)!=null){
            return values.get(field)[0];
        }
        return null;
    }

    private Map<String, String[]> getValuesBien(Bien model2) {
        Map<String, String[]> values = new HashMap<>();
        values.put("serial", new String[]{model2.getSerial()});
        values.put("desc", new String[]{model2.getDescripcion()});
        values.put("marca", new String[]{model2.getMarca()});
        values.put("mod", new String[]{model2.getModelo()});
        if (!Double.toString(model2.getPrecioU()).equals("0.0")) {
            values.put("precio", new String[]{Double.toString(model2.getPrecioU())});
        } else {
            values.put("precio", new String[]{""});
        }
        if (!Integer.toString(model2.getCantidad()).equals("0")) {
            values.put("cant", new String[]{Integer.toString(model2.getCantidad())});
        } else {
            values.put("cant", new String[]{""});
        }
        return values;
    }

    private Map<String, String[]> getValuesSoli(Solicitud model2) {
        Map<String, String[]> values = new HashMap<>();
        values.put("campoNumcomp", new String[]{model2.getNumcomp()});
        values.put("campoFechaAdq", new String[]{model2.getFecha().toString()});
        values.put("options", new String[]{model2.getTipoadq()});
        return values;
    }

    private String tiposelec(String atrib, Map<String, String[]> values){
        if(valueselect("options",values)!= null){
            if(atrib == value("options",values)){
                return "selected";
            }else{
                return "";
            }
        }else{
            if(atrib == ""){
                return "selected";
            }
            return "";
        }
    }

    private String fecha_actual(){
        LocalDate localDate = LocalDate.now();
        String fecha = DateTimeFormatter.ofPattern("yyyy-MM-dd").format(localDate).toString();
        return fecha;
    }
%>