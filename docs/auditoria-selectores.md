# Auditoría de selectores — Hostfully white-label (booking.akora.com)

Auditoría en vivo del DOM real (2026-06-09) con DevTools/JS sobre la home y la
landing de propiedad `Aníbal I`. **Sustituye a los selectores provisionales.**

## Regla de oro
- ✅ **Anclar SIEMPRE a `data-testid`** y a estructura semántica.
- ❌ **NO usar las clases `sc-*`** (`sc-fsYfdN iYQZMo`…): son styled-components
  **hasheadas y cambian en cada build**. El prefijo `sc-` sí es estable (sirve
  para barridos tipo `[class*="sc-"]`), pero el hash no.
- 🎨 **Amarillo de Hostfully = `#FFD60A` (`rgb(255,214,10)`)**. Es color de tema,
  aplicado vía styled-components (no inline) → solo se mata por `data-testid`.
- 🔤 Fuente actual de Hostfully: **"Source Sans 3"** (hay que sobreescribir).

## Header / navegación (home y landing)
| Componente | Selector | Estado actual |
|---|---|---|
| Barra header | `[data-testid="common-header"]` | bg teal `#468186` (config del panel) |
| Logo | `[data-testid="logo-link"]` | texto "AKORA" **amarillo**; `href="/undefined"` (roto) |
| Enlace Home | `[data-testid="home-link"]` | blanco; `href="/undefined"` (roto) |
| Botón Book Now | `[data-testid="book-now-link"]` | **bg amarillo**, radius alto |
| Menú móvil | `[data-testid="mobile-menu-button"]` | icono amarillo |

> La nav real **solo** tiene logo + Home + Book Now (+ menú móvil). Los enlaces
> "Why Akora / Akora Professional / The Akora Guide" del prototipo **no existen**.

## Buscador (search widget)
`[data-testid="search-filter-component"]` (contenedor) ·
`where` / `when` / `who` (+ sus `-field-container` y `where-trigger`) ·
`[data-testid="icon-submit-button"]` (botón circular de buscar; icono amarillo,
círculo teal). En la home hay además un botón **"Buscar"** con fondo amarillo.

## Landing de propiedad
| Componente | Selector |
|---|---|
| Bloque info | `[data-testid="information"]`, `information-name`, `information-address` |
| **Specs** | `information-guests-tag`, `information-bedrooms-tag`, `information-beds-tag`, `information-bathrooms-tag` |
| Galería | `desktop-images-grid`, `main-image`, `image-0..3`, `view-all-button` |
| Pestañas | `page-links` → `page-link-information/amenities/calendar/map/reviews` (subrayado activo amarillo) |
| Descripción | `property-description`, `information-short-summary`, `information-description`, `information-space`, `information-house-rules`, `information-cancellation-policy` |
| Amenities | `property-amenities`, `property-amenities-title`, `amenity-*` |
| **Reviews** | `[data-testid="property-reviews"]` (+ `page-link-reviews` pestaña; estado `reviews-empty`). En tarjetas: `property-card-reviews` |
| Mapa | `property-map`, `map` |

## Booking widget
`[data-testid="property-details-widget"]` = `<aside>`, bg blanco, **radius 15px**.
| Campo | Selector | Nota |
|---|---|---|
| Total/precio | `booking-widget-total` (22px), `booking-widget-total-currency`, `booking-widget-nights-length`, `booking-widget-min-stay` | desglose nativo |
| Fechas | `from-field` / `to-field` (+ `-label`, `-value`) | bg gris `#f7f7f7` |
| Huéspedes | `guests-field-container`, `guests` | |
| Email/Nombre/Tel | `email`, `name`, `countryCode`, `phoneNumber` (+ `-field-container`) | |
| **Promo Code** | `[data-testid="promoCode"]` (+ `promoCode-field-container`) | reducir tamaño |
| **Booking Note** | `[data-testid="notes"]` = `<textarea>` (+ `notes-field-container`) | reducir tamaño |
| Botón reservar | `[data-testid="app-button"]` | **bg amarillo**, radius 20px, "Book Now" |
| Ayuda | `submit-help-text` ("Review and continue") | |

## Footer
`[data-testid="common-footer"]` → **fondo amarillo `#FFD60A`** ·
`agency-logo`, `agency-info`, `common-footer-agency-email`, `common-footer-agency-phone`.

## Mapa del amarillo a matar
`book-now-link` (bg), `app-button` (bg), `common-footer` (bg), botón "Buscar" (bg),
`logo-link` (texto), `mobile-menu-button` (icono), `icon-submit-button` (icono),
subrayado de pestaña activa.
