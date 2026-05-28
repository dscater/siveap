<script setup>
import Highcharts from "highcharts";

import { onMounted, ref, watch } from "vue";

const props = defineProps({
    historico: {
        type: Array,
        default: () => [],
    },

    predicciones: {
        type: Array,
        default: () => [],
    },

    enfermedad: {
        type: String,
        default: "",
    },
});

const chartContainer = ref(null);

const renderChart = () => {
    // FECHAS
    const categorias = [
        ...props.historico.map((x) => x.fecha),

        ...props.predicciones.map((x) => x.fecha),
    ];

    // HISTORICO
    const historicoData = props.historico.map((x) => x.confirmados);

    // PREDICCION
    const prediccionData = [
        ...new Array(props.historico.length).fill(null),

        ...props.predicciones.map((x) => x.casos_estimados),
    ];

    Highcharts.chart(
        chartContainer.value,

        {
            title: {
                text: "Predicción Epidemiológica",
            },

            subtitle: {
                text: props.enfermedad,
            },

            xAxis: {
                categories: categorias,
            },

            yAxis: {
                title: {
                    text: "Cantidad de Casos",
                },
            },

            tooltip: {
                shared: true,
            },

            series: [
                {
                    type: "line",

                    name: "Histórico",

                    data: historicoData,
                },

                {
                    type: "line",

                    name: "Predicción",

                    data: prediccionData,

                    dashStyle: "Dash",
                },
            ],
        },
    );
};

onMounted(() => {
    renderChart();
});

watch(
    () => props.predicciones,
    () => {
        renderChart();
    },
);
</script>

<template>
    <div ref="chartContainer"></div>
</template>
