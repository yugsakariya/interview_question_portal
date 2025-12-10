<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Defaultpage.aspx.cs" Inherits="interviewqunestion.User.Defaultpage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Interview Question Portal | Master Your Interview</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #ffffff;
            color: #1f2937;
            overflow-x: hidden;
        }

        /* Header */
        .header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .logo {
            font-size: 2rem;
            color: #3b82f6;
        }

        .site-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
        }

        .nav-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .btn-login {
            padding: 0.625rem 1.5rem;
            border: 1.5px solid #e5e7eb;
            border-radius: 0.5rem;
            background: white;
            color: #374151;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
        }

            .btn-login:hover {
                border-color: #3b82f6;
                color: #3b82f6;
            }

        .btn-register {
            padding: 0.625rem 1.5rem;
            border-radius: 0.5rem;
            background: #3b82f6;
            color: white;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            text-decoration: none;
        }

            .btn-register:hover {
                background: #2563eb;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            }

        /* Hero Section */
        .hero-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 5rem 2rem;
            text-align: center;
        }

        .tagline {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #eff6ff;
            color: #1e40af;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 2rem;
        }

        .target-icon::before {
            content: '🎯';
            font-size: 1rem;
        }

        .main-heading {
            font-size: 3.5rem;
            font-weight: 800;
            color: #1f2937;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            letter-spacing: -0.02em;
        }

        .highlight {
            color: #3b82f6;
            position: relative;
        }

        .subtitle {
            font-size: 1.25rem;
            color: #6b7280;
            max-width: 700px;
            margin: 0 auto 3rem;
            line-height: 1.7;
        }

        .cta-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-primary {
            padding: 1rem 2rem;
            border-radius: 0.5rem;
            background: #3b82f6;
            color: white;
            font-weight: 600;
            font-size: 1.125rem;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

            .btn-primary:hover {
                background: #2563eb;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
            }

        .btn-secondary {
            padding: 1rem 2rem;
            border-radius: 0.5rem;
            background: white;
            color: #374151;
            font-weight: 600;
            font-size: 1.125rem;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1.5px solid #e5e7eb;
            text-decoration: none;
        }

            .btn-secondary:hover {
                border-color: #3b82f6;
                color: #3b82f6;
            }

        /* Features Section */
        .features-section {
            background: #f9fafb;
            padding: 5rem 2rem;
        }

        .features-container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .features-heading {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
        }

        .features-subtitle {
            font-size: 1.125rem;
            color: #6b7280;
            max-width: 700px;
            margin: 0 auto 4rem;
            line-height: 1.7;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: left;
        }

            .feature-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
            }

        .feature-icon {
            width: 48px;
            height: 48px;
            background: #eff6ff;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #3b82f6;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 0.75rem;
        }

        .feature-description {
            font-size: 1rem;
            color: #6b7280;
            line-height: 1.6;
        }

        /* Stats Section */
        .stats-section {
            padding: 4rem 2rem;
            background: white;
        }

        .stats-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 3rem;
            text-align: center;
        }

        .stat-item {
            padding: 1.5rem;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: #3b82f6;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 1rem;
            color: #6b7280;
            font-weight: 500;
        }

        /* CTA Section */
        .cta-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 5rem 2rem;
            text-align: center;
            color: white;
        }

        .cta-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .cta-heading {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .cta-text {
            font-size: 1.25rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
        }

        .btn-white {
            padding: 1rem 2rem;
            border-radius: 0.5rem;
            background: white;
            color: #667eea;
            font-weight: 600;
            font-size: 1.125rem;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            text-decoration: none;
            display: inline-block;
        }

            .btn-white:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            }


        .footer {
            background: #1f2937;
            color: white;
            padding: 1rem 2rem;
            text-align: center;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            z-index: 999;
        }


        .footer-text {
            color: #9ca3af;
            font-size: 0.95rem;
        }


        @media (max-width: 768px) {
            .header {
                padding: 1rem;
            }

            .site-title {
                font-size: 1rem;
            }

            .logo {
                font-size: 1.5rem;
            }

            .nav-buttons {
                gap: 0.5rem;
            }

            .btn-login, .btn-register {
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
            }

            .hero-section {
                padding: 3rem 1rem;
            }

            .main-heading {
                font-size: 2.25rem;
            }

            .subtitle {
                font-size: 1rem;
            }

            .cta-buttons {
                flex-direction: column;
            }

            .btn-primary, .btn-secondary {
                width: 100%;
                justify-content: center;
            }

            .features-heading {
                font-size: 1.875rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
                gap: 2rem;
            }

            .stat-number {
                font-size: 2.25rem;
            }

            .cta-heading {
                font-size: 1.875rem;
            }

            .cta-text {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo-container">
                    <div class="logo"><i class="fas fa-graduation-cap"></i></div>
                    <h1 class="site-title">IQ Portal</h1>
                </div>
                <div class="nav-buttons">
                    <asp:LinkButton ID="btnAbout" runat="server" CssClass="btn-login"
                        Text="About" OnClick="btnAbout_Click" />

                    <asp:LinkButton ID="btnLoginNav" runat="server" CssClass="btn-login"
                        Text="Login" OnClick="btnLoginNav_Click" />
                    <asp:LinkButton ID="btnRegisterNav" runat="server" CssClass="btn-register"
                        Text="Register" OnClick="btnRegisterNav_Click" />
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="tagline">
                <span class="target-icon"></span>
                <span>Ace your next interview</span>
            </div>

            <h2 class="main-heading">Master Interview Questions<br />
                with <span class="highlight">Confidence</span>
            </h2>

            <p class="subtitle">
                Practice MCQs from top companies, take quizzes and mock tests, track your
                progress, and prepare smarter for your dream job.
            </p>

            <div class="cta-buttons">
                <asp:LinkButton ID="btnGetStarted" runat="server" CssClass="btn-primary"
                    OnClick="btnGetStarted_Click">
                    Get Started Free <i class="fas fa-arrow-right"></i>
                </asp:LinkButton>
                <asp:LinkButton ID="btnHaveAccount" runat="server" CssClass="btn-secondary"
                    Text="I have an account" OnClick="btnHaveAccount_Click" />
            </div>
        </section>




        <!-- Footer -->
        <footer class="footer">
            <p class="footer-text">
                © 2025 Interview Question Portal. All rights reserved.
            </p>
        </footer>

    </form>

</body>
</html>
