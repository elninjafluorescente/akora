#!/usr/bin/env bash
# =============================================
# build.sh — Concatena partials/ en un único main.css
# Sin Node ni dependencias (bash + cat). Cumple las reglas del proyecto.
# ---------------------------------------------
# Por qué: Hostfully solo lee UNA URL de CSS y el ?v= del panel NO invalida
# la caché de los @import. Sirviendo un único archivo, el ?v= basta para
# refrescar TODO. Edita los partials/ y ejecuta ./build.sh antes de commitear.
# =============================================
set -euo pipefail
cd "$(dirname "$0")"

VER="0.14.0"
FECHA="$(date +%Y-%m-%d 2>/dev/null || echo 2026-06-11)"

ORDER=(_variables _typography _utilities _navigation _search-widget _booking-widget _landing _checkout _home _search _punch-jul _responsive)

{
  printf '/* =============================================\n'
  printf '   Akora white-label — main.css (GENERADO por build.sh)\n'
  printf '   NO editar a mano: editar partials/ y ejecutar ./build.sh\n'
  printf '   Version: v%s  ·  Fecha: %s\n' "$VER" "$FECHA"
  printf '   Se carga en Hostfully (White Labelling -> CSS URL) con ?v=%s\n' "$VER"
  printf '   ============================================= */\n'
  # @import de fuentes: DEBE ir primero (antes de cualquier regla)
  printf "@import url('https://fonts.googleapis.com/css2?family=Marcellus&family=Mulish:wght@300;400;500;600;700;800&family=Tenor+Sans&family=Sacramento&display=swap');\n\n"
  for p in "${ORDER[@]}"; do
    printf '/* ===== %s ===== */\n' "$p"
    cat "partials/$p.css"
    printf '\n'
  done
} > main.css

echo "main.css generado (v$VER) — $(wc -l < main.css) lineas, $(wc -c < main.css) bytes"
