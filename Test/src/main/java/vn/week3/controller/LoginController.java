package vn.week3.controller;


import vn.week3.dao.UserDAO;
import vn.week3.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", ""})
public class LoginController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            switch (user.getRoleId()) {
                case 1: // user
                    resp.sendRedirect(req.getContextPath() + "/views/user/home");
                    break;
                case 2: // manager
                    resp.sendRedirect(req.getContextPath() + "/views/manager/home");
                    break;
                case 3: // admin
                    resp.sendRedirect(req.getContextPath() + "/views/admin/home");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/login");
                    break;
            }
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("/views/common/login.jsp").forward(req, resp);
        }
    }
}