package vn.week3.controller;

import vn.week3.dao.CategoryDAO;
import vn.week3.model.Category;
import vn.week3.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.io.IOException;

@WebServlet("/views/manager/category")
@MultipartConfig
public class CategoryController extends HttpServlet {
	private CategoryDAO categoryDAO = new CategoryDAO();
	private static final String UPLOAD_DIRECTORY = "uploads";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		User currentUser = (User) req.getSession().getAttribute("user");

		if (action == null) {
			action = "list";
		}

		switch (action) {
		case "add":
			req.setAttribute("category", new Category());
			req.getRequestDispatcher("/views/manager/category-form.jsp").forward(req, resp);
			break;
		case "edit":
			try {
				int idToEdit = Integer.parseInt(req.getParameter("id"));
				Category category = categoryDAO.findById(idToEdit);

				if (category != null && category.getUser().getId() == currentUser.getId()) {
					req.setAttribute("category", category);
					req.getRequestDispatcher("/views/manager/category-form.jsp").forward(req, resp);
				} else {
					resp.sendRedirect(req.getContextPath() + "/views/common/error.jsp");
				}
			} catch (NumberFormatException e) {
				resp.sendRedirect(req.getContextPath() + "/views/common/error.jsp");
			}
			break;
		case "delete":
			try {
				int idToDelete = Integer.parseInt(req.getParameter("id"));
				Category catToDelete = categoryDAO.findById(idToDelete);

				if (catToDelete != null && catToDelete.getUser().getId() == currentUser.getId()) {
					String applicationPath = getServletContext().getRealPath("");
					String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;
					categoryDAO.delete(idToDelete, uploadPath);
				}
			} catch (NumberFormatException e) {
				// Handle error
			}
			resp.sendRedirect(req.getContextPath() + "/views/manager/home");
			break;
		default: // list
			resp.sendRedirect(req.getContextPath() + "/views/manager/home");
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idParam = req.getParameter("id");
		String name = req.getParameter("name");
		User user = (User) req.getSession().getAttribute("user");

		Category category;
		boolean isAdding = (idParam == null || idParam.isEmpty());

		if (isAdding) {
			category = new Category();
			category.setUser(user);
		} else {
			category = categoryDAO.findById(Integer.parseInt(idParam));
			if (category == null || category.getUser().getId() != user.getId()) {
				resp.sendRedirect(req.getContextPath() + "/views/common/error.jsp");
				return;
			}
		}
		category.setName(name);

		// Xử lý upload file
		Part filePart = req.getPart("icon");
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

		if (fileName != null && !fileName.isEmpty()) {
			// Lấy đường dẫn tuyệt đối của thư mục uploads
			String applicationPath = getServletContext().getRealPath("");
			String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;

			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists())
				uploadDir.mkdir();

			if (!isAdding && category.getIcon() != null && !category.getIcon().isEmpty()) {
				File oldFile = new File(uploadPath + File.separator + category.getIcon());
				if (oldFile.exists())
					oldFile.delete();
			}

			filePart.write(uploadPath + File.separator + fileName);
			category.setIcon(fileName); // Lưu tên file vào entity
		}

		if (isAdding) {
			categoryDAO.add(category);
		} else {
			categoryDAO.update(category);
		}

		resp.sendRedirect(req.getContextPath() + "/views/manager/home");
	}
}