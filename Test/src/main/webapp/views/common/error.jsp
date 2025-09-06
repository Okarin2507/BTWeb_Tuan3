<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Truy Cập Bị Từ Chối</title>
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

        .error-container {
            width: 100%;
            max-width: 480px;
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
            background: linear-gradient(135deg, #fed7d7 0%, #feb2b2 100%);
            border-bottom: 1px solid #fc8181;
        }

        .card-body {
            padding: 2rem;
            text-align: center;
        }

        .error-icon {
            font-size: 4rem;
            color: #f56565;
            margin-bottom: 1rem;
            display: block;
        }

        .error-title {
            font-size: 2rem;
            font-weight: 700;
            color: #742a2a;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .error-subtitle {
            color: #a0616a;
            font-size: 1rem;
            margin-top: 0.5rem;
        }

        .error-message {
            color: #4a5568;
            font-size: 1.1rem;
            margin: 1.5rem 0;
            line-height: 1.6;
        }

        .error-details {
            background: #f7fafc;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #f56565;
            margin: 1.5rem 0;
            text-align: left;
        }

        .error-details-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }

        .error-details-text {
            color: #718096;
            font-size: 0.9rem;
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
            margin: 0.5rem;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
            background: linear-gradient(135deg, #3182ce 0%, #2c5aa0 100%);
            text-decoration: none;
            color: white;
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

        .actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .help-section {
            margin-top: 2rem;
            padding: 1.5rem;
            background: linear-gradient(135deg, #e6fffa 0%, #b2f5ea 100%);
            border-radius: 12px;
            border: 1px solid #4fd1c7;
        }

        .help-title {
            font-weight: 600;
            color: #234e52;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            justify-content: center;
        }

        .help-text {
            color: #285e61;
            font-size: 0.9rem;
            text-align: center;
        }

        .help-list {
            list-style: none;
            padding: 0;
            margin: 1rem 0 0 0;
            text-align: left;
        }

        .help-list li {
            padding: 0.5rem 0;
            color: #285e61;
            font-size: 0.9rem;
            display: flex;
            align-items: flex-start;
            gap: 0.5rem;
        }

        .help-list li::before {
            content: "•";
            color: #4fd1c7;
            font-weight: bold;
            font-size: 1.2rem;
            line-height: 1;
        }

        @media (max-width: 480px) {
            .card-header,
            .card-body {
                padding: 1.5rem;
            }

            .error-title {
                font-size: 1.75rem;
            }

            .error-icon {
                font-size: 3rem;
            }

            .actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="card">
            <div class="card-header">
                <span class="error-icon">🚫</span>
                <h1 class="error-title">Truy Cập Bị Từ Chối</h1>
                <p class="error-subtitle">Access Denied</p>
            </div>
            
            <div class="card-body">
                <div class="error-message">
                    Bạn không có quyền truy cập trang này hoặc tài nguyên được yêu cầu không tồn tại.
                </div>
                
                <div class="error-details">
                    <div class="error-details-title">Chi tiết lỗi:</div>
                    <div class="error-details-text">
                        You do not have permission to access this page or the requested resource does not exist.
                    </div>
                </div>

                <div class="help-section">
                    <div class="help-title">
                        💡 Gợi ý giải quyết
                    </div>
                    <div class="help-text">
                        Có thể bạn cần thực hiện một trong các hành động sau:
                    </div>
                    <ul class="help-list">
                        <li>Đăng nhập với tài khoản có quyền phù hợp</li>
                        <li>Kiểm tra lại đường dẫn URL</li>
                        <li>Liên hệ quản trị viên nếu bạn tin rằng đây là lỗi</li>
                        <li>Quay lại trang trước đó hoặc trang chủ</li>
                    </ul>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/login" class="btn">
                        🔑 Đăng Nhập
                    </a>
                    <a href="javascript:history.back()" class="btn btn-secondary">
                        ← Quay Lại
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto redirect after 10 seconds if user doesn't interact
        let redirectTimer = setTimeout(function() {
            if (confirm('Bạn có muốn chuyển đến trang đăng nhập không?')) {
                window.location.href = '${pageContext.request.contextPath}/login';
            }
        }, 10000);

        // Clear timer if user interacts with the page
        document.addEventListener('click', function() {
            clearTimeout(redirectTimer);
        });

        // Add some visual feedback when buttons are clicked
        document.querySelectorAll('.btn').forEach(function(btn) {
            btn.addEventListener('click', function() {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
    </script>
</body>
</html>