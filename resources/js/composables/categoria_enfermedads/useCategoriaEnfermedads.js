import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useCategoriaEnfermedads = () => {
    const initialState = {
        id: 0,
        nombre: "",
        latitud: -16.125102,
        longitud: -67.196268,
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setCategoriaEnfermedad = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarCategoriaEnfermedad = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setCategoriaEnfermedad,
        limpiarCategoriaEnfermedad,
    };
};
