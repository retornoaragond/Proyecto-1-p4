/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.logic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Escinf
 */
public class Model {
    static Map<String,Persona> personas=new HashMap<>();
    
    public static void agregar(Persona p) throws Exception{
        if(personas.containsKey(p.getNombre())) throw new Exception("Persona ya existe");
        personas.put(p.getNombre(), p);
    }
    
    public static List<Persona> listar(){
        return new ArrayList(personas.values());
    }
    
    public static Persona consultar(Persona id)throws Exception{
        Persona result = personas.get(id.getNombre());
        if (result==null) throw new Exception("Persona no existe");
        return result;
    }    
}
