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
    return `<i class="fa fa-clipboard-check"></i> Acciones de Contingencia`;
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
            <div class="row" v-if="form && form.enfermedad">
                <div class="col-12">
                    <strong>Fecha de Alerta: </strong>{{ form.fecha_t }}
                </div>
                <div class="col-12">
                    <strong>Estado: </strong>{{ form.estado }}
                </div>
                <div class="col-12" v-if="form.estado == 'CONTROLADO'">
                    <strong>Fecha Fin Alerta: </strong>{{ form.fecha_fin_t }}
                </div>
                <div class="col-12">
                    <strong>Enfermedad: </strong>{{ form.enfermedad.nombre }}
                </div>
                <div class="col-12" v-if="form.enfermedad.categoria_enfermedad">
                    <strong>Categoría: </strong
                    >{{ form.enfermedad.categoria_enfermedad?.nombre }}
                    <br />
                    <p
                        v-if="form.enfermedad.categoria_enfermedad.descripcion"
                        v-text="
                            form.enfermedad.categoria_enfermedad?.descripcion
                        "
                    ></p>
                </div>
                <div class="col-12" v-if="form.enfermedad.tipo_transmision">
                    <strong>Tipo de Transmisión: </strong
                    >{{ form.enfermedad.tipo_transmision?.nombre }} <br />
                    <p
                        v-if="form.enfermedad.tipo_transmision.descripcion"
                        v-text="form.enfermedad.tipo_transmision?.descripcion"
                    ></p>
                </div>
                <div class="col-12 mt-2 border-top pt-2">
                    <h5>Medidas de Contingencia</h5>
                </div>
                <div
                    class="col-12 mt-1"
                    v-if="form.enfermedad.enfermedad_contingencia"
                >
                    <div
                        class="ql-editor"
                        v-html="
                            form.enfermedad.enfermedad_contingencia.descripcion
                        "
                    ></div>
                </div>
                <div class="col-12" v-else>
                    <h5 class="text-muted text-md">
                        No se agregó ninguna medida de contingencia
                    </h5>
                </div>
            </div>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-light"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
        </template>
    </MiModal>
</template>
