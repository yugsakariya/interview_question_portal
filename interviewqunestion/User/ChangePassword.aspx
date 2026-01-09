<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="interviewqunestion.User.ChangePassword" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <style>
            /* ================= CHANGE PASSWORD PAGE CONTAINER ================= */
            .change-password-page {
                max-width: 700px;
                margin: 0 auto;
                padding: 0;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                position: relative;
            }

            /* ================= ANIMATED BACKGROUND PARTICLES ================= */
            .password-bg-particles {
                position: absolute;
                top: -100px;
                left: 0;
                right: 0;
                height: 400px;
                overflow: hidden;
                pointer-events: none;
                z-index: 0;
            }

            .particle {
                position: absolute;
                width: 4px;
                height: 4px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                border-radius: 50%;
                opacity: 0.6;
                animation: floatParticle 8s ease-in-out infinite;
                box-shadow: 0 0 10px rgba(99, 102, 241, 0.8);
            }

            .particle:nth-child(1) {
                left: 10%;
                animation-delay: 0s;
                animation-duration: 7s;
            }

            .particle:nth-child(2) {
                left: 25%;
                animation-delay: 1s;
                animation-duration: 9s;
            }

            .particle:nth-child(3) {
                left: 40%;
                animation-delay: 2s;
                animation-duration: 6s;
            }

            .particle:nth-child(4) {
                left: 60%;
                animation-delay: 1.5s;
                animation-duration: 8s;
            }

            .particle:nth-child(5) {
                left: 75%;
                animation-delay: 0.5s;
                animation-duration: 7.5s;
            }

            .particle:nth-child(6) {
                left: 90%;
                animation-delay: 2.5s;
                animation-duration: 8.5s;
            }

            @keyframes floatParticle {

                0%,
                100% {
                    transform: translateY(0) translateX(0) scale(1);
                    opacity: 0.3;
                }

                25% {
                    transform: translateY(-80px) translateX(20px) scale(1.2);
                    opacity: 0.6;
                }

                50% {
                    transform: translateY(-150px) translateX(-15px) scale(0.8);
                    opacity: 0.8;
                }

                75% {
                    transform: translateY(-220px) translateX(30px) scale(1.1);
                    opacity: 0.5;
                }
            }

            /* ================= PAGE HEADER WITH GRADIENT ================= */
            .password-header {
                position: relative;
                display: flex;
                align-items: center;
                gap: 2rem;
                margin-bottom: 3rem;
                padding: 3rem 2.5rem;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.15), rgba(139, 92, 246, 0.1));
                border-radius: 24px;
                border: 1px solid rgba(99, 102, 241, 0.25);
                backdrop-filter: blur(20px);
                box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.4),
                    inset 0 1px 2px rgba(255, 255, 255, 0.05);
                overflow: hidden;
                animation: slideInDown 0.6s ease-out;
                z-index: 1;
            }

            @keyframes slideInDown {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Animated gradient overlay */
            .password-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(139, 92, 246, 0.1) 0%, transparent 70%);
                animation: rotateGradient 15s linear infinite;
                pointer-events: none;
            }

            @keyframes rotateGradient {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            /* ================= HEADER ICON WITH GLOW ================= */
            .password-icon-wrapper {
                position: relative;
                z-index: 2;
            }

            .password-icon {
                width: 100px;
                height: 100px;
                border-radius: 20px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                color: #ffffff;
                box-shadow:
                    0 20px 40px rgba(99, 102, 241, 0.5),
                    0 0 60px rgba(139, 92, 246, 0.3),
                    inset 0 2px 4px rgba(255, 255, 255, 0.2);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                animation: iconPulse 3s ease-in-out infinite;
            }

            @keyframes iconPulse {

                0%,
                100% {
                    transform: scale(1);
                    box-shadow:
                        0 20px 40px rgba(99, 102, 241, 0.5),
                        0 0 60px rgba(139, 92, 246, 0.3);
                }

                50% {
                    transform: scale(1.05);
                    box-shadow:
                        0 25px 50px rgba(99, 102, 241, 0.6),
                        0 0 80px rgba(139, 92, 246, 0.5);
                }
            }

            /* ================= HEADER TITLE BLOCK ================= */
            .password-title-block {
                flex: 1;
                z-index: 2;
            }

            .password-title-block h2 {
                margin: 0 0 0.5rem;
                font-size: 2.5rem;
                font-weight: 800;
                background: linear-gradient(135deg, #ffffff, #c7d2fe);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                color: transparent;
                animation: titleSlideIn 0.6s ease-out 0.2s both;
            }

            @keyframes titleSlideIn {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }

                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .password-title-block p {
                margin: 0;
                color: rgba(255, 255, 255, 0.7);
                font-size: 1.1rem;
                font-weight: 500;
                animation: titleSlideIn 0.6s ease-out 0.3s both;
            }

            /* ================= GLASSMORPHIC CARD ================= */
            .password-card {
                position: relative;
                background: rgba(20, 20, 30, 0.7);
                backdrop-filter: blur(30px);
                border-radius: 24px;
                padding: 2.5rem;
                border: 1px solid rgba(99, 102, 241, 0.2);
                box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.5),
                    inset 0 1px 2px rgba(255, 255, 255, 0.05);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                animation: fadeInUp 0.6s ease-out 0.3s both;
                overflow: hidden;
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

            .password-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg,
                        transparent,
                        rgba(99, 102, 241, 0.1),
                        transparent);
                transition: left 0.6s ease;
            }

            .password-card:hover::before {
                left: 100%;
            }

            .password-card:hover {
                border-color: rgba(99, 102, 241, 0.4);
                box-shadow:
                    0 25px 70px rgba(0, 0, 0, 0.6),
                    0 0 40px rgba(99, 102, 241, 0.2),
                    inset 0 1px 2px rgba(255, 255, 255, 0.08);
                transform: translateY(-5px);
            }

            /* ================= FORM FIELDS ================= */
            .form-group {
                margin-bottom: 2rem;
                animation: fadeInUp 0.6s ease-out both;
            }

            .form-group:nth-child(1) {
                animation-delay: 0.4s;
            }

            .form-group:nth-child(2) {
                animation-delay: 0.5s;
            }

            .form-group:nth-child(3) {
                animation-delay: 0.6s;
            }

            .form-label {
                display: flex;
                align-items: center;
                gap: 0.6rem;
                font-size: 0.95rem;
                font-weight: 600;
                color: rgba(255, 255, 255, 0.7);
                margin-bottom: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-label i {
                color: #a5b4fc;
                font-size: 1.1rem;
            }

            .form-label .required {
                color: #f87171;
                margin-left: 0.25rem;
            }

            /* ================= INPUT FIELDS WITH GLASSMORPHISM ================= */
            .form-input {
                width: 100%;
                padding: 1rem 1.25rem;
                font-size: 1rem;
                color: #e5e7eb;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(139, 92, 246, 0.05));
                border: 1px solid rgba(99, 102, 241, 0.2);
                border-radius: 12px;
                outline: none;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                box-sizing: border-box;
            }

            .form-input::placeholder {
                color: rgba(255, 255, 255, 0.4);
            }

            .form-input:focus {
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.15), rgba(139, 92, 246, 0.1));
                border-color: rgba(99, 102, 241, 0.5);
                box-shadow:
                    0 8px 24px rgba(99, 102, 241, 0.2),
                    0 0 0 3px rgba(99, 102, 241, 0.1),
                    inset 0 1px 2px rgba(255, 255, 255, 0.05);
                transform: translateY(-2px);
            }

            .form-input:hover:not(:focus) {
                border-color: rgba(99, 102, 241, 0.3);
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.12), rgba(139, 92, 246, 0.08));
            }

            /* ================= VALIDATION MESSAGES ================= */
            .validation-message {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-top: 0.5rem;
                padding: 0.75rem 1rem;
                background: rgba(248, 113, 113, 0.1);
                border: 1px solid rgba(248, 113, 113, 0.3);
                border-radius: 8px;
                color: #fca5a5;
                font-size: 0.9rem;
                animation: shake 0.4s ease-in-out;
            }

            @keyframes shake {

                0%,
                100% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-5px);
                }

                75% {
                    transform: translateX(5px);
                }
            }

            .validation-message i {
                font-size: 1rem;
            }

            /* Success message */
            .success-message {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 1.5rem;
                padding: 1rem 1.25rem;
                background: rgba(34, 197, 94, 0.1);
                border: 1px solid rgba(34, 197, 94, 0.3);
                border-radius: 12px;
                color: #86efac;
                font-size: 1rem;
                animation: slideInDown 0.4s ease-out;
            }

            .success-message i {
                font-size: 1.2rem;
            }

            /* Error message */
            .error-message {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 1.5rem;
                padding: 1rem 1.25rem;
                background: rgba(248, 113, 113, 0.1);
                border: 1px solid rgba(248, 113, 113, 0.3);
                border-radius: 12px;
                color: #fca5a5;
                font-size: 1rem;
                animation: slideInDown 0.4s ease-out;
            }

            .error-message i {
                font-size: 1.2rem;
            }

            /* ================= PASSWORD STRENGTH INDICATOR ================= */
            .password-strength {
                margin-top: 0.75rem;
            }

            .strength-bar {
                height: 6px;
                background: rgba(99, 102, 241, 0.1);
                border-radius: 3px;
                overflow: hidden;
                margin-bottom: 0.5rem;
            }

            .strength-fill {
                height: 100%;
                width: 0%;
                transition: all 0.3s ease;
                border-radius: 3px;
            }

            .strength-weak .strength-fill {
                width: 33%;
                background: linear-gradient(90deg, #f87171, #ef4444);
            }

            .strength-medium .strength-fill {
                width: 66%;
                background: linear-gradient(90deg, #fbbf24, #f59e0b);
            }

            .strength-strong .strength-fill {
                width: 100%;
                background: linear-gradient(90deg, #34d399, #10b981);
            }

            .strength-text {
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.6);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .strength-weak .strength-text {
                color: #fca5a5;
            }

            .strength-medium .strength-text {
                color: #fcd34d;
            }

            .strength-strong .strength-text {
                color: #86efac;
            }

            /* ================= BUTTONS ================= */
            .button-group {
                display: flex;
                gap: 1rem;
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid rgba(99, 102, 241, 0.15);
            }

            .btn-primary {
                flex: 1;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                padding: 1rem 2rem;
                font-size: 1rem;
                font-weight: 700;
                color: #ffffff;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                box-shadow:
                    0 8px 24px rgba(99, 102, 241, 0.4),
                    inset 0 1px 2px rgba(255, 255, 255, 0.2);
                position: relative;
                overflow: hidden;
            }

            .btn-primary::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(90deg,
                        transparent 0%,
                        rgba(255, 255, 255, 0.2) 50%,
                        transparent 100%);
                transform: translateX(-100%);
                transition: transform 0.6s ease;
            }

            .btn-primary:hover::before {
                transform: translateX(100%);
            }

            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow:
                    0 12px 32px rgba(99, 102, 241, 0.6),
                    inset 0 1px 2px rgba(255, 255, 255, 0.3);
                background: linear-gradient(135deg, #7c3aed, #a78bfa);
            }

            .btn-primary:active {
                transform: translateY(-1px);
            }

            .btn-primary i {
                font-size: 1.1rem;
                transition: transform 0.3s ease;
            }

            .btn-primary:hover i {
                transform: scale(1.1);
            }

            .btn-secondary {
                flex: 1;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                padding: 1rem 2rem;
                font-size: 1rem;
                font-weight: 700;
                color: rgba(255, 255, 255, 0.8);
                background: rgba(99, 102, 241, 0.1);
                border: 1px solid rgba(99, 102, 241, 0.3);
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                text-decoration: none;
            }

            .btn-secondary:hover {
                background: rgba(99, 102, 241, 0.15);
                border-color: rgba(99, 102, 241, 0.5);
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(99, 102, 241, 0.2);
            }

            .btn-secondary i {
                font-size: 1.1rem;
            }

            /* ================= PASSWORD REQUIREMENTS ================= */
            .password-requirements {
                margin-top: 1rem;
                padding: 1rem;
                background: rgba(99, 102, 241, 0.05);
                border: 1px solid rgba(99, 102, 241, 0.15);
                border-radius: 10px;
            }

            .requirements-title {
                font-size: 0.85rem;
                font-weight: 600;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .requirement-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.5);
                margin-bottom: 0.5rem;
            }

            .requirement-item:last-child {
                margin-bottom: 0;
            }

            .requirement-item i {
                font-size: 0.8rem;
                color: rgba(255, 255, 255, 0.3);
            }

            .requirement-item.met {
                color: #86efac;
            }

            .requirement-item.met i {
                color: #34d399;
            }

            /* ================= RESPONSIVE DESIGN ================= */
            @media (max-width: 767px) {
                .password-header {
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    padding: 2rem 1.5rem;
                    gap: 1.5rem;
                }

                .password-icon {
                    width: 80px;
                    height: 80px;
                    font-size: 2.5rem;
                }

                .password-title-block h2 {
                    font-size: 2rem;
                }

                .password-title-block p {
                    font-size: 1rem;
                }

                .password-card {
                    padding: 1.5rem;
                }

                .button-group {
                    flex-direction: column;
                }

                .btn-primary,
                .btn-secondary {
                    width: 100%;
                }
            }

            @media (max-width: 480px) {
                .change-password-page {
                    padding: 0;
                }

                .password-header {
                    padding: 1.5rem 1rem;
                    margin-bottom: 2rem;
                }

                .password-icon {
                    width: 70px;
                    height: 70px;
                    font-size: 2rem;
                }

                .password-title-block h2 {
                    font-size: 1.75rem;
                }

                .password-card {
                    padding: 1.25rem;
                    border-radius: 20px;
                }

                .form-input {
                    padding: 0.875rem 1rem;
                    font-size: 0.95rem;
                }

                .btn-primary,
                .btn-secondary {
                    padding: 0.875rem 1.5rem;
                    font-size: 0.95rem;
                }
            }
        </style>

        <div class="change-password-page">

            <!-- Animated Background Particles -->
            <div class="password-bg-particles">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>

            <!-- Page Header with Gradient -->
            <div class="password-header">
                <div class="password-icon-wrapper">
                    <div class="password-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                </div>
                <div class="password-title-block">
                    <h2>Change Password</h2>
                    <p>Update your account password securely</p>
                </div>
            </div>

            <!-- Change Password Card -->
            <div class="password-card">

                <!-- Success Message -->
                <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-message">
                    <i class="fas fa-check-circle"></i>
                    <span>
                        <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                    </span>
                </asp:Panel>

                <!-- Error Message -->
                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </span>
                </asp:Panel>

                <!-- Current Password -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i>
                        Current Password
                        <span class="required">*</span>
                    </label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-input"
                        placeholder="Enter your current password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server"
                        ControlToValidate="txtCurrentPassword" Display="Dynamic" CssClass="validation-message"
                        ErrorMessage="<i class='fas fa-exclamation-triangle'></i> Current password is required">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- New Password -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i>
                        New Password
                        <span class="required">*</span>
                    </label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-input"
                        placeholder="Enter your new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword"
                        Display="Dynamic" CssClass="validation-message"
                        ErrorMessage="<i class='fas fa-exclamation-triangle'></i> New password is required">
                    </asp:RequiredFieldValidator>

                    <!-- Password Requirements -->
                    <div class="password-requirements">
                        <div class="requirements-title">Password Requirements:</div>
                        <div class="requirement-item">
                            <i class="fas fa-circle"></i>
                            <span>At least 8 characters long</span>
                        </div>
                        <div class="requirement-item">
                            <i class="fas fa-circle"></i>
                            <span>Contains uppercase and lowercase letters</span>
                        </div>
                        <div class="requirement-item">
                            <i class="fas fa-circle"></i>
                            <span>Contains at least one number</span>
                        </div>
                        <div class="requirement-item">
                            <i class="fas fa-circle"></i>
                            <span>Contains at least one special character</span>
                        </div>
                    </div>
                </div>

                <!-- Confirm New Password -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-check-circle"></i>
                        Confirm New Password
                        <span class="required">*</span>
                    </label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-input"
                        placeholder="Re-enter your new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword" Display="Dynamic" CssClass="validation-message"
                        ErrorMessage="<i class='fas fa-exclamation-triangle'></i> Please confirm your new password">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtNewPassword" Display="Dynamic" CssClass="validation-message"
                        ErrorMessage="<i class='fas fa-exclamation-triangle'></i> Passwords do not match">
                    </asp:CompareValidator>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn-primary"
                        OnClick="btnChangePassword_Click" />
                    <asp:HyperLink ID="lnkCancel" runat="server" NavigateUrl="~/User/Profile.aspx"
                        CssClass="btn-secondary">
                        <i class="fas fa-times"></i>
                        <span>Cancel</span>
                    </asp:HyperLink>
                </div>

            </div>

        </div>

        <script>
            // Password strength indicator (optional enhancement)
            document.addEventListener('DOMContentLoaded', function () {
                const newPasswordField = document.getElementById('<%= txtNewPassword.ClientID %>');
                if (newPasswordField) {
                    newPasswordField.addEventListener('input', function () {
                        // You can add password strength logic here
                        console.log('Password changed');
                    });
                }
            });
        </script>

    </asp:Content>