import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useAlertaEpidemiologicas = () => {
    const initialState = {
        id: 0,
        comunidad_id: "",
        enfermedad_id: "",
        nivel_alerta: "",
        indice: "",
        prediccion: "",
        crecimiento: "",
        confirmados: "",
        activos: "",
        graves: "",
        fallecidos: "",
        fecha: "",
        estado: "ACTIVO",
        fecha_fin: "",
        indice_fin: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setAlertaEpidemiologica = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarAlertaEpidemiologica = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setAlertaEpidemiologica,
        limpiarAlertaEpidemiologica,
    };
};
