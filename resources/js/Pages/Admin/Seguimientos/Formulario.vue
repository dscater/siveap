<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
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
        ? `<i class="fa fa-plus"></i> Nueva Categoría de Enfermedad`
        : `<i class="fa fa-edit"></i> Editar Categoría de Enfermedad`;
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
            ? route("seguimientos.store")
            : route("seguimientos.update", form.id);

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

const cargarListas = () => {
    cargarEstados();
    cargarGravedads();
};

onMounted(() => {
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
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <b>Código Caso: </b
                                        >{{ form.caso_epidemiologico.codigo }}
                                    </div>
                                    <div class="col-6">
                                        <b>Estado del Caso: </b
                                        >{{ form.caso_epidemiologico.estado }}
                                    </div>
                                    <div class="col-6">
                                        <b>Enfermedad: </b
                                        >{{
                                            form.caso_epidemiologico.enfermedad
                                                .nombre
                                        }}
                                    </div>
                                    <div class="col-6">
                                        <b>Gravedad: </b
                                        >{{ form.caso_epidemiologico.gravedad }}
                                    </div>
                                    <div class="col-6">
                                        <b>Observaciones: </b
                                        >{{
                                            form.caso_epidemiologico
                                                .observaciones
                                        }}
                                    </div>
                                    <div class="col-6">
                                        <b>Comunidad: </b
                                        >{{
                                            form.caso_epidemiologico.comunidad
                                                .nombre
                                        }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Fecha</label>
                        <input
                            type="date"
                            class="form-control"
                            v-model="form.fecha"
                        />
                        <ul
                            v-if="form.errors?.fecha"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.fecha }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Gravedad</label>
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
                        <label class="required">Estado</label>
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
                        <label class="">Observaciones</label>
                        <el-input
                            type="textarea"
                            v-model="form.observaciones"
                            autosize
                        >
                        </el-input>
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
