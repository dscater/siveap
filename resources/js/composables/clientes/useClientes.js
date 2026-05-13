import { useForm } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";

export const useClientes = () => {
    const initialState = {
        id: 0,
        nombre: "",
        paterno: "",
        materno: "",
        ci: "",
        ci_exp: "",
        complemento: "",
        fecha_nac: "",
        edad: "",
        cel: "",
        respuesta: "clientes",

        // PAGOS
        con_certificado: true,
        tipo_pago: "EFECTIVO",
        tipo: "NORMAL",
        tramitador_id: "",
        certificado_detalles: [],
        total: "",
        cancelado: "",
        saldo: "",
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setCliente = (item = null) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";
    };

    const limpiarCliente = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    onMounted(() => {});

    return {
        form,
        setCliente,
        limpiarCliente,
    };
};
