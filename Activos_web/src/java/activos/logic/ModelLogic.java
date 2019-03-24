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

/**
 *
 * @author ExtremeTech
 */
public class ModelLogic {

    private final DaoSolicitudes daoSolicitud;
    private final DaoActivos daoActivos;
    private final DaoAdministracion daoAdministracion;

    private static ModelLogic uniqueInstance;

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
    }

    public Usuario getUsuario(String id, String clave) throws Exception {
        Usuario u = daoAdministracion.usuarioGet(id);
        if (u.getPass().equals(clave)) {
            return u;
        } else {
            throw new Exception("Clave incorrecta");
        }
    }

    public void agregarUsuario(Usuario user) throws Exception {
        daoAdministracion.addUsuario(user);
    }

    public List<Usuario> getUsuarios() {
        return daoAdministracion.usuariosGetAll();
    }
    
    public List<Solicitud> getSolicitudes() {
        return daoSolicitud.SolicitudGetAll();
    }

    //<editor-fold desc="Bien" defaultstate="collapsed">
    public List<Bien> getBienes(Solicitud s) {
        return daoSolicitud.getbienes(s);
    }

    public Bien getBien(String serial) throws Exception {
        return daoSolicitud.BienGet(serial);
    }

    public List<Bien> searchBien(Bien filtro) {
        return daoSolicitud.BienSearch(filtro);
    }

    public void deleteBien(Bien p) throws Exception {
        daoSolicitud.BienDelete(p);
    }

    public void addBien(Bien bien) throws Exception {
        daoSolicitud.BienAdd(bien);
    }

    public void addBienPreservar(Bien bien) throws Exception {
        daoSolicitud.addBienPreservar(bien);
    }

    public void updateBien(Bien bien) throws Exception {
        daoSolicitud.BienUpdate(bien);
    }
    //</editor-fold>

    //  <editor-fold desc="Solicitudes" defaultstate="collapsed">
    public List<Solicitud> getSolicitud() {
        return daoSolicitud.SolicitudGetAll();
    }

    public Solicitud getSolicitud(String serial) throws Exception {
        return daoSolicitud.SolicitudGet(Integer.parseInt(serial));
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
        if (filtro.getNumsol() != 0) {
            return daoSolicitud.SolicitudSearchAdm(filtro, l, dep);
        } else {
            return daoSolicitud.SolicitudGetAllbyAdministrador(l, dep);
        }
    }

    public List<Solicitud> searchSolicitudFuncionario(Solicitud filtro, List<String> l, Funcionario fun) {
        if (filtro.getNumsol() != 0) {
            return daoSolicitud.SolicitudSearchRegis(filtro, l, fun);
        } else {
            return daoSolicitud.solicitudRegistradorGetAll(l, fun);
        }
    }

    public List<Solicitud> searchSolicitudbyFuncionario(Funcionario filtro) {
        return daoSolicitud.searchSolicitudbyFuncionario(filtro);
    }

    //</editor-fold>
    //  <editor-fold desc="Funcionario" defaultstate="collapsed">
    public List<Funcionario> getFuncionarios() throws Exception {
        return daoAdministracion.GetFuncionariobyPuesto();
    }

    public Funcionario getFuncionario(Integer codigo) throws Exception {
        return daoAdministracion.FuncionarioGet(codigo.toString());
    }

    public List<Funcionario> getFuncionarioSS(String id) throws Exception {

        return daoAdministracion.GetFuncionarioS(id);
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

    public void deleteFuncionario(Funcionario p) throws Exception {
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

    public Activo getActivo(String codigoId) throws Exception {
        return daoActivos.ActivoGet(codigoId);
    }

    public void deleteActivo(Activo a) throws Exception {
        daoActivos.ActivoDelete(a);
    }

    public void addActivo(Activo activo) throws Exception {
        //daoActivos.ActivoAdd(activo);
        daoActivos.ActivoUpdate(activo);
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

    public void addLabor(Labor lab) throws Exception {
        daoAdministracion.LaborAdd(lab);
    }

    public Labor getLabor(int cod) throws Exception {
        return daoAdministracion.laborGet(cod);
    }

    public int getAutoIncremento() throws Exception {
        return daoAdministracion.getAutoIncremento();
    }

    public int getAutoIncrementoSolicitud() throws Exception {
        return daoSolicitud.getAutoIncrementoSolicitud();
    }

    public List<Categoria> getCategoria() {
        return daoAdministracion.CategoriaALL();
    }

    public void addcategoria(Categoria categoria) throws Exception {
        daoAdministracion.categoriaAdd(categoria);
    }

    public void updatecategoria(Categoria categoria) throws Exception {
        daoAdministracion.categoriaUpdate(categoria);
    }

}
