/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.data;

import activos.logic.Activo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import activos.logic.Bien;
import activos.logic.Categoria;
import activos.logic.Funcionario;
import activos.logic.Solicitud;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author ExtremeTech
 */
public class DaoSolicitudes {

    RelDatabase db;
    DaoAdministracion da = new DaoAdministracion();

    public DaoSolicitudes() {
        db = new RelDatabase();
    }

    //  <editor-fold desc="Solicitud" defaultstate="collapsed">
    public Solicitud getSolicitud(Integer numSolicitud) throws Exception {
        String sql = "SELECT * FROM solicitud where codigoId='%s'";
        sql = String.format(sql, numSolicitud);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            return solicitud(rs);
        } else {
            throw new Exception("Solicitud no Existe");
        }
    }

    public Solicitud getSolicitudNumero(Integer numSolicitud) throws Exception {
        String sql = "SELECT * FROM solicitud where numsol='%s'";
        sql = String.format(sql, numSolicitud);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            return solicitud(rs);
        } else {
            throw new Exception("Solicitud no Existe");
        }
    }
    
    public void setRegistrador(String numsol, String nomFuncionario) throws SQLException, Exception{
        Funcionario f = getRegistradorPorNombre(nomFuncionario);
        String sql = "update solicitud set registrador = '%s' where numsol = '%s';";
        sql = String.format(sql, f.getId(), numsol);
        ResultSet rs = db.executeQuery(sql);
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Error actualizando");
        }
    }
    
    public Funcionario getRegistradorPorNombre(String nom) throws SQLException{
        String sql = "SELECT * FROM funcionario WHERE nombre='%s'";
        sql = String.format(sql, nom);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            return funcionario(rs);
        } else {
            //throw new Exception("Funcionario no Existe");
            return null;
        }
    }
    
    private Funcionario funcionario(ResultSet rs) {
        try {
            Funcionario ec = new Funcionario();
            ec.setId(rs.getString("id"));
            ec.setNombre(rs.getString("nombre"));
            return ec;
        } catch (SQLException ex) {
            return null;
        } catch (Exception ex) {
            return null;
        }
    }

    public Solicitud findSolicitudnumComp(String numComp, String codDependencia) throws Exception {
        String sql = "SELECT * FROM solicitud where numcomp='%s' and Dependencia_codigo='%s'";
        sql = String.format(sql, numComp, codDependencia);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            Solicitud s = solicitud(rs);
            List<Bien> r = getbienes(s);
            Set<Bien> hSet = new HashSet(0);
            for (Bien b : r) {
                hSet.add(b);
            }
            s.setBiens(hSet);
            return s;
        } else {
            throw new Exception("Solicitud no Existe");
        }
    }

    private Solicitud solicitud(ResultSet rs) {
        try {
            Solicitud ec = new Solicitud();
            ec.setNumsol(rs.getInt("numsol"));
            ec.setNumcomp(rs.getString("numcomp"));
            ec.setEstado(rs.getString("estado"));
            ec.setRazonR(rs.getString("razonR"));
            ec.setCantbien(rs.getInt("cantbien"));
            ec.setFecha(rs.getDate("fecha"));
            ec.setMontotal(rs.getDouble("montotal"));
            ec.setTipoadq(rs.getString("tipoadq"));
            ec.setDependencia(da.dependenciaGet(rs.getString("Dependencia_codigo")));
            if (rs.getString("registrador") != null) {
                ec.setFuncionario(da.getFuncionario(rs.getString("registrador")));
            }
            return ec;
        } catch (SQLException ex) {
            return null;
        } catch (Exception ex) {
            return null;
        }
    }

    public List<Solicitud> SolSearchbyNumcomp(Solicitud filtro, String dep) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql;
            if (!filtro.getNumcomp().isEmpty()) {
                sql = "select * from solicitud,dependencia "
                        + "where solicitud.Dependencia_codigo = dependencia.codigo "
                        + "AND dependencia.nombre = '%s' AND solicitud.numcomp like '%%%s%%' ";
            } else {
                sql = "select * from solicitud,dependencia "
                        + "where solicitud.Dependencia_codigo = dependencia.codigo "
                        + "AND dependencia.nombre = '%s' ";
            }
            if (!filtro.getNumcomp().isEmpty()) {
                sql = String.format(sql, dep, filtro.getNumcomp());
            } else {
                sql = String.format(sql, dep);
            }
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    public List<Solicitud> SolicitudSearchAdm(Solicitud filtro, List<String> l, String dep) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql;
            if (filtro.getNumsol() != 0) {
                sql = "select * from solicitud,dependencia "
                        + "where solicitud.Dependencia_codigo = dependencia.codigo "
                        + "AND dependencia.nombre = '%s' AND solicitud.numsol = '%d' ";
            } else {
                sql = "select * from solicitud,dependencia "
                        + "where solicitud.Dependencia_codigo = dependencia.codigo "
                        + "AND dependencia.nombre = '%s' ";
            }
            if (!l.isEmpty()) {
                boolean fla = false;
                sql = sql.concat("AND (");
                if (l.contains("Recibida")) {
                    sql = sql.concat(" solicitud.estado = 'Recibida' ");
                    fla = true;
                }
                if (l.contains("PorVerificar")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'PorVerificar' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'PorVerificar' ");
                        fla = true;
                    }
                }
                if (l.contains("Procesada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Procesada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Procesada' ");
                        fla = true;
                    }
                }
                if (l.contains("Rechazada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Rechazada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Rechazada' ");
                        fla = true;
                    }
                }
                sql = sql.concat(")");
            }
            if (filtro.getNumsol() != 0) {
                sql = String.format(sql, dep, filtro.getNumsol());
            } else {
                sql = String.format(sql, dep);
            }
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public List<Solicitud> SolicitudSearchFunc(Solicitud filtro, List<String> l) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql;
            if (filtro.getNumsol() != 0) {
                sql = "select * from solicitud"
                        + " WHERE solicitud.numsol = '%d'";
            } else {
                sql = "select * from solicitud ";
            }
            if (!l.isEmpty()) {
                boolean fla = false;
                if (filtro.getNumsol() != 0) {
                    sql = sql.concat("AND (");
                } else {
                    sql = sql.concat("where ");
                }
                if (l.contains("Recibida")) {
                    sql = sql.concat(" solicitud.estado = 'Recibida' ");
                    fla = true;
                }
                if (l.contains("PorVerificar")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'PorVerificar' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'PorVerificar' ");
                        fla = true;
                    }
                }
                if (l.contains("Procesada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Procesada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Procesada' ");
                        fla = true;
                    }
                }
                if (l.contains("Rechazada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Rechazada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Rechazada' ");
                    }
                }
                if (filtro.getNumsol() != 0) {
                    sql = sql.concat(" )");
                }
            }
            if (filtro.getNumsol() != 0) {
                sql = String.format(sql, filtro.getNumsol());
            }
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;

    }

    public List<Solicitud> searchSolicitudbyFuncionario(Funcionario filtro) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql = "select * from solicitud "
                    + "where registrador = '%s'";
            sql = String.format(sql, filtro.getId());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public List<Solicitud> SolicitudGetAllbyAdministrador(List<String> l, String dep) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql = "select * from solicitud,dependencia "
                    + "where solicitud.Dependencia_codigo = dependencia.codigo "
                    + "AND dependencia.nombre = '%s' ";
            if (!l.isEmpty()) {
                boolean fla = false;
                sql = sql.concat("AND (");
                if (l.contains("Recibida")) {
                    sql = sql.concat(" solicitud.estado = 'Recibida' ");
                    fla = true;
                }
                if (l.contains("PorVerificar")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'PorVerificar' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'PorVerificar' ");
                        fla = true;
                    }
                }
                if (l.contains("Procesada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Procesada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Procesada' ");
                        fla = true;
                    }
                }
                if (l.contains("Rechazada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Rechazada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Rechazada' ");
                        fla = true;
                    }
                }
                sql = sql.concat(")");
            }
            sql = String.format(sql, dep);
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public List<Solicitud> SolicitudGetAll() {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "SELECT * FROM solicitud";
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public List<Solicitud> SolicitudGetAllSecretaria() {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud where estado = 'porVerificar' or estado = 'rechazada' or estado = 'recibida';";
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }
        
        public List<Solicitud> SolicitudGetAllJefeOccb() {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud where estado = 'porVerificar';";
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public List<Solicitud> buscarPorCodigo(String codigo) {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "SELECT * FROM solicitud where numcomp like '%%%s%%'";
            sql = String.format(sql, codigo);
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public List<Solicitud> buscarPorCodigoSecretaria(String codigo) {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud where numcomp like '%%%s%%' and "
                    + "(estado = 'porVerificar' or estado = 'rechazada' or estado = 'recibida');";
            sql = String.format(sql, codigo);
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }
        
                public List<Solicitud> buscarPorCodigoJefeOccb(String codigo) {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud where numcomp like '%%%s%%' and estado = 'porVerificar';";
            sql = String.format(sql, codigo);
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public List<Solicitud> searchsolicitudesRegistrador(String codigo, Funcionario F) {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud "
                    + "where numcomp like '%%%s%%' "
                    + "and registrador = '%s'  "
                    + "and (estado = 'PorVerificar' "
                    + "or estado = 'Procesada' "
                    + "or estado = 'Etiquetado');";
            sql = String.format(sql, codigo,F.getId());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }
    
    public List<Solicitud> searchsolicitudesRegistrador(Funcionario F) {
        List<Solicitud> estados = new ArrayList<>();
        try {
            String sql = "select * from solicitud "
                    + "where registrador = '%s'  "
                    + "and (estado = 'PorVerificar' "
                    + "or estado = 'Procesada' "
                    + "or estado = 'Etiquetado')";
            sql = String.format(sql, F.getId());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                estados.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public List<Solicitud> solicitudRegistradorGetAl(List<String> l, Funcionario F) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql = "select * from solicitud,funcionario "
                    + "where solicitud.registrador = funcionario.id "
                    + "AND funcionario.nombre = '%s'";
            if (!l.isEmpty()) {
                boolean fla = false;
                sql = sql.concat("AND (");
                if (l.contains("Recibida")) {
                    sql = sql.concat(" solicitud.estado = 'Recibida' ");
                    fla = true;
                }
                if (l.contains("PorVerificar")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'PorVerificar' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'PorVerificar' ");
                        fla = true;
                    }
                }
                if (l.contains("Procesada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Procesada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Procesada' ");
                        fla = true;
                    }
                }
                if (l.contains("Rechazada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Rechazada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Rechazada' ");
                        fla = true;
                    }
                }
                sql = sql.concat(")");
            }
            sql = String.format(sql, F.getNombre());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public List<Solicitud> SolicitudSearchRegis(Solicitud filtro, List<String> l, Funcionario F) {
        List<Solicitud> resultado = new ArrayList<>();
        try {
            String sql;
            if (filtro.getNumsol() != 0) {
                sql = "select * from solicitud,funcionario "
                        + "where solicitud.registrador = funcionario.id "
                        + "AND funcionario.nombre = '%s' AND solicitud.numsol = '%d'";
            } else {
                sql = "select * from solicitud,funcionario "
                        + "where solicitud.registrador = funcionario.id "
                        + "AND funcionario.nombre = '%s'  ";
            }
            if (!l.isEmpty()) {
                boolean fla = false;
                sql = sql.concat("AND (");
                if (l.contains("Recibida")) {
                    sql = sql.concat(" solicitud.estado = 'Recibida' ");
                    fla = true;
                }
                if (l.contains("PorVerificar")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'PorVerificar' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'PorVerificar' ");
                        fla = true;
                    }
                }
                if (l.contains("Procesada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Procesada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Procesada' ");
                        fla = true;
                    }
                }
                if (l.contains("Rechazada")) {
                    if (fla) {
                        sql = sql.concat(" OR solicitud.estado = 'Rechazada' ");
                    } else {
                        sql = sql.concat(" solicitud.estado = 'Rechazada' ");
                    }
                }
                sql = sql.concat(")");
            }
            if (filtro.getNumsol() != 0) {
                sql = String.format(sql, F.getNombre(), filtro.getNumsol());
            } else {
                sql = String.format(sql, F.getNombre());
            }
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(solicitud(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public Solicitud SolicitudGet(Integer numSolicitud) throws Exception {
        return new Solicitud();
    }

    public void SolicitudDelete(Solicitud a) throws Exception {
    }

    public void SolicitudAdd(Solicitud a) throws Exception {

        String sql = "INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq)"
                + " VALUES ('%s', '%d-%d-%d', '%d', '%f','%s', '%s', '%s', '%s')";
        sql = String.format(sql, a.getNumcomp(), a.getFecha().getYear() + 1900, a.getFecha().getMonth() + 1, a.getFecha().getDate(), a.getCantbien(), a.getMontotal(), a.getRazonR(), a.getEstado(), a.getDependencia().getCodigo(), a.getTipoadq()
        );
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Solicitud  ya existe");
        }
    }

    public int getAutoIncrementoSolicitud() throws Exception {
        try {
            String sql = "SELECT LAST_INSERT_ID()";
            ResultSet rs = db.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("LAST_INSERT_ID()");
            } else {
                throw new Exception("Solicitud no Existe");
            }
        } catch (SQLException ex) {
            return -1;
        }
    }

    public void actulizarSoliEditada(Solicitud s) throws Exception {
        String sql = "UPDATE solicitud SET solicitud.numcomp = '%s', solicitud.fecha = '%d-%d-%d', "
                + "solicitud.razonr = '%s', solicitud.estado = '%s', solicitud.tipoadq = '%s'"
                + " WHERE solicitud.numsol = '%d'";
        sql = String.format(sql, s.getNumcomp(), s.getFecha().getYear() + 1900, s.getFecha().getMonth() + 1, s.getFecha().getDate(), s.getRazonR(), s.getEstado(), s.getTipoadq(), s.getNumsol());
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Solicitud  ya existe");
        }
    }

    public void SolicitudUpdate(Solicitud s) throws Exception {
        String sql = "UPDATE solicitud SET solicitud.estado = '%s', solicitud.registrador = '%s' WHERE solicitud.numsol = '%d'";
        sql = String.format(sql, s.getEstado(), s.getFuncionario().getId(), s.getNumsol());
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Solicitud  ya existe");
        }
    }

    public void SolicitudUpdate2(Solicitud s) throws Exception {
        String sql = "UPDATE solicitud SET solicitud.estado = '%s' WHERE solicitud.numsol = '%d'";
        sql = String.format(sql, s.getEstado(), s.getNumsol());
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Solicitud  ya existe");
        }
    }
    //</editor-fol

    //  <editor-fold desc="Bien" defaultstate="collapsed">
    public Bien getBien(String serial) throws Exception {
        String sql = "select * from Bien inner where serial='%s'";
        sql = String.format(sql, serial);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            return bien(rs);
        } else {
            throw new Exception("Solicitud no Existe");
        }
    }

    private Bien bien(ResultSet rs) {
        try {
            Bien ec = new Bien();
            ec.setID(rs.getInt("ID"));
            ec.setSerial(rs.getString("serial"));
            ec.setCantidad(rs.getInt("cantidad"));
            ec.setDescripcion(rs.getString("descripcion"));
            ec.setModelo(rs.getString("modelo"));
            ec.setMarca(rs.getString("marca"));
            ec.setPrecioU(rs.getDouble("precioU"));
            if (rs.getString("categoria") != null) {
                ec.setCategoria(getcategoria(rs.getString("categoria")));
            }
            return ec;
        } catch (SQLException ex) {
            return null;
        } catch (Exception ex) {
            return null;
        }
    }

    public List<Bien> BienSearch(Bien filtro) {
        List<Bien> resultado = new ArrayList<>();
        try {
            String sql = "select * from "
                    + "Bien "
                    + "where descripcion like '%%%s%%'";
            sql = String.format(sql, filtro.getDescripcion());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bien(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    public List<Bien> getbienes(Solicitud s) {
        List<Bien> bienes = new ArrayList<>();
        try {
            String sql = "select * from bien WHERE bien.solicitud = '%d'";
            sql = String.format(sql, s.getNumsol());
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                bienes.add(bien(rs));
            }
        } catch (SQLException ex) {
        }
        return bienes;
    }

    public List<Bien> BienGetAll() {
        List<Bien> bienes = new ArrayList<>();
        try {
            String sql = "select * from Bien";
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                bienes.add(bien(rs));
            }
        } catch (SQLException ex) {
        }
        return bienes;
    }

    public Bien BienGet(int id) throws Exception {
        return new Bien();
    }

    public void addBienPreservar(Bien a) throws Exception {
        String sql = " insert into bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud)"
                + "VALUES ('%s', '%s', '%s', '%s', '%f', '%d', '%d')";
        sql = String.format(sql, a.getSerial(), a.getDescripcion(), a.getMarca(), a.getModelo(), a.getPrecioU(),
                a.getCantidad(), a.getSolicitud().getNumsol());
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Bien ya existe");
        }
    }

    public void borrarBien(Bien b) throws Exception {
        String sql = "DELETE FROM bien WHERE bien.ID = %d;";
        sql = String.format(sql, b.getID());
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Bien ya existe");
        }
    }
    
    public void BienUpdateCat(int bien, String categ) throws Exception {
        String sql = "update bien set categoria='%s' "
                + "where Id='%d'";
        sql = String.format(sql, categ, bien);
        int count = db.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Bien no existe");
        }
    }

    //</editor-fold>
    //  <editor-fold desc="Categoria" defaultstate="collapsed">
    public Categoria getcategoria(String s) throws Exception {
        String sql = "SELECT * FROM categoria where categoria.id = '%s';";
        sql = String.format(sql, s);
        ResultSet rs = db.executeQuery(sql);
        if (rs.next()) {
            return categoria(rs);
        } else {
            throw new Exception("Solicitud no Existe");
        }

    }

    private Categoria categoria(ResultSet rs) {
        try {
            Categoria ca = new Categoria();
            ca.setId(rs.getString("id"));
            ca.setIncremento(rs.getInt("incremento"));
            ca.setDescripcion(rs.getString("descripcion"));
            return ca;
        } catch (SQLException ex) {
            return null;
        }
    }
    //</editor-fold>

    public void close() {
    }

}
