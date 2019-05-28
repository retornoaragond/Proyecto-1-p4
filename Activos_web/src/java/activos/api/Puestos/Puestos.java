/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Puestos;

import activos.logic.ModelLogic;
import activos.logic.Puesto;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author ExtremeTech
 */
@Path("/Puestos")
public class Puestos {
    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();
    
    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Puesto> search() {
        List<Puesto> ps = model.getPuestos();
        return ps;
    }
}
