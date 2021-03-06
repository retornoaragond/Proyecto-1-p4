/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.solicitud.create;

import activos.logic.Bien;
import activos.logic.Dependencia;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import activos.logic.Usuario;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ExtremeTech
 */
@WebServlet(name = "presentation.solicitud.create", urlPatterns = {"/presentation/solicitud/create",
    "/presentation/solicitud/agregarBien",
    "/presentation/solicitud/listadoBien",
    "/presentation/solicitud/agregarSolicitud",
    "/presentation/solicitud/mostrarEditar"})

public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        if (request.getServletPath().equals("/presentation/solicitud/create")) {
            this.create(request, response);
        } else if (request.getServletPath().equals("/presentation/solicitud/agregarBien")) {
            this.agregarBien(request, response);
        } else if (request.getServletPath().equals("/presentation/solicitud/agregarSolicitud")) {
            try {
                this.guardar(request, response);
            } catch (Exception ex) {
                System.out.println(" " + ex.getMessage());
            }
        } else if (request.getServletPath().equals("/presentation/solicitud/mostrarEditar")) {
            this.mostrarEditar(request, response);
        }
    }
    

    protected void create(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (this.verificar(request)) {
            Usuario logged = (Usuario) request.getSession(true).getAttribute("logged");
            Bien b = new Bien();
            Solicitud soli = new Solicitud();
            String habilitado = "false";
            String modo = "agregar";
            request.getSession(true).setAttribute("model2", b);
            request.getSession(true).setAttribute("loggeado", logged);
            request.getSession(true).setAttribute("habilitado", habilitado);
            request.getSession(true).setAttribute("solicitud", soli);
            request.getSession(true).setAttribute("modo", modo);
            request.getSession(true).setAttribute("listaBien",null);
            request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    protected void agregarBien(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (this.verificar(request)) {
            Map<String, String> errors = this.validar(request);
            if (errors.isEmpty()) {
                Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
                Bien model = new Bien();
                updateModel(model, request);
                List<Bien> r = new ArrayList<>();
                if ((ArrayList<Bien>) request.getSession(true).getAttribute("listaBien") == null) {
                    request.getSession(true).setAttribute("listaBien", r);
                    r.add(model);
                } else {
                    r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
                    r.add(model);
                }
                String habilitado = "true";
                request.getSession(true).setAttribute("habilitado", habilitado);
                request.getSession(true).setAttribute("listaBien", r);
                request.getSession(true).setAttribute("loggeado", logged);
                request.setAttribute("model", r);
                request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
            } else {
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    protected void listadoBien(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (this.verificar(request)) {
            Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
            List<Bien> r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
            request.getSession(true).setAttribute("loggeado", logged);
            request.setAttribute("model", r);
            request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    protected void guardar(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException, Exception {
        if ("agregar".equals(request.getSession().getAttribute("modo"))) {
            agregarSolicitud(request, response);
        } else if ("editar".equals(request.getSession().getAttribute("modo"))) {
            actualizar(request, response);
        }
        HttpSession session = request.getSession(true);
        session.removeAttribute("listaBien");
        session.removeAttribute("model2");
        session.removeAttribute("habilitado");
        session.removeAttribute("solicitud");
        session.removeAttribute("modo");
        request.getRequestDispatcher("/presentation/solicitud/listado").forward(request, response);
    }

    protected void agregarSolicitud(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException, Exception {
        if (this.verificar(request)) {
            Map<String, String> errors = this.validarSol(request);
            if (errors.isEmpty()) {
                Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
                Solicitud model = new Solicitud();
                updateModelSolicitud(model, request);

                ModelLogic.instance().addSolicitud(model);
                List<Bien> r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
                model.setNumsol(ModelLogic.instance().getAutoIncrementoSolicitud());
                for (Bien b : r) {
                    try {
                        b.setSolicitud(model);
                        ModelLogic.instance().addBienPreservar(b);
                    } catch (Exception ex) {
                        String msj = ex.getMessage();
                        System.out.println(" " + msj);
                    }
                }
                HttpSession session = request.getSession(true);
                session.removeAttribute("listaBien");
                request.getSession(true).setAttribute("loggeado", logged);
                request.getRequestDispatcher("/presentation/solicitud/listado").forward(request, response);
            } else {
                request.setAttribute("errors2", errors);
                request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    void updateModelSolicitud(Solicitud model, HttpServletRequest request) {
        try {
            Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
            List<Bien> r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");

            model.setDependencia(logged.getLabor().getDependencia());
            model.setFuncionario(logged.getLabor().getFuncionario());
            model.setNumcomp(request.getParameter("campoNumcomp"));
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = format.parse(request.getParameter("campoFechaAdq"));
            model.setFecha(parsed);
            model.setCantbien(calcularCantBienes(r));
            model.setMontotal(calcularMontoTotal(r));
            model.setEstado("Recibida");
            model.setTipoadq(request.getParameter("options"));
            Set<Bien> hSet = new HashSet<>();
            for (Bien x : r) {
                hSet.add(x);
            }

            model.setBiens(hSet);
        } catch (ParseException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int calcularMontoTotal(List<Bien> r) {
        int suma = 0;
        for (Bien b : r) {
            suma += (b.getPrecioU() * b.getCantidad());
        }
        return suma;
    }

    public int calcularCantBienes(List<Bien> r) {
        int suma = 0;
        for (Bien b : r) {
            suma += b.getCantidad();
        }
        return suma;
    }

    void updateModel(Bien model, HttpServletRequest request) {
        model.setSerial(request.getParameter("serial"));
        model.setDescripcion(request.getParameter("desc"));
        model.setMarca(request.getParameter("marca"));
        model.setModelo(request.getParameter("mod"));
        Double num = Double.parseDouble(request.getParameter("precio"));
        model.setPrecioU(num);
        int entero = Integer.parseInt(request.getParameter("cant"));
        model.setCantidad(entero);
    }

    boolean verificar(HttpServletRequest request) {
        if (request.getSession(true).getAttribute("loggeado") == null) {
            return false;
        }
        return true;
    }

    Map<String, String> validar(HttpServletRequest request) {
        Map<String, String> errores = new HashMap<>();
        if (request.getParameter("serial").isEmpty()) {
            errores.put("serial", "Serial requerido");
        } else {
            List<Bien> r = new ArrayList<>();
            Bien model = new Bien();
            model.setSerial(request.getParameter("serial"));
            if ((ArrayList<Bien>) request.getSession(true).getAttribute("listaBien") != null) {
                r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
                for (Bien b : r) {
                    if (model.getSerial().equals(b.getSerial())) {
                        errores.put("serial", "Serial repetido");
                        break;
                    }
                }
            }
        }

        if (request.getParameter("desc").isEmpty()) {
            errores.put("desc", "Descripcion requerida");
        }

        if (request.getParameter("marca").isEmpty()) {
            errores.put("marca", "Marca requerida");
        }

        if (request.getParameter("mod").isEmpty()) {
            errores.put("mod", "Modelo requerido");
        }

        if (request.getParameter("precio").isEmpty()) {
            errores.put("precio", "Precio requerido");
        } else {
            try {
                double p = Double.parseDouble(request.getParameter("precio"));
                if (p <= 0) {
                    errores.put("precio", "Mayor que 0");
                }
            } catch (NumberFormatException e) {
                errores.put("precio", "Debe ser un numero");
            }
        }

        if (request.getParameter("cant").isEmpty()) {
            errores.put("cant", "Catidad requerida");
        } else {
            try {
                int c = Integer.parseInt(request.getParameter("cant"));
                if (c <= 0) {
                    errores.put("cant", "Mayor que 0");
                }
            } catch (NumberFormatException e) {
                errores.put("cant", "Debe ser un numero");
            }
        }
        return errores;
    }

    Map<String, String> validarSol(HttpServletRequest request) {
        Map<String, String> errores = new HashMap<>();
        if (request.getParameter("campoNumcomp").isEmpty()) {
            errores.put("campoNumcomp", "N° de comprobante requerido");
        }
        if (request.getParameter("campoFechaAdq").isEmpty()) {
            errores.put("campoFechaAdq", "Fecha requerida");
        }
        if (request.getParameter("options") == null) {
            errores.put("options", "Tipo requerido");
        }
        return errores;
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        Solicitud sol = (Solicitud) request.getSession(true).getAttribute("solicitud");
        List<Bien> originales = new ArrayList<>();
        Set<Bien> hSet = sol.getBiens();
        for (Bien x : hSet) {
            originales.add(x);
        }
        List<Bien> cambiados = (List<Bien>) request.getSession(true).getAttribute("listaBien");
        
        sol.setNumcomp(request.getParameter("campoNumcomp"));
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date parsed = format.parse(request.getParameter("campoFechaAdq"));
        sol.setFecha(parsed);
        sol.setTipoadq((String) request.getParameter("options"));
        try {
            ModelLogic.instance().actualizarSoliEditada(sol);
        } catch (Exception ex) {
        }

        //if (originales.size() != cambiados.size()) {
            // se revisa si se agrego un nuevo bien
            for (Bien b : cambiados) {
                if (!originales.contains(b)) {
                    try {
                        //insertar en la base
                        b.setSolicitud(sol);
                        ModelLogic.instance().addBienPreservar(b);
                    } catch (Exception ex) {
                        Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    originales.add(b);
                }
            }
            // se revisa si se borro un bien
            for (Bien b : originales) {
                if (!cambiados.contains(b)) {
                    try {
                        //borrar en la base
                        ModelLogic.instance().borrarBien(b);
                    } catch (Exception ex) {
                        Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    originales.remove(b);
                }
            }
        //}

    }

    protected void mostrarEditar(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (this.verificar(request)) {
            Solicitud model = new Solicitud();
            updateModelEdicion(model, request);
            Solicitud modelConsultar = null;
            Bien b = new Bien();
            String habilitado = "true";
            List<Bien> r = new ArrayList<>();
            String modo = "editar";
            try {
                modelConsultar = ModelLogic.instance().findSolicitudnumComp(model);
                Set<Bien> hSet = modelConsultar.getBiens();
                for (Bien x : hSet) {
                    r.add(x);
                }
            } catch (Exception ex) {
                
            }
            request.getSession(true).setAttribute("model2", b);
            request.getSession(true).setAttribute("solicitud", modelConsultar);
            request.getSession(true).setAttribute("listaBien", r);
            request.getSession(true).setAttribute("habilitado", habilitado);
            request.getSession(true).setAttribute("modo", modo);
            request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    void updateModelEdicion(Solicitud model, HttpServletRequest request) {
        model.setNumcomp(request.getParameter("numcomp"));
        String id = request.getParameter("codDep");
        Dependencia d = new Dependencia();
        d.setCodigo(id);
        model.setDependencia(d);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
