package vn.week3.filter;


import vn.week3.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/manager/*", "/user/*"})
public class AuthorizationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
	    HttpServletRequest request = (HttpServletRequest) servletRequest;
	    HttpServletResponse response = (HttpServletResponse) servletResponse;
	    HttpSession session = request.getSession(false);
	    String contextPath = request.getContextPath();

	    String requestURI = request.getRequestURI();

	    if (session == null || session.getAttribute("user") == null) {
	        response.sendRedirect(contextPath + "/login");
	        return;
	    }

	    User user = (User) session.getAttribute("user");
	    int roleId = user.getRoleId();

	    // Sửa lỗi logic kiểm tra đường dẫn ở đây
	    if (requestURI.startsWith(contextPath + "/admin/") && roleId != 3) {
	        response.sendRedirect(contextPath + "/views/common/error.jsp"); // Chuyển hướng đến trang lỗi
	    } else if (requestURI.startsWith(contextPath + "/manager/") && roleId != 2) {
	        response.sendRedirect(contextPath + "/views/common/error.jsp"); // Chuyển hướng đến trang lỗi
	    } else if (requestURI.startsWith(contextPath + "/user/") && roleId != 1) {
	        response.sendRedirect(contextPath + "/views/common/error.jsp"); // Chuyển hướng đến trang lỗi
	    } else {
	        filterChain.doFilter(servletRequest, servletResponse);
	    }
	}
}
