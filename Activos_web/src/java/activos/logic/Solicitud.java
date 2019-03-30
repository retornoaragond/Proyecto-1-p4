package activos.logic;
// Generated 30/10/2018 04:12:49 AM by Hibernate Tools 4.3.1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Solicitud generated by hbm2java
 */
public class Solicitud implements java.io.Serializable {

    private Integer numsol;
    private Dependencia dependencia;
    private Funcionario funcionario;
    private String numcomp;
    private Date fecha;
    private int cantbien;
    private double montotal;
    private String razonR;
    private String estado;
    private String tipoadq;
    private Set biens = new HashSet(0);

    public Solicitud() {
        numsol = 0;
        dependencia = new Dependencia();
        funcionario = new Funcionario();
        numcomp = "";
        fecha = new Date();
        cantbien = 0;
        montotal = 0;
        razonR = "";
        estado = "";
        tipoadq = "";
    }

    public Solicitud(Dependencia dependencia, String numcomp, Date fecha, int cantbien, double montotal, String razonR, String estado, String tipoadq) {
        this.dependencia = dependencia;
        this.numcomp = numcomp;
        this.fecha = fecha;
        this.cantbien = cantbien;
        this.montotal = montotal;
        this.razonR = razonR;
        this.estado = estado;
        this.tipoadq = tipoadq;
    }

    public Solicitud(Dependencia dependencia, Funcionario funcionario, String numcomp, Date fecha, int cantbien, double montotal, String razonR, String estado, String tipoadq, Set biens) {
        this.dependencia = dependencia;
        this.funcionario = funcionario;
        this.numcomp = numcomp;
        this.fecha = fecha;
        this.cantbien = cantbien;
        this.montotal = montotal;
        this.razonR = razonR;
        this.estado = estado;
        this.tipoadq = tipoadq;
        this.biens = biens;
    }

    public Integer getNumsol() {
        return this.numsol;
    }

    public void setNumsol(Integer numsol) {
        this.numsol = numsol;
    }

    public Dependencia getDependencia() {
        return this.dependencia;
    }

    public void setDependencia(Dependencia dependencia) {
        this.dependencia = dependencia;
    }
    
    public String getCodDependencia(){
        return dependencia.getCodigo();
    }

    public Funcionario getFuncionario() {
        return this.funcionario;
    }

    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
    }

    public String getNumcomp() {
        return this.numcomp;
    }

    public void setNumcomp(String numcomp) {
        this.numcomp = numcomp;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getCantbien() {
        return this.cantbien;
    }

    public void setCantbien(int cantbien) {
        this.cantbien = cantbien;
    }

    public double getMontotal() {
        return this.montotal;
    }

    public void setMontotal(double montotal) {
        this.montotal = montotal;
    }

    public String getRazonR() {
        return this.razonR;
    }

    public void setRazonR(String razonR) {
        this.razonR = razonR;
    }

    public String getEstado() {
        return this.estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTipoadq() {
        return this.tipoadq;
    }

    public void setTipoadq(String tipoadq) {
        this.tipoadq = tipoadq;
    }

    public Set getBiens() {
        return this.biens;
    }

    public void setBiens(Set biens) {
        this.biens = biens;
    }

}
