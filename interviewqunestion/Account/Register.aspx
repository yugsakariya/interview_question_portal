<%@ Page Title="Register" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="interviewqunestion.Account.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Terminal Register - IQ Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: radial-gradient(circle at top, #0f172a, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
            font-family: 'Courier New', Courier, monospace;
        }
        .terminal {
            animation: boot 0.6s ease-out;
            box-shadow: 0 0 50px rgba(56, 189, 248, 0.15);
            border: 1px solid rgba(255,255,255,0.1);
        }
        @keyframes boot {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .cursor-blink { animation: blink 1s infinite; }
        @keyframes blink { 50% { opacity: 0; } }
        #output::-webkit-scrollbar { width: 4px; }
        #output::-webkit-scrollbar-thumb { background: #334155; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hfFirstName" runat="server" />
        <asp:HiddenField ID="hfLastName" runat="server" />
        <asp:HiddenField ID="hfEmail" runat="server" />
        <asp:HiddenField ID="hfPassword" runat="server" />
        <asp:Button ID="btnSubmitInternal" runat="server" OnClick="btnRegister_Click" style="display:none;" />

        <div class="terminal p-0 rounded-lg w-full max-w-2xl bg-zinc-900 overflow-hidden">
            <div class="bg-zinc-800 px-4 py-2 flex items-center justify-between border-b border-zinc-700">
                <div class="flex gap-2">
                    <div class="w-3 h-3 rounded-full bg-red-500"></div>
                    <div class="w-3 h-3 rounded-full bg-yellow-500"></div>
                    <div class="w-3 h-3 rounded-full bg-green-500"></div>
                </div>
                <span class="text-zinc-400 text-xs uppercase tracking-widest">iq_portal --- register_wizard</span>
            </div>

            <div id="output" class="p-6 h-[400px] overflow-y-auto text-sm leading-relaxed border-b border-zinc-800">
                <p class="text-emerald-500 font-bold mb-2">>> Initializing Registration Protocol...</p>
                <p class="text-zinc-500">System: IQ Portal User Onboarding</p>
                <p class="text-zinc-500 mb-4">Status: Secure Channel Established</p>
                
                <div id="log-content">
                    <p class="text-sky-400">Step 1: Identity initialization</p>
                    <p class="text-sky-300 italic">Enter First Name:</p>
                </div>
            </div>

            <div class="flex items-center px-6 py-4 bg-zinc-900">
                <span class="text-emerald-500 mr-2 font-bold">guest@iq:~$</span>
                <div class="relative flex-1 flex items-center">
                    <span id="placeholder" class="absolute text-gray-600 pointer-events-none"></span>
                    <input id="term-input" type="text" autofocus autocomplete="off"
                           class="bg-transparent border-none outline-none text-amber-400 w-full font-mono relative z-10" />
                    <span class="text-amber-400 cursor-blink ml-1 font-bold">|</span>
                </div>
            </div>
            
            <div class="px-6 pb-4 text-xs text-zinc-600 text-right">
                Already registered? <a href="Login.aspx" class="text-sky-600 hover:underline">Login</a>
            </div>
        </div>
    </form>

    <script>
        const input = document.getElementById("term-input");
        const logContent = document.getElementById("log-content");
        const outputDiv = document.getElementById("output");

        // ASP.NET Hidden Fields
        const hfFirst = document.getElementById('<%= hfFirstName.ClientID %>');
        const hfLast = document.getElementById('<%= hfLastName.ClientID %>');
        const hfEmail = document.getElementById('<%= hfEmail.ClientID %>');
        const hfPass = document.getElementById('<%= hfPassword.ClientID %>');
        const btnSubmit = document.getElementById('<%= btnSubmitInternal.ClientID %>');

        let step = "firstName";

        function print(text, color = "text-zinc-400") {
            const p = document.createElement("p");
            p.className = `${color} mt-1`;
            p.innerHTML = text;
            logContent.appendChild(p);
            outputDiv.scrollTop = outputDiv.scrollHeight;
        }

        input.addEventListener("keydown", (e) => {
            if (e.key !== "Enter") return;

            const val = input.value.trim();
            if (!val && step !== "done") return;

            input.value = "";
            print(`> ${step === 'password' ? '********' : val}`, "text-amber-500 font-bold");

            if (step === "firstName") {
                hfFirst.value = val;
                print("Enter Last Name:", "text-sky-300 italic");
                step = "lastName";
            }
            else if (step === "lastName") {
                hfLast.value = val;
                print("Enter Email Address:", "text-sky-300 italic");
                step = "email";
            }
            else if (step === "email") {
                if (!val.includes("@")) {
                    print("Error: Invalid email format. Try again:", "text-red-500");
                } else {
                    hfEmail.value = val;
                    print("Create Security Key (Password):", "text-sky-300 italic");
                    input.type = "password";
                    step = "password";
                }
            }
            else if (step === "password") {
                if (val.length < 6) {
                    print("Error: Security key must be 6+ characters. Try again:", "text-red-500");
                } else {
                    hfPass.value = val;
                    print("Confirming credentials...", "text-yellow-500");
                    input.disabled = true;
                    setTimeout(() => {
                        print("Syncing with IQ Central Database...", "text-emerald-400");
                        btnSubmit.click();
                    }, 1000);
                }
            }
        });

        document.addEventListener("click", () => input.focus());
    </script>
</body>
</html>