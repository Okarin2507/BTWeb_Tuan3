package vn.week3.controller;


import vn.week3.dao.CategoryDAO;
import vn.week3.model.Category;
import vn.week3.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/views/admin/home", "/views/manager/home", "/views/user/home"})
public class HomeController extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        User user = (User) req.getSession().getAttribute("user");
        List<Category> categories;

        if (servletPath.equals("/views/manager/home")) {
            // Manager chỉ thấy category của mình
            categories = categoryDAO.findByUserId(user.getId());
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/manager/home.jsp").forward(req, resp);
        } else if (servletPath.equals("/views/admin/home")) {
            // Admin thấy tất cả category
            categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
        } else if (servletPath.equals("/views/user/home")) {
            // User thấy tất cả category
            categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
        }
    }
}