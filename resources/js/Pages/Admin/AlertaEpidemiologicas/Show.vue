<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import MapAlertas from "@/Components/MapAlertas.vue";
import "leaflet/dist/leaflet.css";
const props = defineProps({
    alerta_epidemiologica: Object,
});
const alertas = ref([
    {
        comunidad_id: props.alerta_epidemiologica.comunidad.id,
        comunidad: props.alerta_epidemiologica.comunidad.nombre,
        latitud: props.alerta_epidemiologica.comunidad.latitud,
        longitud: props.alerta_epidemiologica.comunidad.longitud,
        nivel_alerta: props.alerta_epidemiologica.indice,
        alertas: [
            {
                enfermedad: props.alerta_epidemiologica.enfermedad.nombre,
                nivel_alerta: props.alerta_epidemiologica.nivel_alerta,
                indice: props.alerta_epidemiologica.indice,
                confirmados: props.alerta_epidemiologica.confirmados,
            },
        ],
    },
]);
const { props: props_page } = usePage();
const appStore = useAppStore();

onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(async () => {
    recargarMapa();
    appStore.stopLoading();
});

onBeforeMount(() => {
    document.getElementsByTagName("body")[0].classList.add("sidebar-mini");
    document.getElementsByTagName("body")[0].classList.add("sidebar-collapse");
});

onBeforeUnmount(() => {
    document.getElementsByTagName("body")[0].classList.remove("sidebar-mini");
    document
        .getElementsByTagName("body")[0]
        .classList.remove("sidebar-collapse");
});

const mapKey = ref(0);

function recargarMapa() {
    mapKey.value++;
}
</script>
<template>
    <Head title="Alertas Epidemiológicas"></Head>

    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h3 class="m-0">
                        <i class="fa fa-map"></i> Alertas Epidemiológicas
                    </h3>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-end">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('alerta_epidemiologicas.index')"
                                >Alertas Epidemiológicas</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Ver</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12 mb-2">
                <Link
                    class="btn btn-light bg-white"
                    :href="route('alerta_epidemiologicas.index')"
                    ><i class="fa fa-arrow-left"></i> Volver</Link
                >
            </div>
            <div class="col-md-12">
                <MapAlertas :alertas="alertas" :key="mapKey"></MapAlertas>
            </div>
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6 mt-2">
                                <strong>Nro. Alerta: </strong>
                                {{ alerta_epidemiologica.id }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Nivel de Alerta: </strong>
                                {{ alerta_epidemiologica.nivel_alerta }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Comunidad: </strong>
                                {{ alerta_epidemiologica.comunidad.nombre }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Enfermedad: </strong>
                                {{ alerta_epidemiologica.enfermedad.nombre }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Estado: </strong>
                                <span
                                    class="badge text-sm"
                                    :class="{
                                        'bg-success':
                                            alerta_epidemiologica.estado ==
                                            'CONTROLADO',
                                        'bg-warning':
                                            alerta_epidemiologica.estado ==
                                            'ACTIVO',
                                    }"
                                >
                                    {{ alerta_epidemiologica.estado }}
                                </span>
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Fecha de Alerta: </strong>
                                {{ alerta_epidemiologica.fecha_t }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Fecha Fin Alerta: </strong>
                                {{ alerta_epidemiologica.fecha_fin_t }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Indice: </strong>
                                {{ alerta_epidemiologica.indice }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Crecimiento: </strong>
                                {{ alerta_epidemiologica.crecimiento }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Confirmados: </strong>
                                {{ alerta_epidemiologica.confirmados }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Activos: </strong>
                                {{ alerta_epidemiologica.activos }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Graves: </strong>
                                {{ alerta_epidemiologica.graves }}
                            </div>
                            <div class="col-6 mt-2">
                                <strong>Fallecidos: </strong>
                                {{ alerta_epidemiologica.fallecidos }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
