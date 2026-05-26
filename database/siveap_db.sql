-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 26-05-2026 a las 22:41:51
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `siveap_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta_epidemiologicas`
--

CREATE TABLE `alerta_epidemiologicas` (
  `id` bigint UNSIGNED NOT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `nivel_alerta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indice` double(8,2) NOT NULL,
  `prediccion` double(8,2) NOT NULL,
  `crecimiento` double(8,2) NOT NULL,
  `confirmados` int NOT NULL,
  `activos` int NOT NULL,
  `graves` int NOT NULL,
  `fallecidos` int NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alerta_epidemiologicas`
--

INSERT INTO `alerta_epidemiologicas` (`id`, `comunidad_id`, `enfermedad_id`, `nivel_alerta`, `indice`, `prediccion`, `crecimiento`, `confirmados`, `activos`, `graves`, `fallecidos`, `fecha`, `estado`, `fecha_fin`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'CRITICO', 46.00, 10.00, 3.00, 10, 8, 3, 1, '2026-05-26', 'ACTIVO', NULL, '2026-05-26 22:40:59', '2026-05-26 22:41:25'),
(2, 1, 4, 'CRITICO', 46.00, 10.00, 3.00, 10, 8, 3, 1, '2026-05-26', 'ACTIVO', NULL, '2026-05-26 22:40:59', '2026-05-26 22:41:25'),
(3, 1, 6, 'CRITICO', 46.00, 10.00, 3.00, 10, 8, 3, 1, '2026-05-26', 'ACTIVO', NULL, '2026-05-26 22:40:59', '2026-05-26 22:41:25'),
(4, 2, 6, 'CRITICO', 46.00, 10.00, 3.00, 10, 8, 3, 1, '2026-05-26', 'ACTIVO', NULL, '2026-05-26 22:40:59', '2026-05-26 22:41:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caso_epidemiologicos`
--

CREATE TABLE `caso_epidemiologicos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `centro_id` bigint UNSIGNED NOT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fi_sintomas` date NOT NULL,
  `fecha_diagnostico` date NOT NULL,
  `tipo_caso` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gravedad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contacto` int NOT NULL,
  `hospitalizacion` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caso_epidemiologicos`
--

INSERT INTO `caso_epidemiologicos` (`id`, `codigo`, `paciente_id`, `enfermedad_id`, `centro_id`, `comunidad_id`, `user_id`, `fi_sintomas`, `fecha_diagnostico`, `tipo_caso`, `gravedad`, `estado`, `contacto`, `hospitalizacion`, `fecha_registro`, `observaciones`, `created_at`, `updated_at`) VALUES
(1, 'CE-2026-00001', 1, 1, 1, 1, 1, '2026-05-01', '2026-05-25', 'PROBABLE', 'LEVE', 'EN SEGUIMIENTO', 5, 0, '2026-05-25', 'observaciones', '2026-05-25 16:12:07', '2026-05-26 21:53:16'),
(2, 'CE-2026-00002', 2, 4, 1, 1, 1, '2026-05-01', '2026-05-25', 'PROBABLE', 'MODERADO', 'ACTIVO', 10, 0, '2026-05-25', NULL, '2026-05-25 16:25:12', '2026-05-26 20:51:45'),
(3, 'CE-2026-00003', 3, 6, 2, 2, 1, '2026-05-01', '2026-05-26', 'CONFIRMADO', 'GRAVE', 'ACTIVO', 20, 0, '2026-05-26', NULL, '2026-05-26 21:52:20', '2026-05-26 21:52:20'),
(4, 'CE-2026-00004', 4, 6, 1, 1, 1, '2026-05-04', '2026-05-26', 'CONFIRMADO', 'CRITICO', 'FALLECIDO', 5, 0, '2026-05-26', NULL, '2026-05-26 21:54:39', '2026-05-26 21:54:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_enfermedads`
--

CREATE TABLE `categoria_enfermedads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria_enfermedads`
--

INSERT INTO `categoria_enfermedads` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'VIRAL', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(2, 'BACTERIANA', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(3, 'PARASITARIA', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(4, 'RESPIRATORIA', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(5, 'GASTROINTESTINAL', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(6, 'VECTORIAL', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(7, 'ZOONÓTICA', '2026-05-17 20:12:09', '2026-05-17 20:12:09'),
(8, 'DERMATOLÓGICA', '2026-05-17 20:12:09', '2026-05-17 20:12:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros`
--

CREATE TABLE `centros` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(900) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `centros`
--

INSERT INTO `centros` (`id`, `nombre`, `direccion`, `latitud`, `longitud`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'CENTRO 1', 'DIRECCION CENTRO #1', '-16.12535607198427', '-67.19860553741456', NULL, '2026-05-15 21:20:10', '2026-05-15 21:20:10'),
(2, 'CENTRO 2', '', '-16.12803580219172', '-67.19367027282716', NULL, '2026-05-15 21:20:25', '2026-05-15 21:20:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunidads`
--

CREATE TABLE `comunidads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comunidads`
--

INSERT INTO `comunidads` (`id`, `nombre`, `latitud`, `longitud`, `created_at`, `updated_at`) VALUES
(1, 'COMUNIDAD 1', '-16.128238712979083', '-67.19536542892457', '2026-05-14 21:01:40', '2026-05-14 21:02:15'),
(2, 'COMUNIDAD 2', '-16.121604388819243', '-67.19697475433351', '2026-05-14 21:02:36', '2026-05-14 21:02:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunidad_enfermedads`
--

CREATE TABLE `comunidad_enfermedads` (
  `id` bigint UNSIGNED NOT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `cantidad_casos` int NOT NULL,
  `nivel_riesgo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indice_riesgo` double NOT NULL,
  `fecha_evaluacion` date NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `dir`, `fono`, `actividad`, `correo`, `logo`, `logo2`, `created_at`, `updated_at`) VALUES
(1, 'SIVEAP', 'SIVEAP', 'SIVEAP S.A.', '11111111111', 'LOS PEDREGALES #223', '2323232 - 7776666', 'ACTIVIDAD EMPRESA', 'siveap@gmail.com', 'logo11778684319.jpeg', 'logo211778684319.jpeg', '2026-05-13 14:34:05', '2026-05-13 14:58:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedads`
--

CREATE TABLE `enfermedads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria_enfermedad_id` bigint UNSIGNED NOT NULL,
  `tipo_transmision_id` bigint UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `enfermedads`
--

INSERT INTO `enfermedads` (`id`, `nombre`, `categoria_enfermedad_id`, `tipo_transmision_id`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'DENGUE', 6, 5, 'ENFERMEDAD VIRAL TRANSMITIDA POR MOSQUITOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(2, 'MALARIA', 3, 5, 'ENFERMEDAD PARASITARIA TRANSMITIDA POR MOSQUITOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(3, 'CHIKUNGUNYA', 1, 5, 'ENFERMEDAD VIRAL TRANSMITIDA POR MOSQUITOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(4, 'ZIKA', 1, 5, 'VIRUS TRANSMITIDO PRINCIPALMENTE POR MOSQUITOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(5, 'COVI-19', 1, 1, 'ENFERMEDAD RESPIRATORIA CAUSADA POR CORONAVIRUS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(6, 'INFLUENZA', 4, 1, 'INFECCIÓN RESPIRATORIA VIRAL.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(7, 'TUBERCULOSIS', 2, 1, 'ENFERMEDAD BACTERIANA RESPIRATORIA.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(8, 'NEUMONÍA', 4, 1, 'INFECCIÓN QUE INFLAMA LOS PULMONES.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(9, 'DIARRE AGUDA', 5, 3, 'TRASTORNO GASTROINTESTINAL GENERALMENTE INFECCIOSO.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(10, 'CÓLERA', 2, 3, 'ENFERMEDAD BACTERIANA TRANSMITIDA POR AGUA CONTAMINADA.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(11, 'HEPATITI A', 1, 9, 'INFECCIÓN HEPÁTICA VIRAL.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(12, 'PARASITOSI INTESTINAL', 3, 9, 'INFECCIÓN INTESTINAL CAUSADA POR PARÁSITOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(13, 'LEPTOSPIROSIS', 2, 3, 'ENFERMEDAD BACTERIANA ASOCIADA A AGUA CONTAMINADA.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(14, 'RABIA', 7, 8, 'ENFERMEDAD VIRAL TRANSMITIDA POR ANIMALES.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(15, 'SARAMPIÓN', 1, 1, 'ENFERMEDAD VIRAL ALTAMENTE CONTAGIOSA.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(16, 'VARICELA', 1, 2, 'INFECCIÓN VIRAL CONTAGIOSA.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(17, 'ESCABIOSIS', 8, 2, 'ENFERMEDAD DE LA PIEL CAUSADA POR ÁCAROS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17'),
(18, 'SALMONELOSIS', 2, 4, 'INFECCIÓN BACTERIANA TRANSMITIDA POR ALIMENTOS.', '2026-05-17 20:19:17', '2026-05-17 20:19:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ROLE', '{\"id\": 2, \"nombre\": \"ADMINISTADOR\", \"created_at\": \"2026-05-13T21:35:22.000000Z\", \"updated_at\": \"2026-05-13T21:35:22.000000Z\"}', NULL, 'ROLES', '2026-05-13', '17:35:22', '2026-05-13 21:35:22', '2026-05-13 21:35:22'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"COMUNIDAD 1\", \"latitud\": \"-16.125294231628633\", \"longitud\": \"-67.19658851623537\", \"created_at\": \"2026-05-14T21:01:40.000000Z\", \"updated_at\": \"2026-05-14T21:01:40.000000Z\"}', NULL, 'COMUNIDADES', '2026-05-14', '17:01:40', '2026-05-14 21:01:40', '2026-05-14 21:01:40'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"COMUNIDAD 1\", \"latitud\": \"-16.125294231628633\", \"longitud\": \"-67.19658851623537\", \"created_at\": \"2026-05-14T21:01:40.000000Z\", \"updated_at\": \"2026-05-14T21:01:40.000000Z\"}', '{\"id\": 1, \"nombre\": \"COMUNIDAD 1\", \"latitud\": \"-16.128238712979083\", \"longitud\": \"-67.19536542892457\", \"created_at\": \"2026-05-14T21:01:40.000000Z\", \"updated_at\": \"2026-05-14T21:02:15.000000Z\"}', 'COMUNIDADES', '2026-05-14', '17:02:15', '2026-05-14 21:02:15', '2026-05-14 21:02:15'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"COMUNIDAD 2\", \"latitud\": \"-16.121604388819243\", \"longitud\": \"-67.19697475433351\", \"created_at\": \"2026-05-14T21:02:36.000000Z\", \"updated_at\": \"2026-05-14T21:02:36.000000Z\"}', NULL, 'COMUNIDADES', '2026-05-14', '17:02:36', '2026-05-14 21:02:36', '2026-05-14 21:02:36'),
(5, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"CATEGORÍA 1\", \"created_at\": \"2026-05-14T21:56:46.000000Z\", \"updated_at\": \"2026-05-14T21:56:46.000000Z\"}', NULL, 'CATEGORÍA DE ENFERMEDAD', '2026-05-14', '17:56:46', '2026-05-14 21:56:46', '2026-05-14 21:56:46'),
(6, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"CATEGORIA 2\", \"created_at\": \"2026-05-14T21:57:44.000000Z\", \"updated_at\": \"2026-05-14T21:57:44.000000Z\"}', NULL, 'CATEGORÍA DE ENFERMEDAD', '2026-05-14', '17:57:44', '2026-05-14 21:57:44', '2026-05-14 21:57:44'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"CATEGORIA 2\", \"created_at\": \"2026-05-14T21:57:44.000000Z\", \"updated_at\": \"2026-05-14T21:57:44.000000Z\"}', '{\"id\": 2, \"nombre\": \"CATEGORIA 2 ASD\", \"created_at\": \"2026-05-14T21:57:44.000000Z\", \"updated_at\": \"2026-05-14T21:57:48.000000Z\"}', 'CATEGORÍA DE ENFERMEDAD', '2026-05-14', '17:57:48', '2026-05-14 21:57:48', '2026-05-14 21:57:48'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"CATEGORIA 2 ASD\", \"created_at\": \"2026-05-14T21:57:44.000000Z\", \"updated_at\": \"2026-05-14T21:57:48.000000Z\"}', '{\"id\": 2, \"nombre\": \"CATEGORIA 2\", \"created_at\": \"2026-05-14T21:57:44.000000Z\", \"updated_at\": \"2026-05-14T21:57:50.000000Z\"}', 'CATEGORÍA DE ENFERMEDAD', '2026-05-14', '17:57:50', '2026-05-14 21:57:50', '2026-05-14 21:57:50'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"TIPO TRANSMISION 1\", \"created_at\": \"2026-05-14T21:59:16.000000Z\", \"updated_at\": \"2026-05-14T21:59:16.000000Z\"}', NULL, 'TIPO DE TRANSMISIÓN', '2026-05-14', '17:59:16', '2026-05-14 21:59:16', '2026-05-14 21:59:16'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"TIPO TRANSMISION 2\", \"created_at\": \"2026-05-14T21:59:23.000000Z\", \"updated_at\": \"2026-05-14T21:59:23.000000Z\"}', NULL, 'TIPO DE TRANSMISIÓN', '2026-05-14', '17:59:23', '2026-05-14 21:59:23', '2026-05-14 21:59:23'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"TIPO TRANSMISION 2\", \"created_at\": \"2026-05-14T21:59:23.000000Z\", \"updated_at\": \"2026-05-14T21:59:23.000000Z\"}', '{\"id\": 2, \"nombre\": \"TIPO TRANSMISION 2 ASD\", \"created_at\": \"2026-05-14T21:59:23.000000Z\", \"updated_at\": \"2026-05-14T21:59:41.000000Z\"}', 'TIPO DE TRANSMISIÓN', '2026-05-14', '17:59:41', '2026-05-14 21:59:41', '2026-05-14 21:59:41'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"TIPO TRANSMISION 2 ASD\", \"created_at\": \"2026-05-14T21:59:23.000000Z\", \"updated_at\": \"2026-05-14T21:59:41.000000Z\"}', '{\"id\": 2, \"nombre\": \"TIPO TRANSMISION 2\", \"created_at\": \"2026-05-14T21:59:23.000000Z\", \"updated_at\": \"2026-05-14T21:59:47.000000Z\"}', 'TIPO DE TRANSMISIÓN', '2026-05-14', '17:59:47', '2026-05-14 21:59:47', '2026-05-14 21:59:47'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"CENTRO 1\", \"latitud\": \"-16.12535607198427\", \"longitud\": \"-67.19860553741456\", \"direccion\": \"DIRECCION CENTRO #1\", \"created_at\": \"2026-05-15T21:20:10.000000Z\", \"updated_at\": \"2026-05-15T21:20:10.000000Z\"}', NULL, 'CENTROS', '2026-05-15', '17:20:10', '2026-05-15 21:20:10', '2026-05-15 21:20:10'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 2, \"nombre\": \"CENTRO 2\", \"latitud\": \"-16.12803580219172\", \"longitud\": \"-67.19367027282716\", \"direccion\": \"\", \"created_at\": \"2026-05-15T21:20:25.000000Z\", \"updated_at\": \"2026-05-15T21:20:25.000000Z\"}', NULL, 'CENTROS', '2026-05-15', '17:20:25', '2026-05-15 21:20:25', '2026-05-15 21:20:25'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ROLE', '{\"id\": 3, \"nombre\": \"MÉDICO\", \"created_at\": \"2026-05-15T21:24:43.000000Z\", \"updated_at\": \"2026-05-15T21:24:43.000000Z\"}', NULL, 'ROLES', '2026-05-15', '17:24:43', '2026-05-15 21:24:43', '2026-05-15 21:24:43'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ROLE', '{\"id\": 4, \"nombre\": \"SECRETARIA\", \"created_at\": \"2026-05-15T21:24:49.000000Z\", \"updated_at\": \"2026-05-15T21:24:49.000000Z\"}', NULL, 'ROLES', '2026-05-15', '17:24:49', '2026-05-15 21:24:49', '2026-05-15 21:24:49'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"123456\", \"id\": 2, \"dir\": \"ZONA LOS PEDREGALES #22\", \"fono\": \"78787878\", \"foto\": \"21778880973.jpg\", \"tipo\": \"ADMINISTRACIÓN\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"materno\": \"MAMANI\", \"paterno\": \"PERES\", \"role_id\": \"2\", \"usuario\": \"JPERES\", \"centro_id\": null, \"created_at\": \"2026-05-15T21:36:13.000000Z\", \"updated_at\": \"2026-05-15T21:36:13.000000Z\", \"fecha_registro\": \"2026-05-15\"}', NULL, 'USUARIOS', '2026-05-15', '17:36:13', '2026-05-15 21:36:13', '2026-05-15 21:36:13'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"56765756\", \"id\": 3, \"dir\": \"\", \"fono\": \"67676767\", \"tipo\": \"CENTRO MÉDICO\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIO\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"role_id\": \"3\", \"usuario\": \"MGONZALES\", \"centro_id\": \"1\", \"created_at\": \"2026-05-15T21:39:19.000000Z\", \"updated_at\": \"2026-05-15T21:39:19.000000Z\", \"fecha_registro\": \"2026-05-15\"}', NULL, 'USUARIOS', '2026-05-15', '17:39:19', '2026-05-15 21:39:19', '2026-05-15 21:39:19'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"ASDASD\", \"created_at\": \"2026-05-17T20:14:20.000000Z\", \"updated_at\": \"2026-05-17T20:14:20.000000Z\", \"descripcion\": \"ASDASDAD\", \"tipo_transmision_id\": \"3\", \"categoria_enfermedad_id\": \"2\"}', NULL, 'ENFERMDADES', '2026-05-17', '16:14:20', '2026-05-17 20:14:20', '2026-05-17 20:14:20'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 1, \"nombre\": \"ASDASD\", \"created_at\": \"2026-05-17T20:14:20.000000Z\", \"updated_at\": \"2026-05-17T20:14:20.000000Z\", \"descripcion\": \"ASDASDAD\", \"tipo_transmision_id\": 3, \"categoria_enfermedad_id\": 2}', '{\"id\": 1, \"nombre\": \"ASDASD\", \"created_at\": \"2026-05-17T20:14:20.000000Z\", \"updated_at\": \"2026-05-17T20:15:49.000000Z\", \"descripcion\": \"ASDASDADEE\", \"tipo_transmision_id\": \"3\", \"categoria_enfermedad_id\": \"2\"}', 'ENFERMDADES', '2026-05-17', '16:15:49', '2026-05-17 20:15:49', '2026-05-17 20:15:49'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SUCURSAL', '{\"id\": 9, \"nombre\": \"FECHAL-ORAL\", \"created_at\": \"2026-05-17T20:19:10.000000Z\", \"updated_at\": \"2026-05-17T20:19:10.000000Z\"}', '{\"id\": 9, \"nombre\": \"FECAL-ORAL\", \"created_at\": \"2026-05-17T20:19:10.000000Z\", \"updated_at\": \"2026-05-17T20:20:55.000000Z\"}', 'TIPO DE TRANSMISIÓN', '2026-05-17', '16:20:55', '2026-05-17 20:20:55', '2026-05-17 20:20:55'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA REGLA DE ALERTA', '{\"id\": 1, \"riesgo\": \"MEDIO\", \"umbral\": \"6\", \"created_at\": \"2026-05-22T19:26:08.000000Z\", \"updated_at\": \"2026-05-22T19:26:08.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'REGLAS DE ALERTA', '2026-05-22', '15:26:08', '2026-05-22 19:26:08', '2026-05-22 19:26:08'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA REGLA DE ALERTA', '{\"id\": 2, \"riesgo\": \"MEDIO\", \"umbral\": \"6\", \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-22T19:26:35.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'REGLAS DE ALERTA', '2026-05-22', '15:26:35', '2026-05-22 19:26:35', '2026-05-22 19:26:35'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 2, \"riesgo\": \"MEDIO\", \"status\": 1, \"umbral\": 6, \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-22T19:26:35.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 2, \"riesgo\": \"ALTO\", \"status\": 1, \"umbral\": \"12\", \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-22T19:28:32.000000Z\", \"enfermedad_id\": \"1\"}', 'REGLAS DE ALERTA', '2026-05-22', '15:28:32', '2026-05-22 19:28:32', '2026-05-22 19:28:32'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"456546654\", \"id\": 1, \"dir\": \"ASUNTA #3223\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"latitud\": \"-16.123665761985627\", \"materno\": \"SOLIZ\", \"paterno\": \"MONRROY\", \"longitud\": \"-67.19748973381918\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-05-25T14:29:57.000000Z\", \"updated_at\": \"2026-05-25T14:29:57.000000Z\", \"comunidad_id\": \"1\"}', NULL, 'PACIENTES', '2026-05-25', '10:29:57', '2026-05-25 14:29:57', '2026-05-25 14:29:57'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"56565656\", \"id\": 2, \"dir\": \"ASUNTA #2323\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"LP\", \"nombre\": \"MARIA\", \"latitud\": \"-16.125283924900813\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"longitud\": \"-67.19494719477096\", \"fecha_nac\": \"2003-01-01\", \"created_at\": \"2026-05-25T14:44:57.000000Z\", \"updated_at\": \"2026-05-25T14:44:57.000000Z\", \"comunidad_id\": \"1\", \"fecha_registro\": \"2026-05-25\"}', NULL, 'PACIENTES', '2026-05-25', '10:44:57', '2026-05-25 14:44:57', '2026-05-25 14:44:57'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"SOSPECHOSO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-25T16:12:07.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"1\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"1\", \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-25', '12:12:07', '2026-05-25 16:12:07', '2026-05-25 16:12:07'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 2, \"codigo\": \"CE-2026-00002\", \"estado\": \"PROBABLE\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:25:12.000000Z\", \"updated_at\": \"2026-05-25T16:25:12.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"2\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"4\", \"observaciones\": null, \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-25', '12:25:12', '2026-05-25 16:25:12', '2026-05-25 16:25:12'),
(29, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 2, \"codigo\": \"CE-2026-00002\", \"estado\": \"PROBABLE\", \"user_id\": 1, \"contacto\": 10, \"gravedad\": \"MODERADO\", \"centro_id\": 1, \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:25:12.000000Z\", \"updated_at\": \"2026-05-25T16:25:12.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 2, \"comunidad_id\": 1, \"enfermedad_id\": 4, \"observaciones\": null, \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25\"}', '{\"id\": 2, \"codigo\": \"CE-2026-00002\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:25:12.000000Z\", \"updated_at\": \"2026-05-26T20:43:27.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"2\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"4\", \"observaciones\": null, \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-26', '16:43:27', '2026-05-26 20:43:27', '2026-05-26 20:43:27'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"SOSPECHOSO\", \"user_id\": 1, \"contacto\": 5, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-25T16:12:07.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 1, \"comunidad_id\": 1, \"enfermedad_id\": 1, \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25\"}', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-26T20:43:33.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"1\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"1\", \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-26', '16:43:33', '2026-05-26 20:43:33', '2026-05-26 20:43:33'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SEGUIMIENTO', '{\"id\": 1, \"fecha\": \"2026-05-26\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"created_at\": \"2026-05-26T20:47:57.000000Z\", \"updated_at\": \"2026-05-26T20:47:57.000000Z\", \"observaciones\": \"OBSERVACION 1\", \"caso_epidemiologico_id\": \"2\"}', NULL, 'SEGUIMIENTO', '2026-05-26', '16:47:57', '2026-05-26 20:47:57', '2026-05-26 20:47:57'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SEGUIMIENTO', '{\"id\": 2, \"fecha\": \"2026-05-26\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"created_at\": \"2026-05-26T20:48:40.000000Z\", \"updated_at\": \"2026-05-26T20:48:40.000000Z\", \"observaciones\": \"OBSERVACION 1\", \"caso_epidemiologico_id\": \"2\"}', NULL, 'SEGUIMIENTO', '2026-05-26', '16:48:40', '2026-05-26 20:48:40', '2026-05-26 20:48:40'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SEGUIMIENTO', '{\"id\": 2, \"fecha\": \"2026-05-26\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"created_at\": \"2026-05-26T20:48:40.000000Z\", \"updated_at\": \"2026-05-26T20:48:40.000000Z\", \"observaciones\": \"OBSERVACION 1\", \"caso_epidemiologico_id\": 2}', '{\"id\": 2, \"fecha\": \"2026-05-26\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"created_at\": \"2026-05-26T20:48:40.000000Z\", \"updated_at\": \"2026-05-26T20:51:45.000000Z\", \"observaciones\": \"OBSERVACION 2\", \"caso_epidemiologico_id\": \"2\"}', 'SEGUIMIENTO', '2026-05-26', '16:51:45', '2026-05-26 20:51:45', '2026-05-26 20:51:45'),
(34, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"345345\", \"id\": 3, \"dir\": \"ASUNTA #3232\", \"fono\": null, \"sexo\": \"MASCULINO\", \"ci_exp\": \"CB\", \"nombre\": \"MAX\", \"latitud\": \"-16.122441502163745\", \"materno\": \"\", \"paterno\": \"PONZE\", \"longitud\": \"-67.19580530036424\", \"fecha_nac\": \"2005-01-01\", \"created_at\": \"2026-05-26T21:51:52.000000Z\", \"updated_at\": \"2026-05-26T21:51:52.000000Z\", \"comunidad_id\": \"2\", \"fecha_registro\": \"2026-05-26\"}', NULL, 'PACIENTES', '2026-05-26', '17:51:52', '2026-05-26 21:51:52', '2026-05-26 21:51:52'),
(35, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 3, \"codigo\": \"CE-2026-00003\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": \"20\", \"gravedad\": \"GRAVE\", \"centro_id\": \"2\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:52:20.000000Z\", \"updated_at\": \"2026-05-26T21:52:20.000000Z\", \"fi_sintomas\": \"2026-05-01T04:00:00.000000Z\", \"paciente_id\": \"3\", \"comunidad_id\": \"2\", \"enfermedad_id\": \"6\", \"observaciones\": null, \"fecha_registro\": \"2026-05-26T04:00:00.000000Z\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-26T04:00:00.000000Z\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-26', '17:52:20', '2026-05-26 21:52:20', '2026-05-26 21:52:20'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 5, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-26T20:43:33.000000Z\", \"fi_sintomas\": \"2026-05-01T04:00:00.000000Z\", \"paciente_id\": 1, \"comunidad_id\": 1, \"enfermedad_id\": 1, \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25T04:00:00.000000Z\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25T04:00:00.000000Z\"}', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-26T21:53:16.000000Z\", \"fi_sintomas\": \"2026-05-01T08:00:00.000000Z\", \"paciente_id\": \"1\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"1\", \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25T04:00:00.000000Z\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25T08:00:00.000000Z\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-26', '17:53:16', '2026-05-26 21:53:16', '2026-05-26 21:53:16'),
(37, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"24234\", \"id\": 4, \"dir\": \"ASUNTA #$43345\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"LP\", \"nombre\": \"MARIA\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.196268\", \"fecha_nac\": \"1970-01-01\", \"created_at\": \"2026-05-26T21:54:08.000000Z\", \"updated_at\": \"2026-05-26T21:54:08.000000Z\", \"comunidad_id\": \"1\", \"fecha_registro\": \"2026-05-26\"}', NULL, 'PACIENTES', '2026-05-26', '17:54:08', '2026-05-26 21:54:08', '2026-05-26 21:54:08'),
(38, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 4, \"codigo\": \"CE-2026-00004\", \"estado\": \"FALLECIDO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"CRITICO\", \"centro_id\": \"1\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:54:39.000000Z\", \"updated_at\": \"2026-05-26T21:54:39.000000Z\", \"fi_sintomas\": \"2026-05-04T04:00:00.000000Z\", \"paciente_id\": \"4\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"6\", \"observaciones\": null, \"fecha_registro\": \"2026-05-26T04:00:00.000000Z\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-26T04:00:00.000000Z\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-26', '17:54:39', '2026-05-26 21:54:39', '2026-05-26 21:54:39'),
(39, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 2, \"riesgo\": \"ALTO\", \"status\": 1, \"umbral\": 12, \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-22T19:28:32.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 2, \"riesgo\": \"ALTO\", \"status\": 1, \"umbral\": \"12\", \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-26T22:09:27.000000Z\", \"enfermedad_id\": \"4\"}', 'REGLAS DE ALERTA', '2026-05-26', '18:09:27', '2026-05-26 22:09:27', '2026-05-26 22:09:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_02_1153316_create_centros_table', 1),
(2, '2024_01_31_165641_create_configuracions_table', 1),
(3, '2024_11_02_153309_create_roles_table', 1),
(4, '2024_11_02_153315_create_modulos_table', 1),
(5, '2024_11_02_153316_create_permisos_table', 1),
(6, '2024_11_02_153317_create_users_table', 1),
(7, '2024_11_02_153318_create_historial_accions_table', 1),
(8, '2026_05_14_101402_create_notificacions_table', 2),
(9, '2026_05_14_101406_create_notificacion_users_table', 2),
(10, '2026_05_14_101413_create_comunidads_table', 3),
(11, '2026_05_14_101422_create_pacientes_table', 4),
(12, '2026_05_14_101426_create_categoria_enfermedads_table', 4),
(13, '2026_05_14_101427_create_tipo_transmisions_table', 4),
(14, '2026_05_14_101429_create_enfermedads_table', 5),
(15, '2026_05_14_101500_create_caso_epidemiologicos_table', 5),
(16, '2026_05_14_101508_create_seguimientos_table', 5),
(17, '2026_05_14_101517_create_reglas_alertas_table', 5),
(18, '2026_05_14_101530_create_alerta_epidemiologicas_table', 5),
(19, '2026_05_14_161623_create_comunidad_enfermedads_table', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` bigint UNSIGNED NOT NULL,
  `modulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacions`
--

CREATE TABLE `notificacions` (
  `id` bigint UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacions`
--

INSERT INTO `notificacions` (`id`, `descripcion`, `modulo`, `registro_id`, `tipo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 'CRITICO: Se detectó incremento de casos de DENGUE', 'AlertaEpidemiologica', 1, 'ALERTA', '2026-05-26', '18:40:00', '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(2, 'CRITICO: Se detectó incremento de casos de ZIKA', 'AlertaEpidemiologica', 2, 'ALERTA', '2026-05-26', '18:40:00', '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(3, 'CRITICO: Se detectó incremento de casos de INFLUENZA', 'AlertaEpidemiologica', 3, 'ALERTA', '2026-05-26', '18:40:00', '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(4, 'CRITICO: Se detectó incremento de casos de INFLUENZA', 'AlertaEpidemiologica', 4, 'ALERTA', '2026-05-26', '18:40:00', '2026-05-26 22:40:59', '2026-05-26 22:40:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion_users`
--

CREATE TABLE `notificacion_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  `visto` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacion_users`
--

INSERT INTO `notificacion_users` (`id`, `user_id`, `notificacion_id`, `visto`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(2, 2, 1, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(3, 3, 1, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(4, 1, 2, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(5, 2, 2, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(6, 3, 2, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(7, 1, 3, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(8, 2, 3, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(9, 3, 3, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(10, 1, 4, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(11, 2, 4, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59'),
(12, 3, 4, 0, '2026-05-26 22:40:59', '2026-05-26 22:40:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nac` date NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitud` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `nombre`, `paterno`, `materno`, `sexo`, `ci`, `ci_exp`, `fecha_nac`, `dir`, `latitud`, `longitud`, `fono`, `comunidad_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'JUAN', 'MONRROY', 'SOLIZ', 'MASCULINO', '456546654', 'LP', '2000-01-01', 'ASUNTA #3223', '-16.123665761985627', '-67.19748973381918', '67676767', 1, '2026-05-25', '2026-05-25 14:29:57', '2026-05-25 14:29:57'),
(2, 'MARIA', 'GONZALES', '', 'FEMENINO', '56565656', 'LP', '2003-01-01', 'ASUNTA #2323', '-16.125283924900813', '-67.19494719477096', NULL, 1, '2026-05-25', '2026-05-25 14:44:57', '2026-05-25 14:44:57'),
(3, 'MAX', 'PONZE', '', 'MASCULINO', '345345', 'CB', '2005-01-01', 'ASUNTA #3232', '-16.122441502163745', '-67.19580530036424', NULL, 2, '2026-05-26', '2026-05-26 21:51:52', '2026-05-26 21:51:52'),
(4, 'MARIA', 'MARTINEZ', '', 'FEMENINO', '24234', 'LP', '1970-01-01', 'ASUNTA #$43345', '-16.125102', '-67.196268', NULL, 1, '2026-05-26', '2026-05-26 21:54:08', '2026-05-26 21:54:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `modulo_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reglas_alertas`
--

CREATE TABLE `reglas_alertas` (
  `id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `umbral` double NOT NULL,
  `riesgo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reglas_alertas`
--

INSERT INTO `reglas_alertas` (`id`, `enfermedad_id`, `umbral`, `riesgo`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 'MEDIO', 1, '2026-05-22 19:26:08', '2026-05-22 19:26:08'),
(2, 4, 12, 'ALTO', 1, '2026-05-22 19:26:35', '2026-05-26 22:09:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permisos` int NOT NULL DEFAULT '0',
  `usuarios` int NOT NULL DEFAULT '1',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `permisos`, `usuarios`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SUPER USUARIO', 1, 0, 1, '2026-05-13 14:34:05', '2026-05-13 14:34:05'),
(2, 'ADMINISTADOR', 0, 1, 1, '2026-05-13 21:35:22', '2026-05-13 21:35:22'),
(3, 'MÉDICO', 0, 1, 1, '2026-05-15 21:24:43', '2026-05-15 21:24:43'),
(4, 'SECRETARIA', 0, 1, 1, '2026-05-15 21:24:49', '2026-05-15 21:24:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimientos`
--

CREATE TABLE `seguimientos` (
  `id` bigint UNSIGNED NOT NULL,
  `caso_epidemiologico_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimientos`
--

INSERT INTO `seguimientos` (`id`, `caso_epidemiologico_id`, `fecha`, `estado`, `observaciones`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2026-05-26', 'ACTIVO', 'OBSERVACION 1', 1, '2026-05-26 20:47:57', '2026-05-26 20:47:57'),
(2, 2, '2026-05-26', 'ACTIVO', 'OBSERVACION 2', 1, '2026-05-26 20:48:40', '2026-05-26 20:51:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_transmisions`
--

CREATE TABLE `tipo_transmisions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_transmisions`
--

INSERT INTO `tipo_transmisions` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'RESPIRATORIA', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(2, 'CONTACTO DIRECTO', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(3, 'AGUA CONTAMINADA', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(4, 'ALIMENTOS CONTAMINADOS', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(5, 'VECTORIAL', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(6, 'SEXUAL', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(7, 'SANGRE', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(8, 'ANIMAL-HUMANO', '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(9, 'FECAL-ORAL', '2026-05-17 20:19:10', '2026-05-17 20:20:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `centro_id` bigint UNSIGNED DEFAULT NULL,
  `centro_todos` int NOT NULL DEFAULT '0',
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `password`, `foto`, `role_id`, `acceso`, `tipo`, `centro_id`, `centro_todos`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', '', '0', '', '', '', '', '$2y$12$Xx2s8LvuO3NuhNn0CoCl9uyFhDToIwgVr1uTdkj0KaoH8NHDJjmbm', NULL, 1, 1, 'ADMINISTRACIÓN', NULL, 1, '2026-05-13', 1, '2026-05-13 14:34:19', '2026-05-13 14:34:19'),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', 'ZONA LOS PEDREGALES #22', 'juan@gmail.com', '78787878', '$2y$12$NscmHfNEzfQT.tp9XppJYugxRyZvAvzhVxkznh9pHxVvy2ohxSd6u', '21778880973.jpg', 2, 1, 'ADMINISTRACIÓN', NULL, 0, '2026-05-15', 1, '2026-05-15 21:36:13', '2026-05-15 21:36:13'),
(3, 'MGONZALES', 'MARIO', 'GONZALES', '', '56765756', 'LP', '', NULL, '67676767', '$2y$12$4wzNi8P8J1X73GIGjBfWVOn1nZMc8Re3OUGM0dC8Y0hP2oZyeiBZ.', NULL, 3, 1, 'CENTRO MÉDICO', 1, 0, '2026-05-15', 1, '2026-05-15 21:39:19', '2026-05-15 21:39:19');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alerta_epidemiologicas`
--
ALTER TABLE `alerta_epidemiologicas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alerta_epidemiologicas_comunidad_id_foreign` (`comunidad_id`),
  ADD KEY `alerta_epidemiologicas_enfermedad_id_foreign` (`enfermedad_id`);

--
-- Indices de la tabla `caso_epidemiologicos`
--
ALTER TABLE `caso_epidemiologicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `caso_epidemiologicos_paciente_id_foreign` (`paciente_id`),
  ADD KEY `caso_epidemiologicos_enfermedad_id_foreign` (`enfermedad_id`),
  ADD KEY `caso_epidemiologicos_centro_id_foreign` (`centro_id`),
  ADD KEY `caso_epidemiologicos_comunidad_id_foreign` (`comunidad_id`),
  ADD KEY `caso_epidemiologicos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `categoria_enfermedads`
--
ALTER TABLE `categoria_enfermedads`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `centros`
--
ALTER TABLE `centros`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `centros_nombre_unique` (`nombre`);

--
-- Indices de la tabla `comunidads`
--
ALTER TABLE `comunidads`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `comunidad_enfermedads`
--
ALTER TABLE `comunidad_enfermedads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comunidad_enfermedads_comunidad_id_foreign` (`comunidad_id`),
  ADD KEY `comunidad_enfermedads_enfermedad_id_foreign` (`enfermedad_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `enfermedads`
--
ALTER TABLE `enfermedads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enfermedads_categoria_enfermedad_id_foreign` (`categoria_enfermedad_id`),
  ADD KEY `enfermedads_tipo_transmision_id_foreign` (`tipo_transmision_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_accions_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pacientes_comunidad_id_foreign` (`comunidad_id`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permisos_role_id_foreign` (`role_id`),
  ADD KEY `permisos_modulo_id_foreign` (`modulo_id`);

--
-- Indices de la tabla `reglas_alertas`
--
ALTER TABLE `reglas_alertas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reglas_alertas_enfermedad_id_foreign` (`enfermedad_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seguimientos_caso_epidemiologico_id_foreign` (`caso_epidemiologico_id`),
  ADD KEY `seguimientos_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `tipo_transmisions`
--
ALTER TABLE `tipo_transmisions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_role_id_foreign` (`role_id`),
  ADD KEY `users_centro_id_foreign` (`centro_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alerta_epidemiologicas`
--
ALTER TABLE `alerta_epidemiologicas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `caso_epidemiologicos`
--
ALTER TABLE `caso_epidemiologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categoria_enfermedads`
--
ALTER TABLE `categoria_enfermedads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `centros`
--
ALTER TABLE `centros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `comunidads`
--
ALTER TABLE `comunidads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `comunidad_enfermedads`
--
ALTER TABLE `comunidad_enfermedads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `enfermedads`
--
ALTER TABLE `enfermedads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reglas_alertas`
--
ALTER TABLE `reglas_alertas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_transmisions`
--
ALTER TABLE `tipo_transmisions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alerta_epidemiologicas`
--
ALTER TABLE `alerta_epidemiologicas`
  ADD CONSTRAINT `alerta_epidemiologicas_comunidad_id_foreign` FOREIGN KEY (`comunidad_id`) REFERENCES `comunidads` (`id`),
  ADD CONSTRAINT `alerta_epidemiologicas_enfermedad_id_foreign` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`);

--
-- Filtros para la tabla `caso_epidemiologicos`
--
ALTER TABLE `caso_epidemiologicos`
  ADD CONSTRAINT `caso_epidemiologicos_centro_id_foreign` FOREIGN KEY (`centro_id`) REFERENCES `centros` (`id`),
  ADD CONSTRAINT `caso_epidemiologicos_comunidad_id_foreign` FOREIGN KEY (`comunidad_id`) REFERENCES `comunidads` (`id`),
  ADD CONSTRAINT `caso_epidemiologicos_enfermedad_id_foreign` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`),
  ADD CONSTRAINT `caso_epidemiologicos_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`),
  ADD CONSTRAINT `caso_epidemiologicos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `comunidad_enfermedads`
--
ALTER TABLE `comunidad_enfermedads`
  ADD CONSTRAINT `comunidad_enfermedads_comunidad_id_foreign` FOREIGN KEY (`comunidad_id`) REFERENCES `comunidads` (`id`),
  ADD CONSTRAINT `comunidad_enfermedads_enfermedad_id_foreign` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`);

--
-- Filtros para la tabla `enfermedads`
--
ALTER TABLE `enfermedads`
  ADD CONSTRAINT `enfermedads_categoria_enfermedad_id_foreign` FOREIGN KEY (`categoria_enfermedad_id`) REFERENCES `categoria_enfermedads` (`id`),
  ADD CONSTRAINT `enfermedads_tipo_transmision_id_foreign` FOREIGN KEY (`tipo_transmision_id`) REFERENCES `tipo_transmisions` (`id`);

--
-- Filtros para la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD CONSTRAINT `historial_accions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_comunidad_id_foreign` FOREIGN KEY (`comunidad_id`) REFERENCES `comunidads` (`id`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_modulo_id_foreign` FOREIGN KEY (`modulo_id`) REFERENCES `modulos` (`id`),
  ADD CONSTRAINT `permisos_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `reglas_alertas`
--
ALTER TABLE `reglas_alertas`
  ADD CONSTRAINT `reglas_alertas_enfermedad_id_foreign` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`);

--
-- Filtros para la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  ADD CONSTRAINT `seguimientos_caso_epidemiologico_id_foreign` FOREIGN KEY (`caso_epidemiologico_id`) REFERENCES `caso_epidemiologicos` (`id`),
  ADD CONSTRAINT `seguimientos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_centro_id_foreign` FOREIGN KEY (`centro_id`) REFERENCES `centros` (`id`),
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
