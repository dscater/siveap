<script setup>
import L from "leaflet";
import "leaflet/dist/leaflet.css";

import { onMounted, ref, watch } from "vue";

const props = defineProps({
    alertas: {
        type: Array,
        default: () => [],
    },

    latitud: {
        type: Number,
        default: -16.125102,
    },

    longitud: {
        type: Number,
        default: -67.196268,
    },

    zoom: {
        type: Number,
        default: 15,
    },
});

const mapa = ref(null);

let map = null;

let layerGroup = null;

/**
 * OBTENER COLOR SEGÚN RIESGO
 */
const obtenerColor = (riesgo) => {
    switch (riesgo) {
        case "CRITICO":
            return "#ff0000";

        case "ALTO":
            return "#ff8800";

        case "MEDIO":
            return "#ffff00";

        default:
            return "#00aa00";
    }
};

/**
 * OBTENER RIESGO MÁS ALTO
 */
const obtenerMayorRiesgo = (alertas) => {
    if (alertas.some((x) => x.nivel_alerta == "CRITICO")) {
        return "CRITICO";
    }

    if (alertas.some((x) => x.nivel_alerta == "ALTO")) {
        return "ALTO";
    }

    if (alertas.some((x) => x.nivel_alerta == "MEDIO")) {
        return "MEDIO";
    }

    return "BAJO";
};

/**
 * DIBUJAR ALERTAS
 */
const bounds = [];
const renderAlertas = () => {
    if (!map) return;

    // LIMPIAR CAPAS
    if (layerGroup) {
        layerGroup.clearLayers();
    }

    layerGroup = L.layerGroup().addTo(map);

    props.alertas.forEach((item) => {
        bounds.push([item.latitud, item.longitud]);

        const riesgo = obtenerMayorRiesgo(item.alertas);

        // OBTENER INDICE MÁS ALTO
        const indiceMaximo = Math.max(
            ...item.alertas.map((x) => x.indice ?? 0),
        );

        // RADIO DINÁMICO
        // const radio = Math.max(indiceMaximo * 20, 300);
        const radio = Math.max(indiceMaximo, 10);
        // const radio = 100;

        const color = obtenerColor(riesgo);

        // CREAR CIRCULO
        const circle = L.circleMarker([item.latitud, item.longitud], {
            color: color,
            fillColor: color,
            fillOpacity: 0.4,
            radius: radio,
            weight: 2,
        });

        // POPUP HTML
        let html = `
            <div style="min-width:220px">
                <h6>
                    ${item.comunidad}
                </h6>
                <hr>
        `;
        item.alertas.forEach((a) => {
            html += `
                <div style="margin-bottom:10px">
                    <b>
                        ${a.enfermedad}
                    </b>
                    <br>
                    Riesgo:
                    <b>
                        ${a.nivel_alerta}
                    </b>
                    <br>
                    Índice:
                    ${a.indice}
                    <br>
                    Confirmados:
                    ${a.confirmados}
                </div>
                <hr>
            `;
        });
        html += "</div>";

        circle.bindPopup(html);

        circle.addTo(layerGroup);

        /**
         * TEXTO CENTRAL
         */
        const label = L.marker([item.latitud, item.longitud], {
            icon: L.divIcon({
                className: "custom-label",
                html: `
                        <div class="label-alerta">
                            ${item.comunidad}
                        </div>
                    `,
            }),
        });

        label.addTo(layerGroup);
    });

    if (bounds.length > 0) {
        map.fitBounds(bounds, {
            padding: [50, 50],
        });
    }
};

onMounted(() => {
    map = L.map(mapa.value).setView(
        [props.latitud, props.longitud],
        props.zoom,
    );

    // CAPA MAPA
    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenStreetMap",
    }).addTo(map);

    renderAlertas();
});

// OBSERVAR CAMBIOS
watch(
    () => props.alertas,
    () => {
        renderAlertas();
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
    min-width: 100%;
    height: 40vh;
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
