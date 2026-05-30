<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import axios from "axios";
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
        ? `<i class="fa fa-plus"></i> Nueva Alerta Epidemiológica`
        : `<i class="fa fa-edit"></i> Editar Alerta Epidemiológica`;
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
            ? route("alerta_epidemiologicas.store")
            : route("alerta_epidemiologicas.update", form.id);

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
const listEstado = ref([
    {
        value: "ACTIVO",
        label: "ACTIVO",
    },
    {
        value: "CONTROLADO",
        label: "CONTROLADO",
    },
]);

const cargarListas = () => {};

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
                <div class="row" v-if="form && form.enfermedad">
                    <div class="col-12">
                        <strong>Fecha de Alerta: </strong>{{ form.fecha_t }}
                    </div>
                    <div class="col-12">
                        <strong>Estado: </strong>{{ form.estado }}
                    </div>
                    <div class="col-12" v-if="form.estado == 'CONTROLADO'">
                        <strong>Fecha Fin Alerta: </strong
                        >{{ form.fecha_fin_t }}
                    </div>
                    <div class="col-12">
                        <strong>Enfermedad: </strong
                        >{{ form.enfermedad.nombre }}
                    </div>
                    <div
                        class="col-12"
                        v-if="form.enfermedad.categoria_enfermedad"
                    >
                        <strong>Categoría: </strong
                        >{{ form.enfermedad.categoria_enfermedad?.nombre }}
                        <br />
                        <p
                            v-if="
                                form.enfermedad.categoria_enfermedad.descripcion
                            "
                            v-text="
                                form.enfermedad.categoria_enfermedad
                                    ?.descripcion
                            "
                        ></p>
                    </div>
                    <div class="col-12" v-if="form.enfermedad.tipo_transmision">
                        <strong>Tipo de Transmisión: </strong
                        >{{ form.enfermedad.tipo_transmision?.nombre }} <br />
                        <p
                            v-if="form.enfermedad.tipo_transmision.descripcion"
                            v-text="
                                form.enfermedad.tipo_transmision?.descripcion
                            "
                        ></p>
                    </div>
                    <div class="col-12 mt-2 border-top pt-2">
                        <h5>Estado</h5>
                    </div>
                    <div class="col-12">
                        <select v-model="form.estado" class="form-control">
                            <option
                                v-for="item in listEstado"
                                :key="item.value"
                                :value="item.value"
                            >
                                {{ item.label }}
                            </option>
                        </select>
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
