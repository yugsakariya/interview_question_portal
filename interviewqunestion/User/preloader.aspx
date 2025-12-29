<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Loading...</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<style>
/* ================= BASE ================= */
html, body {
    width: 100%;
    height: 100%;
    margin: 0;
    background: #0a0a0f;
    overflow: hidden;
    font-family: Arial, sans-serif;
}

/* From Uiverse.io by Vosoone */
.main-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
    transition: opacity 0.6s ease, transform 0.6s ease;
}

.fade-out {
    opacity: 0;
    transform: scale(0.96);
}

/* Loader */
.loader {
    width: 100%;
    max-width: 900px;
}

/* Traces */
.trace-bg {
    stroke: #333;
    stroke-width: 1.8;
    fill: none;
}

.trace-flow {
    stroke-width: 1.8;
    fill: none;
    stroke-dasharray: 40 400;
    stroke-dashoffset: 438;
    filter: drop-shadow(0 0 6px currentColor);
    animation: flow 3s cubic-bezier(0.5, 0, 0.9, 1) infinite;
}

/* Colors */
.yellow { stroke: #ffea00; color: #ffea00; }
.blue   { stroke: #00ccff; color: #00ccff; }
.green  { stroke: #00ff15; color: #00ff15; }
.purple { stroke: #9900ff; color: #9900ff; }
.red    { stroke: #ff3300; color: #ff3300; }

@keyframes flow {
    to { stroke-dashoffset: 0; }
}
</style>
</head>

<body>

<!-- ================= PRELOADER ================= -->
<div id="preloader" class="main-container">
  <div class="loader">

<svg viewBox="0 0 800 500" xmlns="http://www.w3.org/2000/svg">

  <defs>
    <linearGradient id="chipGradient" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#2d2d2d" />
      <stop offset="100%" stop-color="#0f0f0f" />
    </linearGradient>

    <linearGradient id="textGradient" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#eeeeee" />
      <stop offset="100%" stop-color="#888888" />
    </linearGradient>

    <linearGradient id="pinGradient" x1="1" y1="0" x2="0" y2="0">
      <stop offset="0%" stop-color="#bbbbbb" />
      <stop offset="50%" stop-color="#888888" />
      <stop offset="100%" stop-color="#555555" />
    </linearGradient>
  </defs>

  <!-- LEFT TRACES -->
  <path d="M100 100 H200 V210 H326" class="trace-bg"/>
  <path d="M100 100 H200 V210 H326" class="trace-flow purple"/>

  <path d="M80 180 H180 V230 H326" class="trace-bg"/>
  <path d="M80 180 H180 V230 H326" class="trace-flow blue"/>

  <path d="M60 260 H150 V250 H326" class="trace-bg"/>
  <path d="M60 260 H150 V250 H326" class="trace-flow yellow"/>

  <path d="M100 350 H200 V270 H326" class="trace-bg"/>
  <path d="M100 350 H200 V270 H326" class="trace-flow green"/>

  <!-- RIGHT TRACES -->
  <path d="M700 90 H560 V210 H474" class="trace-bg"/>
  <path d="M700 90 H560 V210 H474" class="trace-flow blue"/>

  <path d="M740 160 H580 V230 H474" class="trace-bg"/>
  <path d="M740 160 H580 V230 H474" class="trace-flow green"/>

  <path d="M720 250 H590 V250 H474" class="trace-bg"/>
  <path d="M720 250 H590 V250 H474" class="trace-flow red"/>

  <path d="M680 340 H570 V270 H474" class="trace-bg"/>
  <path d="M680 340 H570 V270 H474" class="trace-flow yellow"/>

  <!-- CHIP -->
  <rect x="330" y="190" width="140" height="100"
        rx="20" ry="20"
        fill="url(#chipGradient)"
        stroke="#222" stroke-width="3"
        filter="drop-shadow(0 0 6px rgba(0,0,0,0.8))"/>

  <!-- TEXT -->
  <text x="400" y="240"
        font-size="22"
        fill="url(#textGradient)"
        text-anchor="middle"
        alignment-baseline="middle">
    Loading
  </text>

</svg>

  </div>
</div>

<script>
    // ⏳ Loader duration (ms)
    const LOADER_TIME = 3500;

    setTimeout(() => {
        document.getElementById("preloader").classList.add("fade-out");

        setTimeout(() => {
            // 🔁 Redirect to login page
            window.location.href = '<%= ResolveUrl("/Defaultpage.aspx") %>';



            // OR "/Account/Login.aspx"
        }, 10);

    }, LOADER_TIME);
</script>

</body>
</html>
