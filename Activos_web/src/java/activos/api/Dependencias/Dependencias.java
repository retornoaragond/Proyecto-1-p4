/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Dependencias;

import activos.logic.Dependencia;
import activos.logic.ModelLogic;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author steve
 */
@Path("/dependencias")
public class Dependencias {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();

    /*GET DEPENDENCIA POR CODIGO*/

    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Dependencia> search(@QueryParam("nombre") String nombre, @QueryParam("codigo") String codigo) {
        Dependencia filtro = new Dependencia();
        filtro.setNombre(nombre);
        filtro.setCodigo(codigo);
        List<Dependencia> ps = model.searchDependencia(filtro);
        return ps;
    }

    @POST
   @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void agregarDep(Dependencia dep) {
        try {
            model.addDependencia(dep);
        } catch (Exception ex) {
        }
    }

}
