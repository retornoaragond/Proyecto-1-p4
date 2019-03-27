/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.solicitud.create;

import activos.logic.Bien;
import activos.logic.Categoria;
import activos.logic.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ExtremeTech
 */
@WebServlet(name = "presentation.solicitud.create", urlPatterns = {"/presentation/solicitud/create",
                                                                   "/presentation/solicitud/agregarBien",
                                                                   "/presentation/solicitud/listadoBien"})
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
        }

        if (request.getServletPath().equals("/presentation/solicitud/agregarBien")) {
            this.agregarBien(request, response);
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
            r.add(model);
            request.getSession(true).setAttribute("listaBien", r);
        } else {
            r = (ArrayList<Bien>) request.getSession(true).getAttribute("listaBien");
            r.add(model);
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
