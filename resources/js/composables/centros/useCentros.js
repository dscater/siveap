import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useCentros = () => {
    const initialState = {
        id: 0,
        nombre: "",
        direccion: "",
        latitud: -16.125102,
        longitud: -67.196268,
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setCentro = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarCentro = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setCentro,
        limpiarCentro,
    };
};
