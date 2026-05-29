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
        ? `<i class="fa fa-plus"></i> Nueva Regla de Alerta`
        : `<i class="fa fa-edit"></i> Editar Regla de Alerta`;
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
            ? route("reglas_alertas.store")
            : route("reglas_alertas.update", form.id);

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

const listEnfermedads = ref([]);
const cargarEnfermedads = async () => {
    await axios
        .get(route("enfermedads.listado"))
        .then((response) => {
            listEnfermedads.value = response.data.enfermedads;
        })
        .catch((error) => {
            console.log(error);
        });
};

const listRiesgos = ref([
    { id: "BAJO", nombre: "BAJO" },
    { id: "MEDIO", nombre: "MEDIO" },
    { id: "ALTO", nombre: "ALTO" },
    { id: "CRITICO", nombre: "CRITICO" },
]);

const cargarListas = () => {
    cargarEnfermedads();
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
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Seleccionar Enfermedad</label>
                        <el-select
                            v-model="form.enfermedad_id"
                            placeholder="- Seleccione -"
                            filterable
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                        >
                            <el-option
                                v-for="item in listEnfermedads"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.enfermedad_id"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.enfermedad_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required"
                            >Umbral de casos para alerta</label
                        >
                        <input
                            type="number"
                            min="1"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.umbral,
                            }"
                            v-model="form.umbral"
                        />
                        <ul
                            v-if="form.errors?.umbral"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.umbral }}
                            </li>
                        </ul>
                    </div>
                    <!-- <div class="col-md-4 mt-2">
                        <label class="required">Riesgo de alerta</label>
                        <el-select
                            v-model="form.riesgo"
                            filterable
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="Sin resultados"
                        >
                            <el-option
                                v-for="item in listRiesgos"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            />
                        </el-select>
                        <ul
                            v-if="form.errors?.riesgo"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.riesgo }}
                            </li>
                        </ul>
                    </div> -->
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
