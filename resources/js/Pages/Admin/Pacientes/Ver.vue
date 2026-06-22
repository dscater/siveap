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
const enviando = ref(false);
const form = props.form;

const tituloDialog = computed(() => {
    return form.id == 0
        ? `<i class="fa fa-plus"></i> Nueva Comunidad`
        : `<i class="fa fa-edit"></i> Editar Comunidad`;
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
                <div class="col-6 mt-2">
                    <p>
                        <strong>Nombre Completo: </strong>{{ form.full_name }}
                    </p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>C.I.: </strong>{{ form.full_ci }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Sexo: </strong>{{ form.sexo }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p>
                        <strong>Fecha de Nacimiento: </strong
                        >{{ form.fecha_nac_t }}
                    </p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Edad: </strong>{{ form.edad }} años</p>
                </div>
                <div class="col-6 mt-2">
                    <p>
                        <strong>Apoderado o Padre(s): </strong
                        >{{ form.apoderado ?? "" }}
                    </p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Teléfono/Celuar: </strong>{{ form.fono }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Ocupación: </strong>{{ form.ocupación }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p>
                        <strong>Departamento: </strong>{{ form.departamento }}
                    </p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Municipio: </strong>{{ form.municipio }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p>
                        <strong>Comunidad: </strong>{{ form.comunidad.nombre }}
                    </p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Barrio/Zona/U.V.: </strong>{{ form.zona }}</p>
                </div>
                <div class="col-6 mt-2">
                    <p><strong>Dirección: </strong>{{ form.dir }}</p>
                </div>
                <div class="col-12 mt-2">
                    <MapMarker
                        :latitud="Number(form.latitud)"
                        :longitud="Number(form.longitud)"
                        :zoom="16"
                        :readonly="true"
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
