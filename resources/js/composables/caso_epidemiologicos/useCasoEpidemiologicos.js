import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useCasoEpidemiologicos = () => {
    const obtenerFechaActual = () => {
        const fecha = new Date();
        const anio = fecha.getFullYear();
        const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
        const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
        return `${anio}-${mes}-${dia}`;
    };

    const initialState = {
        id: 0,
        codigo: "",
        paciente_id: "",
        enfermedad_id: "",
        centro_id: "",
        comunidad_id: "",
        user_id: "",
        fi_sintomas: "",
        fecha_diagnostico: obtenerFechaActual(),
        tipo_caso: "",
        gravedad: "",
        estado: "",
        contacto: 0,
        hospitalizacion: 0,
        fecha_registro: "",
        observaciones: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setCasoEpidemiologico = (item = null, ver = false) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarCasoEpidemiologico = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setCasoEpidemiologico,
        limpiarCasoEpidemiologico,
    };
};
