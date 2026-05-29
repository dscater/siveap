import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useSeguimientos = () => {
    const obtenerFechaActual = () => {
        const fecha = new Date();
        const anio = fecha.getFullYear();
        const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
        const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
        return `${anio}-${mes}-${dia}`;
    };

    const initialState = {
        id: 0,
        caso_epidemiologico_id: "",
        caso_epidemiologico: "",
        fecha: obtenerFechaActual(),
        gravedad: "",
        estado: "",
        observaciones: "",
        user_id: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setSeguimiento = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarSeguimiento = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setSeguimiento,
        limpiarSeguimiento,
    };
};
