<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Trang Chủ - Danh Mục Sản Phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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

        /* Categories Grid */
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .category-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.2s ease;
            border: 1px solid #e2e8f0;
        }

        .category-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .category-card-content {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .category-card img {
            width: 64px;
            height: 64px;
            object-fit: cover;
            object-position: center;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
        }

        .category-card-placeholder {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .category-card-info h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            color: #2d3748;
        }

        .category-card-info p {
            margin: 0.25rem 0 0 0;
            font-size: 0.875rem;
            color: #718096;
        }

        /* Table View */
        .table-section {
            margin-top: 3rem;
        }

        .table-section h3 {
            margin-bottom: 1rem;
            color: #4a5568;
            font-size: 1.25rem;
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

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .empty-state-title {
            font-size: 1.25rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .empty-state-subtitle {
            font-size: 0.9rem;
        }

        /* Footer Info */
        .footer-info {
            margin-top: 2rem;
            text-align: center;
            padding: 1.5rem;
            background: #f7fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .footer-info-title {
            color: #4a5568;
            font-size: 0.95rem;
        }

        .footer-info-subtitle {
            color: #718096;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }
            
            .navbar {
                padding: 1rem;
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }
            
            .categories-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .page-header h2 {
                font-size: 1.875rem;
            }
            
            .styled-table {
                font-size: 0.875rem;
            }
            
            .styled-table th,
            .styled-table td {
                padding: 0.875rem;
            }
            
            .category-icon,
            .category-card img,
            .category-card-placeholder {
                width: 48px;
                height: 48px;
            }
        }

        @media (max-width: 480px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .category-card {
                padding: 1rem;
            }
            
            .empty-state {
                padding: 2rem 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Enhanced Navbar -->
    <div class="navbar">
        <span class="navbar-brand">Chào mừng, ${sessionScope.user.fullname}!</span>
        <a href="${pageContext.request.contextPath}/logout" class="navbar-logout">Đăng Xuất</a>
    </div>

    <div class="container">
        <!-- User Dashboard Header -->
        <div class="card">
            <div class="card-header">
                <div class="page-header">
                    <h2>Danh Mục Sản Phẩm</h2>
                    <p class="page-subtitle">Khám phá các danh mục sản phẩm có sẵn trong hệ thống</p>
                </div>
            </div>
            
            <div class="card-body">
                <!-- Categories Grid View -->
                <c:choose>
                    <c:when test="${empty categories}">
                        <div class="empty-state">
                            <div class="empty-state-icon">📂</div>
                            <div class="empty-state-title">Chưa có danh mục nào</div>
                            <div class="empty-state-subtitle">Hiện tại hệ thống chưa có danh mục sản phẩm nào</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Categories as Cards -->
                        <div class="categories-grid">
                            <c:forEach var="cat" items="${categories}">
                                <div class="category-card">
                                    <div class="category-card-content">
                                        <c:choose>
                                            <c:when test="${not empty cat.icon}">
                                                <img src="<c:url value='/uploads/${cat.icon}' />" 
                                                     alt="${cat.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="category-card-placeholder">
                                                    📦
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="category-card-info">
                                            <h3>${cat.name}</h3>
                                            <p>ID: #${cat.id}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Traditional Table View -->
                        <div class="table-section">
                            <h3>Xem Dạng Bảng</h3>
                            <div class="table-container">
                                <table class="styled-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 10%;">ID</th>
                                            <th style="width: 60%;">Tên Danh Mục</th>
                                            <th style="width: 30%;">Icon</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cat" items="${categories}">
                                            <tr>
                                                <td><strong>#${cat.id}</strong></td>
                                                <td>
                                                    <div style="font-weight: 500; font-size: 1rem;">${cat.name}</div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty cat.icon}">
                                                            <div class="image-container">
                                                                <img src="<c:url value='/uploads/${cat.icon}' />" 
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
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- Footer Info -->
                <div class="footer-info">
                    <div class="footer-info-title">
                        <strong>Tổng cộng:</strong> 
                        <c:set var="totalCategories" value="0"/>
                        <c:forEach var="cat" items="${categories}">
                            <c:set var="totalCategories" value="${totalCategories + 1}"/>
                        </c:forEach>
                        ${totalCategories} danh mục sản phẩm
                    </div>
                    <div class="footer-info-subtitle">
                        Hệ thống quản lý danh mục sản phẩm
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>