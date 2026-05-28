<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import MapAlertas from "@/Components/MapAlertas.vue";
import "leaflet/dist/leaflet.css";
const props = defineProps({
    comunidads: Array,
    enfermedads: Array,
});
const { props: props_page } = usePage();
const appStore = useAppStore();

onBeforeMount(() => {
    appStore.startLoading();
});
const miTable = ref(null);

const multiSearch = ref({
    search: "",
    estado: "ACTIVO",
    comunidad_id: "",
    enfermedad_id: "",
    filtro: [],
});
const headers = [
    {
        label: "Nro.",
        key: "id",
        sortable: true,
        width: "3%",
    },
    {
        label: "COMUNIDAD",
        key: "comunidad.nombre",
        sortable: true,
    },
    {
        label: "ENFERMEDAD",
        key: "enfermedad.nombre",
        sortable: true,
    },
    {
        label: "NIVEL DE ALERTA",
        key: "nivel_alerta",
        sortable: true,
    },
    {
        label: "FECHA ALERTA",
        key: "fecha_t",
        sortable: true,
    },
    {
        label: "ESTADO",
        key: "estado",
        sortable: true,
    },
    {
        label: "FECHA FIN",
        key: "fecha_fin_t",
        sortable: true,
    },
    {
        label: "INDICE",
        key: "indice",
        sortable: true,
    },
    {
        label: "PREDICCIÓN",
        key: "prediccion",
        sortable: true,
    },
    {
        label: "CRECIMIENTO",
        key: "crecimiento",
        sortable: true,
    },
    {
        label: "CONFIRMADOS",
        key: "confirmados",
        sortable: true,
    },
    {
        label: "ACTIVOS",
        key: "activos",
        sortable: true,
    },
    {
        label: "GRAVES",
        key: "graves",
        sortable: true,
    },
    {
        label: "FALLECIDOS",
        key: "fallecidos",
        sortable: true,
    },
];

const listEstados = ref([
    {
        value: "ACTIVO",
        label: "ACTIVOS",
    },
    {
        value: "CONTROLADO",
        label: "CONTROLADOS",
    },
]);

const alertas = ref([]);
const cargandoAlertas = ref(false);
const cargarAlertas = () => {
    cargandoAlertas.value = true;
    axios
        .get(route("alerta_epidemiologicas.verificarAlertas"))
        .then((response) => {
            alertas.value = response.data.alertas;
        })
        .finally(() => {
            cargandoAlertas.value = false;
        });
};

onMounted(async () => {
    cargarAlertas();
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
                        <li class="breadcrumb-item active">
                            Alertas Epidemiológicas
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <MapAlertas :alertas="alertas"></MapAlertas>
            </div>
            <div class="col-md-12 mt-3">
                <div class="row">
                    <div class="col-md-3 my-1">
                        <span class="text-xs text-muted">Estado Alerta</span>
                        <el-select
                            placeholder="Estado Alerta"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultado
                            clearables"
                            clearable
                            v-model="multiSearch.estado"
                        >
                            <el-option
                                v-for="item in listEstados"
                                :key="item.value"
                                :value="item.value"
                                :label="item.label"
                            ></el-option>
                        </el-select>
                    </div>
                    <div class="col-md-3 my-1">
                        <span class="text-xs text-muted">Comunidad</span>
                        <el-select
                            placeholder="Comunidad"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                            clearable
                            v-model="multiSearch.comunidad_id"
                        >
                            <el-option
                                v-for="item in comunidads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            ></el-option>
                        </el-select>
                    </div>
                    <div class="col-md-3 my-1">
                        <span class="text-xs text-muted">Enfermedad</span>
                        <el-select
                            placeholder="Enfermedad"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                            clearable
                            v-model="multiSearch.enfermedad_id"
                        >
                            <el-option
                                v-for="item in enfermedads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            ></el-option>
                        </el-select>
                    </div>
                </div>
                <MiTable
                    :tableClass="'bg-white mitabla'"
                    ref="miTable"
                    :cols="headers"
                    :api="true"
                    :url="route('alerta_epidemiologicas.paginado')"
                    :numPages="5"
                    :multiSearch="multiSearch"
                    :syncOrderBy="'id'"
                    :syncOrderAsc="'DESC'"
                    table-responsive
                    :header-class="'bg__primary'"
                    fixed-header
                >
                    <template #estado="{ item }">
                        <span
                            class="badge text-xxs"
                            :class="{
                                'bg-warning text-dark': item.estado == 'ACTIVO',
                                'bg-success': item.estado == 'CONTROLADO',
                            }"
                        >
                            {{ item.estado }}
                        </span>
                    </template>
                    <template #acceso="{ item }">
                        <div
                            class="badge text-sm"
                            :class="[
                                item.acceso == 1 ? 'bg-success' : 'bg-danger',
                            ]"
                        >
                            {{
                                item.acceso == 1
                                    ? "HABILITADO"
                                    : "DESHABILITADO"
                            }}
                        </div>
                    </template>
                    <template #accion="{ item }"> </template>
                </MiTable>
            </div>
        </div>
    </Content>
</template>
