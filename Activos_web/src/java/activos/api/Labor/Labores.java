/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Labor;

import activos.logic.Funcionario;
import activos.logic.Labor;
import activos.logic.ModelLogic;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.NotAcceptableException;
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
@Path("/Labores")
public class Labores {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();

    @POST
    @Path("{id_fun}&{id_dep}&{id_pues}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public int add(@PathParam("id_fun") String f, @PathParam("id_dep") String d, @PathParam("id_pues") String p) {
        try {
            return model.addLabor(f, d, p);
        } catch (Exception ex) {
            throw new NotAcceptableException();
        }
    }
}
