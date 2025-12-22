<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="interviewqunestion.Account.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Terminal Login - IQ Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: radial-gradient(circle at top, #1e293b, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .terminal {
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            animation: boot 0.6s ease-out;
        }

        @keyframes boot {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Blinking cursor effect */
        #terminal-input::after {
            content: "|";
            animation: blink 1s infinite;
        }

        @keyframes blink { 50% { opacity: 0; } }
        
        #output::-webkit-scrollbar { width: 4px; }
        #output::-webkit-scrollbar-thumb { background: #334155; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfRole" runat="server" Value="User" />
        <asp:HiddenField ID="hfEmail" runat="server" />
        <asp:HiddenField ID="hfPassword" runat="server" />
        <asp:Button ID="btnSubmitInternal" runat="server" OnClick="btnLogin_Click" style="display:none;" />

        <div class="terminal p-5 rounded-lg font-mono min-w-[520px] max-w-[600px]">
            <div class="terminal-header bg-zinc-700 text-white p-2 rounded-t-lg flex items-center">
                <span class="text-red-500 text-5xl leading-[0px] align-middle -mt-2">•</span>
                <span class="text-yellow-500 text-5xl leading-[0px] align-middle -mt-2 ml-1">•</span>
                <span class="text-green-500 text-5xl leading-[0px] align-middle -mt-2 ml-1">•</span>
                <span class="ml-4 text-sm opacity-70">iq_portal --- bash</span>
            </div>

            <div class="pl-4 pt-4 bg-gray-900 h-[300px] overflow-y-auto border-x border-zinc-800" id="output">
                <p class="text-emerald-400 font-bold mb-2">>> Connection Established...</p>
                <p class="text-gray-500">System: Interview Question Portal (v2.0.1)</p>
                <p class="text-gray-500 mb-4">-----------------------------------------</p>
                <p class="text-sky-300">Enter <span class="text-amber-400 font-bold">[1]</span> for USER LOGIN</p>
                <p class="text-sky-300">Enter <span class="text-amber-400 font-bold">[2]</span> for ADMIN LOGIN</p>
                <p class="text-sky-300">Enter <span class="text-amber-400 font-bold">[3]</span> to REGISTER</p>
            </div>

            <div class="input flex pl-4 bg-gray-900 pb-4 rounded-b-lg items-center border-x border-b border-zinc-800">
                <span class="text-green-500 font-bold">➝</span>
                <span class="text-sky-300 ml-2 font-bold">~</span>
                <span class="ml-2 text-md text-gray-500 italic" id="placeholder"></span>
                <input class="bg-transparent border-none outline-none ring-0 focus:ring-0 text-amber-400 w-full ml-1" 
                       id="terminal-input" type="text" autofocus autocomplete="off" />
            </div>
        </div>

        <script>
            const input = document.getElementById("terminal-input");
            const output = document.getElementById("output");
            const placeholder = document.getElementById("placeholder");

            // Link to ASP.NET Hidden Fields
            const hfRole = document.getElementById('<%= hfRole.ClientID %>');
            const hfEmail = document.getElementById('<%= hfEmail.ClientID %>');
            const hfPassword = document.getElementById('<%= hfPassword.ClientID %>');

            let step = "choice"; // Current state

            function print(text, color = "text-gray-400") {
                const p = document.createElement("p");
                p.className = `${color} mt-1`;
                p.innerHTML = text;
                output.appendChild(p);
                output.scrollTop = output.scrollHeight;
            }

            function typePlaceholder(text) {
                placeholder.textContent = text;
            }

            typePlaceholder("Enter choice...");

            input.addEventListener("keydown", (e) => {
                if (e.key === "Enter") {
                    e.preventDefault();
                    const val = input.value.trim();
                    if (!val && step !== "password") return;
                    
                    // Print the command entered
                    print(`<span class="text-green-500">➝</span> <span class="text-sky-300">~</span> <span class="text-amber-400">${step === 'password' ? '********' : val}</span>`);
                    input.value = "";

                    handleStep(val);
                }
            });

            function handleStep(val) {
                switch (step) {
                    case "choice":
                        if (val === "1") {
                            hfRole.value = "User";
                            print("Access Level: <span class='text-white'>USER</span>", "text-emerald-500");
                            print("Enter Email Address:", "text-sky-300");
                            step = "email";
                        } else if (val === "2") {
                            hfRole.value = "Admin";
                            print("Access Level: <span class='text-white'>ADMIN</span>", "text-emerald-500");
                            print("Enter Email Address:", "text-sky-300");
                            step = "email";
                        } else if (val === "3") {
                            print("Redirecting to Registration...", "text-yellow-400");
                            setTimeout(() => window.location.href = "Register.aspx", 500);
                        } else {
                            print("Invalid Option. Choose 1, 2, or 3.", "text-red-500");
                        }
                        break;

                    case "email":
                        if (val.includes("@")) {
                            hfEmail.value = val;
                            print("Identity Verified.", "text-emerald-500");
                            print("Enter Password:", "text-sky-300");
                            input.type = "password"; // Hide password
                            step = "password";
                        } else {
                            print("Invalid Email Format.", "text-red-500");
                        }
                        break;

                    case "password":
                        hfPassword.value = val;
                        print("Authenticating with IQ-Core...", "text-yellow-400");
                        // Trigger the actual ASP.NET Postback
                        document.getElementById('<%= btnSubmitInternal.ClientID %>').click();
                        break;
                }
            }

            // Keep focus on input
            document.addEventListener("click", () => input.focus());
        </script>
    </form>
</body>
</html>