import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useReglasAlertas = () => {
    const initialState = {
        id: 0,
        enfermedad_id: "",
        umbral: 1,
        riesgo: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setReglasAlerta = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarReglasAlerta = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setReglasAlerta,
        limpiarReglasAlerta,
    };
};
