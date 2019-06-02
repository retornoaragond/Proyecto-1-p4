/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Solicitudes;

import activos.logic.Bien;
import activos.logic.Funcionario;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
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
public class Solicitudes {

    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();

    @GET
    @Path("/comprobantes")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Solicitud> search(@QueryParam("comprobante") String comprobante) {
        Solicitud filtro = new Solicitud();
        filtro.setNumcomp(comprobante);
        List<Solicitud> ps = model.filtroSolicitudesSecretaria(filtro);
        return ps;
    }

    @GET
    @Path("/jefe")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Solicitud> searSolicitudesJefe(@QueryParam("comprobante") String comprobante) {
        Solicitud filtro = new Solicitud();
        filtro.setNumcomp(comprobante);
        List<Solicitud> ps = model.filtroSolicitudesJefeOccb(filtro);
        return ps;
    }

    @GET
    @Path("/registrador")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Funcionario> buscarRegistradores() {
        List<Funcionario> lista = null;
        try {
            lista = model.searchRegistradores();
        } catch (Exception ex) {
            Logger.getLogger(Solicitudes.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
    }

    @GET
    @Path("/solicitudes")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Bien> getBienes(@QueryParam("numsol") String numsol) {
        Solicitud sol = new Solicitud();
        sol.setNumsol(Integer.parseInt(numsol));
        List<Bien> ps = model.getBienes(sol);
        return ps;
    }

    @GET
    @Path("/detalles")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Solicitud buscarSolicitud(@QueryParam("numero") String numero) {
        Solicitud nueva = null;
        try {
            nueva = model.getSolicitudNumSol(numero);
        } catch (Exception ex) {
            Logger.getLogger(Solicitudes.class.getName()).log(Level.SEVERE, null, ex);
        }
        return nueva;
    }

        @PUT
    @Path("/encargado")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updateRegistrador(@QueryParam("nums") String nums, @QueryParam("val") String val) {
        Solicitud sol = new Solicitud();
        sol.setNumsol(Integer.parseInt(nums));
        sol.setEstado(val);
        try {
            model.setRegistrador(nums, val);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }
    
    @PUT
    @Path("/actualice")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@QueryParam("nums") String nums, @QueryParam("val") String val) {
        Solicitud sol = new Solicitud();
        sol.setNumsol(Integer.parseInt(nums));
        sol.setEstado(val);
        try {
            model.actualizarEstadoSolicitud(sol);
        } catch (Exception ex) {
            throw new NotFoundException();
        }
    }

}
