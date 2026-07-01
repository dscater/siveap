<script setup>
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import html2canvas from "html2canvas";

import markerIcon2x from "leaflet/dist/images/marker-icon-2x.png";
import markerIcon from "leaflet/dist/images/marker-icon.png";
import markerShadow from "leaflet/dist/images/marker-shadow.png";

import { onMounted, ref } from "vue";

const props = defineProps({
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
        default: 14,
    },
    readonly: {
        type: Boolean,
        default: false,
    },
    capturar: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits([
    "update:latitud",
    "update:longitud",
    "update:captura",
]);

const mapa = ref(null);

let map = null;
let marker = null;

const getUbicacion = () => {
    navigator.geolocation.getCurrentPosition(
        (position) => {
            // console.log(position);
            actualizarUbicacion(
                position.coords.latitude,
                position.coords.longitude,
            );

            moverMapa(position.coords.latitude, position.coords.longitude);
        },

        (error) => {
            if (error.code == 1) {
                alert("Primero debe dar permisos para acceder a su ubicación");
            }
            console.log(error);
        },
    );
};

const capturarMapa = async () => {
    if (!props.capturar) return;

    const posicion = marker.getLatLng();
    const zoomOriginal = map.getZoom();

    // Escuchar solo un cambio de movimiento
    map.once("moveend", async () => {
        // Esperar un poco para que terminen de cargar los tiles
        await new Promise((resolve) => setTimeout(resolve, 300));

        const canvas = await html2canvas(mapa.value, {
            useCORS: true,
            logging: false,
            scale: 3,
        });

        emit("update:captura", canvas.toDataURL("image/png"));

        // Restaurar el zoom original
        map.setView(posicion, zoomOriginal);
    });

    // Zoom solo para la captura
    map.setView(posicion, 18);
};

const moverMapa = (lat, lon) => {
    // map.setView([lat, lon], props.zoom);
    map.setView([lat, lon], map.getZoom());
};

const resetPosicion = () => {
    actualizarUbicacion(-16.125102, -67.196268);
    moverMapa(-16.125102, -67.196268);
};

const actualizarUbicacion = async (lat, lng) => {
    marker.setLatLng([lat, lng]);

    emit("update:latitud", lat);
    emit("update:longitud", lng);

    moverMapa(lat, lng);
    await capturarMapa();
};

onMounted(async () => {
    delete L.Icon.Default.prototype._getIconUrl;
    L.Icon.Default.mergeOptions({
        iconRetinaUrl: markerIcon2x,
        iconUrl: markerIcon,
        shadowUrl: markerShadow,
    });

    map = L.map(mapa.value).setView(
        [props.latitud, props.longitud],
        props.zoom,
    );

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenStreetMap",
    }).addTo(map);

    marker = L.marker([props.latitud, props.longitud], {
        draggable: !props.readonly,
    }).addTo(map);

    /**
     * SOLO SI ES EDITABLE
     */
    if (!props.readonly) {
        /**
         * CLICK EN MAPA
         */
        map.on("click", (e) => {
            const { lat, lng } = e.latlng;

            actualizarUbicacion(lat, lng);
        });

        /**
         * ARRASTRAR MARCADOR
         */
        marker.on("dragend", () => {
            const position = marker.getLatLng();

            actualizarUbicacion(position.lat, position.lng);
        });
    }

    if (props.capturar) {
        await capturarMapa();
    }
});
</script>

<template>
    <div class="row">
        <div class="col-12">
            <button
                type="button"
                class="btn btn-outline-success btn-sm text-xs"
                @click.prevent="getUbicacion"
                v-if="!readonly"
            >
                Usar mi ubicación <i class="fa fa-map-marker-alt"></i>
            </button>
            <button
                class="btn btn-light btn-sm text-xs ms-1"
                type="button"
                @click.prevent="resetPosicion"
                v-if="!readonly"
            >
                <i class="fa fa-sync"></i>
            </button>
            <div ref="mapa" class="mapa"></div>
        </div>
    </div>
</template>

<style scoped>
.mapa {
    width: 100%;
    height: 400px;
}
</style>
