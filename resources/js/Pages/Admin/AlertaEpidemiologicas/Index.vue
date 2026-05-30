<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useAlertaEpidemiologicas } from "@/composables/alerta_epidemiologicas/useAlertaEpidemiologicas";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAxios } from "@/composables/axios/useAxios";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "./Formulario.vue";
import MapAlertas from "@/Components/MapAlertas.vue";
import "leaflet/dist/leaflet.css";
import Contingencia from "./Contingencia.vue";
const props = defineProps({
    comunidads: Array,
    enfermedads: Array,
});
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();

const { setAlertaEpidemiologica, limpiarAlertaEpidemiologica, form } =
    useAlertaEpidemiologicas();
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
    {
        label: "ACCIÓN",
        key: "accion",
        sortable: true,
        fixed: "right",
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

const muestra_formulario_contingencia = ref(false);
const muestra_formulario = ref(false);
const oAlertaEpidemiologica = ref(null);
const muestraContingencia = (item) => {
    oAlertaEpidemiologica.value = null;
    axios
        .get(route("alerta_epidemiologicas.getInfo", item.id))
        .then((response) => {
            oAlertaEpidemiologica.value = response.data;
            muestra_formulario_contingencia.value = true;
        });
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        limpiarAlertaEpidemiologica();
        cargarAlertas();
        muestra_formulario.value = false;
    }
};

const eliminarAlertaEpidemiologica = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.comunidad.nombre}</strong> - ${item.enfermedad.nombre}`,
        showCancelButton: true,
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "bg-danger",
            cancelButton: "bg-light text-dark border border-secondary",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosDelete(
                route("alerta_epidemiologicas.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

onMounted(async () => {
    cargarAlertas();
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
                <MapAlertas :alertas="alertas" :key="mapKey"></MapAlertas>
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
                    <template #accion="{ item }">
                        <template
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'alerta_epidemiologicas.index',
                                )
                            "
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Contingencia"
                                placement="left-start"
                            >
                                <button
                                    type="button"
                                    class="btn btn-info"
                                    @click="muestraContingencia(item)"
                                >
                                    <i
                                        class="fa fa-clipboard-check"
                                    ></i></button
                            ></el-tooltip>
                        </template>
                        <template
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'alerta_epidemiologicas.index',
                                )
                            "
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Ver"
                                placement="left-start"
                            >
                                <Link
                                    :href="
                                        route(
                                            'alerta_epidemiologicas.show',
                                            item.id,
                                        )
                                    "
                                    class="btn btn-primary"
                                >
                                    <i class="fa fa-eye"></i></Link
                            ></el-tooltip>
                        </template>
                        <template
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'alerta_epidemiologicas.edit',
                                )
                            "
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Editar"
                                placement="left-start"
                            >
                                <button
                                    class="btn btn-warning"
                                    @click="
                                        setAlertaEpidemiologica(item);
                                        muestra_formulario = true;
                                    "
                                >
                                    <i class="fa fa-pen"></i></button
                            ></el-tooltip>
                        </template>
                        <template
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'alerta_epidemiologicas.destroy',
                                )
                            "
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Eliminar"
                                placement="left-start"
                            >
                                <button
                                    class="btn btn-danger"
                                    @click="eliminarAlertaEpidemiologica(item)"
                                >
                                    <i class="fa fa-trash-alt"></i></button
                            ></el-tooltip>
                        </template>
                    </template>
                </MiTable>
                <Contingencia
                    v-if="muestra_formulario_contingencia"
                    :muestra_formulario="muestra_formulario_contingencia"
                    :form="oAlertaEpidemiologica"
                    @cerrar-formulario="muestra_formulario_contingencia = false"
                ></Contingencia>

                <Formulario
                    v-if="muestra_formulario"
                    :muestra_formulario="muestra_formulario"
                    :form="form"
                    @envio-formulario="updateDatatable"
                    @cerrar-formulario="muestra_formulario = false"
                ></Formulario>
            </div>
        </div>
    </Content>
</template>
