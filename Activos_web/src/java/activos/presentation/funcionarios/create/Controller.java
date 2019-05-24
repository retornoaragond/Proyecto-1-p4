/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.presentation.funcionarios.create;

import activos.logic.Dependencia;
import activos.logic.Funcionario;
import activos.logic.ModelLogic;
import activos.logic.Puesto;
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
@WebServlet(name = "presentation.funcionarios.create", urlPatterns = {"/presentation/funcionarios/create"})
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
        if (request.getServletPath().equals("/presentation/funcionarios/create")) {
            this.create(request, response);
        }else{
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    protected void create(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        if (this.verificar(request)) {
            Usuario logged = (Usuario) request.getSession(true).getAttribute("logged");
            ModelLogic model = ModelLogic.instance();
            Funcionario fun = new Funcionario();
            List<Puesto> puestos = model.getPuestos();
            List<Dependencia> depen = model.getDependencias();
            Usuario nuevoU = new Usuario();
            request.getSession(true).setAttribute("loggeado", logged);
            request.getSession(true).setAttribute("funcionario", fun);
            request.setAttribute("puestos", puestos);
            request.setAttribute("dependencias",depen);
            request.getSession(true).setAttribute("usuario",nuevoU);
            request.getRequestDispatcher("/presentation/funcionarios/create/View.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/presentation/Error.jsp").forward(request, response);
        }
    }

    boolean verificar(HttpServletRequest request) {
        if (request.getSession(true).getAttribute("logged") == null) {
            return false;
        }
        return true;
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
