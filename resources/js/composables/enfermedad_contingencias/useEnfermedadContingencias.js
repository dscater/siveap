import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useEnfermedadContingencias = () => {
    const initialState = {
        id: 0,
        enfermedad_id: "",
        descripcion: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setEnfermedadContingencia = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarEnfermedadContingencia = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setEnfermedadContingencia,
        limpiarEnfermedadContingencia,
    };
};
