<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import "leaflet/dist/leaflet.css";
import GraficoPrediccion from "@/Components/GraficoPrediccion.vue";
import MapaPrediccion from "@/Components/MapaPrediccion.vue";
const props = defineProps({
    comunidads: Array,
    enfermedads: Array,
});
const { props: props_page } = usePage();
const appStore = useAppStore();

const filtro = ref({
    dias_predecir: 7,
    comunidad_id: "",
    enfermedad_id_id: "",
});
const prediccions = ref([]);
const cargarPrediccions = () => {
    axios
        .get(route("prediccions.realizarPrediccions"), {
            params: filtro.value,
        })
        .then((response) => {
            console.log(response.data);
            prediccions.value = response.data.prediccions;
        })
        .catch((e) => {
            console.log(e);
            if (e.response.status == 500) {
            }
        });
};

onMounted(async () => {
    cargarPrediccions();
    appStore.stopLoading();
});

onBeforeMount(() => {
    appStore.startLoading();
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
    <Head title="Predicción Epidemiológica"></Head>

    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h3 class="m-0">
                        <i class="fa fa-chart-line"></i> Predicción
                        Epidemiológica
                    </h3>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-end">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Predicción Epidemiológica
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-3 my-1">
                <span class="text-xs text-muted">Días Predecir</span>
                <input
                    type="number"
                    step="1"
                    class="form-control"
                    placeholder="Estado Alerta"
                    v-model="filtro.dias_predecir"
                    @keyup="cargarPrediccions"
                    @change="cargarPrediccions"
                />
            </div>
            <div class="col-md-3 my-1">
                <span class="text-xs text-muted">Comunidad</span>
                <el-select
                    placeholder="Comunidad"
                    no-data-text="Sin datos"
                    no-match-text="Sin resultados"
                    filterable
                    clearable
                    v-model="filtro.comunidad_id"
                    @change="cargarPrediccions"
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
                    v-model="filtro.enfermedad_id"
                    @change="cargarPrediccions"
                >
                    <el-option
                        v-for="item in enfermedads"
                        :key="item.id"
                        :value="item.id"
                        :label="item.nombre"
                    ></el-option>
                </el-select>
            </div>
            <div class="col-12">
                <MapaPrediccion :comunidades="prediccions"></MapaPrediccion>
            </div>
        </div>
        <div
            v-for="comunidad in prediccions"
            :key="comunidad.comunidad_id"
            class="mb-5"
        >
            <h3>
                {{ comunidad.comunidad }}
            </h3>
            <div class="row">
                <div
                    class="col-md-6 mt-2"
                    v-for="item in comunidad.enfermedades"
                    :key="item.enfermedad_id"
                >
                    <GraficoPrediccion
                        :enfermedad="item.enfermedad"
                        :historico="item.historico"
                        :predicciones="item.predicciones"
                    />
                </div>
            </div>
        </div>
    </Content>
</template>
