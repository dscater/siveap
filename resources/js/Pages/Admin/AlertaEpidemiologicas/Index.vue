<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
const { props: props_page } = usePage();
const appStore = useAppStore();

onBeforeMount(() => {
    appStore.startLoading();
});

const mapa = ref(null);
const cargarMapa = () => {
    const map = L.map(mapa.value).setView([-16.5, -68.15], 10);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenStreetMap",
    }).addTo(map);
};

onMounted(async () => {
    cargarMapa();
    appStore.stopLoading();
});
</script>
<template>
    <Head title="Alerta Epidemiologicas"></Head>

    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h3 class="m-0">
                        <i class="fa fa-users"></i> Alerta Epidemiologicas
                    </h3>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-end">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Alerta Epidemiologicas
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>

        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-4">
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'usuarios.create',
                                )
                            "
                            type="button"
                            class="btn btn-primary text-sm"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo Usuario
                        </button>
                    </div>
                    <div class="col-md-8 my-1"></div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div ref="mapa" style="height: 400px"></div>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
