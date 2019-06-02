/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.funcionarios;

import activos.logic.Funcionario;
import activos.logic.ModelLogic;
import activos.logic.Usuario;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.NotAcceptableException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author ExtremeTech
 */
@Path("/funcionarios")
public class Funcionarios {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();
    
    @POST
    @Path("{id_dep}/{id_puest}/{id_user}/{id_pass}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces({MediaType.APPLICATION_JSON})    
    public void add(Funcionario p,
            @PathParam("id_dep") String dep,
            @PathParam("id_puest") String puest,
            @PathParam("id_user") String user,
            @PathParam("id_pass") String pass) {  
        try {
            model.addFuncionario(p);
            Usuario use = new Usuario(user, null, pass);
            model.agregarUsuario(use, model.addLabor(p.getId(), dep, puest));
        } catch (Exception ex) {
            throw new NotAcceptableException(); 
        }
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_JSON})
    public Funcionario get(@PathParam("id") String cedula) {
        try {
            return model.getFuncionario(cedula);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }

    @GET
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Funcionario> search(@QueryParam("id") String id) {
        try {
            Funcionario fun = new Funcionario(id,"");
            List<Funcionario> ps = model.searchFuncionario(fun);
            return ps;
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(Funcionario p) {
        try {
            model.updateFuncionario(p);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }

    @DELETE
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void del(@PathParam("id") String id) {
        try {
            model.deleteFuncionario(id);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }

}
