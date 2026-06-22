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
        departamento: "",
        municipio: "",
        centro_id: "",
        comunidad_id: "",
        red_salud: "",
        tipo: "",
        captado: "",
        captado_desc: "",
        user_id: "",
        pais_lpi: "",
        departamento_lpi: "",
        municipio_lpi: "",
        comunidad_id_lpi: "",
        zona_lpi: "",
        pais_lis: "",
        departamento_lis: "",
        municipio_lis: "",
        comunidad_id_lis: "",
        zona_lis: "",
        embarazada: "",
        fuma: "",
        fecha_parto: "",
        fi_sintomas: "",
        fecha_diagnostico: obtenerFechaActual(),
        semana: "",
        tipo_caso: "",
        gravedad: "",
        estado: "",
        fecha_falle: "",
        contacto: "",
        hospitalizacion: 0,
        tipo_alta: "",
        fecha_hospitalizacion: "",
        establecimiento: "",
        hospitalizacion_uti: 0,
        fecha_hospitalizacion_uti: "",
        establecimiento_uti: "",
        laboratorio: 0,
        nexo: 0,
        muestra: 0,
        fecha_muestra: "",
        tipo_muestra: "",
        rt_pcr: "",
        igm: "",
        igm_nc: "",
        igg: "",
        igg_nc: "",
        observacion_lab: "",
        fecha_registro: "",
        observaciones: "",
        caso_sintomas: [],
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
