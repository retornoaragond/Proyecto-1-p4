/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.api.Activos;

import activos.logic.ModelLogic;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

/**
 *
 * @author steve
 */
@Path("/")
public class Activos {
    
    @Context
    HttpServletRequest request;
    ModelLogic model = ModelLogic.instance();
    
}
