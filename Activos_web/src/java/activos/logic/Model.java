/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.logic;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Escinf
 */
public class Model {

    static Map<Integer, Solicitud> solicitudes = new HashMap<>();

    public static void agregar(Solicitud p) throws Exception {
        if (solicitudes.containsKey(p.getNumsol())) {
            throw new Exception("Solicitud ya existe");
        }
        solicitudes.put(p.getNumsol(), p);
    }

    public static Solicitud consultar(Solicitud id) throws Exception {
        Solicitud result = solicitudes.get(id.getNumsol());
        if (result == null) {
            throw new Exception("Solicitud no existe");
        }
        return result;
    }
    
    public static void limpiar(){
        solicitudes = new HashMap<>();
    }
}
