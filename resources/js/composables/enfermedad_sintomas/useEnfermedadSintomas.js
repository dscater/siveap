import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useEnfermedadSintomas = () => {
    const initialState = {
        id: 0,
        enfermedad_id: "",
        nombre: "",
        tipo: "",
        input: 0,
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setEnfermedadSintoma = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarEnfermedadSintoma = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setEnfermedadSintoma,
        limpiarEnfermedadSintoma,
    };
};
