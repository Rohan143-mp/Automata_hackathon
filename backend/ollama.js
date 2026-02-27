const express = require("express");
const router = express.Router();

// Ollama runs on the same PC as this backend
const OLLAMA_URL = process.env.OLLAMA_HOST || "http://localhost:11434";

/**
 * GET /ollama/health
 * Lightweight ping — just checks if Ollama process is alive.
 * Returns { ok: true } so the app doesn't have to parse /api/tags.
 */
router.get("/health", async (_req, res) => {
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 5000);
    const response = await fetch(`${OLLAMA_URL}/api/tags`, {
      signal: controller.signal,
    });
    clearTimeout(timeout);
    if (response.ok) {
      res.json({ ok: true });
    } else {
      res.status(502).json({ ok: false, error: `Ollama returned ${response.status}` });
    }
  } catch (err) {
    console.error("[Ollama Proxy] Health-check failed:", err.message);
    res.status(502).json({
      ok: false,
      error: "Ollama not reachable",
      detail: err.message,
      hint: "Make sure Ollama is running: ollama serve",
    });
  }
});

/**
 * GET /ollama/tags
 * Proxies to Ollama's /api/tags so the app can verify connectivity.
 */
router.get("/tags", async (_req, res) => {
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 5000);
    const response = await fetch(`${OLLAMA_URL}/api/tags`, {
      signal: controller.signal,
    });
    clearTimeout(timeout);
    const data = await response.json();
    res.json(data);
  } catch (err) {
    console.error("[Ollama Proxy] /tags failed:", err.message);
    res.status(502).json({ error: "Ollama not reachable", detail: err.message });
  }
});

/**
 * POST /ollama/generate
 * Proxies a generate request to Ollama's /api/generate endpoint.
 */
router.post("/generate", async (req, res) => {
  try {
    // 2-minute timeout for generation (large models can be slow)
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 120000);
    const response = await fetch(`${OLLAMA_URL}/api/generate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(req.body),
      signal: controller.signal,
    });
    clearTimeout(timeout);
    const data = await response.json();
    res.json(data);
  } catch (err) {
    console.error("[Ollama Proxy] Generate failed:", err.message);
    res.status(502).json({ error: "Ollama generate failed", detail: err.message });
  }
});

module.exports = router;
