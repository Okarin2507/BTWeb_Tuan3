<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${not empty category.id && category.id != 0 ? 'Chỉnh Sửa' : 'Thêm Mới'} Danh Mục</title>
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

        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #4a5568;
            font-size: 0.95rem;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.2s ease;
            background: #f7fafc;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
            background: white;
        }

        .file-upload-container {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .form-group input[type="file"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .file-upload-label {
            display: inline-block;
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, #718096 0%, #4a5568 100%);
            color: white;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            font-weight: 500;
            box-shadow: 0 4px 12px rgba(113, 128, 150, 0.3);
        }

        .file-upload-label:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(113, 128, 150, 0.4);
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
        }

        #file-name {
            display: block;
            margin-top: 0.75rem;
            color: #718096;
            font-size: 0.875rem;
            font-style: italic;
        }

        /* Fixed Image Scaling - Key improvement */
        .current-icon {
            margin-top: 1rem;
            padding: 1rem;
            background: #f7fafc;
            border-radius: 12px;
            border: 2px dashed #cbd5e0;
            text-align: center;
        }

        .category-icon {
            width: 80px;
            height: 80px;
            object-fit: cover;
            object-position: center;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            transition: all 0.2s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
            vertical-align: middle;
            margin: 0.5rem 0;
        }

        .category-icon:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        /* Preview image container - for uploaded image preview */
        .image-preview-container {
            display: none;
            margin-top: 1rem;
            padding: 1rem;
            background: #f7fafc;
            border-radius: 12px;
            border: 2px dashed #4299e1;
            text-align: center;
        }

        .preview-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            object-position: center;
            border-radius: 12px;
            border: 2px solid #4299e1;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.3);
            justify-content: center;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
            background: linear-gradient(135deg, #3182ce 0%, #2c5aa0 100%);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #718096 0%, #4a5568 100%);
            box-shadow: 0 4px 12px rgba(113, 128, 150, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            box-shadow: 0 8px 20px rgba(113, 128, 150, 0.4);
        }

        .upload-guidelines {
            margin-top: 0.75rem;
            font-size: 0.825rem;
            color: #718096;
            line-height: 1.4;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .button-group .btn {
            flex: 1;
            min-width: 120px;
            text-align: center;
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
            
            .card-body,
            .form-container {
                padding: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .button-group {
                flex-direction: column;
            }

            .button-group .btn {
                flex: none;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Enhanced Navbar -->
    <div class="navbar">
        <span class="navbar-brand">
            ${not empty category.id && category.id != 0 ? 'Chỉnh Sửa' : 'Tạo Mới'} Danh Mục
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="navbar-logout">Đăng Xuất</a>
    </div>

    <div class="container">
        <!-- Form Card -->
        <div class="card">
            <div class="card-header">
                <div class="page-header">
                    <h2>
                        <c:choose>
                            <c:when test="${not empty category.id && category.id != 0}">
                                ✏️ Chỉnh Sửa Danh Mục
                            </c:when>
                            <c:otherwise>
                                ➕ Tạo Danh Mục Mới
                            </c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="page-subtitle">
                        <c:choose>
                            <c:when test="${not empty category.id && category.id != 0}">
                                Cập nhật thông tin danh mục "${category.name}"
                            </c:when>
                            <c:otherwise>
                                Điền thông tin để tạo danh mục mới
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            
            <div class="card-body">
                <div class="form-container">
                    <form action="<c:url value='/views/manager/category' />" method="post" enctype="multipart/form-data">
                        
                        <c:if test="${not empty category.id && category.id != 0}">
                             <input type="hidden" name="id" value="${category.id}">
                        </c:if>
                        
                        <!-- Category Name Field -->
                        <div class="form-group">
                            <label for="name">📝 Tên Danh Mục</label>
                            <input type="text" 
                                   id="name" 
                                   name="name" 
                                   value="${category.name}" 
                                   required 
                                   placeholder="Ví dụ: Sách Lập Trình, Điện Thoại, Thời Trang..."
                                   maxlength="100">
                        </div>
                        
                        <!-- Icon Upload Field -->
                        <div class="form-group">
                            <label for="icon">🖼️ Icon Danh Mục</label>
                            <div class="file-upload-container">
                                <input type="file" 
                                       id="icon" 
                                       name="icon" 
                                       accept="image/png, image/jpeg, image/jpg, image/gif, image/webp" 
                                       onchange="handleFileSelect(this)">
                                <label for="icon" class="file-upload-label">📁 Chọn Hình Ảnh</label>
                                <span id="file-name">Chưa có file nào được chọn</span>
                            </div>
                            
                            <!-- Display Current Icon -->
                            <c:if test="${not empty category.icon}">
                                <div class="current-icon">
                                    <strong>🖼️ Icon hiện tại:</strong><br>
                                    <img src="<c:url value='/uploads/${category.icon}' />" 
                                         alt="Current Icon" 
                                         class="category-icon">
                                    <div style="margin-top: 0.5rem; font-size: 0.875rem; color: #718096;">
                                        File: ${category.icon}
                                    </div>
                                </div>
                            </c:if>

                            <!-- Preview for new uploaded image -->
                            <div id="image-preview" class="image-preview-container">
                                <strong>📷 Xem trước ảnh mới:</strong><br>
                                <img id="preview-img" src="" alt="Preview" class="preview-image">
                                <div style="margin-top: 0.5rem; font-size: 0.875rem; color: #4299e1;">
                                    Ảnh sẽ được upload khi bạn lưu form
                                </div>
                            </div>
                            
                            <!-- Upload Guidelines -->
                            <div class="upload-guidelines">
                                💡 <strong>Gợi ý:</strong> Chọn hình ảnh có kích thước vuông (tỷ lệ 1:1) để có kết quả tốt nhất. 
                                Định dạng được hỗ trợ: PNG, JPEG, GIF, WebP. Kích thước tối đa: 5MB.
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="button-group">
                            <button type="submit" class="btn">
                                <c:choose>
                                    <c:when test="${not empty category.id && category.id != 0}">
                                        💾 Cập Nhật Danh Mục
                                    </c:when>
                                    <c:otherwise>
                                        ✅ Tạo Danh Mục
                                    </c:otherwise>
                                </c:choose>
                            </button>
                            <a href="<c:url value='/views/manager/home' />" 
                               class="btn btn-secondary">
                                ❌ Hủy Bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function handleFileSelect(input) {
            const fileName = input.files[0] ? input.files[0].name : "Chưa có file nào được chọn";
            const fileSize = input.files[0] ? (input.files[0].size / (1024 * 1024)).toFixed(2) + ' MB' : '';
            
            document.getElementById('file-name').innerHTML = fileName + 
                (fileSize ? ' <span style="color: #4299e1;">(' + fileSize + ')</span>' : '');
            
            // Show image preview
            const previewContainer = document.getElementById('image-preview');
            const previewImg = document.getElementById('preview-img');
            
            if (input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewContainer.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
                
                // Update label appearance
                const label = document.querySelector('.file-upload-label');
                label.style.background = 'linear-gradient(135deg, #48bb78 0%, #38a169 100%)';
                label.textContent = '✅ Đã chọn file';
                
                // Reset label after 2 seconds
                setTimeout(() => {
                    label.style.background = '';
                    label.textContent = '📁 Chọn Hình Ảnh';
                }, 2000);
            } else {
                previewContainer.style.display = 'none';
            }
        }

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const nameInput = document.getElementById('name');
            const fileInput = document.getElementById('icon');
            
            if (nameInput.value.trim().length < 2) {
                e.preventDefault();
                alert('⚠️ Tên danh mục phải có ít nhất 2 ký tự!');
                nameInput.focus();
                return false;
            }
            
            // Check file size if file is selected
            if (fileInput.files[0] && fileInput.files[0].size > 5 * 1024 * 1024) {
                e.preventDefault();
                alert('⚠️ Kích thước file không được vượt quá 5MB!');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>