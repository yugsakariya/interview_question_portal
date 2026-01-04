<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/User/Site.Master" AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs" Inherits="interviewqunestion.User.Profile" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <style>
            /* ================= PROFILE PAGE CONTAINER ================= */
            .profile-page {
                max-width: 1100px;
                margin: 0 auto;
                padding: 0;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                position: relative;
            }

            /* ================= ANIMATED BACKGROUND PARTICLES ================= */
            .profile-bg-particles {
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

            /* ================= PROFILE HEADER WITH GRADIENT ================= */
            .profile-header {
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
            .profile-header::before {
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

            /* ================= PROFILE AVATAR WITH GLOW ================= */
            .profile-avatar-wrapper {
                position: relative;
                z-index: 2;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 24px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3.5rem;
                color: #ffffff;
                box-shadow:
                    0 20px 40px rgba(99, 102, 241, 0.5),
                    0 0 60px rgba(139, 92, 246, 0.3),
                    inset 0 2px 4px rgba(255, 255, 255, 0.2);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                animation: avatarPulse 3s ease-in-out infinite;
                position: relative;
                overflow: hidden;
            }

            /* Shimmer effect on avatar */
            .profile-avatar::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(45deg,
                        transparent 30%,
                        rgba(255, 255, 255, 0.3) 50%,
                        transparent 70%);
                animation: shimmer 3s linear infinite;
            }

            @keyframes shimmer {
                0% {
                    transform: translateX(-100%) translateY(-100%) rotate(45deg);
                }

                100% {
                    transform: translateX(100%) translateY(100%) rotate(45deg);
                }
            }

            @keyframes avatarPulse {

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

            .profile-avatar:hover {
                transform: scale(1.08) rotate(5deg);
                box-shadow:
                    0 30px 60px rgba(99, 102, 241, 0.7),
                    0 0 100px rgba(139, 92, 246, 0.6);
            }

            /* Avatar glow rings */
            .avatar-ring {
                position: absolute;
                border-radius: 24px;
                border: 2px solid rgba(139, 92, 246, 0.3);
                animation: ringPulse 3s ease-in-out infinite;
            }

            .avatar-ring:nth-child(1) {
                inset: -10px;
                animation-delay: 0s;
            }

            .avatar-ring:nth-child(2) {
                inset: -20px;
                animation-delay: 0.5s;
            }

            @keyframes ringPulse {

                0%,
                100% {
                    opacity: 0;
                    transform: scale(1);
                }

                50% {
                    opacity: 1;
                    transform: scale(1.1);
                }
            }

            /* ================= PROFILE TITLE BLOCK ================= */
            .profile-title-block {
                flex: 1;
                z-index: 2;
            }

            .profile-title-block h2 {
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

            .profile-title-block p {
                margin: 0;
                color: rgba(255, 255, 255, 0.7);
                font-size: 1.1rem;
                font-weight: 500;
                animation: titleSlideIn 0.6s ease-out 0.3s both;
            }

            /* ================= GLASSMORPHIC CARD ================= */
            .profile-card {
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

            .profile-card::before {
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

            .profile-card:hover::before {
                left: 100%;
            }

            .profile-card:hover {
                border-color: rgba(99, 102, 241, 0.4);
                box-shadow:
                    0 25px 70px rgba(0, 0, 0, 0.6),
                    0 0 40px rgba(99, 102, 241, 0.2),
                    inset 0 1px 2px rgba(255, 255, 255, 0.08);
                transform: translateY(-5px);
            }

            /* ================= CARD HEADER ================= */
            .card-header {
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid rgba(99, 102, 241, 0.15);
            }

            .card-header h3 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
                color: #e5e7eb;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .card-header h3 i {
                color: #8b5cf6;
                font-size: 1.4rem;
                animation: iconBounce 2s ease-in-out infinite;
            }

            @keyframes iconBounce {

                0%,
                100% {
                    transform: translateY(0);
                }

                50% {
                    transform: translateY(-5px);
                }
            }

            /* ================= PROFILE FIELDS GRID ================= */
            .profile-fields {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            @media (min-width: 768px) {
                .profile-fields {
                    grid-template-columns: 1fr 1fr;
                }

                .field-group.full-width {
                    grid-column: 1 / -1;
                }
            }

            /* ================= FIELD GROUP WITH HOVER EFFECTS ================= */
            .field-group {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
                animation: fadeInUp 0.6s ease-out both;
            }

            .field-group:nth-child(1) {
                animation-delay: 0.4s;
            }

            .field-group:nth-child(2) {
                animation-delay: 0.5s;
            }

            .field-group:nth-child(3) {
                animation-delay: 0.6s;
            }

            .field-group:nth-child(4) {
                animation-delay: 0.7s;
            }

            .field-group:nth-child(5) {
                animation-delay: 0.8s;
            }

            .field-label {
                font-size: 0.9rem;
                font-weight: 600;
                color: rgba(255, 255, 255, 0.6);
                display: flex;
                align-items: center;
                gap: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .field-label i {
                color: #a5b4fc;
                font-size: 1rem;
                width: 18px;
            }

            /* ================= FIELD VALUE WITH GLASSMORPHISM ================= */
            .field-value {
                font-size: 1.1rem;
                color: #e5e7eb;
                padding: 1rem 1.25rem;
                border-radius: 12px;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(139, 92, 246, 0.05));
                border: 1px solid rgba(99, 102, 241, 0.2);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                font-weight: 500;
                position: relative;
                overflow: hidden;
            }

            .field-value::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), transparent);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .field-value:hover {
                background: linear-gradient(135deg, rgba(99, 102, 241, 0.15), rgba(139, 92, 246, 0.1));
                border-color: rgba(99, 102, 241, 0.4);
                transform: translateX(5px);
                box-shadow:
                    0 8px 24px rgba(99, 102, 241, 0.2),
                    inset 0 1px 2px rgba(255, 255, 255, 0.05);
            }

            .field-value:hover::before {
                opacity: 1;
            }

            /* ================= ROLE BADGE WITH GRADIENT ================= */
            .badge-role {
                display: inline-flex;
                align-items: center;
                gap: 0.6rem;
                font-size: 1rem;
                font-weight: 700;
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                background: linear-gradient(135deg, #6366f1, #8b5cf6);
                color: #ffffff;
                border: 1px solid rgba(255, 255, 255, 0.2);
                width: fit-content;
                box-shadow:
                    0 8px 24px rgba(99, 102, 241, 0.4),
                    inset 0 1px 2px rgba(255, 255, 255, 0.2);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .badge-role::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(45deg,
                        transparent 30%,
                        rgba(255, 255, 255, 0.2) 50%,
                        transparent 70%);
                transform: translateX(-100%);
                transition: transform 0.6s ease;
            }

            .badge-role:hover::before {
                transform: translateX(100%);
            }

            .badge-role:hover {
                transform: scale(1.05);
                box-shadow:
                    0 12px 32px rgba(99, 102, 241, 0.6),
                    inset 0 1px 2px rgba(255, 255, 255, 0.3);
            }

            .badge-role i {
                font-size: 1.2rem;
                animation: iconRotate 4s linear infinite;
            }

            @keyframes iconRotate {

                0%,
                90%,
                100% {
                    transform: rotate(0deg);
                }

                95% {
                    transform: rotate(15deg);
                }
            }

            /* ================= RESPONSIVE DESIGN ================= */
            @media (max-width: 767px) {
                .profile-header {
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    padding: 2rem 1.5rem;
                    gap: 1.5rem;
                }

                .profile-avatar {
                    width: 100px;
                    height: 100px;
                    font-size: 3rem;
                }

                .profile-title-block h2 {
                    font-size: 2rem;
                }

                .profile-title-block p {
                    font-size: 1rem;
                }

                .profile-card {
                    padding: 1.5rem;
                }

                .profile-fields {
                    gap: 1.25rem;
                }
            }

            @media (max-width: 480px) {
                .profile-page {
                    padding: 0;
                }

                .profile-header {
                    padding: 1.5rem 1rem;
                    margin-bottom: 2rem;
                }

                .profile-avatar {
                    width: 90px;
                    height: 90px;
                    font-size: 2.5rem;
                }

                .profile-title-block h2 {
                    font-size: 1.75rem;
                }

                .profile-card {
                    padding: 1.25rem;
                    border-radius: 20px;
                }

                .card-header h3 {
                    font-size: 1.25rem;
                }

                .field-value {
                    padding: 0.875rem 1rem;
                    font-size: 1rem;
                }

                .badge-role {
                    padding: 0.625rem 1.25rem;
                    font-size: 0.9rem;
                }
            }

            /* ================= CHANGE PASSWORD BUTTON ================= */
            .btn-change-password {
                display: inline-flex;
                align-items: center;
                gap: 0.75rem;
                padding: 1rem 2rem;
                margin-top: 2rem;
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
                text-decoration: none;
            }

            .btn-change-password::before {
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

            .btn-change-password:hover::before {
                transform: translateX(100%);
            }

            .btn-change-password:hover {
                transform: translateY(-3px);
                box-shadow:
                    0 12px 32px rgba(99, 102, 241, 0.6),
                    inset 0 1px 2px rgba(255, 255, 255, 0.3);
                background: linear-gradient(135deg, #7c3aed, #a78bfa);
            }

            .btn-change-password:active {
                transform: translateY(-1px);
            }

            .btn-change-password i {
                font-size: 1.1rem;
                transition: transform 0.3s ease;
            }

            .btn-change-password:hover i {
                transform: rotate(15deg) scale(1.1);
            }

            .button-container {
                display: flex;
                justify-content: center;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(99, 102, 241, 0.15);
                margin-top: 1.5rem;
            }

            @media (max-width: 480px) {
                .btn-change-password {
                    width: 100%;
                    justify-content: center;
                    padding: 0.875rem 1.5rem;
                    font-size: 0.95rem;
                }
            }
        </style>

        <div class="profile-page">

            <!-- Animated Background Particles -->
            <div class="profile-bg-particles">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>

            <!-- Profile Header with Gradient -->
            <div class="profile-header">
                <div class="profile-avatar-wrapper">
                    <div class="avatar-ring"></div>
                    <div class="avatar-ring"></div>
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
                <div class="profile-title-block">
                    <h2>My Profile</h2>
                    <p>View and manage your account information</p>
                </div>
            </div>

            <!-- Account Details Card -->
            <div class="profile-card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-id-card"></i>
                        Account Details
                    </h3>
                </div>

                <div class="profile-fields">
                    <div class="field-group">
                        <span class="field-label">
                            <i class="fas fa-user"></i>
                            Full Name
                        </span>
                        <div class="field-value">
                            <asp:Label ID="lblFullName" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="field-group">
                        <span class="field-label">
                            <i class="fas fa-envelope"></i>
                            Email Address
                        </span>
                        <div class="field-value">
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="field-group">
                        <span class="field-label">
                            <i class="fas fa-at"></i>
                            Username
                        </span>
                        <div class="field-value">
                            <asp:Label ID="lblUsername" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="field-group">
                        <span class="field-label">
                            <i class="fas fa-calendar-alt"></i>
                            Member Since
                        </span>
                        <div class="field-value">
                            <asp:Label ID="lblMemberSince" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Change Password Button -->
                <div class="button-container">
                    <asp:LinkButton ID="btnChangePassword" runat="server" CssClass="btn-change-password"
                        OnClick="btnChangePassword_Click">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </asp:LinkButton>
                </div>
            </div>

        </div>

    </asp:Content>