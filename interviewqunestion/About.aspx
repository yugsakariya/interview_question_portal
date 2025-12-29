<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meet Our Team - Interview Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #0a0a0f;
            min-height: 100vh;
            color: #ffffff;
            position: relative;
            overflow-x: hidden;
        }

        .gradient-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            background: linear-gradient(135deg, #0a0a0f 0%, #1a1a2e 100%);
        }

        .gradient-bg::before,
        .gradient-bg::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.4;
            animation: float 20s ease-in-out infinite;
        }

        .gradient-bg::before {
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, #6366f1 0%, transparent 70%);
            top: -200px;
            right: -100px;
        }

        .gradient-bg::after {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, #ec4899 0%, transparent 70%);
            bottom: -150px;
            left: -100px;
            animation-delay: -10s;
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            33% {
                transform: translate(50px, -50px) scale(1.1);
            }
            66% {
                transform: translate(-30px, 30px) scale(0.9);
            }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 60px 20px;
            position: relative;
            z-index: 1;
        }

        .back-button {
            position: fixed;
            top: 30px;
            left: 30px;
            width: 56px;
            height: 56px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 1000;
            text-decoration: none;
        }

        .back-button:hover {
            background: rgba(99, 102, 241, 0.2);
            border-color: #6366f1;
            transform: translateX(-5px);
            box-shadow: 0 0 30px rgba(99, 102, 241, 0.3);
        }

        .header {
            text-align: center;
            margin-bottom: 80px;
            animation: fadeInDown 0.8s ease;
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 28px;
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 50px;
            color: #a5b4fc;
            font-size: 0.875rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
        }

        .header h1 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 4.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff 0%, #a5b4fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            margin-bottom: 25px;
            letter-spacing: -2px;
            line-height: 1.1;
        }

        .header p {
            font-size: 1.25rem;
            color: #94a3b8;
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.8;
        }

        .stats-section {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 60px;
            animation: fadeInUp 1s ease 0.2s both;
        }

        .stat-box {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, #6366f1, transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-box:hover::before {
            opacity: 1;
        }

        .stat-box:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.05);
            border-color: #6366f1;
            box-shadow: 0 10px 40px rgba(99, 102, 241, 0.2);
        }

        .stat-number {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff, #a5b4fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #94a3b8;
            font-weight: 600;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .team-card {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 24px;
            padding: 40px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeInUp 0.8s ease both;
        }

        .team-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent-color), transparent);
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .team-card:hover::before {
            opacity: 1;
        }

        .team-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.05);
            border-color: var(--accent-color);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4), 0 0 40px var(--accent-glow);
        }

        .team-card:nth-child(1) {
            --accent-color: #6366f1;
            --accent-glow: rgba(99, 102, 241, 0.2);
        }

        .team-card:nth-child(2) {
            --accent-color: #ec4899;
            --accent-glow: rgba(236, 72, 153, 0.2);
        }

        .team-card:nth-child(3) {
            --accent-color: #14b8a6;
            --accent-glow: rgba(20, 184, 166, 0.2);
        }

        .team-card:nth-child(4) {
            --accent-color: #f59e0b;
            --accent-glow: rgba(245, 158, 11, 0.2);
        }

        .card-avatar {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            position: relative;
        }

        .avatar-circle {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-color), rgba(255, 255, 255, 0.1));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            position: relative;
            z-index: 1;
            transition: all 0.4s ease;
        }

        .team-card:hover .avatar-circle {
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 0 40px var(--accent-glow);
        }

        .avatar-circle::before {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-color), transparent);
            opacity: 0.5;
            filter: blur(10px);
            z-index: -1;
        }

        .card-content {
            text-align: center;
        }

        .role-tag {
            display: inline-block;
            padding: 8px 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--accent-color);
            border-radius: 50px;
            color: var(--accent-color);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            margin-bottom: 15px;
        }

        .member-name {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 8px;
            line-height: 1.2;
        }

        .member-role {
            font-size: 1rem;
            color: var(--accent-color);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .member-bio {
            font-size: 0.9rem;
            color: #94a3b8;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .skills-section {
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
        }

        .skills-title {
            font-size: 0.8rem;
            font-weight: 700;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .skills-title i {
            color: var(--accent-color);
        }

        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: center;
        }

        .skill-tag {
            padding: 6px 14px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            font-size: 0.75rem;
            color: #cbd5e1;
            transition: all 0.3s ease;
            cursor: default;
        }

        .skill-tag:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--accent-color);
            color: var(--accent-color);
            transform: translateY(-2px);
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .team-card:nth-child(1) { animation-delay: 0.1s; }
        .team-card:nth-child(2) { animation-delay: 0.2s; }
        .team-card:nth-child(3) { animation-delay: 0.3s; }
        .team-card:nth-child(4) { animation-delay: 0.4s; }

        @media (max-width: 1024px) {
            .team-grid {
                grid-template-columns: 1fr;
            }

            .stats-section {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.5rem;
            }

            .header p {
                font-size: 1rem;
            }

            .stats-section {
                grid-template-columns: 1fr;
            }

            .back-button {
                width: 48px;
                height: 48px;
                top: 20px;
                left: 20px;
            }

            .team-card {
                padding: 30px 20px;
            }
        }

        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: #0a0a0f;
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(99, 102, 241, 0.3);
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(99, 102, 241, 0.5);
        }
    </style>
</head>

<body>
    <div class="gradient-bg"></div>

    <a href="javascript:history.back()" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>

    <div class="container">
        <div class="header">
            <div class="header-badge">
                <i class="fas fa-users"></i> Our Team
            </div>
            <h1>Meet Our Team</h1>
            <p>A dedicated team of four students collaborating to build a comprehensive interview preparation platform
                with cutting-edge technology and modern design principles.</p>
        </div>

        <div class="stats-section">
            <div class="stat-box">
                <div class="stat-number">4</div>
                <div class="stat-label">Team Members</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">100%</div>
                <div class="stat-label">Dedication</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">1</div>
                <div class="stat-label">Vision</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">∞</div>
                <div class="stat-label">Possibilities</div>
            </div>
        </div>

        <div class="team-grid">
            <div class="team-card">
                <div class="card-avatar">
                    <div class="avatar-circle">👨‍💼</div>
                </div>
                <div class="card-content">
                    <div class="role-tag"><i class="fas fa-crown"></i> Team Leader</div>
                    <h2 class="member-name">Darshan Lila</h2>
                    <div class="member-role">Project Leader &amp; Coordinator</div>
                    <p class="member-bio">Leads the project with strategic planning, task allocation, and seamless
                        integration of all modules while maintaining coordination between team members.</p>
                    <div class="skills-section">
                        <div class="skills-title"><i class="fas fa-star"></i> Key Expertise</div>
                        <div class="skills-list">
                            <div class="skill-tag">System Architecture</div>
                            <div class="skill-tag">Project Management</div>
                            <div class="skill-tag">Integration</div>
                            <div class="skill-tag">Leadership</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="card-avatar">
                    <div class="avatar-circle"><i class="fas fa-database"></i></div>
                </div>
                <div class="card-content">
                    <div class="role-tag"><i class="fas fa-database"></i> Database Expert</div>
                    <h2 class="member-name">Yug Sakariya</h2>
                    <div class="member-role">Database Design &amp; Backend</div>
                    <p class="member-bio">Architected the robust database schema and manages all data operations with
                        optimized performance, ensuring data integrity and security.</p>
                    <div class="skills-section">
                        <div class="skills-title"><i class="fas fa-star"></i> Key Expertise</div>
                        <div class="skills-list">
                            <div class="skill-tag">SQL Server</div>
                            <div class="skill-tag">Stored Procedures</div>
                            <div class="skill-tag">Data Modeling</div>
                            <div class="skill-tag">Optimization</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="card-avatar">
                    <div class="avatar-circle"><i class="fa-solid fa-laptop-code"></i></div>
                </div>
                <div class="card-content">
                    <div class="role-tag"><i class="fas fa-palette"></i> UI/UX Designer</div>
                    <h2 class="member-name">Yug Kansagara</h2>
                    <div class="member-role">UI/UX &amp; Frontend Developer</div>
                    <p class="member-bio">Crafted the entire user interface with modern design principles, creating an
                        intuitive and responsive experience across all pages.</p>
                    <div class="skills-section">
                        <div class="skills-title"><i class="fas fa-star"></i> Key Expertise</div>
                        <div class="skills-list">
                            <div class="skill-tag">UI Design</div>
                            <div class="skill-tag">Responsive Web</div>
                            <div class="skill-tag">CSS/HTML</div>
                            <div class="skill-tag">UX Patterns</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="card-avatar">
                    <div class="avatar-circle">📋</div>
                </div>
                <div class="card-content">
                    <div class="role-tag"><i class="fas fa-file-alt"></i> Documentation</div>
                    <h2 class="member-name">Ruchit Kadeval</h2>
                    <div class="member-role">SRS, Report &amp; Testing</div>
                    <p class="member-bio">Prepared comprehensive project documentation including SRS, technical
                        diagrams, and conducted thorough testing to ensure system quality.</p>
                    <div class="skills-section">
                        <div class="skills-title"><i class="fas fa-star"></i> Key Expertise</div>
                        <div class="skills-list">
                            <div class="skill-tag">Documentation</div>
                            <div class="skill-tag">Testing</div>
                            <div class="skill-tag">UML Diagrams</div>
                            <div class="skill-tag">Quality Assurance</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function goBack() { window.history.back(); }
    </script>
</body>

</html>