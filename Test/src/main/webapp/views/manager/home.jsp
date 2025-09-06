<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản Lý Danh Mục</title>
    <%-- ... toàn bộ phần <style> của bạn giữ nguyên ... --%>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #2d3748;
            line-height: 1.6;
        }

        .navbar {
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            padding: 1rem 2rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.1rem;
            color: #e2e8f0;
        }

        .navbar-logout {
            color: #cbd5e0;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.2s ease;
            font-weight: 500;
        }

        .navbar-logout:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateY(-1px);
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-header {
            padding: 2rem;
            text-align: center;
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-bottom: 1px solid #e2e8f0;
        }

        .card-body {
            padding: 2rem;
        }

        .page-header h2 {
            font-size: 2.25rem;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .page-subtitle {
            color: #718096;
            font-size: 1.1rem;
            margin-top: 0.5rem;
        }

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .search-form {
            display: flex;
            flex: 1;
            max-width: 400px;
            position: relative;
        }

        .search-form input[type="text"] {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px 0 0 12px;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.2s ease;
            background: #f7fafc;
        }

        .search-form input[type="text"]:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
            background: white;
        }

        .search-form .btn {
            border-radius: 0 12px 12px 0;
            border-left: none;
        }

        .btn {
            padding: 0.875rem 1.5rem;
            font-size: 0.95rem;
            font-weight: 500;
            color: white;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            border: none;
            border-radius: 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
            background: linear-gradient(135deg, #3182ce 0%, #2c5aa0 100%);
        }

        .btn:active {
            transform: translateY(0);
        }

        .table-container {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .styled-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .styled-table thead tr {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
            text-align: left;
            font-weight: 600;
        }

        .styled-table th {
            padding: 1.25rem 1.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border: none;
        }

        .styled-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .styled-table tbody tr {
            transition: all 0.2s ease;
        }

        .styled-table tbody tr:hover {
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            transform: translateX(4px);
        }

        .styled-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Fixed Image Scaling */
        .category-icon {
            width: 64px;
            height: 64px;
            object-fit: cover;
            object-position: center;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            transition: all 0.2s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .category-icon:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        .image-container {
            display: flex;
            align-items: center;
            justify-content: flex-start;
        }

        .no-image-placeholder {
            width: 64px;
            height: 64px;
            background: #e2e8f0;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #a0aec0;
            font-size: 0.75rem;
            text-align: center;
        }

        .actions {
            white-space: nowrap;
        }

        .actions a {
            color: #4299e1;
            font-weight: 500;
            text-decoration: none;
            margin-right: 1rem;
            padding: 0.25rem 0.75rem;
            border-radius: 6px;
            transition: all 0.2s ease;
            font-size: 0.875rem;
        }

        .actions a:hover {
            background: rgba(66, 153, 225, 0.1);
            color: #3182ce;
            text-decoration: none;
        }

        .actions a:last-child {
            margin-right: 0;
            color: #f56565;
        }

        .actions a:last-child:hover {
            background: rgba(245, 101, 101, 0.1);
            color: #e53e3e;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }

        .empty-state-title {
            font-size: 1.125rem;
            margin-bottom: 0.5rem;
        }

        .empty-state-subtitle {
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }
            
            .toolbar {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
            
            .search-form {
                max-width: none;
            }
            
            .navbar {
                padding: 1rem;
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }
            
            .styled-table {
                font-size: 0.875rem;
            }
            
            .styled-table th,
            .styled-table td {
                padding: 0.875rem;
            }
            
            .category-icon {
                width: 48px;
                height: 48px;
            }
            
            .page-header h2 {
                font-size: 1.875rem;
            }
        }

        @media (max-width: 480px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .actions {
                display: flex;
                flex-direction: column;
                gap: 0.25rem;
            }
            
            .actions a {
                margin-right: 0;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <span class="navbar-brand">Chào mừng, ${sessionScope.user.fullname}!</span>
        <a href="${pageContext.request.contextPath}/logout" class="navbar-logout">Đăng Xuất</a>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <div class="page-header">
                    <h2>Danh Sách Danh Mục</h2>
                    <p class="page-subtitle">Quản lý và tổ chức các danh mục trong hệ thống</p>
                </div>
            </div>
            
            <div class="card-body">
                <div class="toolbar">
                    <form class="search-form" action="#" method="get">
                        <input type="text" name="search" placeholder="Tìm kiếm danh mục...">
                        <button type="submit" class="btn">Tìm Kiếm</button>
                    </form>
                   
                    <a href="${pageContext.request.contextPath}/views/manager/category?action=add" class="btn">
                        + Thêm Danh Mục Mới
                    </a>
                </div>

                <div class="table-container">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th style="width: 10%;">ID</th>
                                <th>Tên Danh Mục</th>
                                <th style="width: 15%;">Icon</th>
                                <th style="width: 20%;">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <tr>
                                        <td colspan="4" class="empty-state">
                                            <div class="empty-state-title">Chưa có danh mục nào</div>
                                            <div class="empty-state-subtitle">Hãy thêm danh mục đầu tiên của bạn</div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat" items="${categories}">
                                        <tr>
                                            <td><strong>#${cat.id}</strong></td>
                                            <td>${cat.name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cat.icon}">
                                                        <div class="image-container">
                                                            <img src="${pageContext.request.contextPath}/uploads/${cat.icon}" 
                                                                 alt="${cat.name}" 
                                                                 class="category-icon"
                                                                 title="${cat.name}">
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="no-image-placeholder">
                                                            No Image
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">

                                                <a href="${pageContext.request.contextPath}/views/manager/category?action=edit&id=${cat.id}">
                                                    ✏️ Sửa
                                                </a>

                                                <a href="${pageContext.request.contextPath}/views/manager/category?action=delete&id=${cat.id}" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục \"${cat.name}\"? Hành động này không thể hoàn tác.')">
                                                    🗑️ Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>