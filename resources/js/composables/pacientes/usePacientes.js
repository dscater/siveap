import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const usePacientes = () => {
    const initialState = {
        id: 0,
        nombre: "",
        paterno: "",
        materno: "",
        ci: "",
        ci_exp: "",
        sexo: "",
        fecha_nac: "",
        dir: "",
        latitud: -16.125102,
        longitud: -67.196268,
        fono: "",
        comunidad_id: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setPaciente = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarPaciente = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setPaciente,
        limpiarPaciente,
    };
};
