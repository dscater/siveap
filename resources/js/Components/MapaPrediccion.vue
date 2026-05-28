<script setup>
import L from "leaflet";
import "leaflet/dist/leaflet.css";

import { onMounted, ref, watch } from "vue";

const props = defineProps({
    comunidades: {
        type: Array,
        default: () => [],
    },

    zoom: {
        type: Number,
        default: 10,
    },

    latitud: {
        type: Number,
        default: -16.125102,
    },

    longitud: {
        type: Number,
        default: -67.196268,
    },
});

const mapa = ref(null);

let map = null;
let layers = [];

/**
 * COLOR SEGUN RIESGO
 */
const getColor = (riesgo) => {
    switch (riesgo) {
        case "CRITICO":
            return "#dc3545";

        case "ALTO":
            return "#fd7e14";

        case "MEDIO":
            return "#ffc107";

        default:
            return "#198754";
    }
};

/**
 * LIMPIAR CAPAS
 */
const limpiarCapas = () => {
    layers.forEach((layer) => {
        map.removeLayer(layer);
    });

    layers = [];
};

/**
 * DIBUJAR ALERTAS
 */
const dibujarAlertas = () => {
    if (!map) return;

    limpiarCapas();

    props.comunidades.forEach((comunidad) => {
        /**
         * VALIDAR COORDENADAS
         */
        if (!comunidad.latitud || !comunidad.longitud) {
            return;
        }

        /**
         * OBTENER ENFERMEDAD MAS GRAVE
         */
        let enfermedadTop = null;

        comunidad.enfermedades.forEach((item) => {
            const ultima = item.predicciones[item.predicciones.length - 1];

            const casos = ultima?.casos_estimados || 0;

            if (!enfermedadTop || casos > enfermedadTop.casos) {
                enfermedadTop = {
                    ...item,
                    casos,
                };
            }
        });

        /**
         * VALIDAR
         */
        if (!enfermedadTop) {
            return;
        }

        /**
         * RADIO
         */
        // const radius = Math.max(enfermedadTop.casos * 40, 10);
        const radius = 35;
        /**
         * COLOR
         */
        const color = getColor(enfermedadTop.riesgo);

        /**
         * CIRCULO
         */
        const circle = L.circleMarker([comunidad.latitud, comunidad.longitud], {
            color,
            fillColor: color,
            fillOpacity: 0.35,
            radius,
            weight: 2,
        }).addTo(map);

        /**
         * POPUP
         */
        let html = `
            <div style="min-width:220px;">
                <h6 style="margin-bottom:10px;">
                    ${comunidad.comunidad}
                </h6>
        `;

        comunidad.enfermedades.forEach((item) => {
            const ultima = item.predicciones[item.predicciones.length - 1];

            html += `
                    <div
                        style="
                            margin-bottom:8px;
                            padding:6px;
                            border-radius:6px;
                            background:#f8f9fa;
                        "
                    >
                        <strong>
                            ${item.enfermedad}
                        </strong>

                        <br>

                        Riesgo:
                        <strong
                            style="
                                color:${getColor(item.riesgo)}
                            "
                        >
                            ${item.riesgo}
                        </strong>

                        <br>

                        Predicción:
                        <strong>
                            ${Math.round(ultima?.casos_estimados || 0)}
                        </strong>
                    </div>
                `;
        });

        html += `</div>`;

        circle.bindPopup(html);

        /**
         * LABEL CENTRAL
         */
        const label = L.marker([comunidad.latitud, comunidad.longitud], {
            icon: L.divIcon({
                className: "custom-label",

                html: `
                        <div class="label-alerta">
                            ${comunidad.comunidad}
                        </div>
                    `,
            }),
        }).addTo(map);

        layers.push(circle);
        layers.push(label);
    });

    /**
     * AUTO AJUSTAR MAPA
     */
    if (layers.length > 0) {
        const group = L.featureGroup(layers);

        map.fitBounds(group.getBounds(), {
            padding: [40, 40],
        });
    }
};

/**
 * INIT
 */
onMounted(() => {
    map = L.map(mapa.value).setView(
        [props.latitud, props.longitud],
        props.zoom,
    );

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenStreetMap",
    }).addTo(map);

    dibujarAlertas();
});

/**
 * WATCH
 */
watch(
    () => props.comunidades,
    () => {
        dibujarAlertas();
    },
    {
        deep: true,
    },
);
</script>

<template>
    <div ref="mapa" class="mapa"></div>
</template>

<style scoped>
.mapa {
    width: 100%;
    height: 30vh;
    border-radius: 10px;
}

:deep(.custom-label) {
    background: transparent;
    border: none;
}

:deep(.label-alerta) {
    display: inline-block;

    background: rgba(255, 255, 255, 0.95);

    padding: 4px 10px;

    border-radius: 999px;

    border: 1px solid #ddd;

    font-size: 12px;

    font-weight: 600;

    white-space: nowrap;

    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);

    min-width: max-content;
}
</style>
