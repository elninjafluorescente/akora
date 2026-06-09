# Notas de trabajo — Akora white-label

Cuaderno interno (no es la doc de handoff; esa es el `README.md` raíz).

## Selectores de Hostfully

### Confirmados (del prototipo `cabecera.css.rtf`)
- `header[data-testid="common-header"]` — barra del header
- `header[...] a[data-testid="logo-link"]` (+ `img`, `span`)
- `header[...] nav` — contenedor de navegación
- `nav a[data-testid="home-link"]` — "Find your home"
- `nav a[data-testid="book-now-link"]` — botón Book Now

### Por verificar contra el DOM en vivo (marcados con ⚠ en los parciales)
- Search Widget → `_search-widget.css`
- Booking Widget, Booking Note, Promo Code → `_booking-widget.css`
- Specs de propiedad y sección de reviews → `_landing.css`
- Componentes con amarillo de Hostfully → `_utilities.css`

> Método: abrir el componente en `booking.akora.com` con DevTools,
> copiar el `data-testid`/clase real y sustituir los selectores
> provisionales. Confirmar que reservas siguen funcionando tras estilar.

## Decisiones abiertas / a confirmar con Akora
- [ ] Logo definitivo (SVG en teal evita el `filter` del partial de nav).
- [ ] Lista real de enlaces del menú → van en `header.html` (no en CSS).
- [ ] ¿Existe toggle nativo para ocultar reviews? (preferible al CSS).
- [ ] Fallback tipográfico final mientras no haya licencias.
- [ ] Measurement ID de GA4 y Pixel ID de Meta.

## Capturas / referencias
Guardar aquí los antes/después y las referencias visuales de "más premium"
que envíe Akora.
