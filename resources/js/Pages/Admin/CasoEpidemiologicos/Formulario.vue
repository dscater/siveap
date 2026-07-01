<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import axios from "axios";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
const { props: props_page } = usePage();

const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    form: {
        type: Object,
    },
});

const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
const form = props.form;

const tituloDialog = computed(() => {
    return form.id == 0
        ? `<i class="fa fa-plus"></i> Nuevo Caso Epidemiológico`
        : `<i class="fa fa-edit"></i> Editar Caso Epidemiológico`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (form.id == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("caso_epidemiologicos.store")
            : route("caso_epidemiologicos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: (response) => {
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-alert-success",
                },
            });
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            } else {
                const error =
                    "Ocurrió un error inesperado contactese con el Administrador";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            }
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
        },
    });
};

const listPacientes = ref([]);
const cargarPacientes = () => {
    axios.get(route("pacientes.listado")).then((response) => {
        listPacientes.value = response.data.pacientes;
    });
};

const listEnfermedads = ref([]);
const cargarEnfermedads = () => {
    axios.get(route("enfermedads.listado")).then((response) => {
        listEnfermedads.value = response.data.enfermedads;
    });
};

const listCentros = ref([]);
const cargarCentros = () => {
    axios.get(route("centros.listado")).then((response) => {
        listCentros.value = response.data.centros;
    });
};

const listComunidads = ref([]);
const cargarComunidads = () => {
    axios.get(route("comunidads.listado")).then((response) => {
        listComunidads.value = response.data.comunidads;
    });
};

const listTipoCasos = ref([]);
const cargarTipoCasos = () => {
    axios.get(route("tipo_casos.listado")).then((response) => {
        listTipoCasos.value = response.data;
    });
};

const listGravedads = ref([]);
const cargarGravedads = () => {
    axios.get(route("gravedads.listado")).then((response) => {
        listGravedads.value = response.data;
    });
};

const listEstados = ref([]);
const cargarEstados = () => {
    axios.get(route("estados.listado")).then((response) => {
        listEstados.value = response.data;
    });
};

const listTipos = ref(["PÚBLICO", "SEGURO SALUD", "PRIVADO", "OTRO"]);
const listCaptados = ref([
    "CASO CAPTADO EN BUSQUEDA ACTUAL",
    "ATENCIÓN EN SERVICIO DE SALUD",
    "OTRO",
]);

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const cargarListas = () => {
    cargarComunidads();
    cargarPacientes();
    cargarEnfermedads();
    cargarCentros();
    cargarTipoCasos();
    cargarGravedads();
    cargarEstados();
    cargarTipoSintomas();
};

const pacienteSeleccionado = ref(null);
const identificaComunidad = () => {
    if (form.paciente_id) {
        pacienteSeleccionado.value = listPacientes.value.filter(
            (elem) => elem.id == form.paciente_id,
        )[0];
        form.comunidad_id = pacienteSeleccionado.value.comunidad_id;

        form.embarazada = "";
        form.fuma = "";
        form.fecha_parto = "";
        if (pacienteSeleccionado.value.sexo == "FEMENINO") {
            form.embarazada = 0;
        }
    }
};

const obtenerSemanaDelAnio = (fecha) => {
    const date = new Date(fecha);

    // Convertir a UTC para evitar problemas de zona horaria
    const fechaUTC = new Date(
        Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()),
    );

    // Ajustar al jueves de la semana actual
    fechaUTC.setUTCDate(
        fechaUTC.getUTCDate() + 4 - (fechaUTC.getUTCDay() || 7),
    );

    const inicioAnio = new Date(Date.UTC(fechaUTC.getUTCFullYear(), 0, 1));

    return Math.ceil(((fechaUTC - inicioAnio) / 86400000 + 1) / 7);
};

watch(
    () => form.fi_sintomas,
    (fecha) => {
        if (fecha) {
            form.semana = obtenerSemanaDelAnio(fecha);
        }
    },
);

const enfermedadSeleccionada = ref(null);

watch(
    () => form.enfermedad_id,
    (enfermedad_id) => {
        enfermedadSeleccionada.value = null;
        listEnfermedadSintomas.value = [];
        form.caso_sintomas = [];
        if (enfermedad_id) {
            enfermedadSeleccionada.value = listEnfermedads.value.filter(
                (el) => el.id == enfermedad_id,
            )[0];
            cargarCasoSintomas(enfermedad_id);
        }
    },
);

const listTipoSintoma = ref([]);

const cargarTipoSintomas = () => {
    axios.get(route("tipo_sintomas.listado")).then((response) => {
        listTipoSintoma.value = response.data;

        if (form.enfermedad_id && form.enfermedad_id != 0) {
            enfermedadSeleccionada.value = listEnfermedads.value.filter(
                (el) => el.id == form.enfermedad_id,
            )[0];
            cargarCasoSintomas(form.enfermedad_id);
        }
    });
};

const listEnfermedadSintomas = ref([]);
const cargarCasoSintomas = (enfermedad_id) => {
    axios
        .get(route("enfermedad_sintomas.listado"), {
            params: {
                enfermedad_id: enfermedad_id,
            },
        })
        .then((response) => {
            listEnfermedadSintomas.value = response.data.enfermedad_sintomas;
            // console.log(listEnfermedadSintomas.value);
            iniciaSintomas();
        });
};

const iniciaSintomas = () => {
    // console.log("iniciaSintomas");
    // console.log(form.caso_sintomas);
    listTipoSintoma.value.forEach((elem) => {
        const sintomas = listEnfermedadSintomas.value.filter(
            (elSin) => elSin.tipo == elem.value,
        );
        // console.log(sintomas);
        // console.log("--------------------");
        sintomas.forEach((sin, index) => {
            const existeForm = form.caso_sintomas.filter(
                (elForm) => elForm.enfermedad_sintoma_id == sin.id,
            )[0];
            console.log("existe?");
            console.log(existeForm);
            if (!existeForm) {
                form.caso_sintomas.push({
                    id: 0,
                    caso_epidemiologico_id: 0,
                    enfermedad_sintoma_id: sin.id,
                    enfermedad_sintoma: sin,
                    valor: sin.input == 0 ? "false" : "",
                });
            }
        });
    });
};

const sintomasPorTipo = computed(() => {
    const grupos = {};
    // console.log("**************************");
    // console.log(form.caso_sintomas);
    form.caso_sintomas.forEach((item) => {
        const tipo = item.enfermedad_sintoma?.tipo;

        if (!grupos[tipo]) {
            grupos[tipo] = [];
        }

        grupos[tipo].push(item);
    });

    return grupos;
});

onMounted(() => {
    if (props_page.auth?.user.tipo == "CENTRO MÉDICO" && form.id == 0) {
        form.centro_id = props_page.auth?.user.centro_id;
    }
    cargarListas();
});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-principal'"
        :footer-class="'justify-content-end'"
    >
        <template #header>
            <h4 class="modal-title text-white" v-html="tituloDialog"></h4>
            <button
                type="button"
                class="btn-close btn-close-white"
                @click.prevent="cerrarFormulario()"
            ></button>
        </template>

        <template #body>
            <form @submit.prevent="enviarFormulario()" class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <h4 class="card-title">1. DATOS GENERALES</h4>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required"
                            >Fecha Notificación/Diagnostico</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.fecha_diagnostico,
                            }"
                            v-model="form.fecha_diagnostico"
                        />
                        <ul
                            v-if="form.errors?.fecha_diagnostico"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_diagnostico }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Departamento</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.departamento,
                            }"
                            v-model="form.departamento"
                        />
                        <ul
                            v-if="form.errors?.departamento"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.departamento }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Municipio</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.municipio,
                            }"
                            v-model="form.municipio"
                        />
                        <ul
                            v-if="form.errors?.municipio"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.municipio }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Comunidad</label>
                        <el-select
                            v-model="form.comunidad_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listComunidads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.comunidad_id"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.comunidad_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Red de Salud</label>
                        <input
                            type="text"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.red_salud,
                            }"
                            v-model="form.red_salud"
                        />
                        <ul
                            v-if="form.errors?.red_salud"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.red_salud }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required"
                            >Establecimiento de Salud Notificante</label
                        >
                        <el-select
                            v-model="form.centro_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                            v-if="
                                props_page.auth?.user.tipo == 'ADMINISTRACIÓN'
                            "
                        >
                            <el-option
                                v-for="item in listCentros"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            >
                            </el-option>
                        </el-select>
                        <span v-else>{{
                            props_page.auth.user.centro?.nombre
                        }}</span>
                        <ul
                            v-if="form.errors?.centro_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.centro_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Tipo de Atención</label>
                        <el-select
                            v-model="form.tipo"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listTipos"
                                :key="item"
                                :value="item"
                                :label="item"
                            >
                            </el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.tipo"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Tipo Registro</label>
                        <el-select
                            v-model="form.captado"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listCaptados"
                                :key="item"
                                :value="item"
                                :label="item"
                            >
                            </el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.captado"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.captado }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2" v-if="form.captado == 'OTRO'">
                        <label class="">Especificar</label>
                        <input
                            v-model="form.captado_desc"
                            class="form-control"
                        />
                        <ul
                            v-if="form.errors?.captado_desc"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.captado_desc }}
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row border-top mt-2">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">2. DATOS DEL PACIENTE</h4>
                    </div>

                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Paciente</label>
                        <el-select
                            v-model="form.paciente_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                            @change="identificaComunidad"
                        >
                            <el-option
                                v-for="item in listPacientes"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            >
                            </el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.paciente_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.paciente_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-8" v-if="pacienteSeleccionado">
                        <div class="row">
                            <div class="col-6">
                                <p>
                                    <strong>Edad: </strong
                                    >{{ pacienteSeleccionado.edad }}
                                </p>
                            </div>
                            <div class="col-6">
                                <p>
                                    <strong>Sexo: </strong
                                    >{{ pacienteSeleccionado.sexo }}
                                </p>
                            </div>
                            <div class="col-6">
                                <p>
                                    <strong>Ocupación: </strong
                                    >{{ pacienteSeleccionado.ocupacion }}
                                </p>
                            </div>
                            <div class="col-6">
                                <p>
                                    <strong>Teléfono: </strong
                                    >{{ pacienteSeleccionado.fono }}
                                </p>
                            </div>
                            <div class="col-6">
                                <p>
                                    <strong>C.I.: </strong
                                    >{{ pacienteSeleccionado.full_ci }}
                                </p>
                            </div>
                            <div
                                class="col-6"
                                v-if="pacienteSeleccionado.apoderado"
                            >
                                <p>
                                    <strong>Padre(s)/Apoderado: </strong
                                    >{{ pacienteSeleccionado.apoderado }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 border-top">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">
                            3. ANTECEDENTES EPIDEMIOLÓGICOS
                        </h4>
                    </div>
                    <div class="col-md-12 mt-2">
                        <label class="required">Seleccionar Enfermedad</label>
                        <el-select
                            v-model="form.enfermedad_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listEnfermedads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            >
                            </el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.enfermedad_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.enfermedad_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-12">
                        <div class="row mt-1">
                            <div class="col-12">
                                <div
                                    class="fw-bold fw-uppercase text-sm text-center w-100"
                                >
                                    Lugar probable de infección
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="required">País/Lugar</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.pais_lpi,
                                    }"
                                    v-model="form.pais_lpi"
                                />
                                <ul
                                    v-if="form.errors?.pais_lpi"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.pais_lpi }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required">Departamento</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.departamento_lpi,
                                    }"
                                    v-model="form.departamento_lpi"
                                />
                                <ul
                                    v-if="form.errors?.departamento_lpi"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.departamento_lpi }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required"
                                    >Provincia/Municipio</label
                                >
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.municipio_lpi,
                                    }"
                                    v-model="form.municipio_lpi"
                                />
                                <ul
                                    v-if="form.errors?.municipio_lpi"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.municipio_lpi }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required"
                                    >Ciudad/Localidad/Comunidad</label
                                >
                                <el-select
                                    v-model="form.comunidad_id_lpi"
                                    placeholder="- Seleccione -"
                                    no-data-text="Sin datos"
                                    no-match-text="Sin resultados"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listComunidads"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                                <ul
                                    v-if="form.errors?.comunidad_id_lpi"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.comunidad_id_lpi }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required">Barrio/Zona/U.V.</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.zona_lpi,
                                    }"
                                    v-model="form.zona_lpi"
                                />
                                <ul
                                    v-if="form.errors?.zona_lpi"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.zona_lpi }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row mt-1">
                            <div class="col-12">
                                <div
                                    class="fw-bold fw-uppercase text-sm w-100 text-center"
                                >
                                    Lugar de inicio de signos y síntomas
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="required">País/Lugar</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.pais_lis,
                                    }"
                                    v-model="form.pais_lis"
                                />
                                <ul
                                    v-if="form.errors?.pais_lis"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.pais_lis }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required">Departamento</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.departamento_lis,
                                    }"
                                    v-model="form.departamento_lis"
                                />
                                <ul
                                    v-if="form.errors?.departamento_lis"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.departamento_lis }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required"
                                    >Provincia/Municipio</label
                                >
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.municipio_lis,
                                    }"
                                    v-model="form.municipio_lis"
                                />
                                <ul
                                    v-if="form.errors?.municipio_lis"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.municipio_lis }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required"
                                    >Ciudad/Localidad/Comunidad</label
                                >
                                <el-select
                                    v-model="form.comunidad_id_lis"
                                    placeholder="- Seleccione -"
                                    no-data-text="Sin datos"
                                    no-match-text="Sin resultados"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listComunidads"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                                <ul
                                    v-if="form.errors?.comunidad_id_lis"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.comunidad_id_lis }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label class="required">Barrio/Zona/U.V.</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.zona_lis,
                                    }"
                                    v-model="form.zona_lis"
                                />
                                <ul
                                    v-if="form.errors?.zona_lis"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.zona_lis }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-12"
                        v-if="
                            pacienteSeleccionado &&
                            pacienteSeleccionado.sexo == 'FEMENINO'
                        "
                    >
                        <div class="row">
                            <div class="col-md-4">
                                <label class="">Esta embarazada</label>
                                <el-radio-group v-model="form.embarazada">
                                    <el-radio :value="1" size="large"
                                        >SI</el-radio
                                    >
                                    <el-radio :value="0" size="large"
                                        >NO</el-radio
                                    >
                                </el-radio-group>
                            </div>
                            <div class="col-md-4">
                                <label class="">Fuma</label>
                                <el-radio-group v-model="form.fuma">
                                    <el-radio :value="1" size="large"
                                        >SI</el-radio
                                    >
                                    <el-radio :value="0" size="large"
                                        >NO</el-radio
                                    >
                                </el-radio-group>
                            </div>
                            <div class="col-md-4" v-if="form.embarazada == 1">
                                <label class="required">Fecha parto</label>
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.fecha_parto,
                                    }"
                                    v-model="form.fecha_parto"
                                />
                                <ul
                                    v-if="form.errors?.fecha_parto"
                                    class="list-unstyled text-danger"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fecha_parto }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2 border-top">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">4. DATOS CLÍNICOS</h4>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Fecha Inicio Sintomas</label>
                        <input
                            type="date"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.fi_sintomas,
                            }"
                            v-model="form.fi_sintomas"
                        />
                        <ul
                            v-if="form.errors?.fi_sintomas"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fi_sintomas }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Semana</label>
                        <input
                            type="number"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.semana,
                            }"
                            v-model="form.semana"
                        />
                        <ul
                            v-if="form.errors?.semana"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.semana }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Gravedad</label>
                        <el-select
                            v-model="form.gravedad"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listGravedads"
                                :key="item.value"
                                :value="item.value"
                                :label="item.label"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.gravedad"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.gravedad }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Estado</label>
                        <el-select
                            v-model="form.estado"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listEstados"
                                :key="item.value"
                                :value="item.value"
                                :label="item.label"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.estado"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.estado }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required"
                            >Nro. Contactos con otras personas</label
                        >
                        <input
                            type="number"
                            step="1"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.contacto,
                            }"
                            v-model="form.contacto"
                        />
                        <ul
                            v-if="form.errors?.contacto"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.contacto }}
                            </li>
                        </ul>
                    </div>
                    <div
                        clas="col-12"
                        v-if="form.enfermedad_id && enfermedadSeleccionada"
                        v-for="tipo in listTipoSintoma"
                        :key="tipo.value"
                    >
                        <template v-if="sintomasPorTipo[tipo.value]?.length">
                            <div class="col-12 mt-3">
                                <h5 class="text-sm fw-bold">
                                    - {{ tipo.label }} DE
                                    {{ enfermedadSeleccionada.nombre }}
                                </h5>
                            </div>
                            <div class="row">
                                <div
                                    class="col-md-3"
                                    v-for="sintoma in sintomasPorTipo[
                                        tipo.value
                                    ]"
                                    :key="sintoma.enfermedad_sintoma_id"
                                >
                                    {{ sintoma.enfermedad_sintoma.nombre }}
                                    <el-checkbox
                                        v-if="
                                            sintoma.enfermedad_sintoma.input ==
                                            0
                                        "
                                        v-model="sintoma.valor"
                                        :true-value="'true'"
                                        :false-value="'false'"
                                        size="large"
                                    ></el-checkbox>
                                    <input
                                        type="text"
                                        class="form-control"
                                        v-else
                                        v-model="sintoma.valor"
                                    />
                                </div>
                            </div>
                        </template>
                    </div>
                </div>

                <div class="row mt-2 border-top">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">5. HOSPITALIZACIÓN</h4>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Fue hospitalizado(a)</label>
                        <br />
                        <el-switch
                            size="large"
                            active-text="SI"
                            inactive-text="NO"
                            v-model="form.hospitalizacion"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Fecha de Hospitalización</label>
                        <input
                            type="date"
                            class="form-control"
                            v-model="form.fecha_hospitalizacion"
                        />
                        <ul
                            v-if="form.errors?.fecha_hospitalizacion"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_hospitalizacion }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Establecimiento de Salud</label>
                        <input
                            type="text"
                            class="form-control"
                            v-model="form.establecimiento"
                        />
                        <ul
                            v-if="form.errors?.establecimiento"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.establecimiento }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Hospitalizado(a) U TI.</label>
                        <br />
                        <el-switch
                            size="large"
                            active-text="SI"
                            inactive-text="NO"
                            v-model="form.hospitalizacion_uti"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Fecha de Hospitalización</label>
                        <input
                            type="date"
                            class="form-control"
                            v-model="form.fecha_hospitalizacion_uti"
                        />
                        <ul
                            v-if="form.errors?.fecha_hospitalizacion_uti"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_hospitalizacion_uti }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Establecimiento de Salud</label>
                        <input
                            type="text"
                            class="form-control"
                            v-model="form.establecimiento_uti"
                        />
                        <ul
                            v-if="form.errors?.establecimiento_uti"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.establecimiento_uti }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Tipo de Alta</label>
                        <el-select
                            v-model="form.tipo_alta"
                            placeholder="- Seleccione-"
                        >
                            <el-option
                                v-for="item in [
                                    'MÉDICA',
                                    'SOLICITADA',
                                    'FUGA',
                                    'DEFUNCIÓN',
                                ]"
                                :key="item"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.tipo_alta"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_alta }}
                            </li>
                        </ul>
                    </div>
                    <div
                        class="col-md-4 mt-2"
                        v-if="form.tipo_alto == 'DEFUNCIÓN'"
                    >
                        <label class="">Fecha Defunción</label>
                        <input
                            type="date"
                            class="form-control"
                            v-model="form.fecha_falle"
                        />
                        <ul
                            v-if="form.errors?.fecha_falle"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_falle }}
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row mt-2 border-top">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">6. DEFINICIÓN DE CASO</h4>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Estado del Caso</label>
                        <el-select
                            v-model="form.tipo_caso"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listTipoCasos"
                                :key="item.value"
                                :value="item.value"
                                :label="item.label"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.tipo_caso"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_caso }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="me-1">Laboratorio</label>
                        <el-checkbox
                            v-model="form.laboratorio"
                            :true-value="1"
                            :false-value="0"
                            size="large"
                        ></el-checkbox>
                        <ul
                            v-if="form.errors?.laboratorio"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.laboratorio }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="me-1">Por Nexo Epidemiologico</label>
                        <el-checkbox
                            v-model="form.nexo"
                            :true-value="1"
                            :false-value="0"
                            size="large"
                        ></el-checkbox>
                        <ul
                            v-if="form.errors?.nexo"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nexo }}
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row mt-2 border-top">
                    <div class="col-12 pt-2">
                        <h4 class="card-title">7. EXÁMENES DE LABORATORIO</h4>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Se tomo muestra</label>
                        <br />
                        <el-switch
                            size="large"
                            active-text="SI"
                            inactive-text="NO"
                            v-model="form.muestra"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Fecha Muestra</label>
                        <input
                            type="date"
                            class="form-control"
                            v-model="form.fecha_muestra"
                        />
                        <ul
                            v-if="form.errors?.fecha_muestra"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha_muestra }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Tipo Muestra</label>
                        <el-select
                            v-model="form.tipo_muestra"
                            placeholder="Seleccione"
                        >
                            <el-option
                                v-for="item in ['SUERO', 'ORINA', 'OTRO']"
                                :key="item"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.tipo_muestra"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_muestra }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Resultado RT-PCR</label>
                        <br />
                        <el-switch
                            size="large"
                            active-text="+"
                            inactive-text="-"
                            v-model="form.rt_pcr"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Resultado Serológico</label>
                        <br />
                        IgM
                        <el-switch
                            size="large"
                            active-text="+"
                            inactive-text="-"
                            v-model="form.igm"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                        n/c
                        <el-checkbox
                            v-model="form.igm_nc"
                            :true-value="1"
                            :false-value="0"
                            size="large"
                        ></el-checkbox>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Resultado Serológico</label>
                        <br />
                        IgG
                        <el-switch
                            size="large"
                            active-text="+"
                            inactive-text="-"
                            v-model="form.igg"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                        n/c
                        <el-checkbox
                            v-model="form.igg_nc"
                            :true-value="1"
                            :false-value="0"
                            size="large"
                        ></el-checkbox>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="">Observaciones</label>
                        <el-input
                            type="textarea"
                            v-model="form.observacion_lab"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.observacion_lab"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.observacion_lab }}
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="">Observaciones</label>
                        <el-input
                            type="textarea"
                            v-model="form.observaciones"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.observaciones"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.observaciones }}
                            </li>
                        </ul>
                    </div>
                </div> -->
            </form>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-light"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
            <button
                type="button"
                class="btn btn-primary"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
