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
import activos.logic.ModelLogic;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
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
}
