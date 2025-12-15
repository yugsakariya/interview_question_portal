<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs"
    Inherits="interviewqunestion.Account.Register" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register - IQ Portal</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.clouds.min.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
            overflow: hidden;
            margin: 0;
        }

        /* Vanta.js background container */
        #vanta-bg {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .auth-container {
            width: 100%;
            max-width: 520px;
            position: relative;
            z-index: 10;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .brand {
            text-align: center;
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-out 0.2s both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .brand i {
            font-size: 2.5rem;
            color: #ffffff;
            margin-bottom: 0.5rem;
            display: block;
            text-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            animation: bounceIcon 2s ease-in-out infinite;
        }

        @keyframes bounceIcon {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        .brand h1 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.25rem;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .brand p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.875rem;
            text-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
        }

        .auth-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem;
            box-shadow: 
                0 20px 60px rgba(0, 0, 0, 0.3),
                0 0 0 1px rgba(255, 255, 255, 0.15) inset;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeInScale 0.6s ease-out 0.3s both;
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .auth-card:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 30px 80px rgba(0, 0, 0, 0.35),
                0 0 0 1px rgba(255, 255, 255, 0.25) inset;
        }

        .auth-header {
            margin-bottom: 1.5rem;
        }

        .auth-header h2 {
            font-size: 1.25rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.25rem;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        .auth-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.875rem;
            text-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
        }

        .form-group {
            margin-bottom: 1rem;
            animation: slideIn 0.5s ease-out both;
        }

        .form-group:nth-child(3) {
            animation-delay: 0.4s;
        }

        .form-group:nth-child(4) {
            animation-delay: 0.5s;
        }

        .form-group:nth-child(5) {
            animation-delay: 0.6s;
        }

        .form-group:nth-child(6) {
            animation-delay: 0.7s;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 0.375rem;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 0.875rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            z-index: 1;
        }

        .form-control {
            width: 100%;
            padding: 0.625rem 0.875rem 0.625rem 2.5rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 0.5rem;
            font-size: 0.875rem;
            color: #1f2937;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:hover {
            border-color: rgba(255, 255, 255, 0.5);
            background: rgba(255, 255, 255, 0.95);
        }

        .form-control:focus {
            outline: none;
            border-color: #3b82f6;
            background: rgba(255, 255, 255, 1);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
            transform: translateY(-1px);
        }

        .form-control:focus ~ .input-icon {
            color: #3b82f6;
            transform: translateY(-50%) scale(1.1);
        }

        .input-wrapper:hover .input-icon {
            color: #3b82f6;
            transform: translateY(-50%) scale(1.1);
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        .error-message {
            color: #ef4444;
            font-size: 0.75rem;
            margin-top: 0.25rem;
            display: block;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }
            25% {
                transform: translateX(-5px);
            }
            75% {
                transform: translateX(5px);
            }
        }

        .validation-summary {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 0.5rem;
            padding: 0.75rem;
            margin-bottom: 1rem;
            animation: slideDown 0.4s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 1.25rem;
            color: #991b1b;
            font-size: 0.8rem;
        }

        .success-alert {
            background: #f0fdf4;
            border: 1px solid #86efac;
            color: #166534;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-size: 0.875rem;
            animation: slideDown 0.4s ease-out;
        }

        .btn-primary {
            width: 100%;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            padding: 0.75rem;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 0.875rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 0.5rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.5);
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:active {
            transform: translateY(0);
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.3);
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        .auth-footer p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.875rem;
            margin: 0;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        }

        .auth-footer a {
            color: #ffffff;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
            position: relative;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .auth-footer a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: #ffffff;
            transition: width 0.3s ease;
        }

        .auth-footer a:hover {
            color: #93c5fd;
        }

        .auth-footer a:hover::after {
            width: 100%;
        }

        .name-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        @media (max-width: 576px) {
            body {
                padding: 0.5rem;
            }

            .auth-card {
                padding: 1.5rem;
            }

            .name-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }

        /* Loading animation for form submission */
        .btn-primary.loading {
            pointer-events: none;
            opacity: 0.7;
        }

        .btn-primary.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <!-- Vanta.js Background -->
    <div id="vanta-bg"></div>

    <form id="form1" runat="server">
        <div class="auth-container">
            
            <!-- Brand -->
            <div class="brand">
                <i class="fas fa-graduation-cap"></i>
                <h1>IQ Portal</h1>
                <p>Interview Questions Portal</p>
            </div>

            <!-- Card -->
            <div class="auth-card">
                
                <!-- Header -->
                <div class="auth-header">
                    <h2>Create your account</h2>
                    <p>Get started with your free account</p>
                </div>

                <!-- Success Message -->
                <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-alert">
                    <asp:Label ID="lblMsg" runat="server" />
                </asp:Panel>

                <!-- Validation Summary -->
                <asp:ValidationSummary runat="server" CssClass="validation-summary" 
                    HeaderText="Please fix the following:" />

                <!-- Name Row -->
                <div class="name-row">
                    <!-- First Name -->
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <asp:TextBox ID="txtFirstName" runat="server" 
                                CssClass="form-control"
                                placeholder="John" />
                        </div>
                        <asp:RequiredFieldValidator runat="server"
                            ControlToValidate="txtFirstName"
                            ErrorMessage="First name is required"
                            Display="Dynamic"
                            CssClass="error-message" />
                    </div>

                    <!-- Last Name -->
                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <asp:TextBox ID="txtLastName" runat="server" 
                                CssClass="form-control"
                                placeholder="Doe" />
                        </div>
                        <asp:RequiredFieldValidator runat="server"
                            ControlToValidate="txtLastName"
                            ErrorMessage="Last name is required"
                            Display="Dynamic"
                            CssClass="error-message" />
                    </div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope input-icon"></i>
                        <asp:TextBox ID="txtEmail" runat="server" 
                            TextMode="Email"
                            CssClass="form-control"
                            placeholder="you@example.com" />
                    </div>
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required"
                        Display="Dynamic"
                        CssClass="error-message" />
                    <asp:RegularExpressionValidator runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Invalid email format"
                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                        Display="Dynamic"
                        CssClass="error-message" />
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <asp:TextBox ID="txtPassword" runat="server" 
                            TextMode="Password"
                            CssClass="form-control"
                            placeholder="••••••" />
                    </div>
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required"
                        Display="Dynamic"
                        CssClass="error-message" />
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <asp:TextBox ID="txtCPassword" runat="server" 
                            TextMode="Password"
                            CssClass="form-control"
                            placeholder="••••••" />
                    </div>
                    <asp:RequiredFieldValidator runat="server"
                        ControlToValidate="txtCPassword"
                        ErrorMessage="Confirm password is required"
                        Display="Dynamic"
                        CssClass="error-message" />
                    <asp:CompareValidator runat="server"
                        ControlToCompare="txtPassword"
                        ControlToValidate="txtCPassword"
                        ErrorMessage="Passwords do not match" 
                        Display="Dynamic" 
                        CssClass="error-message" />
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnRegister" runat="server" 
                    Text="Create Account"
                    CssClass="btn-primary"
                    OnClick="btnRegister_Click" />

                <!-- Footer -->
                <div class="auth-footer">
                    <p>
                        Already have an account? 
                        <asp:HyperLink runat="server" NavigateUrl="~/Account/Login.aspx" Text="Login" />
                    </p>
                </div>

            </div>

        </div>

        <script>
            // Initialize Vanta.js CLOUDS effect
            VANTA.CLOUDS({
                el: "#vanta-bg",
                mouseControls: true,
                touchControls: true,
                gyroControls: false,
                minHeight: 200.00,
                minWidth: 200.00,
                skyColor: 0x1e3a8a,
                cloudColor: 0x3b82f6,
                cloudShadowColor: 0x1e293b,
                sunColor: 0x60a5fa,
                sunGlareColor: 0x93c5fd,
                sunlightColor: 0x3b82f6,
                speed: 0.8
            });
        </script>
    </form>
</body>
</html>