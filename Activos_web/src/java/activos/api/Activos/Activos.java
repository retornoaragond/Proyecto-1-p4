/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Activos;

import activos.logic.Activo;
import activos.logic.Bien;
import activos.logic.Dependencia;
import activos.logic.Funcionario;
import activos.logic.Labor;
import activos.logic.ModelLogic;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author steve
 */
@Path("/")
public class Activos {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();

    @GET
    @Path("/activos")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Activo> search(@QueryParam("codigoid") String codigoid) {
        Activo filtro = new Activo();
        filtro.setCodigoId(codigoid);
        Bien b = new Bien();
        b.setDescripcion(codigoid);
        filtro.setBien(b);
        return model.filtroActivos(filtro);
    }

    @GET
    @Path("/dependencia")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Dependencia> buscarDependencias() {
        Dependencia d = new Dependencia();
        d.setCodigo("");
        return model.searchDependencia(d);
    }

    @GET
    @Path("/func")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Funcionario> buscarFuncionarios(@QueryParam("dependencia") String dependencia) {
        List<Funcionario> f = model.searchFuncionariosDependencia(dependencia);
        return f;
    }

    @PUT
    @Path("/actualizaActivo")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateRegistrador(
            @QueryParam("id_fun") String fun,
            @QueryParam("id_activo") String acti) {
        try {
            Labor l= model.laborGetbyFunc(fun);
            model.actualizaActi(acti,l.getId());
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }
    
    @POST
    @Path("/barras")
    @Consumes(MediaType.APPLICATION_JSON)
    public void reportePDF(@QueryParam("header") String header,
            @QueryParam("info") String info, @QueryParam("footer") String footer,
            @QueryParam("salida") String salida, @QueryParam("codigo") String codigo) {
        model.generarPDF(header, info, footer, salida, codigo);
    }
    
//    @POST
//    @Path("/barras2")
//    @Consumes(MediaType.APPLICATION_JSON)
//    public void reportePDF2(@Context HttpServletRequest request) {
//        String[] l = request.getParameterValues("list");
//        List<String> w = Arrays.asList(l); 
////        List<String> w = new ArrayList<>(); 
////        w.add("b12341234");
////        w.add("a12341234");
////        w.add("c12341234");
////        w.add("12341234");
//        model.generarPDF("", "", "", "codigosdeBarra", w);
//    }
}
