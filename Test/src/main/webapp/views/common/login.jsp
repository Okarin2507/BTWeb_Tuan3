<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng Nhập Hệ Thống</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            margin: 0 auto;
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

        .login-title {
            font-size: 1.875rem;
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

        .form-group input[type="text"],
        .form-group input[type="password"] {
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

        .btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .error-message {
            color: #f56565;
            text-align: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            background: rgba(245, 101, 101, 0.1);
            border-radius: 8px;
            border: 1px solid rgba(245, 101, 101, 0.2);
            font-weight: 500;
        }

        .footer-info {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e2e8f0;
        }

        .footer-info p {
            color: #718096;
            font-size: 0.875rem;
        }

        @media (max-width: 480px) {
            .card-header,
            .card-body {
                padding: 1.5rem;
            }

            .login-title {
                font-size: 1.5rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="card">
            <div class="card-header">
                <h2 class="login-title">🔐 Đăng Nhập Hệ Thống</h2>
                <p class="page-subtitle">Vui lòng nhập thông tin để tiếp tục</p>
            </div>
            
            <div class="card-body">
                <form action="<c:url value='/login' />" method="post">
                    <div class="form-group">
                        <label for="username">👤 Tên đăng nhập</label>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               required 
                               placeholder="Nhập tên đăng nhập..."
                               autocomplete="username">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">🔒 Mật khẩu</label>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               required 
                               placeholder="Nhập mật khẩu..."
                               autocomplete="current-password">
                    </div>
                    
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            ⚠️ ${error}
                        </div>
                    </c:if>

                    <div class="form-group">
                        <button type="submit" class="btn" style="width: 100%; font-size: 1.1rem; padding: 1rem;">
                            🚀 Đăng Nhập
                        </button>
                    </div>
                </form>
                
                <div class="footer-info">
                    <p>💡 Hệ thống quản lý danh mục sản phẩm</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto focus on username field
        document.getElementById('username').focus();
        
        // Add loading state to form submission
        document.querySelector('form').addEventListener('submit', function() {
            const submitBtn = document.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '⏳ Đang đăng nhập...';
            submitBtn.disabled = true;
        });
    </script>
</body>
</html>