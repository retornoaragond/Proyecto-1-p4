/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Usuarios;

import activos.logic.ModelLogic;
import activos.logic.Usuario;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotAcceptableException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author ExtremeTech
 */
@Path("/Usuarios")
public class Usuarios {
    
    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();
    
    @POST
    @Path("{id_lab}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void add(Usuario u, @PathParam("id_lab") int l) {
        try {
            model.agregarUsuario(u,l);
        } catch (Exception ex) {
            throw new NotAcceptableException();
        }
    }
    
    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Usuario get(@PathParam("id") String usuario) {
        try {
            return model.getUsuario(usuario);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }
}