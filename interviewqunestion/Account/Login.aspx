<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="interviewqunestion.Account.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Terminal Login - IQ Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/matter-js/0.19.0/matter.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: linear-gradient(135deg, #0a0e27 0%, #1a1f3a 50%, #0a0e27 100%);
            font-family: 'Fira Code', monospace;
        }

        /* Physics Background Container */
        #falling-text-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: auto;
        }

        #text-target {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .word {
            position: absolute;
            display: inline-block;
            user-select: none;
            white-space: nowrap;
            font-family: 'Fira Code', monospace;
            font-weight: 800;
            font-size: 1.5rem;
            opacity: 0.7;
            cursor: grab;
            transition: opacity 0.3s ease, transform 0.3s ease;
            pointer-events: auto;
        }

            .word:hover {
                opacity: 1;
                transform: scale(1.1);
            }

            /* Individual word colors - vibrant highlighter palette */
            .word:nth-child(1) { color: #fbbf24; text-shadow: 0 0 20px rgba(251, 191, 36, 0.6); }
            .word:nth-child(2) { color: #f59e0b; text-shadow: 0 0 20px rgba(245, 158, 11, 0.6); }
            .word:nth-child(3) { color: #fb923c; text-shadow: 0 0 20px rgba(251, 146, 60, 0.6); }
            .word:nth-child(4) { color: #facc15; text-shadow: 0 0 20px rgba(250, 204, 21, 0.6); }
            .word:nth-child(5) { color: #fde047; text-shadow: 0 0 20px rgba(253, 224, 71, 0.6); }
            .word:nth-child(6) { color: #a3e635; text-shadow: 0 0 20px rgba(163, 230, 53, 0.6); }
            .word:nth-child(7) { color: #84cc16; text-shadow: 0 0 20px rgba(132, 204, 22, 0.6); }
            .word:nth-child(8) { color: #22c55e; text-shadow: 0 0 20px rgba(34, 197, 94, 0.6); }
            .word:nth-child(9) { color: #10b981; text-shadow: 0 0 20px rgba(16, 185, 129, 0.6); }
            .word:nth-child(10) { color: #14b8a6; text-shadow: 0 0 20px rgba(20, 184, 166, 0.6); }
            .word:nth-child(11) { color: #06b6d4; text-shadow: 0 0 20px rgba(6, 182, 212, 0.6); }
            .word:nth-child(12) { color: #0ea5e9; text-shadow: 0 0 20px rgba(14, 165, 233, 0.6); }
            .word:nth-child(13) { color: #3b82f6; text-shadow: 0 0 20px rgba(59, 130, 246, 0.6); }
            .word:nth-child(14) { color: #6366f1; text-shadow: 0 0 20px rgba(99, 102, 241, 0.6); }
            .word:nth-child(15) { color: #8b5cf6; text-shadow: 0 0 20px rgba(139, 92, 246, 0.6); }
            .word:nth-child(16) { color: #a855f7; text-shadow: 0 0 20px rgba(168, 85, 247, 0.6); }
            .word:nth-child(17) { color: #d946ef; text-shadow: 0 0 20px rgba(217, 70, 239, 0.6); }
            .word:nth-child(18) { color: #ec4899; text-shadow: 0 0 20px rgba(236, 72, 153, 0.6); }
            .word:nth-child(19) { color: #f43f5e; text-shadow: 0 0 20px rgba(244, 63, 94, 0.6); }
            .word:nth-child(20) { color: #ef4444; text-shadow: 0 0 20px rgba(239, 68, 68, 0.6); }

            /* Repeat pattern for more words */
            .word:nth-child(n+21):nth-child(odd) { color: #fbbf24; text-shadow: 0 0 20px rgba(251, 191, 36, 0.6); }
            .word:nth-child(n+21):nth-child(even) { color: #3b82f6; text-shadow: 0 0 20px rgba(59, 130, 246, 0.6); }
            .word:nth-child(n+22):nth-child(3n) { color: #a855f7; text-shadow: 0 0 20px rgba(168, 85, 247, 0.6); }
            .word:nth-child(n+23):nth-child(4n) { color: #10b981; text-shadow: 0 0 20px rgba(16, 185, 129, 0.6); }
            .word:nth-child(n+24):nth-child(5n) { color: #ec4899; text-shadow: 0 0 20px rgba(236, 72, 153, 0.6); }

        .highlighted {
            font-weight: 900 !important;
            font-size: 1.7rem !important;
            animation: highlight-glow 2s ease-in-out infinite;
            filter: drop-shadow(0 0 30px currentColor);
        }

        @keyframes highlight-glow {
            0%, 100% { opacity: 0.9; filter: drop-shadow(0 0 30px currentColor); }
            50% { opacity: 1; filter: drop-shadow(0 0 45px currentColor) drop-shadow(0 0 60px currentColor); }
        }

        /* Atmospheric effects */
        .glow {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 1000px;
            height: 1000px;
            background: radial-gradient( circle, rgba(59, 130, 246, 0.1) 0%, transparent 70% );
            z-index: 0;
            pointer-events: none;
            animation: pulse 6s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 0.3; transform: translate(-50%, -50%) scale(1); }
            50% { opacity: 0.6; transform: translate(-50%, -50%) scale(1.2); }
        }

        .vignette {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            background: radial-gradient( ellipse at center, transparent 30%, rgba(0, 0, 0, 0.6) 100% );
            z-index: 2;
        }

        /* Scan line effect */
        .scanline {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient( to bottom, transparent 50%, rgba(0, 0, 0, 0.03) 51% );
            background-size: 100% 4px;
            z-index: 2;
            pointer-events: none;
            animation: scan 8s linear infinite;
        }

        @keyframes scan {
            0% { background-position: 0 0; }
            100% { background-position: 0 100%; }
        }

        /* Terminal UI */
        .terminal-wrapper {
            position: relative;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            padding: 20px;
            pointer-events: none;
        }

        .terminal {
            background: rgba(10, 14, 39, 0.95);
            backdrop-filter: blur(30px);
            box-shadow: 0 0 100px rgba(59, 130, 246, 0.3), 0 30px 80px rgba(0, 0, 0, 0.8), inset 0 0 0 1px rgba(59, 130, 246, 0.2);
            border-radius: 16px;
            overflow: hidden;
            animation: boot 1s cubic-bezier(0.34, 1.56, 0.64, 1);
            pointer-events: auto;
            min-width: 320px;
            max-width: 700px;
            width: 100%;
        }

        @keyframes boot {
            from { opacity: 0; transform: translateY(40px) scale(0.95); filter: blur(10px); }
            to { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); }
        }

        .terminal-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 14px 18px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid rgba(59, 130, 246, 0.3);
            position: relative;
            overflow: hidden;
        }

            .terminal-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient( 90deg, transparent, rgba(59, 130, 246, 0.15), transparent );
                animation: shimmer 4s infinite;
            }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .terminal-dot {
            width: 13px;
            height: 13px;
            border-radius: 50%;
            margin-right: 9px;
            box-shadow: 0 0 15px currentColor;
        }

        .terminal-title {
            font-size: 11px;
            color: rgba(255, 255, 255, 0.6);
            text-transform: uppercase;
            letter-spacing: 2.5px;
            font-weight: 600;
        }

        #output {
            background: #0a0e27;
            height: 360px;
            overflow-y: auto;
            padding: 24px;
            font-size: 14px;
            line-height: 1.8;
        }

            #output::-webkit-scrollbar { width: 8px; }
            #output::-webkit-scrollbar-track { background: rgba(0, 0, 0, 0.3); }
            #output::-webkit-scrollbar-thumb { background: rgba(59, 130, 246, 0.4); border-radius: 4px; }
            #output::-webkit-scrollbar-thumb:hover { background: rgba(59, 130, 246, 0.6); }

        .input-wrapper {
            display: flex;
            align-items: center;
            padding: 18px 24px;
            background: #0f172a;
            border-top: 1px solid rgba(59, 130, 246, 0.2);
        }

        .prompt {
            color: #10b981;
            font-weight: 700;
            margin-right: 10px;
            font-size: 16px;
            text-shadow: 0 0 15px rgba(16, 185, 129, 0.6);
            animation: glow-pulse 2s ease-in-out infinite;
        }

        @keyframes glow-pulse {
            0%, 100% { text-shadow: 0 0 15px rgba(16, 185, 129, 0.6); }
            50% { text-shadow: 0 0 25px rgba(16, 185, 129, 0.9); }
        }

        .path {
            color: #3b82f6;
            font-weight: 600;
            margin-right: 10px;
        }

        #terminal-input {
            background: transparent;
            border: none;
            outline: none;
            color: #fbbf24;
            flex: 1;
            font-family: 'Fira Code', monospace;
            font-size: 14px;
            font-weight: 500;
        }

        /* Text colors */
        .text-emerald { color: #10b981; text-shadow: 0 0 8px rgba(16, 185, 129, 0.4); }
        .text-sky { color: #38bdf8; text-shadow: 0 0 8px rgba(56, 189, 248, 0.4); }
        .text-amber { color: #fbbf24; text-shadow: 0 0 8px rgba(251, 191, 36, 0.4); }
        .text-gray { color: #64748b; }
        .text-yellow { color: #facc15; text-shadow: 0 0 8px rgba(250, 204, 21, 0.4); }
        .text-red { color: #ef4444; text-shadow: 0 0 8px rgba(239, 68, 68, 0.4); }
        .text-purple { color: #a855f7; text-shadow: 0 0 8px rgba(168, 85, 247, 0.4); }

        .fade-in { animation: fadeIn 0.4s ease-in; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .spinner {
            display: inline-block;
            width: 12px;
            height: 12px;
            border: 2px solid rgba(251, 191, 36, 0.2);
            border-top-color: #fbbf24;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
            margin-right: 8px;
            vertical-align: middle;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        @media (max-width: 640px) {
            .word { font-size: 0.9rem; }
            #output { height: 300px; font-size: 13px; }
            .terminal { border-radius: 0; }
        }
    </style>
</head>
<body>
    <div class="glow"></div>
    <div class="scanline"></div>
    <div class="vignette"></div>

    <form id="form1" runat="server">
        <asp:HiddenField ID="hfRole" runat="server" Value="User" />
        <asp:HiddenField ID="hfEmail" runat="server" />
        <asp:HiddenField ID="hfPassword" runat="server" />
        <asp:Button ID="btnSubmitInternal" runat="server" Style="display: none;" OnClick="btnLogin_Click" />

        <div id="falling-text-container">
            <div id="text-target"></div>
            <div id="canvas-container" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
        </div>

        <div class="terminal-wrapper">
            <div class="terminal">
                <div class="terminal-header">
                    <div class="terminal-dot" style="background: #ef4444; cursor: pointer;" title="Admin Login" onclick="goToAdmin()"></div>
                    <div class="terminal-dot" style="background: #f59e0b;"></div>
                    <div class="terminal-dot" style="background: #10b981;"></div>
                    <span class="terminal-title" style="margin-left: 14px;">IQ PORTAL - Secure Terminal</span>
                </div>

                <div id="output"></div>

                <div class="input-wrapper">
                    <span class="prompt">➜</span>
                    <span class="path">~</span>
                    <input id="terminal-input" type="text" autofocus autocomplete="off" spellcheck="false" />
                </div>
            </div>
        </div>

        <script>
            function goToAdmin() {
                if (!inputEnabled || step !== "choice") return;
                print(`<span class="text-emerald-400">➜</span> <span class="text-amber-400">2</span>`);
                disableInput();
                handleStep("2");
            }

            const initFallingText = () => {
                const container = document.getElementById('falling-text-container');
                const textTarget = document.getElementById('text-target');
                const canvasContainer = document.getElementById('canvas-container');

                const config = {
                    text: "LOGIN PAGE INTERVIEW QUESTION PORTAL IQ PORTAL TERMINAL STYLE USER INTERFACE MODERN INTERACTIVE ENGAGING EXPERIENCE KEYBOARD COMMANDS LINUX TERMINAL SYSTEM DATABASE ENCRYPTION SECURE ACCESS AUTHENTICATION BYTES DATA",
                    highlightWords: ["IQ", "PORTAL", "TERMINAL", "SECURE", "LOGIN"],
                    gravity: 0.6
                };

                const words = config.text.split(' ');
                const { Engine, Render, World, Bodies, Runner, Mouse, MouseConstraint, Body } = Matter;

                const engine = Engine.create();
                engine.world.gravity.y = config.gravity;

                const width = window.innerWidth;
                const height = window.innerHeight;

                const render = Render.create({
                    element: canvasContainer,
                    engine: engine,
                    options: {
                        width,
                        height,
                        background: 'transparent',
                        wireframes: false
                    }
                });

                const thickness = 50;
                const floor = Bodies.rectangle(width / 2, height + thickness / 2, width, thickness, { isStatic: true, render: { fillStyle: 'transparent' } });
                const leftWall = Bodies.rectangle(-thickness / 2, height / 2, thickness, height, { isStatic: true, render: { fillStyle: 'transparent' } });
                const rightWall = Bodies.rectangle(width + thickness / 2, height / 2, thickness, height, { isStatic: true, render: { fillStyle: 'transparent' } });

                const wordBodies = words.map((word, index) => {
                    const isHighlighted = config.highlightWords.includes(word);
                    const elem = document.createElement('span');
                    elem.className = `word ${isHighlighted ? 'highlighted' : ''}`;
                    elem.textContent = word;
                    textTarget.appendChild(elem);

                    const x = Math.random() * (width - 200) + 100;
                    const y = -(Math.random() * height + index * 30);
                    const w = word.length * 18 + 30;
                    const h = 35;

                    const body = Bodies.rectangle(x, y, w, h, {
                        restitution: 0.4,
                        friction: 0.01,
                        frictionAir: 0.015,
                        density: 0.001,
                        render: { fillStyle: 'transparent' }
                    });

                    Body.setAngularVelocity(body, (Math.random() - 0.5) * 0.08);
                    return { elem, body };
                });

                const mouse = Mouse.create(render.canvas);
                const mouseConstraint = MouseConstraint.create(engine, {
                    mouse: mouse,
                    constraint: { stiffness: 0.15, render: { visible: false } }
                });

                World.add(engine.world, [floor, leftWall, rightWall, mouseConstraint, ...wordBodies.map(wb => wb.body)]);

                Runner.run(Runner.create(), engine);
                Render.run(render);

                const updateLoop = () => {
                    wordBodies.forEach(({ body, elem }) => {
                        const { x, y } = body.position;
                        const angle = body.angle;
                        elem.style.left = `${x}px`;
                        elem.style.top = `${y}px`;
                        elem.style.transform = `translate(-50%, -50%) rotate(${angle}rad)`;
                    });
                    requestAnimationFrame(updateLoop);
                };
                updateLoop();
            };

            const input = document.getElementById("terminal-input");
            const output = document.getElementById("output");
            const hfRole = document.getElementById('<%= hfRole.ClientID %>');
            const hfEmail = document.getElementById('<%= hfEmail.ClientID %>');
            const hfPassword = document.getElementById('<%= hfPassword.ClientID %>');

            let step = "boot";
            let inputEnabled = false;

            function print(text, className = "text-gray", animate = true) {
                const p = document.createElement("p");
                p.className = `${className} ${animate ? 'fade-in' : ''}`;
                p.style.marginTop = '6px';
                p.innerHTML = text;
                output.appendChild(p);
                output.scrollTop = output.scrollHeight;
            }

            function enableInput() {
                inputEnabled = true;
                input.disabled = false;
                input.focus();
            }

            function disableInput() {
                inputEnabled = false;
                input.disabled = true;
            }

            setTimeout(() => {
                print('<span class="text-emerald" style="font-weight: 700;">╔════════════════════════════════════════╗</span>', '', false);
                print('<span class="text-emerald" style="font-weight: 700;">║</span>  <span class="text-purple">PHYSICS ENGINE INITIALIZED...</span>      <span class="text-emerald" style="font-weight: 700;">║</span>', '', false);
                print('<span class="text-emerald" style="font-weight: 700;">╚════════════════════════════════════════╝</span>', '', false);
            }, 400);

            setTimeout(() => {
                print('System: <span class="text-sky">IQ Portal v2.5.1</span>', 'text-gray');
                print('Interface: <span class="text-purple">Terminal UI Active</span>', 'text-gray');
                print('Security: <span class="text-yellow">256-bit Encrypted</span>', 'text-gray');
            }, 1000);

            setTimeout(() => {
                print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', 'text-gray');
            }, 1500);

            setTimeout(() => {
                print('');
                print('<span class="text-sky">▶ Enter <span class="text-amber">[1]</span> for USER LOGIN</span>');
                print('<span class="text-sky">▶ Enter <span class="text-amber">[2]</span> to REGISTER</span>');
                print('');
                print('<span class="text-gray" style="font-style: italic; font-size: 12px;">💡 Tip: Press ESC to go back</span>', 'text-gray');
                print('');
                step = "choice";
                enableInput();
            }, 2000);

            input.addEventListener("keydown", (e) => {
                if (e.key === "Escape" && inputEnabled) {
                    e.preventDefault();
                    handleEsc();
                    return;
                }
                if (e.key === "Enter" && inputEnabled) {
                    e.preventDefault();
                    const val = input.value.trim();
                    if (!val && step !== "password") return;
                    
                    // Check if user typed 'reset' during password step
                    if (step === "password" && val.toLowerCase() === "reset") {
                        print('<span class="prompt">➜</span> <span class="text-purple">reset</span>', '', false);
                        input.value = "";
                        disableInput();
                        handleForgotPassword();
                        return;
                    }
                    
                    const displayVal = (step === 'password' || step === 'newPassword' || step === 'confirmPassword') ? '•'.repeat(8) : val;
                    print(`<span class="prompt">➜</span> <span class="text-amber">${displayVal}</span>`, '', false);
                    input.value = "";
                    disableInput();
                    handleStep(val);
                }
            });

            function handleEsc() {
                if (step === "password") {
                    print('<span class="text-yellow">⟵ Returning to email input...</span>', 'text-yellow');
                    input.type = "text";
                    step = "email";
                    setTimeout(() => {
                        print('<span class="text-sky">📧 Enter Email Address:</span>', 'text-sky');
                        enableInput();
                    }, 300);
                } else if (step === "email") {
                    print('<span class="text-yellow">⟵ Returning to main menu...</span>', 'text-yellow');
                    step = "choice";
                    setTimeout(() => {
                        print('');
                        print('<span class="text-sky">▶ Enter <span class="text-amber">[1]</span> for USER LOGIN</span>');
                        print('<span class="text-sky">▶ Enter <span class="text-amber">[2]</span> to REGISTER</span>');
                        print('');
                        enableInput();
                    }, 300);
                }
            }

            function handleStep(val) {
                if (step === "choice") {
                    if (val === "1") {
                        hfRole.value = "User";
                        print('<span class="text-emerald">✓ USER MODE SELECTED</span>', 'text-emerald');
                        print('<span class="text-sky">📧 Enter Email Address:</span>', 'text-sky');
                        step = "email";
                        enableInput();
                    } else if (val === "2") {
                        print('<span class="text-purple">↗ Redirecting to registration...</span>', 'text-purple');
                        setTimeout(() => {
                            window.location.href = '<%= ResolveUrl("~/Account/Register.aspx") %>';
                        }, 900);
                    } else {
                        print('<span class="text-red">✗ Invalid selection. Enter 1, 2</span>', 'text-red');
                        enableInput();
                    }
                } else if (step === "email") {
                    if (val.includes('@') && val.includes('.')) {
                        // Show checking message
                        print('<span class="spinner"></span><span class="text-yellow">Checking email in database...</span>', 'text-yellow');
                        
                        // AJAX call to check if email exists in database
                        fetch('Login.aspx/CheckEmailExists', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({ email: val })
                        })
                        .then(response => response.json())
                        .then(data => {
                            const result = data.d;
                            if (result.success) {
                                hfEmail.value = val;
                                print('<span class="text-emerald">✓</span> Email verified successfully', 'text-emerald');
                                print('');
                                print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                                print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                                input.type = "password";
                                step = "password";
                                enableInput();
                            } else {
                                print('<span class="text-red">✗ ' + result.message + '</span>', 'text-red');
                                enableInput();
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            print('<span class="text-red">✗ System error. Please try again.</span>', 'text-red');
                            enableInput();
                        });
                    } else {
                        setTimeout(() => {
                            print('<span class="text-red">✗</span> Invalid email format. Must contain @ and domain', 'text-red');
                            enableInput();
                        }, 300);
                    }
                } else if (step === "password") {
                    input.type = "text";
                    print('');
                    print('<span class="spinner"></span><span class="text-yellow">Authenticating credentials...</span>', 'text-yellow');
                    
                    // AJAX call to verify credentials
                    fetch('Login.aspx/VerifyCredentials', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ email: hfEmail.value, password: val })
                    })
                    .then(response => response.json())
                    .then(data => {
                        const result = data.d;
                        if (result.success) {
                            // Password correct - show success messages and redirect
                            print('<span class="text-emerald">✓</span> Establishing secure connection...', 'text-emerald');
                            setTimeout(() => {
                                print('<span class="text-emerald">✓</span> Access granted. Redirecting...', 'text-emerald');
                            }, 500);
                            setTimeout(() => {
                                // Redirect using the URL from server
                                const redirectUrl = result.redirectUrl.replace('~/', '<%= ResolveUrl("~/") %>');
                                window.location.href = redirectUrl;
                            }, 1000);
                        } else {
                            // Password incorrect - show error and allow retry
                            print('<span class="text-red">✗ ' + result.message + '</span>', 'text-red');
                            print('');
                            print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                            print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                            input.type = "password";
                            enableInput();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        print('<span class="text-red">✗ System error. Please try again.</span>', 'text-red');
                        print('');
                        print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                        print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                        input.type = "password";
                        enableInput();
                    });
                } else if (step === "enterOTP") {
                    print('');
                    print('<span class="spinner"></span><span class="text-yellow">Verifying OTP...</span>', 'text-yellow');
                    
                    // Store OTP for password reset
                    hfPassword.value = val; // Temporarily store OTP
                    
                    setTimeout(() => {
                        print('<span class="text-emerald">✓</span> OTP verified', 'text-emerald');
                        print('');
                        print('<span class="text-sky">🔐 Enter New Password:</span>', 'text-sky');
                        input.type = "password";
                        step = "newPassword";
                        enableInput();
                    }, 500);
                } else if (step === "newPassword") {
                    if (val.length < 6) {
                        print('<span class="text-red">✗ Password must be at least 6 characters</span>', 'text-red');
                        print('');
                        print('<span class="text-sky">🔐 Enter New Password:</span>', 'text-sky');
                        input.type = "password";
                        enableInput();
                        return;
                    }
                    
                    const storedOTP = hfPassword.value;
                    const newPassword = val;
                    
                    print('');
                    print('<span class="spinner"></span><span class="text-yellow">Resetting password...</span>', 'text-yellow');
                    
                    // AJAX call to verify OTP and reset password
                    fetch('Login.aspx/VerifyOTPAndResetPassword', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ email: hfEmail.value, otp: storedOTP, newPassword: newPassword })
                    })
                    .then(response => response.json())
                    .then(data => {
                        const result = data.d;
                        if (result.success) {
                            print('<span class="text-emerald">✓ ' + result.message + '</span>', 'text-emerald');
                            print('');
                            print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                            print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                            input.type = "password";
                            step = "password";
                            hfPassword.value = "";
                            enableInput();
                        } else {
                            print('<span class="text-red">✗ ' + result.message + '</span>', 'text-red');
                            print('');
                            print('<span class="text-sky">🔢 Enter OTP from email:</span>', 'text-sky');
                            input.type = "text";
                            step = "enterOTP";
                            enableInput();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        print('<span class="text-red">✗ System error. Please try again.</span>', 'text-red');
                        print('');
                        print('<span class="text-sky">🔢 Enter OTP from email:</span>', 'text-sky');
                        input.type = "text";
                        step = "enterOTP";
                        enableInput();
                    });
                }
            }
            
            // Handle forgot password flow
            function handleForgotPassword() {
                print('');
                print('<span class="spinner"></span><span class="text-yellow">Sending OTP to your email...</span>', 'text-yellow');
                
                fetch('Login.aspx/SendPasswordResetOTP', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ email: hfEmail.value })
                })
                .then(response => response.json())
                .then(data => {
                    const result = data.d;
                    if (result.success) {
                        print('<span class="text-emerald">✓ ' + result.message + '</span>', 'text-emerald');
                        print('');
                        print('<span class="text-sky">🔢 Enter 6-digit OTP from email:</span>', 'text-sky');
                        input.type = "text";
                        step = "enterOTP";
                        enableInput();
                    } else {
                        print('<span class="text-red">✗ ' + result.message + '</span>', 'text-red');
                        print('');
                        print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                        print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                        input.type = "password";
                        step = "password";
                        enableInput();
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    print('<span class="text-red">✗ Failed to send OTP. Please try again.</span>', 'text-red');
                    print('');
                    print('<span class="text-sky">🔒 Enter Password:</span>', 'text-sky');
                    print('<span class="text-gray" style="font-size:12px;">💡 Type <span class="text-purple">reset</span> to reset password</span>', 'text-gray');
                    input.type = "password";
                    step = "password";
                    enableInput();
                });
            }

            document.addEventListener("click", (e) => {
                if (inputEnabled && !e.target.classList.contains('word')) {
                    input.focus();
                }
            });

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', initFallingText);
            } else {
                initFallingText();
            }
            
            // Handle browser back/forward navigation - reset the terminal state
            window.addEventListener('pageshow', function(event) {
                if (event.persisted) {
                    // Page was loaded from cache (back/forward navigation)
                    // Reset the terminal to initial state
                    output.innerHTML = '';
                    input.value = '';
                    input.type = 'text';
                    step = 'boot';
                    inputEnabled = false;
                    input.disabled = true;
                    hfEmail.value = '';
                    hfPassword.value = '';
                    
                    // Re-run the boot sequence
                    setTimeout(() => {
                        print('<span class="text-emerald" style="font-weight: 700;">╔════════════════════════════════════════╗</span>', '', false);
                        print('<span class="text-emerald" style="font-weight: 700;">║</span>  <span class="text-purple">TERMINAL RESTORED...</span>              <span class="text-emerald" style="font-weight: 700;">║</span>', '', false);
                        print('<span class="text-emerald" style="font-weight: 700;">╚════════════════════════════════════════╝</span>', '', false);
                    }, 200);
                    
                    setTimeout(() => {
                        print('System: <span class="text-sky">IQ Portal v2.5.1</span>', 'text-gray');
                        print('Interface: <span class="text-purple">Terminal UI Active</span>', 'text-gray');
                    }, 600);
                    
                    setTimeout(() => {
                        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', 'text-gray');
                    }, 900);
                    
                    setTimeout(() => {
                        print('');
                        print('<span class="text-sky">▶ Enter <span class="text-amber">[1]</span> for USER LOGIN</span>');
                        print('<span class="text-sky">▶ Enter <span class="text-amber">[2]</span> to REGISTER</span>');
                        print('');
                        print('<span class="text-gray" style="font-style: italic; font-size: 12px;">💡 Tip: Press ESC to go back</span>', 'text-gray');
                        print('');
                        step = "choice";
                        enableInput();
                    }, 1200);
                }
            });
        </script>
    </form>
</body>
</html>