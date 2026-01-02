<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8" />
<title>Interview Question Portal | Loading</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<style>
:root {
  --bg: #020617;
  --text: #e5e7eb;
  --muted: #9ca3af;
  --accent: #38bdf8;
  --grid: rgba(255,255,255,0.06);
}

* {
  box-sizing: border-box;
  font-family: "JetBrains Mono", monospace;
}

body {
  margin: 0;
  background: radial-gradient(circle at top, #0f172a, #020617);
  color: var(--text);
  height: 100vh;
  overflow: hidden;
}

/* Layout */
.wrapper {
  display: flex;
  height: 100vh;
  padding: 40px;
}

/* Left */
.left {
  width: 55%;
}

/* Branding */
.brand {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 25px;
}

.brand span {
  color: var(--accent);
}

/* Logs */
.logs {
  font-size: 14px;
  line-height: 1.9;
}

.log {
  opacity: 0;
  animation: fadeIn 0.6s forwards;
}

.log time {
  color: var(--muted);
  margin-right: 10px;
}

/* Terminal */
.terminal {
  margin-top: 25px;
  padding: 20px;
  border: 1px dashed rgba(255,255,255,0.15);
}

.ascii {
  white-space: pre;
  font-size: 13px;
  color: var(--muted);
}

/* Footer */
.footer {
  position: absolute;
  bottom: 40px;
  left: 40px;
  font-size: 14px;
  color: var(--accent);
}

/* Right */
.right {
  width: 45%;
  position: relative;
}

/* Grid */
.grid {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(var(--grid) 1px, transparent 1px),
    linear-gradient(90deg, var(--grid) 1px, transparent 1px);
  background-size: 120px 120px;
  mask-image: radial-gradient(circle at center, black 25%, transparent 75%);
}

/* Loading */
.loading {
  position: absolute;
  bottom: 40px;
  right: 40px;
  display: flex;
  align-items: center;
  gap: 10px;
  color: var(--muted);
  font-size: 13px;
}

.spinner {
  width: 14px;
  height: 14px;
  border: 2px solid var(--muted);
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

/* Animations */
@keyframes spin {
  to { transform: rotate(360deg); }
}

@keyframes fadeIn {
  to { opacity: 1; }
}
</style>
</head>

<body>
<form id="form1" runat="server">

<div class="wrapper">

  <!-- LEFT -->
  <div class="left">
    <div class="brand">
      🎯 <span>Interview Question Portal</span>
    </div>

    <div class="logs" id="logs"></div>

    <div class="terminal">
<pre class="ascii">
 ██████╗ ██╗   ██╗███████╗███████╗████████╗
██╔═══██╗██║   ██║██╔════╝██╔════╝╚══██╔══╝
██║   ██║██║   ██║█████╗  ███████╗   ██║   
██║   ██║██║   ██║██╔══╝  ╚════██║   ██║   
╚██████╔╝╚██████╔╝███████╗███████║   ██║   
 ╚═════╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝   
 AI INTERVIEW SYSTEM INITIALIZING
</pre>
    </div>

    <div class="footer">Preparing interview environment →</div>
  </div>

  <!-- RIGHT -->
  <div class="right">
    <div class="grid"></div>

    <div class="loading">
      <div class="spinner"></div>
      LOADING INTERVIEW MODULES
    </div>
  </div>

</div>

</form>

<script>
    const steps = [
        "Connecting to Interview Engine ...",
        "Loading Question Bank ...",
        "Initializing AI Evaluator ...",
        "Setting Difficulty Levels ...",
        "Preparing Candidate Session ...",
        "Securing Interview Environment ...",
        "Ready to Begin Interview ..."
    ];

    const logs = document.getElementById("logs");

    steps.forEach((text, i) => {
        const div = document.createElement("div");
        div.className = "log";
        div.style.animationDelay = `${i * 0.7}s`;
        div.innerHTML = `<time>${new Date().toLocaleTimeString()}</time>${text}`;
        logs.appendChild(div);
    });

    /* Redirect */
    setTimeout(function () {
        window.location.href = '<%= ResolveUrl("~/Defaultpage.aspx") %>';

    }, 6500);
</script>

</body>
</html>