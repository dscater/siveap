<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useCasoEpidemiologicos } from "@/composables/caso_epidemiologicos/useCasoEpidemiologicos";
import { ref, onMounted, onBeforeMount, onBeforeUnmount } from "vue";
import Formulario from "./Formulario.vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useAxios } from "@/composables/axios/useAxios";
import InfoPaciente from "./InfoPaciente.vue";
const { props: props_page } = usePage();
const appStore = useAppStore();
const { axiosDelete } = useAxios();

onBeforeMount(() => {
    appStore.startLoading();
});

const { setCasoEpidemiologico, limpiarCasoEpidemiologico, form } =
    useCasoEpidemiologicos();

const miTable = ref(null);
const headers = [
    {
        label: "CÓDIGO",
        key: "codigo",
        sortable: true,
        fixed: true,
        width: "3%",
    },
    {
        label: "PACIENTE",
        key: "paciente",
        fixed: true,
        sortable: true,
    },
    {
        label: "ENFERMEDAD",
        key: "enfermedad.nombre",
        sortable: true,
    },
    {
        label: "FECHA SINTOMAS",
        key: "fi_sintomas_t",
        sortable: true,
    },
    {
        label: "FECHA DIAGNOSTICO",
        key: "fecha_diagnostico_t",
        sortable: true,
    },
    {
        label: "CENTRO",
        key: "centro.nombre",
        sortable: true,
    },
    {
        label: "COMUNIDAD",
        key: "comunidad.nombre",
        sortable: true,
    },
    {
        label: "TIPO CASO",
        key: "tipo_caso",
        sortable: true,
    },
    {
        label: "GRAVEDAD",
        key: "gravedad",
        sortable: true,
    },
    {
        label: "ESTADO",
        key: "estado",
        fixed: "right",
        sortable: true,
    },
    {
        label: "ACCIÓN",
        key: "accion",
        fixed: "right",
        width: "4%",
    },
];

const multiSearch = ref({
    search: "",
    filtro: [],
});

const muestra_formulario = ref(false);
const muestra_formulario_paciente = ref(false);
const oPaciente = ref(null);

const verInfoPaciente = (item) => {
    oPaciente.value = null;
    axios.get(route("pacientes.show", item.id)).then((response) => {
        oPaciente.value = response.data;
        muestra_formulario_paciente.value = true;
    });
};

const agregarRegistro = () => {
    limpiarCasoEpidemiologico();
    muestra_formulario.value = true;
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        limpiarCasoEpidemiologico();
        muestra_formulario.value = false;
    }
};

const eliminarCasoEpidemiologico = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre}</strong>`,
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
                route("caso_epidemiologicos.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

onMounted(async () => {
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
    <Head title="Casos Epidemiológicos"></Head>

    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h3 class="m-0">
                        <i class="fa fa-book-medical"></i> Casos Epidemiológicos
                    </h3>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-end">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Casos Epidemiológicos
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-4">
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'caso_epidemiologicos.create',
                                )
                            "
                            type="button"
                            class="btn btn-primary text-sm"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo Caso Epidemiológico
                        </button>
                    </div>
                    <div class="col-md-8 my-1">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div
                                    class="input-group"
                                    style="align-items: end"
                                >
                                    <input
                                        v-model="multiSearch.search"
                                        placeholder="Buscar"
                                        class="form-control border-1 border-right-0"
                                    />
                                    <button
                                        class="btn btn-light bg-white rounded-0"
                                        @click="updateDatos"
                                    >
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <MiTable
                            :tableClass="'bg-white mitabla'"
                            ref="miTable"
                            :cols="headers"
                            :api="true"
                            :url="route('caso_epidemiologicos.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #codigo="{ item }">
                                <div>
                                    <span class="fw-bold text-sm">{{
                                        item.codigo
                                    }}</span>
                                </div>
                            </template>
                            <template #paciente="{ item }">
                                <div>
                                    <span class="fw-bold"
                                        >{{ item.paciente.full_name }}
                                        <button
                                            class="btn btn-sm btn-outline-primary text-xs py-0 px-1"
                                            title="Datos Paciente"
                                            @click="
                                                verInfoPaciente(item.paciente)
                                            "
                                        >
                                            <i
                                                class="fa fa-external-link-alt"
                                            ></i></button></span
                                    ><br />
                                    <span class="text-xxs"
                                        >({{ item.paciente.sexo }} -
                                        {{ item.paciente.edad }} años)</span
                                    >
                                </div>
                            </template>
                            <template #fecha_nac="{ item }">
                                <div>
                                    <span>{{ item.fecha_nac_t }}</span
                                    ><br />
                                    <span class="text-xs"
                                        >({{ item.edad }} años)</span
                                    >
                                </div>
                            </template>
                            <template #accion="{ item }">
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'seguimientos.index',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Seguimiento"
                                        placement="left-start"
                                    >
                                        <Link
                                            class="btn btn-primary"
                                            :href="
                                                route(
                                                    'seguimientos.index',
                                                    item.id,
                                                )
                                            "
                                        >
                                            {{ item.seguimientos_count }}
                                            <br />
                                            <i class="fa fa-list"></i></Link
                                    ></el-tooltip>
                                </template>
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'caso_epidemiologicos.edit',
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
                                                setCasoEpidemiologico(item);
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
                                            'caso_epidemiologicos.destroy',
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
                                            @click="
                                                eliminarCasoEpidemiologico(item)
                                            "
                                        >
                                            <i
                                                class="fa fa-trash-alt"
                                            ></i></button
                                    ></el-tooltip>
                                </template>
                            </template>
                        </MiTable>
                    </div>
                </div>
            </div>
        </div>
    </Content>

    <Formulario
        v-if="muestra_formulario"
        :muestra_formulario="muestra_formulario"
        :form="form"
        @envio-formulario="updateDatatable"
        @cerrar-formulario="muestra_formulario = false"
    ></Formulario>

    <InfoPaciente
        v-if="muestra_formulario_paciente"
        :muestra_formulario="muestra_formulario_paciente"
        :form="oPaciente"
        @cerrar-formulario="muestra_formulario_paciente = false"
    ></InfoPaciente>
</template>
