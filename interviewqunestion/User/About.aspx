<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="interviewqunestion.User.About" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Us - IQ Portal Team</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="~/Styles/About.css" rel="stylesheet" /> 
    <style>
        /* Basic styles needed if not using a Master Page's body styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f3f4f6; /* Light gray background for contrast */
        }
        /* Style for the back button container */
        .back-button-container {
            max-width: 1200px;
            margin-left:-10px;
            padding: 1rem 1rem 0;
        }
        /* Style for the back button */
        .btn-back {
            background: #ffffff;
            color: #4b5563;
            border: 1px solid #d1d5db;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        .btn-back:hover {
            background-color: #f9fafb;
            border-color: #9ca3af;
            color: #1f2937;
            transform: translateY(-1px);
        }
        /* Adjusted header padding to account for button */
        .about-header {
            padding-top: 1rem; 
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="back-button-container">
            <button type="button" class="btn-back" onclick="window.history.back()">
                <i class="fas fa-arrow-left"></i>
                
            </button>
        </div>
        <div class="about-page">
            <div class="about-header">
                <h2>Meet Our Team</h2>
                <p>
                    This Interview Question Portal is developed as a college project by a dedicated team of four students,
                    each bringing unique expertise to create a comprehensive learning platform.
                </p>
            </div>

            <div class="team-grid">

                <div class="member-card role-leader">
                    <div class="member-photo-container">
                        <span class="member-role-badge">Team Leader</span>
                        <img src="https://ui-avatars.com/api/?name=Student+One&size=280&background=3b82f6&color=fff&bold=true&font-size=0.4"
                             alt="Team Leader"
                             class="member-photo" />
                    </div>
                    <div class="member-content">
                        <h3 class="member-name">Student Name 1</h3>
                        <p class="member-role">Project Leader & Coordinator</p>

                        <p class="member-desc">
                            Leads the project with strategic planning, task allocation, and seamless integration of all modules
                            while maintaining coordination between team members.
                        </p>

                        <div class="member-responsibility-title">Key Contributions</div>
                        <ul class="member-responsibility-list">
                            <li>Designed overall system architecture</li>
                            <li>Coordinated frontend and database integration</li>
                            <li>Managed project timelines and deliverables</li>
                            <li>Implemented critical application features</li>
                        </ul>
                    </div>
                </div>

                <div class="member-card role-db">
                    <div class="member-photo-container">
                        <span class="member-role-badge">Database</span>
                        <img src="https://ui-avatars.com/api/?name=Student+Two&size=280&background=10b981&color=fff&bold=true&font-size=0.4"
                             alt="Database Developer"
                             class="member-photo" />
                    </div>
                    <div class="member-content">
                        <h3 class="member-name">Student Name 2</h3>
                        <p class="member-role">Database Design & Backend</p>

                        <p class="member-desc">
                            Architected the database schema and manages all data operations including users, questions,
                            tests, results, and bookmarks with optimized performance.
                        </p>

                        <div class="member-responsibility-title">Key Contributions</div>
                        <ul class="member-responsibility-list">
                            <li>Created normalized database structure</li>
                            <li>Developed SQL queries and procedures</li>
                            <li>Maintained data integrity and relationships</li>
                            <li>Optimized query performance</li>
                        </ul>
                    </div>
                </div>

                <div class="member-card role-frontend">
                    <div class="member-photo-container">
                        <span class="member-role-badge">Frontend</span>
                        <img src="https://ui-avatars.com/api/?name=Student+Three&size=280&background=f59e0b&color=fff&bold=true&font-size=0.4"
                             alt="Frontend Developer"
                             class="member-photo" />
                    </div>
                    <div class="member-content">
                        <h3 class="member-name">Student Name 3</h3>
                        <p class="member-role">UI/UX & Web Design</p>

                        <p class="member-desc">
                            Crafted the entire user interface with modern design principles, creating an intuitive
                            and responsive experience across all pages of the portal.
                        </p>

                        <div class="member-responsibility-title">Key Contributions</div>
                        <ul class="member-responsibility-list">
                            <li>Designed responsive page layouts</li>
                            <li>Created user dashboard and quiz interfaces</li>
                            <li>Implemented modern UI/UX patterns</li>
                            <li>Integrated dynamic data binding</li>
                        </ul>
                    </div>
                </div>

                <div class="member-card role-srs">
                    <div class="member-photo-container">
                        <span class="member-role-badge">Documentation</span>
                        <img src="https://ui-avatars.com/api/?name=Student+Four&size=280&background=8b5cf6&color=fff&bold=true&font-size=0.4"
                             alt="Documentation Specialist"
                             class="member-photo" />
                    </div>
                    <div class="member-content">
                        <h3 class="member-name">Student Name 4</h3>
                        <p class="member-role">SRS, Report & Testing</p>

                        <p class="member-desc">
                            Prepared comprehensive project documentation including SRS, technical diagrams,
                            and conducted thorough testing to ensure system quality.
                        </p>

                        <div class="member-responsibility-title">Key Contributions</div>
                        <ul class="member-responsibility-list">
                            <li>Created SRS documentation</li>
                            <li>Designed ER and UML diagrams</li>
                            <li>Documented test cases and results</li>
                            <li>Performed functional testing</li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>