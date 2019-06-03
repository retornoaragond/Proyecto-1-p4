/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.data;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import activos.logic.Activo;
import activos.logic.Bien;
import activos.logic.Categoria;
import activos.logic.Dependencia;
import activos.logic.Funcionario;
import activos.logic.Labor;

/**
 *
 * @author Estudiante
 */
public class DaoActivos {

    RelDatabase dbbb;

    public DaoActivos() {
        dbbb = new RelDatabase();
    }

    public Activo getActivo(String codigoId) throws Exception {
        String sql = "select * from activo inner where codigoId='%s'";
        sql = String.format(sql, codigoId);
        ResultSet rs = dbbb.executeQuery(sql);
        if (rs.next()) {
            return activo(rs);
        } else {
            throw new Exception("Activo no Existe");
        }
    }

    private Activo activo(ResultSet rs) {
        try {
            Bien b = new Bien();
            b.setID(Integer.parseInt(rs.getString("bien_id")));
            b.setSerial(rs.getString("serial"));
            b.setDescripcion(rs.getString("descripcion"));
            b.setMarca(rs.getString("marca"));
            b.setModelo(rs.getString("modelo"));
            b.setPrecioU(Integer.parseInt(rs.getString("precioU")));
            b.setCantidad(Integer.parseInt(rs.getString("cantidad")));
            /*solicitud*/
            Categoria cat = new Categoria();
            cat.setId(rs.getString("id"));
            cat.setDescripcion(rs.getString("c.descripcion"));

            b.setCategoria(cat);

            Activo ec = new Activo();
            ec.setCodigoId(rs.getString("codigoId"));
            ec.setBien(b);

            return ec;
        } catch (SQLException ex) {
            return null;
        }
    }

    public List<Activo> ActivoSearch(Activo filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "select a.bien_id, b.serial, b.descripcion, "
                       + "b.marca, b.modelo, b.precioU, b.cantidad, c.id, c.descripcion, a.codigoId "
                       + "from activo a, bien b, categoria c "
                       + "where a.bien_id = b.id  and b.categoria = c.id and b.descripcion like '%%%s%%'";
            sql = String.format(sql, filtro.getCodigoId());
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(activo(rs));
            }
        } catch (SQLException ex) {
        }

        return resultado;
    }

    ////arreglar inner jpin
    public List<Activo> ActivoSearchCategoria(String filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "SELECT activo.codigoId activocodigo, "
                    + "labor.id laborid, bien.serial bienserial,"
                    + " funcionario.id funcionarioid,"
                    + " funcionario.nombre funcionarionombre,"
                    + " dependencia.codigo dependenciacodigo,"
                    + " bien.descripcion biendescripcion, "
                    + "categoria.id categoriaid, "
                    + "categoria.descripcion categoriadescripcion,"
                    + " dependencia.nombre dependencianombre "
                    + "FROM activo "
                    + "INNER JOIN labor ON activo.labAct = labor.id "
                    + "INNER JOIN bien ON bien.serial = activo.bienAct "
                    + "INNER JOIN categoria ON bien.categoria = categoria.id "
                    + "INNER JOIN dependencia ON labor.depLab = dependencia.codigo "
                    + "INNER JOIN funcionario ON funcionario.id= labor.funcLab  "
                    + "WHERE categoria.descripcion LIKE '%%%s%%'";
            sql = String.format(sql, filtro);
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bigActivo(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    public List<Activo> ActivoSearchCodigo(String filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "SELECT activo.codigoId activocodigo, "
                    + "labor.id laborid, bien.serial bienserial,"
                    + " funcionario.id funcionarioid,"
                    + " funcionario.nombre funcionarionombre,"
                    + " dependencia.codigo dependenciacodigo,"
                    + " bien.descripcion biendescripcion, "
                    + "categoria.id categoriaid, "
                    + "categoria.descripcion categoriadescripcion,"
                    + " dependencia.nombre dependencianombre "
                    + "FROM activo "
                    + "INNER JOIN labor ON activo.labAct = labor.id "
                    + "INNER JOIN bien ON bien.serial = activo.bienAct "
                    + "INNER JOIN categoria ON bien.categoria = categoria.id "
                    + "INNER JOIN dependencia ON labor.depLab = dependencia.codigo "
                    + "INNER JOIN funcionario ON funcionario.id= labor.funcLab  "
                    + "WHERE activo.codigoId LIKE '%%%s%%';";
            sql = String.format(sql, filtro);
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bigActivo(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    ///hacer innerjoijn
    public List<Activo> ActivoSearchDependencia(String filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "SELECT activo.codigoId activocodigo, "
                    + "labor.id laborid, bien.serial bienserial,"
                    + " funcionario.id funcionarioid,"
                    + " funcionario.nombre funcionarionombre,"
                    + " dependencia.codigo dependenciacodigo,"
                    + " bien.descripcion biendescripcion, "
                    + "categoria.id categoriaid, "
                    + "categoria.descripcion categoriadescripcion,"
                    + " dependencia.nombre dependencianombre "
                    + "FROM activo "
                    + "INNER JOIN labor ON activo.labAct = labor.id "
                    + "INNER JOIN bien ON bien.serial = activo.bienAct "
                    + "INNER JOIN categoria ON bien.categoria = categoria.id "
                    + "INNER JOIN dependencia ON labor.depLab = dependencia.codigo "
                    + "INNER JOIN funcionario ON funcionario.id= labor.funcLab  "
                    + "WHERE dependencia.nombre LIKE '%%%s%%';";
            sql = String.format(sql, filtro);
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bigActivo(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    public List<Activo> ActivoSearchDescripcion(String filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "SELECT activo.codigoId activocodigo, "
                    + "labor.id laborid, bien.serial bienserial,"
                    + " funcionario.id funcionarioid,"
                    + " funcionario.nombre funcionarionombre,"
                    + " dependencia.codigo dependenciacodigo,"
                    + " bien.descripcion biendescripcion, "
                    + "categoria.id categoriaid, "
                    + "categoria.descripcion categoriadescripcion,"
                    + " dependencia.nombre dependencianombre "
                    + "FROM activo "
                    + "INNER JOIN labor ON activo.labAct = labor.id "
                    + "INNER JOIN bien ON bien.serial = activo.bienAct "
                    + "INNER JOIN categoria ON bien.categoria = categoria.id "
                    + "INNER JOIN dependencia ON labor.depLab = dependencia.codigo "
                    + "INNER JOIN funcionario ON funcionario.id= labor.funcLab  "
                    + "WHERE bien.descripcion LIKE '%%%s%%'";
            sql = String.format(sql, filtro);
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bigActivo(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    public List<Activo> ActivoSearchResponsable(String filtro) {
        List<Activo> resultado = new ArrayList<>();
        try {
            String sql = "SELECT activo.codigoId activocodigo, "
                    + "labor.id laborid,"
                    + " bien.serial bienserial,"
                    + " funcionario.id funcionarioid,"
                    + " funcionario.nombre funcionarionombre,"
                    + " dependencia.codigo dependenciacodigo,"
                    + " bien.descripcion biendescripcion, "
                    + "categoria.id categoriaid, "
                    + "categoria.descripcion categoriadescripcion,"
                    + " dependencia.nombre dependencianombre "
                    + "FROM activo "
                    + "INNER JOIN labor ON activo.labAct = labor.id "
                    + "INNER JOIN bien ON bien.serial = activo.bienAct "
                    + "INNER JOIN categoria ON bien.categoria = categoria.id "
                    + "INNER JOIN dependencia ON labor.depLab = dependencia.codigo "
                    + "INNER JOIN funcionario ON funcionario.id= labor.funcLab  "
                    + "WHERE funcionario.nombre LIKE '%%%s%%'";
            sql = String.format(sql, filtro);
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                resultado.add(bigActivo(rs));
            }
        } catch (SQLException ex) {
        }
        return resultado;
    }

    private Activo bigActivo(ResultSet rs) {
        try {
            Activo ac = new Activo();
            Categoria ca = new Categoria();
            Bien bi = new Bien();
            Dependencia de = new Dependencia();
            Funcionario fu = new Funcionario();
            Labor la = new Labor();
            //activo
            ac.setCodigoId(rs.getString("activocodigo"));
            ac.setBien(bi);
            ac.setLabor(la);
            //categoria
            ca.setId(rs.getString("categoriaid"));
            ca.setDescripcion(rs.getString("categoriadescripcion"));
            //bien
            bi.setSerial(rs.getString("bienserial"));
            bi.setCategoria(ca);
            bi.setDescripcion(rs.getString("biendescripcion"));
            //dependencia
            de.setCodigo(rs.getString("dependenciacodigo"));
            de.setNombre(rs.getString("dependencianombre"));
            //funcionario
            fu.setId(rs.getString("funcionarioid"));
            fu.setNombre(rs.getString("funcionarionombre"));
            //labor
            la.setId(rs.getInt("laborid"));
            la.setDependencia(de);
            la.setFuncionario(fu);
            return ac;
        } catch (SQLException ex) {
            return null;
        }
    }

    private Activo MiddleActivo(ResultSet rs) {
        try {
            Activo ac = new Activo();
            Categoria ca = new Categoria();
            Bien bi = new Bien();
            Dependencia de = new Dependencia();
            Funcionario fu = new Funcionario();
            Labor la = new Labor();
            //activo
            ac.setCodigoId(rs.getString("activocodigo"));
            ac.setBien(bi);
            ac.setLabor(la);
            //categoria
            ca.setId(rs.getString("categoriaid"));
            ca.setDescripcion(rs.getString("categoriadescripcion"));
            //bien
            bi.setSerial(rs.getString("bienserial"));
            bi.setCategoria(ca);
            bi.setDescripcion(rs.getString("biendescripcion"));
            //dependencia
            de.setCodigo(rs.getString("dependenciacodigo"));
            de.setNombre(rs.getString("dependencianombre"));
            //funcionario
            fu.setId(rs.getString("funcionarioid"));
            fu.setNombre(rs.getString("funcionarionombre"));
            //labor
            if (la.getId() != 0) {
                la.setId(rs.getInt("laborid"));
            }
            la.setDependencia(de);
            la.setFuncionario(fu);
            return ac;
        } catch (SQLException ex) {
            return null;
        }
    }

    public List<Activo> ActivosGetAll() {
        List<Activo> estados = new ArrayList<>();
        try {
            String sql = "select a.bien_id, b.serial, b.descripcion, "
                       + "b.marca, b.modelo, b.precioU, b.cantidad, c.id, c.descripcion, a.codigoId "
                       + "from activo a, bien b, categoria c "
                       + " where a.bien_id = b.id  and b.categoria = c.id";
            ResultSet rs = dbbb.executeQuery(sql);
            while (rs.next()) {
                estados.add(activo(rs));
            }
        } catch (SQLException ex) {
        }
        return estados;
    }

    public Activo ActivoGet(String codigoId) throws Exception {
        String sql = "SELECT * FROM dependencia WHERE codigoId='%s'";
        sql = String.format(sql, codigoId);
        ResultSet rs = dbbb.executeQuery(sql);
        if (rs.next()) {
            return activo(rs);
        } else {
            throw new Exception("Activo no Existe");
        }
    }

    public void ActivoDelete(Activo a) throws Exception {
        String sql = "delete from activo where codigoId='%s'";
        sql = String.format(sql, a.getCodigoId());
        int count = dbbb.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Activo no existe");
        }
    }

    public void ActivoAdd(String b, int c) throws Exception {
        String sql = "insert into activo (codigoId,bien_ID)"
                + "values('%s','%d')";
        sql = String.format(sql, b, c);
        int count = dbbb.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Activo ya existe");
        }
    }

    public void ActivoUpdate(Activo a) throws Exception {
        String sql = "update activo set labAct='%d',bienAct='%s'"
                + "where codigoId='%s'";
        sql = String.format(sql, a.getLabor().getId(), a.getBien().getSerial(), a.getCodigoId());
        int count = dbbb.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Activo no existe");
        }
    }
    
    public void ActivoUpdate(String a, int l) throws Exception {
        String sql = "update activo set labAct='%d' "
                + "where codigoId='%s'";
        sql = String.format(sql, l,a);
        int count = dbbb.executeUpdate(sql);
        if (count == 0) {
            throw new Exception("Activo no existe");
        }
    }

    public void close() {
    }

}
