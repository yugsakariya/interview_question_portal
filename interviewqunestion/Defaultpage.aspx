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
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial;
            background: #020617;
            color: #e5e7eb;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
        }

        /* Animated gradient background */
        body::before {
            content: '';
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle at 20% 50%, rgba(99, 102, 241, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(59, 130, 246, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 40% 20%, rgba(168, 85, 247, 0.1) 0%, transparent 50%);
            animation: gradientShift 20s ease infinite;
            z-index: 0;
        }

        @keyframes gradientShift {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(5%, -5%) rotate(120deg); }
            66% { transform: translate(-5%, 5%) rotate(240deg); }
        }

        /* Floating particles */
        .particle {
            position: fixed;
            background: rgba(96, 165, 250, 0.3);
            border-radius: 50%;
            pointer-events: none;
            z-index: 1;
            animation: float linear infinite;
        }

        @keyframes float {
            to {
                transform: translateY(-100vh) rotate(360deg);
            }
        }

        /* ================= HEADER ================= */
        .header {
            background: rgba(15, 23, 42, 0.8);
            border-bottom: 1px solid rgba(255,255,255,0.08);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(20px);
            animation: slideDown 0.8s ease;
        }

        @keyframes slideDown {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .header-container {
            max-width: 1200px;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
        }

        .logo {
            font-size: 2rem;
            background: linear-gradient(135deg, #60a5fa, #a78bfa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        .site-title {
            font-size: 1.3rem;
            font-weight: 700;
            background: linear-gradient(135deg, #f8fafc, #cbd5e1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .btn-login {
            padding: 0.65rem 1.5rem;
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 0.6rem;
            color: #e5e7eb;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(59,130,246,0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn-login:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-login:hover {
            border-color: #60a5fa;
            color: #60a5fa;
            transform: translateY(-1px);
        }

        .btn-register {
            padding: 0.65rem 1.75rem;
            border-radius: 0.6rem;
            background: linear-gradient(135deg, #3b82f6, #6366f1, #8b5cf6);
            background-size: 200% 200%;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s ease;
            border: none;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(99,102,241,0.3);
            position: relative;
            animation: gradientFlow 3s ease infinite;
        }

        @keyframes gradientFlow {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .btn-register:hover {
            box-shadow: 0 6px 30px rgba(99,102,241,0.6);
            transform: translateY(-2px);
        }

        /* ================= HERO ================= */
        .hero-section {
            max-width: 1200px;
            margin: auto;
            padding: 6rem 2rem 8rem;
            text-align: center;
            animation: fadeUp 1s ease;
            position: relative;
            z-index: 2;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .tagline {
            display: inline-flex;
            gap: 0.5rem;
            align-items: center;
            background: linear-gradient(135deg, rgba(59,130,246,0.2), rgba(168,85,247,0.2));
            color: #93c5fd;
            padding: 0.6rem 1.3rem;
            border-radius: 2rem;
            font-weight: 600;
            margin-bottom: 2.5rem;
            border: 1px solid rgba(147,197,253,0.2);
            backdrop-filter: blur(10px);
            animation: float-badge 3s ease-in-out infinite;
        }

        @keyframes float-badge {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
        }

        .main-heading {
            font-size: 3.8rem;
            font-weight: 900;
            margin-bottom: 1.5rem;
            line-height: 1.2;
            background: linear-gradient(135deg, #ffffff, #cbd5e1, #ffffff);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: shimmer 4s ease-in-out infinite;
        }

        @keyframes shimmer {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .highlight {
            background: linear-gradient(135deg, #60a5fa, #a78bfa, #60a5fa);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientFlow 3s ease infinite;
            position: relative;
        }

        .highlight::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, transparent, #60a5fa, transparent);
            animation: underlineFlow 2s ease-in-out infinite;
        }

        @keyframes underlineFlow {
            0%, 100% { transform: translateX(-100%); }
            50% { transform: translateX(100%); }
        }

        .subtitle {
            font-size: 1.25rem;
            color: #9ca3af;
            max-width: 750px;
            margin: auto auto 3.5rem;
            line-height: 1.7;
        }

        .cta-buttons {
            display: flex;
            gap: 1.25rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 4rem;
        }

        .btn-primary {
            padding: 1.1rem 2.5rem;
            background: linear-gradient(135deg, #3b82f6, #6366f1, #8b5cf6);
            background-size: 200% 200%;
            border-radius: 0.7rem;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
            cursor: pointer;
            transition: all 0.4s ease;
            box-shadow: 0 8px 25px rgba(99,102,241,0.4);
            text-decoration: none;
            position: relative;
            overflow: hidden;
            animation: gradientFlow 3s ease infinite;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn-primary:hover::before {
            width: 400px;
            height: 400px;
        }

        .btn-primary:hover {
            box-shadow: 0 12px 40px rgba(99,102,241,0.7);
            transform: translateY(-3px);
        }

        .btn-primary i {
            margin-left: 0.5rem;
            transition: transform 0.3s ease;
        }

        .btn-primary:hover i {
            transform: translateX(5px);
        }

        .btn-secondary {
            padding: 1.1rem 2.5rem;
            border-radius: 0.7rem;
            background: rgba(255,255,255,0.05);
            color: #e5e7eb;
            font-weight: 600;
            font-size: 1.1rem;
            border: 1px solid rgba(255,255,255,0.15);
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            color: #60a5fa;
            border-color: #60a5fa;
            background: rgba(96,165,250,0.1);
            transform: translateY(-2px);
        }

        /* Stats Section */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            max-width: 900px;
            margin: auto;
            padding: 0 2rem;
        }

        .stat-card {
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 1rem;
            padding: 2rem 1.5rem;
            text-align: center;
            backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            animation: fadeUp 1s ease backwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.2s; }
        .stat-card:nth-child(2) { animation-delay: 0.4s; }
        .stat-card:nth-child(3) { animation-delay: 0.6s; }

        .stat-card:hover {
            background: rgba(255,255,255,0.06);
            border-color: rgba(96,165,250,0.3);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(96,165,250,0.2);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #60a5fa, #a78bfa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: #60a5fa;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #9ca3af;
            font-weight: 500;
        }

        /* ================= FOOTER ================= */
        .footer {
            background: rgba(2, 6, 23, 0.95);
            border-top: 1px solid rgba(255,255,255,0.08);
            padding: 1.5rem;
            text-align: center;
            margin-top: 6rem;
            backdrop-filter: blur(10px);
        }

        .footer-text {
            color: #9ca3af;
            font-size: 0.95rem;
        }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 768px) {
            .main-heading { font-size: 2.5rem; }
            .hero-section { padding: 4rem 1.5rem 6rem; }
            .cta-buttons { flex-direction: column; width: 100%; }
            .btn-primary, .btn-secondary { width: 100%; }
            .nav-buttons { gap: 0.5rem; }
            .btn-login, .btn-register { padding: 0.5rem 1rem; font-size: 0.9rem; }
            .stats-section { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <!-- HEADER -->
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

    <!-- HERO -->
    <section class="hero-section">
        <div class="tagline">
            🎯 Ace your next interview
        </div>

        <h2 class="main-heading">
            Master Interview Questions<br />
            with <span class="highlight">Confidence</span>
        </h2>

        <p class="subtitle">
            Practice MCQs from top companies, take quizzes and mock tests,
            track your progress, and prepare smarter for your dream job.
        </p>

        <div class="cta-buttons">
            <asp:LinkButton ID="btnGetStarted" runat="server" CssClass="btn-primary"
                OnClick="btnGetStarted_Click">
                Get Started Free <i class="fas fa-arrow-right"></i>
            </asp:LinkButton>

            <asp:LinkButton ID="btnHaveAccount" runat="server" CssClass="btn-secondary"
                Text="I have an account" OnClick="btnHaveAccount_Click" />
        </div>

        <!-- Stats Section -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-question-circle"></i></div>
                <div class="stat-number">10K+</div>
                <div class="stat-label">Questions</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-number">5K+</div>
                <div class="stat-label">Active Users</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-building"></i></div>
                <div class="stat-number">100+</div>
                <div class="stat-label">Companies</div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="footer">
        <p class="footer-text">
            © 2025 Interview Question Portal. All rights reserved.
        </p>
    </footer>

</form>

<script>
    // Create floating particles
    function createParticle() {
        const particle = document.createElement('div');
        particle.className = 'particle';
        
        const size = Math.random() * 4 + 2;
        const startX = Math.random() * window.innerWidth;
        const duration = Math.random() * 20 + 15;
        const delay = Math.random() * 5;
        
        particle.style.width = size + 'px';
        particle.style.height = size + 'px';
        particle.style.left = startX + 'px';
        particle.style.bottom = '-10px';
        particle.style.animationDuration = duration + 's';
        particle.style.animationDelay = delay + 's';
        particle.style.opacity = Math.random() * 0.5 + 0.2;
        
        document.body.appendChild(particle);
        
        setTimeout(() => {
            particle.remove();
        }, (duration + delay) * 1000);
    }
    
    // Generate particles periodically
    for (let i = 0; i < 15; i++) {
        setTimeout(() => createParticle(), i * 1000);
    }
    
    setInterval(() => createParticle(), 2000);
</script>

</body>
</html>