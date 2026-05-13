export const useVerificaCertificados = () => {
    const verificarPendiente = async (cliente_id) => {
        const response = await axios.get(
            route("certificados.verificaPendienteCliente", cliente_id),
        );

        return response.data.existe ? response.data.certificado : null;
    };

    return { verificarPendiente };
};
