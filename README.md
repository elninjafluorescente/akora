# Akora — White-label CSS sobre Hostfully

Personalización visual del entorno **Hostfully** (PMS y motor de reservas)
para que `booking.akora.com` y los widgets embebidos en `akora.com`
respiren la identidad de **Akora**. Es un proyecto de **solo CSS y
configuración del panel** — sin desarrollo a medida vía API.

- **Cliente final:** Akora (apartamentos de lujo de media estancia, Madrid).
- **Agencia / cliente directo:** Asiri Marketing.
- **Repo:** `git@github.com:elninjafluorescente/akora.git`

> Sin Node, npm, bundlers ni frameworks JS. El CSS se sirve como archivos
> estáticos vía GitHub Pages; el navegador resuelve los `@import`.

---

## Identidad visual

| Token | Valor | Uso |
|---|---|---|
| Teal | `#468186` | Principal / acento |
| Navy | `#181e3a` | Texto / oscuro |
| Crema | `#fdf8ec` | Fondos |
| — | **sin amarillo** | Se sobreescribe el amarillo por defecto de Hostfully |

- **Títulos:** URW Classico · **Cuerpo:** Avenir Book *(licencias web pendientes — ver [`fonts/README.md`](fonts/README.md))*.
- **Border-radius:** `5px` (esquinas refinadas).

Todo vive como tokens en [`partials/_variables.css`](partials/_variables.css).

---

## Estructura del repo

```
main.css                  ← se carga en Hostfully (campo "CSS URL"); agrega los parciales
partials/
  _variables.css          ← colores, fuentes y radius (tokens de marca)
  _typography.css         ← @font-face + tipografía base
  _utilities.css          ← resets globales (radius 5px, anti-amarillo)
  _navigation.css         ← header/nav del subdominio (selectores CONFIRMADOS)
  _search-widget.css      ← widget de búsqueda      (selectores por verificar ⚠)
  _booking-widget.css     ← widget de reserva        (selectores por verificar ⚠)
  _landing.css            ← specs + reviews de landings (por verificar ⚠)
fonts/                    ← .woff2 de marca (pendientes de licencia)
header.html               ← para el campo "Header HTML" del panel
footer.html               ← para el campo "Footer HTML" del panel
tracking/
  ga4.html                ← GA4 con cross-domain
  meta-pixel.html         ← Meta Pixel
docs/notas.md             ← cuaderno interno (selectores, decisiones abiertas)
```

---

## Despliegue (GitHub Pages + Hostfully)

1. **GitHub Pages:** en el repo `akora`, activar Pages sobre la rama `main`
   (raíz). La URL del CSS será:
   `https://elninjafluorescente.github.io/akora/main.css`
2. **Hostfully:** Configuración de Agencia → **White Labelling** y rellenar:
   - **Custom Domain Name:** `booking.akora.com`
   - **CSS URL:** la URL de Pages **con versión** → `…/main.css?v=0.16.0`
   - **Favicon**, **Header HTML** ([`header.html`](header.html)),
     **Footer HTML** ([`footer.html`](footer.html)),
     **Google Analytics** ([`tracking/ga4.html`](tracking/ga4.html)),
     **Meta HTML / Header HTML** ([`tracking/meta-pixel.html`](tracking/meta-pixel.html))
3. **Widgets embebidos** (Search / Booking / Calendar): Herramientas de
   Publicación. Ya van incrustados en `akora.com`; el repo solo los estiliza.

---

## Cómo aplica Hostfully el CSS y el contenido (header/footer)

Basado en la doc de Hostfully ([custom CSS](https://help.hostfully.com/en/articles/8860821-set-up-custom-css) · [custom branding](https://help.hostfully.com/en/articles/8744751-set-up-your-custom-branding)).

**Scope `.hf-dbs` (obligatorio).** El sitio de reservas lleva
`<body class="hf-dbs">` (verificado en vivo). El CSS URL se aplica TANTO al
Direct Booking Site COMO a la página de login/PMP, así que **todos nuestros
selectores van prefijados con `.hf-dbs`** para tocar solo el sitio público.

**Dos vías para aplicar CSS:**
- **CSS URL** → nuestro `main.css` en Pages. Para la hoja completa.
- **`<style>` inline en Footer HTML** → para overrides pequeños/críticos.
  Ventaja: **instantáneo, esquiva la caché** de Pages. Ver [`footer.html`](footer.html).

**Modificar el contenido de header/footer:**
- Campos **Header HTML** / **Footer HTML** (requieren Custom Domain ✓).
  Aceptan HTML (`<style>`, `<script>`, `<nav>`, `<a>`…). El contenido se
  **añade** a la página (no reemplaza el header/footer nativo); se estila con
  clases propias scopeadas a `.hf-dbs`. Plantillas: [`header.html`](header.html),
  [`footer.html`](footer.html).
- El **Meta Pixel** va en Header HTML; GA4 puede ir en el campo
  **Google Analytics ID** o como snippet en Header HTML.
- ⚠ **El código de Header/Footer NO es restaurable** en Hostfully: el repo
  (`header.html`/`footer.html`) es la copia de seguridad. Archiva antes de borrar.

---

## Caché y versiones (importante)

`main.css` es **un único archivo generado** por [`build.sh`](build.sh) (concatena
los `partials/`). Al no haber `@import` de parciales, **el `?v=` del panel
invalida TODO de golpe** (antes el `?v=` no refrescaba los parciales `@import`
y se veían estilos viejos).

Tras cada cambio visible:
1. Sube `VER` en [`build.sh`](build.sh).
2. Actualiza el query string del campo **CSS URL** del panel:
   `…/main.css?v=0.4.2`, etc.

> Las fuentes (Marcellus/Mulish/Sacramento de Google) sí entran por `@import`
> en `main.css`, pero son estáticas y no necesitan versionado.

---

## Cómo iterar el CSS

1. Edita el parcial correspondiente en `partials/` (**no** `main.css`, que es generado).
2. Verifica los selectores ⚠ contra el DOM real con DevTools sobre
   `booking.akora.com` (ver [`docs/notas.md`](docs/notas.md)).
3. **Ejecuta `./build.sh`** para regenerar `main.css`.
4. Commit + push → Pages se actualiza solo.
5. Bump del `?v=` en el panel y refresca `booking.akora.com`.

**Ajustes menores que Akora puede hacer sin volver a nosotros:** cambiar un
color o el radius editando solo [`partials/_variables.css`](partials/_variables.css),
o los textos/enlaces de [`header.html`](header.html) / [`footer.html`](footer.html).

---

## Estado de los selectores

- ✅ **Navegación** — selectores confirmados (del prototipo `cabecera.css`).
- ⚠ **Search / Booking / Landing** — selectores **provisionales**; hay que
  verificarlos contra el DOM en vivo antes de dar por bueno cada bloque.
  Marcados con `⚠ PROVISIONALES` dentro de cada parcial.

Si algún ajuste pedido no es posible solo con CSS (p. ej. reubicar specs
porque el HTML de Hostfully no lo permite), **se comunica y se ofrece la
alternativa más cercana** — no se promete lo que no se puede entregar.

---

## Pendiente de Akora (bloqueantes)

- [ ] Acceso al panel de Hostfully (permisos de Agency Settings).
- [ ] DNS: CNAME de `booking.akora.com` apuntado (o confirmación).
- [ ] Licencias web de **URW Classico** y **Avenir Book** (.woff2 / Adobe Fonts).
- [ ] Logo en alta (SVG preferible) y favicon (≥32×32).
- [ ] GA4 (measurement ID) y Meta Pixel (ID).
- [ ] Lista de enlaces del menú de `akora.com` a replicar en la nav.
- [ ] Referencias de "más premium" (no bloqueante; asumimos interpretación conservadora).

---

## Verificación final (checklist de entrega)

- [ ] White-label visible en `booking.akora.com` (fuentes, paleta, sin amarillo, radius 5px).
- [ ] Widgets embebidos en `akora.com` estilizados.
- [ ] Reviews ocultas (toggle nativo si existe; si no, CSS).
- [ ] **GA4 cross-domain validado en DebugView** (sin doble conteo de sesiones).
- [ ] **Meta Pixel validado** con Pixel Helper.
- [ ] Enlaces rotos y problemas de visualización revisados.

---

## Fuera de alcance (pactado)

Desarrollo vía API · tarjetas de propiedad propias · listado/búsqueda en
`akora.com` · desglose de precio a medida · filtro por barrio · dropdowns en
landings de WordPress · checkout/Stripe · traducción de contenido · CRM/ERP.

> Cualquier petición que vaya más allá de este documento se **escala para
> presupuestar aparte**, no se asume como "ajuste menor".
