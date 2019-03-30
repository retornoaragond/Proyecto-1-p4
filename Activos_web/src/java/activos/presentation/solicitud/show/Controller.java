/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.solicitud.show;

import activos.logic.Dependencia;
import activos.logic.ModelLogic;
import activos.logic.Solicitud;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ExtremeTech
 */
@WebServlet(name = "presentation.solicitud.show", urlPatterns = {"/presentation/solicitud/show"})
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
        String var = request.getServletPath();
        if (request.getServletPath().equals("/presentation/solicitud/show")) {
            this.show(request, response);
        }
    }

    protected void show(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        Solicitud model = new Solicitud();
        updateModelId(model, request);
        Solicitud modelConsultar = null;
        try {
            modelConsultar = ModelLogic.instance().findSolicitudnumComp(model);
        } catch (Exception ex) {
        }
        request.setAttribute("model", modelConsultar);
        request.getRequestDispatcher("/presentation/solicitud/show/View.jsp").forward(request, response);
    }

    void updateModelId(Solicitud model, HttpServletRequest request) {
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
