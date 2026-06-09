# Fuentes — Akora

Carpeta para los archivos de fuente web de marca. **Vacía a propósito**
hasta que Akora entregue las licencias web.

## Pendiente de Akora (bloqueante para tipografía final)

| Fuente | Uso | Formato esperado | Estado |
|---|---|---|---|
| **URW Classico** | Títulos | `.woff2` (regular + bold) | ⏳ pendiente de licencia web (URW Type Foundry) |
| **Avenir Book** | Cuerpo | `.woff2` o kit de Adobe Fonts | ⏳ pendiente de licencia web / Creative Cloud |

Ambas son comerciales y requieren **licencia web** para servirse con
`@font-face`. No se pueden usar archivos de relleno sin licencia.

## Cómo activarlas cuando lleguen

1. Copiar los `.woff2` aquí, con estos nombres (o ajustar las rutas en
   `partials/_typography.css`):
   - `urw-classico.woff2`
   - `urw-classico-bold.woff2`
   - `avenir-book.woff2`
2. Descomentar los bloques `@font-face` en
   [`../partials/_typography.css`](../partials/_typography.css).
3. Si Avenir viene por **Adobe Fonts** (Creative Cloud) en vez de `.woff2`,
   no se usa `@font-face`: se inyecta el `<link>` del kit en el campo
   **Header HTML** del panel (ver [`../header.html`](../header.html)).

## Mientras tanto (fallbacks activos)

Definidos en [`../partials/_variables.css`](../partials/_variables.css):

- Títulos → `'TeX Gyre Bonum', Georgia, serif`
- Cuerpo → `'Nunito Sans', 'Helvetica Neue', Arial, sans-serif`
