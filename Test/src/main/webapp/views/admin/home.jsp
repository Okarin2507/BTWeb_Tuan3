<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Admin Dashboard - Tất Cả Danh Mục</title>
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

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            text-align: center;
        }

        .stat-card.green {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
        }

        .stat-card-value {
            font-size: 2rem;
            font-weight: bold;
        }

        .stat-card-label {
            font-size: 0.9rem;
            opacity: 0.9;
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

        /* Manager info styling */
        .manager-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .manager-avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 0.875rem;
        }

        .manager-details {
            flex: 1;
        }

        .manager-name {
            font-weight: 500;
        }

        .manager-role {
            font-size: 0.75rem;
            color: #718096;
        }

        /* Status badge */
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: rgba(72, 187, 120, 0.1);
            color: #38a169;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Empty state */
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

        /* Footer info */
        .footer-info {
            margin-top: 2rem;
            text-align: center;
            color: #718096;
            font-size: 0.875rem;
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
            
            .category-icon {
                width: 48px;
                height: 48px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 0.75rem;
            }
        }

        @media (max-width: 480px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .manager-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.25rem;
            }
        }
    </style>
</head>
<body>
    <!-- Enhanced Navbar -->
    <div class="navbar">
        <span class="navbar-brand">🧑‍💼 Administrator Dashboard - ${sessionScope.user.fullname}</span>
        <a href="${pageContext.request.contextPath}/logout" class="navbar-logout">Đăng Xuất</a>
    </div>

    <div class="container">
        <!-- Admin Dashboard Header -->
        <div class="card">
            <div class="card-header">
                <div class="page-header">
                    <h2>📊 Tất Cả Danh Mục Trong Hệ Thống</h2>
                    <p class="page-subtitle">Xem tổng quan tất cả danh mục được tạo bởi các Manager</p>
                </div>
            </div>
            
            <div class="card-body">
                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-card-value">
                            <c:set var="totalCategories" value="0"/>
                            <c:forEach var="cat" items="${categories}">
                                <c:set var="totalCategories" value="${totalCategories + 1}"/>
                            </c:forEach>
                            ${totalCategories}
                        </div>
                        <div class="stat-card-label">Tổng Danh Mục</div>
                    </div>
                    <div class="stat-card green">
                        <div class="stat-card-value">
                            <c:set var="managersCount" value="0"/>
                            <c:set var="uniqueManagers" value=""/>
                            <c:forEach var="cat" items="${categories}">
                                <c:if test="${not fn:contains(uniqueManagers, cat.user.username)}">
                                    <c:set var="managersCount" value="${managersCount + 1}"/>
                                    <c:set var="uniqueManagers" value="${uniqueManagers},${cat.user.username}"/>
                                </c:if>
                            </c:forEach>
                            ${managersCount}
                        </div>
                        <div class="stat-card-label">Manager Hoạt Động</div>
                    </div>
                </div>

                <!-- Enhanced Table -->
                <div class="table-container">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th style="width: 8%;">ID</th>
                                <th style="width: 35%;">Tên Danh Mục</th>
                                <th style="width: 15%;">Icon</th>
                                <th style="width: 25%;">Người Tạo (Manager)</th>
                                <th style="width: 17%;">Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <tr>
                                        <td colspan="5" class="empty-state">
                                            <div class="empty-state-title">🔭 Chưa có danh mục nào</div>
                                            <div class="empty-state-subtitle">Hệ thống chưa có danh mục nào được tạo</div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat" items="${categories}" varStatus="status">
                                        <tr>
                                            <td><strong>#${cat.id}</strong></td>
                                            <td>
                                                <div style="font-weight: 500;">${cat.name}</div>
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
                                            <td>
                                                <div class="manager-info">
                                                    <div class="manager-avatar">
                                                        ${fn:substring(cat.user.username, 0, 1)}
                                                    </div>
                                                    <div class="manager-details">
                                                        <div class="manager-name">${cat.user.username}</div>
                                                        <div class="manager-role">Manager</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-badge">
                                                    ✅ Hoạt động
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
                
                <!-- Footer Info -->
                <div class="footer-info">
                    💡 <strong>Lưu Ý:</strong> Với quyền Administrator, bạn có thể xem tất cả danh mục trong hệ thống nhưng không thể chỉnh sửa. 
                    Chỉ Manager tạo danh mục mới có quyền chỉnh sửa.
                </div>
            </div>
        </div>
    </div>
</body>
</html>