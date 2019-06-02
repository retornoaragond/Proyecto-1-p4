/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Categorias;

import activos.logic.Categoria;
import activos.logic.ModelLogic;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author ExtremeTech
 */
@Path("/categorias")
public class Categorias {
    
    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void agregarDep(Categoria cat) {
        try {
            model.addcategoria(cat);
        } catch (Exception ex) {
        }
    }
    
    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Categoria> search(@QueryParam("descripcion") String descripcion, @QueryParam("id") String id) {
        Categoria filtro = new Categoria();
        filtro.setDescripcion(descripcion);
        filtro.setId(id);
        List<Categoria> ps = model.searchCategorias(filtro);
        return ps;
    }
    
    @GET
    @Path("/filtro")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Categoria> searchregistrador() {
        List<Categoria> ps = model.getCategorias();
        return ps;
    }
    
}
