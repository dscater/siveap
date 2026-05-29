<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
import MapMarker from "@/Components/MapMarker.vue";
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

const tituloDialog = computed(() => {
    return `<i class="fa fa-user"></i> Datos del Paciente`;
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
            <div class="row">
                <div class="col-6">
                    <strong>Nombre(s) y Apellidos: </strong>{{ form.full_name }}
                </div>
                <div class="col-6">
                    <strong>C.I.: </strong>{{ form.full_ci }}
                </div>
                <div class="col-6">
                    <strong>Fecha Nacimiento: </strong>{{ form.fecha_nac_t }}
                </div>
                <div class="col-6">
                    <strong>Edad: </strong>{{ form.edad }} años
                </div>
                <div class="col-6"><strong>Sexo: </strong>{{ form.sexo }}</div>
                <div class="col-6">
                    <strong>Comunidad: </strong>{{ form.comunidad.nombre }}
                </div>
                <div class="col-6">
                    <strong>Dirección: </strong>{{ form.dir }}
                </div>
                <div class="col-12">
                    <MapMarker
                        v-model:latitud="form.latitud"
                        v-model:longitud="form.longitud"
                        :readonly="true"
                        :zoom="16"
                    ></MapMarker>
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
