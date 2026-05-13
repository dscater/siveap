<script setup>
import { onMounted, onUnmounted, ref, nextTick, reactive } from "vue";
import { router, usePage, Link } from "@inertiajs/vue3";
import ItemMenu from "@/Components/ItemMenu.vue";
import { useSideBar } from "@/composables/useSidebar.js";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useConfiguracionStore } from "@/stores/configuracion/configuracionStore";
const { closeSidebar, toggleSubMenuELem } = useSideBar();
const { auth } = usePage().props;
const configuracionStore = useConfiguracionStore();
const appStore = useAppStore();
const usuario = ref(null);
const permisos = ref([]);
const route_current = ref("");

const toggleSubMenu = (menu) => {
    openMenus[menu] = !openMenus[menu];
};

const sincronizarMenus = () => {
    Object.keys(openMenus).forEach((key) => {
        openMenus[key] = false;
    });

    if (
        route_current.value == "usuarios.index" ||
        route_current.value == "roles.index"
    ) {
        openMenus.usuarios = true;
    }
};

const openMenus = reactive({
    usuarios: false,
    ventas: false,
    inventario: false,
});

router.on("navigate", (event) => {
    route_current.value = route().current();
    sincronizarMenus();
    closeSidebar();
});

onMounted(() => {
    usuario.value = appStore.getUsuario;
    permisos.value = auth.user.permisos;
    route_current.value = route().current();
    sincronizarMenus();
});

const salir = () => {
    Swal.fire({
        icon: "question",
        title: "Cerrar sesión",
        html: `¿Esta seguro(a) de cerrar sesión?`,
        showCancelButton: true,
        confirmButtonText: "Si, salir",
        cancelButtonText: "Cancelar",
        denyButtonText: `Cancelar`,
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            axios
                .post(route("logout"))
                .then((response) => {})
                .finally(() => {
                    window.location.href = "/";
                });
        }
    });
};

onUnmounted(() => {});
</script>
<template>
    <!-- Main Sidebar Container -->
    <aside class="app-sidebar shadow elevation-1 bg-white">
        <!-- Brand Logo -->
        <div class="sidebar-brand">
            <a
                :href="route('inicio')"
                class="brand-link d-flex justify-content-center align-items-center py-0"
            >
                <img
                    :src="configuracionStore.oConfiguracion.url_logo"
                    alt="Logo"
                    class="brand-image opacity-75 shadow"
                />
                <span class="brand-text font-weight-600 ml-1">{{
                    configuracionStore.oConfiguracion.nombre_sistema
                }}</span>
            </a>
        </div>

        <!-- Sidebar -->
        <div class="sidebar-wrapper">
            <!-- Sidebar user panel (optional) -->
            <div class="user-panel mt-3 pb-2 d-flex border-bottom">
                <div class="image">
                    <img
                        :src="usuario?.url_foto"
                        class="rounded-circle elevation-2 user-image"
                        alt="User Image"
                    />
                </div>
                <div class="info">
                    <Link
                        :href="route('profile.edit')"
                        class="d-block text-decoration-none"
                    >
                        <div class="nombre">
                            {{ usuario?.nombre }} {{ usuario?.paterno }}
                            {{ usuario?.materno }}
                        </div>
                        <div class="tipo">{{ usuario?.tipo }}</div>
                    </Link>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul
                    class="nav sidebar-menu flex-column"
                    data-lte-toggle="treeview"
                    role="navigation"
                    aria-label="Main navigation"
                    data-accordion="false"
                    id="navigation"
                >
                    <ItemMenu
                        :label="'Inicio'"
                        :ruta="'inicio'"
                        :icon="'fa fa-home'"
                    ></ItemMenu>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('usuarios.index') ||
                            permisos.includes('clientes.index') ||
                            permisos.includes('sucursals.index') ||
                            permisos.includes('tipo_certificados.index') ||
                            permisos.includes('certificados.index')
                        "
                    >
                        ADMINISTRACIÓN
                    </li>
                    <!-- <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('clientes.index')
                        "
                        :label="'Clientes'"
                        :ruta="'clientes.index'"
                        :icon="'fa fa-user-friends'"
                    ></ItemMenu> -->
                    <li
                        class="nav-item"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('usuarios.index') ||
                            permisos.includes('roles.index')
                        "
                        :class="{ 'menu-open': openMenus.usuarios }"
                    >
                        <a
                            href="#"
                            class="nav-link"
                            :class="[
                                route_current == 'usuarios.index' ||
                                route_current == 'roles.index'
                                    ? 'active menu-is-opening menu-open'
                                    : '',
                            ]"
                            @click.prevent="toggleSubMenu('usuarios')"
                        >
                            <i class="nav-icon fa fa-users"></i>
                            <p>
                                Usuarios
                                <i class="nav-arrow fa fa-chevron-right"></i>
                            </p>
                        </a>
                        <ul
                            class="nav nav-treeview"
                            role="navigation"
                            aria-label="Navigation 4"
                            :style="{
                                maxHeight: openMenus.usuarios ? '500px' : '0',
                                overflow: 'hidden',
                                transition: 'max-height 0.3s ease',
                            }"
                        >
                            <ItemMenu
                                v-if="
                                    permisos == '*' ||
                                    permisos.includes('usuarios.index')
                                "
                                :label="'Usuarios'"
                                :ruta="'usuarios.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                            <ItemMenu
                                v-if="
                                    permisos == '*' ||
                                    permisos.includes('roles.index')
                                "
                                :label="'Roles y Permisos'"
                                :ruta="'roles.index'"
                                :icon="'fa fa-angle-right'"
                            ></ItemMenu>
                        </ul>
                    </li>
                    <li
                        class="nav-header font-weight-bold"
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.clientes') ||
                            permisos.includes('reportes.certificados') ||
                            permisos.includes(
                                'reportes.certificados_interno',
                            ) ||
                            permisos.includes('reportes.historial_accions') ||
                            permisos.includes('reportes.gcemitidos') ||
                            permisos.includes('reportes.gmemitidos')
                        "
                    >
                        REPORTES
                    </li>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('reportes.usuarios')
                        "
                        :label="'Lista de Usuarios'"
                        :ruta="'reportes.usuarios'"
                        :icon="'fa fa-file-pdf'"
                    ></ItemMenu>
                    <li class="nav-header font-weight-bold">OTROS</li>
                    <ItemMenu
                        v-if="
                            permisos == '*' ||
                            permisos.includes('configuracions.index')
                        "
                        :label="'Configuración Sistema'"
                        :ruta="'configuracions.index'"
                        :icon="'fa fa-cog'"
                    ></ItemMenu>
                    <!-- <ItemMenu
                        :label="'Perfil'"
                        :ruta="'profile.edit'"
                        :icon="'fa fa-id-card'"
                    ></ItemMenu> -->
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link"
                            @click.prevent="salir()"
                            ref="link"
                        >
                            <i class="nav-icon fa fa-power-off"></i>
                            <p>Salir</p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>
<style scoped></style>
