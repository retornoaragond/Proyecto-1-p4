/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.logic;

import java.util.ArrayList;
import java.util.List;
import activos.data.DaoActivos;
import activos.data.DaoAdministracion;
import activos.data.DaoSolicitudes;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.apache.commons.codec.binary.Hex;

/**
 *
 * @author ExtremeTech
 */
public class ModelLogic {

    private final DaoSolicitudes daoSolicitud;
    private final DaoActivos daoActivos;
    private final DaoAdministracion daoAdministracion;
    private final GenerarPDF generarPDF;

    private static ModelLogic uniqueInstance;
    
//    public void generarPDF(String header, String info, String footer, String salida, List<String> codigo){
//        generarPDF.generarPDF(header, info, footer, salida, codigo);
//    }
    
    public void generarPDF(String header, String info, String footer, String salida, String codigo){
        generarPDF.generarPDF(header, info, footer, salida, codigo);
    }
    
    public static ModelLogic instance() {
        if (uniqueInstance == null) {
            uniqueInstance = new ModelLogic();
        }
        System.out.println("coneccion a la base");
        return uniqueInstance;
    }

    private ModelLogic() {
        daoSolicitud = new DaoSolicitudes();
        daoActivos = new DaoActivos();
        daoAdministracion = new DaoAdministracion();
        generarPDF = new GenerarPDF();
    }

    public String getSHA_256(String pass) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(pass.getBytes());
            byte[] mb = md.digest();
            return String.valueOf(Hex.encodeHex(mb));
        } catch (NoSuchAlgorithmException ex) {

        }
        return null;
    }

    public Usuario getUsuario(String id) throws Exception {
        Usuario u = daoAdministracion.usuarioGet(id);
        return u;
    }

    public Usuario getUsuario(String id, String clave) throws Exception {
        Usuario u = daoAdministracion.usuarioGet(id);
        if (u.getPass().equals(getSHA_256(clave))) {
            return u;
        } else {
            throw new Exception("Clave incorrecta");
        }
    }

    public void agregarUsuario(Usuario user) throws Exception {
        daoAdministracion.addUsuario(user);
    }

    public void agregarUsuario(Usuario user, int lab) throws Exception {
        daoAdministracion.addUsuario(user, lab);
    }

    public List<Usuario> getUsuarios() {
        return daoAdministracion.usuariosGetAll();
    }
    
    public List<Funcionario> getRegistradores() {
        return daoAdministracion.getRegistradores();
    }
    
    public void setRegistrador(String numsol, String nomFunc) throws Exception{
        daoSolicitud.setRegistrador(numsol, nomFunc);
    }

    public List<Solicitud> getSolicitudes() {
        return daoSolicitud.SolicitudGetAll();
    }

    public List<Solicitud> searByNumComp(Solicitud filtro, String dep) {
        return daoSolicitud.SolSearchbyNumcomp(filtro, dep);
    }

    public Solicitud findSolicitudnumComp(Solicitud sol) throws Exception {
        return daoSolicitud.findSolicitudnumComp(sol.getNumcomp(), sol.getDependencia().getCodigo());
    }

    public void actualizarSoliEditada(Solicitud sol) throws Exception {
        daoSolicitud.actulizarSoliEditada(sol);
    }

    public void actualizarEstadoSolicitud(Solicitud sol) throws Exception {
        daoSolicitud.SolicitudUpdate2(sol);
    }

    public void borrarBien(Bien b) throws Exception {
        daoSolicitud.borrarBien(b);
    }

    //<editor-fold desc="Bien" defaultstate="collapsed">
    public List<Bien> getBienes(Solicitud s) {
        return daoSolicitud.getbienes(s);
    }
    
    public Bien getBien(int serial) throws Exception {
        return daoSolicitud.BienGet(serial);
    }

    public List<Bien> searchBien(Bien filtro) {
        return daoSolicitud.BienSearch(filtro);
    }

    public void addBienPreservar(Bien bien) throws Exception {
        daoSolicitud.addBienPreservar(bien);
    }
    
     public void BienUpdate(int bien, String categ) throws Exception{
         daoSolicitud.BienUpdateCat(bien, categ);
     }

    //</editor-fold>
    //  <editor-fold desc="Solicitudes" defaultstate="collapsed">
    public List<Solicitud> getSolicitud() {
        return daoSolicitud.SolicitudGetAll();
    }

    public Solicitud getSolicitud(String serial) throws Exception {
        return daoSolicitud.SolicitudGet(Integer.parseInt(serial));
    }

    public Solicitud getSolicitudNumSol(String numsol) throws Exception {
        return daoSolicitud.getSolicitudNumero(Integer.parseInt(numsol));
    }

    public void deleteSolicitud(Solicitud p) throws Exception {
        daoSolicitud.SolicitudDelete(p);
    }

    public void addSolicitud(Solicitud solicitud) throws Exception {
        daoSolicitud.SolicitudAdd(solicitud);
    }

    public void updateSolicitud(Solicitud solicitud) throws Exception {
        daoSolicitud.SolicitudUpdate(solicitud);
    }

    public void updateSolicitud2(Solicitud solicitud) throws Exception {
        daoSolicitud.SolicitudUpdate2(solicitud);
    }

    public List<Solicitud> searchSolicitud(Solicitud filtro, List<String> l) {
        return daoSolicitud.SolicitudSearchFunc(filtro, l);
    }

    public List<Solicitud> searchSolicitudAdministrador(Solicitud filtro, List<String> l, String dep) {
        if (!filtro.getNumcomp().isEmpty()) {
            return daoSolicitud.SolicitudSearchAdm(filtro, l, dep);
        } else {
            return daoSolicitud.SolicitudGetAllbyAdministrador(l, dep);
        }
    }

    public List<Solicitud> searchSolicitudAdministradorCod(Solicitud filtro, String dep) {
        return daoSolicitud.SolSearchbyNumcomp(filtro, dep);
    }

    public List<Solicitud> searchSolicitudFuncionario(Solicitud filtro, List<String> l, Funcionario fun) {
        if (filtro.getNumsol() != 0) {
            return daoSolicitud.SolicitudSearchRegis(filtro, l, fun);
        } else {
            return daoSolicitud.solicitudRegistradorGetAl(l, fun);
        }
    }

    public List<Solicitud> filtroSolicitudes(Solicitud filtro) {
        List<Solicitud> sol = new ArrayList<>();
        if (filtro != null) {
            if (!filtro.getNumcomp().equals("") && !filtro.getNumcomp().equals(" ")) {
                sol = daoSolicitud.buscarPorCodigo(filtro.getNumcomp());
            } else {
                sol = daoSolicitud.SolicitudGetAll();
            }
        } else {
            sol = daoSolicitud.SolicitudGetAll();
        }
        return sol;
    }
    
    public List<Solicitud> filtroSolicitudesJefeOccb(Solicitud filtro) {
        List<Solicitud> sol = new ArrayList<>();
        if (filtro != null) {
            if (!filtro.getNumcomp().equals("") && !filtro.getNumcomp().equals(" ")) {
                sol = daoSolicitud.buscarPorCodigoJefeOccb(filtro.getNumcomp());
            } else {
                sol = daoSolicitud.SolicitudGetAllJefeOccb();
            }
        } else {
            sol = daoSolicitud.SolicitudGetAllJefeOccb();
        }
        return sol;
    }
    
        public List<Solicitud> filtroSolicitudesSecretaria(Solicitud filtro) {
        List<Solicitud> sol = new ArrayList<>();
        if (filtro != null) {
            if (!filtro.getNumcomp().equals("") && !filtro.getNumcomp().equals(" ")) {
                sol = daoSolicitud.buscarPorCodigoSecretaria(filtro.getNumcomp());
            } else {
                sol = daoSolicitud.SolicitudGetAllSecretaria();
            }
        } else {
            sol = daoSolicitud.SolicitudGetAllSecretaria();
        }
        return sol;
    }

    public List<Solicitud> searchSolicitudbyFuncionario(Funcionario filtro) {
        return daoSolicitud.searchSolicitudbyFuncionario(filtro);
    }

    public List<Solicitud> filtroSolicitudesRegistrador(Solicitud filtro, Funcionario f) {
        List<Solicitud> sol = new ArrayList<>();
        if (!filtro.getNumcomp().equals("") && !filtro.getNumcomp().equals(" ")) {
            sol = daoSolicitud.searchsolicitudesRegistrador(filtro.getNumcomp(), f);
        } else {
            sol = daoSolicitud.searchsolicitudesRegistrador(f);
        }
        return sol;
    }

    //</editor-fold>
    //  <editor-fold desc="Funcionario" defaultstate="collapsed">
    public List<Funcionario> getFuncionarios() throws Exception {
        return daoAdministracion.GetFuncionariobyPuesto();
    }

    public Funcionario getFuncionario(String codigo) throws Exception {
        return daoAdministracion.FuncionarioGet(codigo);
    }

    public List<Funcionario> getFuncionarioSS(String id) throws Exception {
        return daoAdministracion.GetFuncionarioS(id);
    }
    
    public List<Funcionario> searchRegistradores() throws Exception {
        return daoAdministracion.getRegistradores();
    }

    public List<Funcionario> searchFuncionario(Funcionario filtro) {
        if (filtro.getId().length() == 0 && filtro.getNombre().length() != 0) {
            return daoAdministracion.FuncionaroSearchNombre(filtro);
        } else if (filtro.getId().length() != 0 && filtro.getNombre().length() == 0) {
            return daoAdministracion.FuncionarioSearchCodigo(filtro);
        } else if (filtro.getId().length() != 0 && filtro.getNombre().length() != 0) {
            return daoAdministracion.FuncionarioSearch(filtro);
        } else {
            return daoAdministracion.FuncionarioGetAll();
        }
    }
    
    public List<Funcionario> searchFuncionariosDependencia(String dependencia) {
        List<Funcionario> f = daoAdministracion.funcionariosDependencia(dependencia);
        return f ;
    }

    public void deleteFuncionario(String p) throws Exception {
        daoAdministracion.FuncionarioDelete(p);
    }

    public void addFuncionario(Funcionario funcionario) throws Exception {
        daoAdministracion.FuncionarioAdd(funcionario);
    }

    public void updateFuncionario(Funcionario funcionario) throws Exception {
        daoAdministracion.FuncionarioUpdate(funcionario);
    }

    //</editor-fold>
    //  <editor-fold desc="Dependencia" defaultstate="collapsed">
    public List<Dependencia> getDependencias() {
        return daoAdministracion.DependenciaGetAll();
    }

    public Dependencia getDependencia(Dependencia filter) throws Exception {
        return daoAdministracion.dependenciaGet(filter.getCodigo());
    }

    public Dependencia buscarDependencia_codigo(String filter) throws Exception {
        return daoAdministracion.buscarDependencia_codigo(filter);
    }

    public List<Dependencia> getDependenciaSS(String codigo) throws Exception {
        return daoAdministracion.GetDependenciaS(codigo);
    }

    public List<Dependencia> searchDependenciaCodigo(Dependencia filtro) {

        return daoAdministracion.DependenciaSearchCodigo(filtro);
    }

    public List<Dependencia> searchDependencia(Dependencia filtro) {
        if (filtro.getCodigo().length() == 0 && filtro.getNombre().length() != 0) {
            return daoAdministracion.DependenciaSearchNombre(filtro);
        } else if (filtro.getCodigo().length() != 0 && filtro.getNombre().length() == 0) {
            return daoAdministracion.DependenciaSearchCodigo(filtro);
        } else if (filtro.getCodigo().length() != 0 && filtro.getNombre().length() != 0) {
            return daoAdministracion.DependenciaSearch(filtro);
        } else {
            return daoAdministracion.DependenciaGetAll();
        }

    }

    public void deleteDependencia(Dependencia p) throws Exception {
        daoAdministracion.DependenciaDelete(p);
    }

    public void addDependencia(Dependencia dependencia) throws Exception {
        daoAdministracion.DependenciaAdd(dependencia);
    }

    public void updateDependencia(Dependencia dependencia) throws Exception {
        daoAdministracion.DependenciaUpdate(dependencia);
    }
    //</editor-fold>

    //  <editor-fold desc="Activos" defaultstate="collapsed">
    public List<Activo> getActivos() {
        return daoActivos.ActivosGetAll();
    }
    
        public List<Activo> filtroActivos(Activo filtro) {
        List<Activo> sol = new ArrayList<>();
        if (filtro != null) {
            if (!filtro.getCodigoId().equals("") && !filtro.getCodigoId().equals(" ")) {
                sol = daoActivos.ActivoSearch(filtro);
            } else {
                sol = daoActivos.ActivosGetAll();
            }
        } else {
            sol = daoActivos.ActivosGetAll();
        }
        return sol;
    }

    public Activo getActivo(String codigoId) throws Exception {
        return daoActivos.ActivoGet(codigoId);
    }

    public void deleteActivo(Activo a) throws Exception {
        daoActivos.ActivoDelete(a);
    }
    
    public Categoria getincrementocategoria(String f){
       return daoAdministracion.Categoriaget(f);
    }

    public void addActivo(String codID, int id) throws Exception {
        daoActivos.ActivoAdd(codID, id);
    }
    
    public void actualizaincremento(int id, String c_id)throws Exception {
        id = id+1;
        daoAdministracion.incrementoplus(id, c_id);
    }
    
    public void actualizaActi(String id, int acti)throws Exception {
        daoActivos.ActivoUpdate(id, acti);
    }

    public void updateActivo(Activo activo) throws Exception {
        daoActivos.ActivoUpdate(activo);
    }

    public List<Activo> searchActivo(String filtro, int select) {
        List<Activo> list = new ArrayList<>();
        switch (select) {
            case 0:
                list = daoActivos.ActivoSearchCodigo(filtro);
                break;
            case 1:
                list = daoActivos.ActivoSearchDescripcion(filtro);
                break;
            case 2:
                list = daoActivos.ActivoSearchCategoria(filtro);
                break;
            case 3:
                list = daoActivos.ActivoSearchDependencia(filtro);
                break;
            case 4:
                list = daoActivos.ActivoSearchResponsable(filtro);
                break;
        }
        return list;
    }

//    public List<Activo> searchActivoL(String s) {
//     return daoActivos.ActivoSearch();
//    
//    }
//    
    //</editor-fold>
    public void close() {
        daoSolicitud.close();
        daoActivos.close();
        daoAdministracion.close();
    }

    public List<Puesto> getPuestos() {
        return daoAdministracion.puestoGetAll();
    }

    public List<Labor> getLaboresbyFuncionario(String FunId) throws Exception {
        return daoAdministracion.laborGetbyFuncionario(FunId);
    }
    
    public Labor laborGetbyFunc(String id)throws Exception{
        return daoAdministracion.laborGetbyFunc(id);
    }

    public void addLabor(Labor lab) throws Exception {
        daoAdministracion.LaborAdd(lab);
    }

    public int addLabor(String f, String d, String p) throws Exception {
        return daoAdministracion.LaborAdd(f, d, p);
    }

    public Labor getLabor(int cod) throws Exception {
        return daoAdministracion.laborGet(cod);
    }

    public int getAutoIncremento() throws Exception {
        return daoAdministracion.getAutoIncremento();
    }

    public void actulizarSoliEditada(Solicitud s) throws Exception {
        daoSolicitud.actulizarSoliEditada(s);
    }

    public int getAutoIncrementoSolicitud() throws Exception {
        return daoSolicitud.getAutoIncrementoSolicitud();
    }

    public List<Categoria> getCategorias() {
        return daoAdministracion.CategoriaALL();
    }

    public List<Categoria> searchCategorias(Categoria filtro) {
        if (filtro.getId().length() == 0 && filtro.getDescripcion().length() != 0) {
            return daoAdministracion.CategoriaSearchDescripcion(filtro);
        } else if (filtro.getId().length() != 0 && filtro.getDescripcion().length() == 0) {
            return daoAdministracion.CategoriaSearchId(filtro);
        } else if (filtro.getId().length() != 0 && filtro.getDescripcion().length() != 0) {
            return daoAdministracion.CategoriaSearch(filtro);
        } else {
            return daoAdministracion.CategoriaALL();
        }
    }

    public void addcategoria(Categoria categoria) throws Exception {
        daoAdministracion.categoriaAdd(categoria);
    }

    public void updatecategoria(Categoria categoria) throws Exception {
        daoAdministracion.categoriaUpdate(categoria);
    }

}
