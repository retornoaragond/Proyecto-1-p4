/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.solicitud.list;

import activos.logic.Model;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import activos.logic.Usuario;
import java.io.IOException;
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
@WebServlet(name = "presentation.solicitud.list", urlPatterns = {"/presentation/solicitud/list", "/presentation/solicitud/listado"})
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
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/presentation/solicitud/list")) {
            this.list(request, response);
        }
        if (request.getServletPath().equals("/presentation/solicitud/listado")) {
            this.listado(request, response);
        }
    }

    protected void list(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
//        request.setAttribute("model", ModelLogic.instance().getSolicitudes());
        request.getRequestDispatcher("/presentation/solicitud/list/View.jsp").forward(request, response);
    }

    protected void listado(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        Usuario logged = (Usuario) request.getSession(true).getAttribute("logged");
        List<Solicitud> rows;
        //Solicitud sol = null; Antes se iniciaba en null y por se daba nullpointerexception
        Solicitud sol = new Solicitud();
        filtroSol(sol, request);
        rows = ModelLogic.instance().searchSolicitudAdministradorCod(sol, logged.getLabor().getDependencia().getNombre());
        addsolicitudes(rows);
        request.setAttribute("model", rows);
        request.getRequestDispatcher("/presentation/solicitud/list/View.jsp").forward(request, response);
    }

    void filtroSol(Solicitud model, HttpServletRequest request) {
        model.setNumcomp(request.getParameter("filtro"));
    }

    void addsolicitudes(List<Solicitud> rows) {
        for (Solicitud s : rows) {
            try {
                Model.agregar(s);
            } catch (Exception ex) {

            }
        }
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
