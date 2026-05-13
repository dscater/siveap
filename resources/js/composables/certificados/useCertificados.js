import { useForm } from "@inertiajs/vue3";

export const useCertificados = () => {
    const initialState = {
        id: 0,
        cliente_id: "",
        cliente: "",
        total: "",
        cancelado: 0,
        saldo: 0,
        tipo_pago: "EFECTIVO",
        tipo: "NORMAL",
        tramitador_id: "",
        tramitador: null,
        user_id: "",
        sucursal_id: "",
        fecha_inicio: "",
        hora_inicio: "",
        fecha_fin: "",
        hora_fin: "",
        estado: "",
        certificado_detalles: [],
        eliminados: [],
        _method: "POST",
    };

    const form = useForm({ ...initialState });

    const setCertificado = (item) => {
        form.clearErrors();
        form.reset();
        Object.assign(form, item);
        form._method = "PUT";

        if (!form.certificado_detalles?.length) {
            form.certificado_detalles = [{}];
        }
    };

    const limpiarCertificado = () => {
        form.clearErrors();
        form.reset();
        form.defaults({ ...initialState });
    };

    return {
        form,
        setCertificado,
        limpiarCertificado,
    };
};
