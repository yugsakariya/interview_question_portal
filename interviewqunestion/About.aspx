<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meet Our Team</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            min-height: 100vh;
            padding: 40px 20px;
            color: #333;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 60px;
            animation: fadeInDown 0.8s ease;
        }

        .header h1 {
            font-size: 3rem;
            color: white;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .header p {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.9);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .team-section {
            display: flex;
            flex-direction: column;
            gap: 60px;
            margin-top: 40px;
        }

        .team-member {
            display: flex;
            align-items: center;
            gap: 40px;
            background: white;
            border-radius: 25px;
            padding: 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            transition: all 0.4s ease;
            animation: fadeInUp 0.8s ease;
            position: relative;
            overflow: hidden;
        }

        .team-member::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, #3b82f6, #1d4ed8);
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .team-member:nth-child(even) {
            flex-direction: row-reverse;
        }

        .member-image {
            flex-shrink: 0;
            width: 280px;
            height: 280px;
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
            position: relative;
            overflow: hidden;
        }

        .member-image::before {
            content: '';
            position: absolute;
            width: 150%;
            height: 150%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 3s ease-in-out infinite;
        }

        .image-content {
            text-align: center;
            color: white;
            z-index: 1;
            padding: 20px;
        }

        .image-icon {
            font-size: 4rem;
            margin-bottom: 15px;
            filter: drop-shadow(0 5px 10px rgba(0,0,0,0.2));
        }

        .image-text {
            font-size: 1.1rem;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .member-details {
            flex: 1;
            min-width: 0;
        }

        .role-badge {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }

        .member-name {
            font-size: 2.2rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .member-title {
            font-size: 1.1rem;
            color: #3b82f6;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .member-description {
            font-size: 1rem;
            color: #4a5568;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .contributions-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .contributions-title::before {
            content: '✦';
            color: #3b82f6;
            margin-right: 10px;
            font-size: 1.3rem;
        }

        .contributions-list {
            list-style: none;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 12px;
        }

        .contributions-list li {
            padding: 10px 0;
            padding-left: 30px;
            color: #4a5568;
            font-size: 0.95rem;
            position: relative;
            line-height: 1.6;
        }

        .contributions-list li::before {
            content: '→';
            position: absolute;
            left: 0;
            color: #3b82f6;
            font-weight: bold;
            font-size: 1.2rem;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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

        @keyframes pulse {
            0%, 100% {
                transform: scale(1) rotate(0deg);
            }
            50% {
                transform: scale(1.1) rotate(5deg);
            }
        }

        .team-member:nth-child(1) { animation-delay: 0.1s; }
        .team-member:nth-child(2) { animation-delay: 0.2s; }
        .team-member:nth-child(3) { animation-delay: 0.3s; }
        .team-member:nth-child(4) { animation-delay: 0.4s; }

        @media (max-width: 968px) {
            .team-member,
            .team-member:nth-child(even) {
                flex-direction: column;
            }

            .member-image {
                width: 100%;
                max-width: 280px;
            }

            .contributions-list {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .header p {
                font-size: 1rem;
            }

            .member-name {
                font-size: 1.8rem;
            }

            .team-member {
                padding: 30px 20px;
            }
        }
        /* Back Button */
.back-button {
    position: fixed;
    top: 20px;
    left: 20px;
    width: 50px;
    height: 50px;
    background: #3b82f6;
    color: black;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.8rem;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
    transition: all 0.3s ease;
    z-index: 1000;
}

.back-button:hover {
    transform: translateX(-5px);
    background: #e0e7ff;
}

    </style>
</head>
<body>
    <div class="back-button" onclick="goBack()">
    ←
</div>
    <div class="container">
        <div class="header">
            <h1>Meet Our Team</h1>
            <p>This Interview Question Portal is developed as a college project by a dedicated team of four students, each bringing unique expertise to create a comprehensive learning platform.</p>
        </div>

        <div class="team-section">
            <!-- Team Member 1 -->
            <div class="team-member">
                <div class="member-image">
                    <div class="image-content">
                        <div class="image-icon">👨‍💼</div>
                        <div class="image-text">Project Leader</div>
                    </div>
                </div>
                <div class="member-details">
                    <div class="role-badge">Team Leader</div>
                    <h2 class="member-name">Darshan Lila</h2>
                    <div class="member-title">Project Leader & Coordinator</div>
                    <p class="member-description">
                        Leads the project with strategic planning, task allocation, and seamless integration of all modules while maintaining coordination between team members. Oversees the entire development lifecycle and ensures all components work together harmoniously.
                    </p>
                    <div class="contributions-title">Key Contributions</div>
                    <ul class="contributions-list">
                        <li>Designed overall system architecture and project blueprint</li>
                        <li>Coordinated frontend and database integration workflows</li>
                        <li>Managed project timelines, milestones, and deliverables</li>
                        <li>Implemented critical application features and core functionality</li>
                    </ul>
                </div>
            </div>

            <!-- Team Member 2 -->
            <div class="team-member">
                <div class="member-image">
                    <div class="image-content">
                        <div class="image-icon">💾</div>
                        <div class="image-text">Database Expert</div>
                    </div>
                </div>
                <div class="member-details">
                    <div class="role-badge">Database</div>
                    <h2 class="member-name">Yug Sakaraya</h2>
                    <div class="member-title">Database Design & Backend Development</div>
                    <p class="member-description">
                        Architected the robust database schema and manages all data operations including users, questions, tests, results, and bookmarks with optimized performance. Ensures data integrity, security, and efficient query processing across the platform.
                    </p>
                    <div class="contributions-title">Key Contributions</div>
                    <ul class="contributions-list">
                        <li>Created normalized database structure with proper relationships</li>
                        <li>Developed complex SQL queries and stored procedures</li>
                        <li>Maintained data integrity and referential constraints</li>
                        <li>Optimized query performance and database indexing</li>
                    </ul>
                </div>
            </div>

            <!-- Team Member 3 -->
            <div class="team-member">
                <div class="member-image">
                    <div class="image-content">
                        <div class="image-icon">🎨</div>
                        <div class="image-text">UI/UX Designer</div>
                    </div>
                </div>
                <div class="member-details">
                    <div class="role-badge">Frontend</div>
                    <h2 class="member-name">Yug Kansagara</h2>
                    <div class="member-title">UI/UX & Web Design Specialist</div>
                    <p class="member-description">
                        Crafted the entire user interface with modern design principles, creating an intuitive and responsive experience across all pages of the portal. Focuses on user-centered design to ensure seamless navigation and engagement throughout the platform.
                    </p>
                    <div class="contributions-title">Key Contributions</div>
                    <ul class="contributions-list">
                        <li>Designed responsive and mobile-friendly page layouts</li>
                        <li>Created interactive user dashboard and quiz interfaces</li>
                        <li>Implemented modern UI/UX patterns and design trends</li>
                        <li>Integrated dynamic data binding and real-time updates</li>
                    </ul>
                </div>
            </div>

            <!-- Team Member 4 -->
            <div class="team-member">
                <div class="member-image">
                    <div class="image-content">
                        <div class="image-icon">📋</div>
                        <div class="image-text">Documentation Lead</div>
                    </div>
                </div>
                <div class="member-details">
                    <div class="role-badge">Documentation</div>
                    <h2 class="member-name">Ruchit Kadeval</h2>
                    <div class="member-title">SRS, Report & Testing Specialist</div>
                    <p class="member-description">
                        Prepared comprehensive project documentation including Software Requirements Specification (SRS), technical diagrams, and conducted thorough testing to ensure system quality. Validates all features and maintains complete technical documentation.
                    </p>
                    <div class="contributions-title">Key Contributions</div>
                    <ul class="contributions-list">
                        <li>Created detailed SRS and technical documentation</li>
                        <li>Designed ER diagrams, UML diagrams, and flowcharts</li>
                        <li>Documented comprehensive test cases and results</li>
                        <li>Performed functional, integration, and usability testing</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <script>
    function goBack() {
        window.history.back();
    }
    </script>

</body>
</html>