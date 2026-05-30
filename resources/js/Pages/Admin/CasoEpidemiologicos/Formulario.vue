<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
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
};

const identificaComunidad = () => {
    if (form.paciente_id) {
        form.comunidad_id = listPacientes.value.filter(
            (elem) => elem.id == form.paciente_id,
        )[0].comunidad_id;
    }
};

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
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
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
                    <div class="col-md-4 mt-2">
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
                    <div
                        class="col-md-4 mt-2"
                        v-if="props_page.auth?.user.tipo == 'ADMINISTRACIÓN'"
                    >
                        <label class="required">Seleccionar Centro</label>
                        <el-select
                            v-model="form.centro_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                            filterable
                        >
                            <el-option
                                v-for="item in listCentros"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            >
                            </el-option>
                        </el-select>
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
                        {{ form.fi_sintomas }}
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
                        <label class="required">Fecha Diagnostico</label>
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
                        <label class="required">Seleccionar Tipo de Caso</label>
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
                    <div class="col-md-4 mt-2">
                        <label class="required">Requiere Hospitalización</label>
                        <br />
                        <el-switch
                            size="large"
                            active-text="SI"
                            inactive-text="NO"
                            v-model="form.acceso"
                            :active-value="1"
                            :inactive-value="0"
                            style="
                                --el-switch-on-color: #009047;
                                --el-switch-off-color: #e1f5fe;
                            "
                        />
                    </div>
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
                </div>
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
