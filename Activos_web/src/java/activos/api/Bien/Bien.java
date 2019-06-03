/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Bien;

import activos.logic.Categoria;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
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
 * @author ExtremeTech
 */
@Path("/bienes")
public class Bien {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();

    @POST
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void search(
            @QueryParam("id_b") int id,
            @QueryParam("cant_b") int cant,
            @QueryParam("cat_b") String cate) {
        try {
            Categoria consec;
            for (int i = 0; i < cant; i++) {
                consec = model.getincrementocategoria(cate);
                model.addActivo(consec.getIncremento() + consec.getDescripcion(), id);
                model.actualizaincremento(consec.getIncremento(), cate);
            }
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }
    
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@QueryParam("id_bien") int id_bien, @QueryParam("id_cat") String id_cat) {
        try {
            model.BienUpdate(id_bien, id_cat);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }
}
