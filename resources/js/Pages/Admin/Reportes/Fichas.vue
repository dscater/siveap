<script setup>
import Content from "@/Components/Content.vue";
import { computed, onBeforeMount, onMounted, ref } from "vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { useAppStore } from "@/stores/aplicacion/appStore";
const appStore = useAppStore();
const { props: props_page } = usePage();

onBeforeMount(() => {
    appStore.startLoading();
});

const listCasosEpidemiologicos = ref([]);
const listComunidads = ref([]);
const listCentros = ref([]);
const listEnfermedads = ref([]);
const cargarCasosEpidemiologicos = () => {
    axios.get(route("caso_epidemiologicos.listado")).then((response) => {
        listCasosEpidemiologicos.value = response.data.caso_epidemiologicos;
        listCasosEpidemiologicos.value.unshift({
            id: "todos",
            codigo: "TODOS",
        });
    });
};
const cargarComunidads = () => {
    axios.get(route("comunidads.listado")).then((response) => {
        listComunidads.value = response.data.comunidads;
        listComunidads.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};
const cargarCentros = () => {
    axios.get(route("centros.listado")).then((response) => {
        listCentros.value = response.data.centros;
        listCentros.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const cargarEnfermedads = () => {
    axios.get(route("enfermedads.listado")).then((response) => {
        listEnfermedads.value = response.data.enfermedads;
        listEnfermedads.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const listTipoCasos = ref([]);
const cargarTipoCasos = () => {
    axios.get(route("tipo_casos.listado")).then((response) => {
        listTipoCasos.value = response.data;
        listTipoCasos.value.unshift({
            value: "todos",
            label: "TODOS",
        });
    });
};

const listGravedads = ref([]);
const cargarGravedads = () => {
    axios.get(route("gravedads.listado")).then((response) => {
        listGravedads.value = response.data;
        listGravedads.value.unshift({
            value: "todos",
            label: "TODOS",
        });
    });
};

const listEstados = ref([]);
const cargarEstados = () => {
    axios.get(route("estados.listado")).then((response) => {
        listEstados.value = response.data;
        listEstados.value.unshift({
            value: "todos",
            label: "TODOS",
        });
    });
};

const cargarListas = () => {
    cargarCasosEpidemiologicos();
    cargarComunidads();
    cargarCentros();
    cargarEnfermedads();
    cargarTipoCasos();
    cargarGravedads();
    cargarEstados();
};

onMounted(() => {
    cargarListas();
    appStore.stopLoading();
});

const listFormatos = ref([
    {
        icon: "fa fa-file-pdf",
        value: "pdf",
        label: "PDF",
    },
    {
        icon: "fa fa-file-excel",
        value: "excel",
        label: "EXCEL",
    },
]);

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};
const form = ref({
    caso_epidemiologico_id: "todos",
    comunidad_id: "todos",
    centro_id: "todos",
    enfermedad_id: "todos",
    tipo_caso: "todos",
    gravedad: "todos",
    estado: "todos",
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
    formato: "pdf",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_fichas", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Fichas de Casos Epidemiológicos"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Fichas de Casos Epidemiológicos</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-end">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reportes - Fichas de Casos Epidemiológicos
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <form @submit.prevent="generarReporte">
                            <div class="row">
                                <div class="col-md-12">
                                    <label>Código Caso*</label>
                                    <el-select
                                        v-model="form.caso_epidemiologico_id"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listCasosEpidemiologicos"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.codigo"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                            </div>
                            <div
                                class="row"
                                v-if="form.caso_epidemiologico_id == 'todos'"
                            >
                                <div class="col-md-12">
                                    <label>Seleccionar comunidad*</label>
                                    <el-select
                                        v-model="form.comunidad_id"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listComunidads"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div
                                    class="col-md-12"
                                    v-if="
                                        props_page.auth?.user.tipo ==
                                        'ADMINISTRACIÓN'
                                    "
                                >
                                    <label>Seleccionar Centro*</label>
                                    <el-select
                                        v-model="form.centro_id"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listCentros"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-md-12">
                                    <label>Seleccionar Enfermedad*</label>
                                    <el-select
                                        v-model="form.enfermedad_id"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listEnfermedads"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-md-12">
                                    <label>Seleccionar Tipo de Caso*</label>
                                    <el-select
                                        v-model="form.tipo_caso"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listTipoCasos"
                                            :key="item.value"
                                            :value="item.value"
                                            :label="item.label"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-md-12">
                                    <label>Seleccionar Gravedad*</label>
                                    <el-select
                                        v-model="form.gravedad"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listGravedads"
                                            :key="item.value"
                                            :value="item.value"
                                            :label="item.label"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-md-12">
                                    <label>Seleccionar Estado*</label>
                                    <el-select
                                        v-model="form.estado"
                                        filterable
                                        placeholder="- Seleccione -"
                                    >
                                        <el-option
                                            v-for="item in listEstados"
                                            :key="item.value"
                                            :value="item.value"
                                            :label="item.label"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-12">
                                    <label>Fecha de Diagnostico</label>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_ini"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_fin"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <!-- <div class="col-md-12 text-center mt-2">
                                    <el-radio-group v-model="form.formato">
                                        <el-radio
                                            v-for="item in listFormatos"
                                            :value="item.value"
                                            size="large"
                                            ><i :class="item.icon"></i>
                                            {{ item.label }}</el-radio
                                        >
                                    </el-radio-group>
                                </div> -->
                            </div>
                            <div class="row">
                                <div class="col-md-12 text-center mt-3">
                                    <button
                                        class="btn btn-primary"
                                        block
                                        @click="generarReporte"
                                        :disabled="generando"
                                        v-text="txtBtn"
                                    ></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
