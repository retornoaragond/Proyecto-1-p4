/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.solicitud.create;

import activos.logic.Bien;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import activos.logic.Usuario;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
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
                                                                   "/presentation/solicitud/agregarSolicitud"})
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
                this.agregarSolicitud(request, response);
            } catch (Exception ex) {
                System.out.println(" " + ex.getMessage());
            }
        }

    }

    protected void agregarBien(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
        Bien model = new Bien();
        updateModel(model, request);
        List<Bien> r = new ArrayList<>();
        if ((ArrayList<Bien>) request.getSession(true).getAttribute("listaBien") == null) {
            boolean existe = false;
            for (Bien b : r) {
                if (model.getSerial().equals(b.getSerial())) {
                    existe = true;
                    break;
                }
            }
            if (!existe) {
                r.add(model);
            }
            request.getSession(true).setAttribute("listaBien", r);
        } else {
            r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
            boolean existe = false;
            for (Bien b : r) {
                if (model.getSerial().equals(b.getSerial())) {
                    existe = true;
                    break;
                }
            }
            if (!existe) {
                r.add(model);
            }
            request.getSession(true).setAttribute("listaBien", r);
        }
        request.getSession(true).setAttribute("loggeado", logged);
        request.setAttribute("model", r);
        request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
    }

    protected void create(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        Usuario logged = (Usuario) request.getSession(true).getAttribute("logged");
        request.getSession(true).setAttribute("loggeado", logged);
        
        request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
    }

    protected void listadoBien(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
        List<Bien> r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
        request.getSession(true).setAttribute("loggeado", logged);
        request.setAttribute("model", r);
        request.getRequestDispatcher("/presentation/solicitud/create/View.jsp").forward(request, response);
    }

    protected void agregarSolicitud(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException, Exception {
        Usuario logged = (Usuario) request.getSession(true).getAttribute("loggeado");
        Solicitud model = new Solicitud();
        updateModelSolicitud(model, request);
        ModelLogic.instance().addSolicitud(model);
        List<Bien> r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");

        for (Bien b : r) {
            try {
                model.setNumsol(ModelLogic.instance().getAutoIncrementoSolicitud());
                b.setSolicitud(model);
                ModelLogic.instance().addBienPreservar(b);
            } catch (Exception ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        HttpSession session = request.getSession(true);
        session.removeAttribute("listaBien");
        request.getSession(true).setAttribute("loggeado", logged);
        request.getRequestDispatcher("/presentation/solicitud/listado").forward(request, response);
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
            model.setEstado("PorVerificar");
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
            suma += (b.getPrecioU()*b.getCantidad());
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
