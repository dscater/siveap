-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-07-2026 a las 16:15:59
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
  `nivel_alerta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `indice` double(8,2) NOT NULL,
  `prediccion` double(8,2) NOT NULL,
  `crecimiento` double(8,2) NOT NULL,
  `confirmados` int NOT NULL,
  `activos` int NOT NULL,
  `graves` int NOT NULL,
  `fallecidos` int NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `indice_fin` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alerta_epidemiologicas`
--

INSERT INTO `alerta_epidemiologicas` (`id`, `comunidad_id`, `enfermedad_id`, `nivel_alerta`, `indice`, `prediccion`, `crecimiento`, `confirmados`, `activos`, `graves`, `fallecidos`, `fecha`, `estado`, `fecha_fin`, `indice_fin`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 'CRITICO', 46.00, 10.00, 3.00, 10, 8, 3, 1, '2026-05-30', 'CONTROLADO', '2026-05-30', NULL, '2026-05-30 21:28:51', '2026-05-30 21:40:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caso_epidemiologicos`
--

CREATE TABLE `caso_epidemiologicos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `departamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `centro_id` bigint UNSIGNED NOT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `red_salud` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `captado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `captado_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `pais_lpi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departamento_lpi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio_lpi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comunidad_id_lpi` bigint DEFAULT NULL,
  `zona_lpi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais_lis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departamento_lis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio_lis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comunidad_id_lis` bigint DEFAULT NULL,
  `zona_lis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `embarazada` int DEFAULT NULL,
  `fuma` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_parto` date DEFAULT NULL,
  `fi_sintomas` date NOT NULL,
  `semana` int DEFAULT NULL,
  `fecha_diagnostico` date NOT NULL,
  `tipo_caso` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gravedad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_falle` date DEFAULT NULL,
  `contacto` int NOT NULL,
  `hospitalizacion` int NOT NULL,
  `tipo_alta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fecha_hospitalizacion` date DEFAULT NULL,
  `establecimiento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hospitalizacion_uti` int NOT NULL,
  `fecha_hospitalizacion_uti` date DEFAULT NULL,
  `establecimiento_uti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `laboratorio` int NOT NULL,
  `nexo` int NOT NULL,
  `muestra` int NOT NULL,
  `fecha_muestra` date DEFAULT NULL,
  `tipo_muestra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rt_pcr` int NOT NULL,
  `igm` int NOT NULL,
  `igm_nc` int NOT NULL,
  `igg` int NOT NULL,
  `igg_nc` int NOT NULL,
  `observacion_lab` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caso_epidemiologicos`
--

INSERT INTO `caso_epidemiologicos` (`id`, `codigo`, `paciente_id`, `enfermedad_id`, `departamento`, `municipio`, `centro_id`, `comunidad_id`, `red_salud`, `tipo`, `captado`, `captado_desc`, `user_id`, `pais_lpi`, `departamento_lpi`, `municipio_lpi`, `comunidad_id_lpi`, `zona_lpi`, `pais_lis`, `departamento_lis`, `municipio_lis`, `comunidad_id_lis`, `zona_lis`, `embarazada`, `fuma`, `fecha_parto`, `fi_sintomas`, `semana`, `fecha_diagnostico`, `tipo_caso`, `gravedad`, `estado`, `fecha_falle`, `contacto`, `hospitalizacion`, `tipo_alta`, `fecha_registro`, `observaciones`, `created_at`, `updated_at`, `fecha_hospitalizacion`, `establecimiento`, `hospitalizacion_uti`, `fecha_hospitalizacion_uti`, `establecimiento_uti`, `laboratorio`, `nexo`, `muestra`, `fecha_muestra`, `tipo_muestra`, `rt_pcr`, `igm`, `igm_nc`, `igg`, `igg_nc`, `observacion_lab`) VALUES
(1, 'CE-2026-00001', 1, 5, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-01', NULL, '2026-05-25', 'PROBABLE', 'MODERADO', 'EN SEGUIMIENTO', NULL, 5, 0, NULL, '2026-05-25', 'observaciones', '2026-05-25 16:12:07', '2026-05-30 21:18:58', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(2, 'CE-2026-00002', 2, 5, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-01', NULL, '2026-05-25', 'PROBABLE', 'MODERADO', 'ACTIVO', NULL, 10, 0, NULL, '2026-05-25', NULL, '2026-05-25 16:25:12', '2026-05-30 21:04:59', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(3, 'CE-2026-00003', 3, 5, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-01', NULL, '2026-05-26', 'CONFIRMADO', 'MODERADO', 'ACTIVO', NULL, 20, 0, NULL, '2026-05-26', NULL, '2026-05-26 21:52:20', '2026-05-30 21:04:52', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(4, 'CE-2026-00004', 4, 5, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-04', NULL, '2026-05-26', 'CONFIRMADO', 'CRITICO', 'FALLECIDO', NULL, 5, 0, NULL, '2026-05-26', NULL, '2026-05-26 21:54:39', '2026-05-30 21:07:11', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(5, 'CE-2026-00005', 5, 5, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-20', NULL, '2026-05-29', 'CONFIRMADO', 'GRAVE', 'EN SEGUIMIENTO', NULL, 0, 0, NULL, '2026-05-29', NULL, '2026-05-29 20:17:29', '2026-05-30 21:19:07', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(6, 'CE-2026-00006', 6, 5, NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-05-20', NULL, '2026-05-30', 'CONFIRMADO', 'MODERADO', 'ACTIVO', NULL, 0, 0, NULL, '2026-05-30', NULL, '2026-05-30 20:23:26', '2026-05-30 21:04:30', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL),
(11, 'CE-2026-00011', 7, 1, 'la paz', 'asunta', 1, 1, 'red', 'PÚBLICO', 'CASO CAPTADO EN BUSQUEDA ACTUAL', NULL, 1, 'bolivia', 'la paz', 'asunta', 1, 'zona', 'bolivia', 'la paz', 'asunta', 1, 'zona', NULL, NULL, NULL, '2026-05-01', 18, '2026-06-22', 'CONFIRMADO', 'MODERADO', 'EN SEGUIMIENTO', NULL, 10, 1, NULL, '2026-06-22', NULL, '2026-06-22 18:51:59', '2026-06-22 18:54:37', '2026-06-01', 'Establecimiento', 0, NULL, NULL, 1, 1, 1, '2026-06-22', 'ORINA', 1, 1, 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caso_sintomas`
--

CREATE TABLE `caso_sintomas` (
  `id` bigint UNSIGNED NOT NULL,
  `caso_epidemiologico_id` bigint UNSIGNED NOT NULL,
  `enfermedad_sintoma_id` bigint UNSIGNED NOT NULL,
  `valor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `caso_sintomas`
--

INSERT INTO `caso_sintomas` (`id`, `caso_epidemiologico_id`, `enfermedad_sintoma_id`, `valor`, `created_at`, `updated_at`) VALUES
(25, 11, 1, 'true', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(26, 11, 2, 'true', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(27, 11, 3, 'true', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(28, 11, 4, 'true', '2026-06-22 18:51:59', '2026-07-01 16:09:19'),
(29, 11, 5, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(30, 11, 6, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(31, 11, 7, 'prueba otro', '2026-06-22 18:51:59', '2026-07-01 16:09:31'),
(32, 11, 8, 'true', '2026-06-22 18:51:59', '2026-07-01 16:15:31'),
(33, 11, 9, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(34, 11, 10, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(35, 11, 11, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(36, 11, 12, '', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(37, 11, 13, 'true', '2026-06-22 18:51:59', '2026-07-01 16:15:31'),
(38, 11, 14, 'true', '2026-06-22 18:51:59', '2026-07-01 16:15:31'),
(39, 11, 15, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(40, 11, 16, 'false', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(41, 11, 17, '', '2026-06-22 18:51:59', '2026-06-22 18:51:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_enfermedads`
--

CREATE TABLE `categoria_enfermedads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `nombre` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono_correo` varchar(700) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `centros`
--

INSERT INTO `centros` (`id`, `nombre`, `fono_correo`, `direccion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'CENTRO 1', NULL, 'DIRECCION CENTRO #1', NULL, '2026-05-15 21:20:10', '2026-05-15 21:20:10'),
(2, 'CENTRO 2', '2222222', 'DIRECCION', NULL, '2026-05-15 21:20:25', '2026-06-22 14:12:33'),
(3, 'CENTRO 3', 'correo3@gmail.com', '', NULL, '2026-06-22 14:12:48', '2026-06-22 14:12:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunidads`
--

CREATE TABLE `comunidads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitud` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitud` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `nivel_riesgo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `indice_riesgo` double NOT NULL,
  `fecha_evaluacion` date NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ventanaDias` int NOT NULL DEFAULT '7',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `dir`, `fono`, `actividad`, `correo`, `logo`, `logo2`, `ventanaDias`, `created_at`, `updated_at`) VALUES
(1, 'SIVEAP', 'SIVEAP', 'SIVEAP S.A.', '11111111111', 'LOS PEDREGALES #223', '2323232 - 7776666', 'ACTIVIDAD EMPRESA', 'siveap@gmail.com', 'logo11778684319.jpeg', 'logo211778684319.jpeg', 14, '2026-05-13 14:34:05', '2026-05-30 21:59:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedads`
--

CREATE TABLE `enfermedads` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria_enfermedad_id` bigint UNSIGNED NOT NULL,
  `tipo_transmision_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
(5, 'COVID-19', 1, 1, 'ENFERMEDAD RESPIRATORIA CAUSADA POR CORONAVIRUS.', '2026-05-17 20:19:17', '2026-05-30 21:05:12'),
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
-- Estructura de tabla para la tabla `enfermedad_contingencias`
--

CREATE TABLE `enfermedad_contingencias` (
  `id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `enfermedad_contingencias`
--

INSERT INTO `enfermedad_contingencias` (`id`, `enfermedad_id`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 1, '<ol><li>Medida 1</li><li>Medida 2</li><li>Medida 3</li></ol>', '2026-05-30 15:34:40', '2026-05-30 15:34:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedad_sintomas`
--

CREATE TABLE `enfermedad_sintomas` (
  `id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `input` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enfermedad_sintomas`
--

INSERT INTO `enfermedad_sintomas` (`id`, `enfermedad_id`, `nombre`, `tipo`, `input`, `created_at`, `updated_at`) VALUES
(1, 1, 'Fiebre aguda', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:01:55', '2026-06-22 15:03:59'),
(2, 1, 'Nauseas/Vomito', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:04:15', '2026-06-22 15:04:15'),
(3, 1, 'Céfalea', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:04:27', '2026-06-22 15:04:27'),
(4, 1, 'Dolor Retro-Orbitario', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:04:44', '2026-06-22 15:04:44'),
(5, 1, 'Malgias', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:04:56', '2026-06-22 15:04:56'),
(6, 1, 'Petequias Prueba Torniquete +', 'SIN SIGNOS DE ALARMA', 0, '2026-06-22 15:06:26', '2026-06-22 15:06:26'),
(7, 1, 'Otro (especificar)', 'SIN SIGNOS DE ALARMA', 1, '2026-06-22 15:06:41', '2026-06-22 15:06:41'),
(8, 1, 'Dolor abdominal', 'CON SIGNOS DE ALARMA', 0, '2026-06-22 15:06:57', '2026-06-22 15:06:57'),
(9, 1, 'Vomitos Persistentes', 'CON SIGNOS DE ALARMA', 0, '2026-06-22 15:07:09', '2026-06-22 15:07:09'),
(10, 1, 'Letargia o Irratibilidad', 'CON SIGNOS DE ALARMA', 0, '2026-06-22 15:07:23', '2026-06-22 15:07:23'),
(11, 1, 'Sangrado de Mucosas', 'CON SIGNOS DE ALARMA', 0, '2026-06-22 15:07:33', '2026-06-22 15:07:33'),
(12, 1, 'Otros (especificar)', 'CON SIGNOS DE ALARMA', 1, '2026-06-22 15:07:48', '2026-06-22 15:07:48'),
(13, 1, 'Distres Respiratorio', 'GRAVE', 0, '2026-06-22 15:08:32', '2026-06-22 15:22:35'),
(14, 1, 'Choque', 'GRAVE', 0, '2026-06-22 15:09:28', '2026-06-22 15:22:49'),
(15, 1, 'Sangrado Grave', 'GRAVE', 0, '2026-06-22 15:23:01', '2026-06-22 15:23:01'),
(16, 1, 'Compromiso Grave de Organos', 'GRAVE', 0, '2026-06-22 15:23:14', '2026-06-22 15:23:14'),
(17, 1, 'Otros', 'GRAVE', 1, '2026-06-22 15:23:25', '2026-06-22 18:05:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(39, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 2, \"riesgo\": \"ALTO\", \"status\": 1, \"umbral\": 12, \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-22T19:28:32.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 2, \"riesgo\": \"ALTO\", \"status\": 1, \"umbral\": \"12\", \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-26T22:09:27.000000Z\", \"enfermedad_id\": \"4\"}', 'REGLAS DE ALERTA', '2026-05-26', '18:09:27', '2026-05-26 22:09:27', '2026-05-26 22:09:27'),
(40, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SEGUIMIENTO', '{\"id\": 3, \"fecha\": \"2026-05-29\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"gravedad\": \"MODERADO\", \"created_at\": \"2026-05-29T20:14:25.000000Z\", \"updated_at\": \"2026-05-29T20:14:25.000000Z\", \"observaciones\": \"\", \"caso_epidemiologico\": {\"id\": 3, \"codigo\": \"CE-2026-00003\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": 20, \"gravedad\": \"MODERADO\", \"centro_id\": 2, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:52:20.000000Z\", \"updated_at\": \"2026-05-29T20:14:25.000000Z\", \"fi_sintomas\": \"2026-05-01T04:00:00.000000Z\", \"paciente_id\": 3, \"comunidad_id\": 2, \"enfermedad_id\": 6, \"fi_sintomas_t\": \"01/05/2026\", \"observaciones\": null, \"fecha_registro\": \"2026-05-26T04:00:00.000000Z\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-26T04:00:00.000000Z\", \"fecha_diagnostico_t\": \"26/05/2026\"}, \"caso_epidemiologico_id\": \"3\"}', NULL, 'SEGUIMIENTO', '2026-05-29', '16:14:25', '2026-05-29 20:14:25', '2026-05-29 20:14:25'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"54645645\", \"id\": 5, \"dir\": \"ASUNTA #2323\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"CB\", \"nombre\": \"SANDRA\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"CACERES\", \"longitud\": \"-67.196268\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-05-29T20:16:57.000000Z\", \"updated_at\": \"2026-05-29T20:16:57.000000Z\", \"comunidad_id\": \"1\", \"fecha_registro\": \"2026-05-29\"}', NULL, 'PACIENTES', '2026-05-29', '16:16:57', '2026-05-29 20:16:57', '2026-05-29 20:16:57'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SEGUIMIENTO', '{\"id\": 4, \"fecha\": \"2026-05-29T04:00:00.000000Z\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"gravedad\": \"LEVE\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-29T20:17:29.000000Z\", \"observaciones\": \"\", \"caso_epidemiologico\": {\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 0, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-29T20:17:29.000000Z\", \"fi_sintomas\": \"2026-05-20T04:00:00.000000Z\", \"paciente_id\": 5, \"comunidad_id\": 1, \"enfermedad_id\": 1, \"fi_sintomas_t\": \"20/05/2026\", \"observaciones\": null, \"fecha_registro\": \"2026-05-29T04:00:00.000000Z\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-29T04:00:00.000000Z\", \"fecha_diagnostico_t\": \"29/05/2026\"}, \"caso_epidemiologico_id\": \"5\"}', NULL, 'SEGUIMIENTO', '2026-05-29', '16:17:29', '2026-05-29 20:17:29', '2026-05-29 20:17:29'),
(43, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"0\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-29T20:17:29.000000Z\", \"fi_sintomas\": \"2026-05-20T04:00:00.000000Z\", \"paciente_id\": \"5\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"1\", \"observaciones\": null, \"fecha_registro\": \"2026-05-29T04:00:00.000000Z\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-29T04:00:00.000000Z\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-29', '16:17:29', '2026-05-29 20:17:29', '2026-05-29 20:17:29'),
(44, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN TIPO DE TRANSMISIÓN', '{\"id\": 9, \"nombre\": \"FECAL-ORAL\", \"created_at\": \"2026-05-17T20:19:10.000000Z\", \"updated_at\": \"2026-05-17T20:20:55.000000Z\", \"descripcion\": null}', '{\"id\": 9, \"nombre\": \"FECAL-ORAL\", \"created_at\": \"2026-05-17T20:19:10.000000Z\", \"updated_at\": \"2026-05-29T21:00:16.000000Z\", \"descripcion\": \"DESCRIPCION\"}', 'TIPO DE TRANSMISIÓN', '2026-05-29', '17:00:16', '2026-05-29 21:00:16', '2026-05-29 21:00:16'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CONTINGENCIA', '{\"id\": 1, \"created_at\": \"2026-05-30T15:34:40.000000Z\", \"updated_at\": \"2026-05-30T15:34:40.000000Z\", \"descripcion\": \"<ol><li>Medida 1</li><li>Medida 2</li><li>Medida 3</li></ol>\", \"enfermedad_id\": \"1\"}', NULL, 'CONTINGENCIAS', '2026-05-30', '11:34:40', '2026-05-30 15:34:40', '2026-05-30 15:34:40'),
(46, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"ACTIVO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-28T16:47:55.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"CONTROLADO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:53:08.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', 'ALERTAS EPIDEMIOLOGICAS', '2026-05-30', '14:53:08', '2026-05-30 18:53:08', '2026-05-30 18:53:08'),
(47, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"CONTROLADO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:53:08.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"ACTIVO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:57:07.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', 'ALERTAS EPIDEMIOLOGICAS', '2026-05-30', '14:57:07', '2026-05-30 18:57:07', '2026-05-30 18:57:07'),
(48, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"ACTIVO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:57:07.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"CONTROLADO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:57:40.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', 'ALERTAS EPIDEMIOLOGICAS', '2026-05-30', '14:57:40', '2026-05-30 18:57:40', '2026-05-30 18:57:40'),
(49, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"CONTROLADO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:57:40.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', '{\"id\": 4, \"fecha\": \"2026-05-28\", \"estado\": \"ACTIVO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": null, \"created_at\": \"2026-05-26T22:40:59.000000Z\", \"fallecidos\": 1, \"prediccion\": 10, \"updated_at\": \"2026-05-30T18:57:57.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 2, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 6}', 'ALERTAS EPIDEMIOLOGICAS', '2026-05-30', '14:57:57', '2026-05-30 18:57:57', '2026-05-30 18:57:57'),
(50, 3, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN PACIENTE', '{\"ci\": \"123123\", \"id\": 6, \"dir\": \"ASDASD\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"LP\", \"nombre\": \"ASD\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"ASD\", \"longitud\": \"-67.196268\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-05-30T20:19:21.000000Z\", \"updated_at\": \"2026-05-30T20:19:21.000000Z\", \"comunidad_id\": \"2\", \"fecha_registro\": \"2026-05-30\"}', NULL, 'PACIENTES', '2026-05-30', '16:19:21', '2026-05-30 20:19:21', '2026-05-30 20:19:21'),
(51, 3, 'MODIFICACIÓN', 'EL USUARIO MGONZALES ACTUALIZÓ UN PACIENTE', '{\"ci\": \"123123\", \"id\": 6, \"dir\": \"ASDASD\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"LP\", \"nombre\": \"ASD\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"ASD\", \"longitud\": \"-67.196268\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-05-30T20:19:21.000000Z\", \"updated_at\": \"2026-05-30T20:19:21.000000Z\", \"comunidad_id\": 2, \"fecha_registro\": \"2026-05-30\"}', '{\"ci\": \"123123\", \"id\": 6, \"dir\": \"LOSOLIVOS #2323\", \"fono\": null, \"sexo\": \"FEMENINO\", \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"longitud\": \"-67.196268\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-05-30T20:19:21.000000Z\", \"updated_at\": \"2026-05-30T20:19:34.000000Z\", \"comunidad_id\": \"2\", \"fecha_registro\": \"2026-05-30\"}', 'PACIENTES', '2026-05-30', '16:19:34', '2026-05-30 20:19:34', '2026-05-30 20:19:34'),
(52, 3, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN SEGUIMIENTO', '{\"id\": 5, \"fecha\": \"2026-05-30T04:00:00.000000Z\", \"estado\": \"ACTIVO\", \"user_id\": 3, \"gravedad\": \"MODERADO\", \"created_at\": \"2026-05-30T20:23:26.000000Z\", \"updated_at\": \"2026-05-30T20:23:26.000000Z\", \"observaciones\": \"\", \"caso_epidemiologico\": {\"id\": 6, \"codigo\": \"CE-2026-00006\", \"estado\": \"ACTIVO\", \"user_id\": 3, \"contacto\": 0, \"gravedad\": \"MODERADO\", \"centro_id\": 1, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-30T20:23:26.000000Z\", \"updated_at\": \"2026-05-30T20:23:26.000000Z\", \"fi_sintomas\": \"2026-05-20T04:00:00.000000Z\", \"paciente_id\": 6, \"comunidad_id\": 2, \"enfermedad_id\": 1, \"fi_sintomas_t\": \"20/05/2026\", \"observaciones\": null, \"fecha_registro\": \"2026-05-30T04:00:00.000000Z\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-30T04:00:00.000000Z\", \"fecha_diagnostico_t\": \"30/05/2026\"}, \"caso_epidemiologico_id\": \"6\"}', NULL, 'SEGUIMIENTO', '2026-05-30', '16:23:26', '2026-05-30 20:23:26', '2026-05-30 20:23:26'),
(53, 3, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 6, \"codigo\": \"CE-2026-00006\", \"estado\": \"ACTIVO\", \"user_id\": 3, \"contacto\": \"0\", \"gravedad\": \"MODERADO\", \"centro_id\": 1, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-30T20:23:26.000000Z\", \"updated_at\": \"2026-05-30T20:23:26.000000Z\", \"fi_sintomas\": \"2026-05-20T04:00:00.000000Z\", \"paciente_id\": \"6\", \"comunidad_id\": \"2\", \"enfermedad_id\": \"1\", \"observaciones\": null, \"fecha_registro\": \"2026-05-30T04:00:00.000000Z\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-30T04:00:00.000000Z\"}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '16:23:26', '2026-05-30 20:23:26', '2026-05-30 20:23:26'),
(54, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"2342342\", \"id\": 4, \"dir\": \"\", \"fono\": \"676767676\", \"tipo\": \"ADMINISTRACIÓN\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"role_id\": \"4\", \"usuario\": \"MMARTINEZ\", \"centro_id\": null, \"created_at\": \"2026-05-30T20:33:07.000000Z\", \"updated_at\": \"2026-05-30T20:33:07.000000Z\", \"centro_todos\": 1, \"fecha_registro\": \"2026-05-30\"}', NULL, 'USUARIOS', '2026-05-30', '16:33:07', '2026-05-30 20:33:07', '2026-05-30 20:33:07'),
(55, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"2342342\", \"id\": 4, \"dir\": \"\", \"fono\": \"676767676\", \"foto\": null, \"tipo\": \"ADMINISTRACIÓN\", \"acceso\": 1, \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"role_id\": 4, \"usuario\": \"MMARTINEZ\", \"centro_id\": null, \"created_at\": \"2026-05-30T20:33:07.000000Z\", \"updated_at\": \"2026-05-30T20:33:07.000000Z\", \"centro_todos\": 1, \"fecha_registro\": \"2026-05-30\"}', '{\"ci\": \"2342342\", \"id\": 4, \"dir\": \"\", \"fono\": \"676767676\", \"foto\": null, \"tipo\": \"CENTRO MÉDICO\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"role_id\": \"4\", \"usuario\": \"MMARTINEZ\", \"centro_id\": \"1\", \"created_at\": \"2026-05-30T20:33:07.000000Z\", \"updated_at\": \"2026-05-30T20:39:09.000000Z\", \"centro_todos\": 1, \"fecha_registro\": \"2026-05-30\"}', 'USUARIOS', '2026-05-30', '16:39:09', '2026-05-30 20:39:09', '2026-05-30 20:39:09'),
(56, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"2342342\", \"id\": 4, \"dir\": \"\", \"fono\": \"676767676\", \"foto\": null, \"tipo\": \"CENTRO MÉDICO\", \"acceso\": 1, \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"role_id\": 4, \"usuario\": \"MMARTINEZ\", \"centro_id\": 1, \"created_at\": \"2026-05-30T20:33:07.000000Z\", \"updated_at\": \"2026-05-30T20:39:09.000000Z\", \"centro_todos\": 1, \"fecha_registro\": \"2026-05-30\"}', '{\"ci\": \"2342342\", \"id\": 4, \"dir\": \"\", \"fono\": \"676767676\", \"foto\": null, \"tipo\": \"ADMINISTRACIÓN\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"role_id\": \"4\", \"usuario\": \"MMARTINEZ\", \"centro_id\": null, \"created_at\": \"2026-05-30T20:33:07.000000Z\", \"updated_at\": \"2026-05-30T20:39:49.000000Z\", \"centro_todos\": 1, \"fecha_registro\": \"2026-05-30\"}', 'USUARIOS', '2026-05-30', '16:39:49', '2026-05-30 20:39:49', '2026-05-30 20:39:49'),
(57, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 6, \"codigo\": \"CE-2026-00006\", \"estado\": \"ACTIVO\", \"user_id\": 3, \"contacto\": 0, \"gravedad\": \"MODERADO\", \"centro_id\": 1, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-30T20:23:26.000000Z\", \"updated_at\": \"2026-05-30T20:23:26.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": 6, \"comunidad_id\": 2, \"enfermedad_id\": 1, \"observaciones\": null, \"fecha_registro\": \"2026-05-30\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-30\"}', '{\"id\": 6, \"codigo\": \"CE-2026-00006\", \"estado\": \"ACTIVO\", \"user_id\": 3, \"contacto\": \"0\", \"gravedad\": \"MODERADO\", \"centro_id\": \"1\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-30T20:23:26.000000Z\", \"updated_at\": \"2026-05-30T21:04:30.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": \"6\", \"comunidad_id\": \"2\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-30\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-30\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:04:30', '2026-05-30 21:04:30', '2026-05-30 21:04:30'),
(58, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 0, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-29T20:17:29.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": 5, \"comunidad_id\": 1, \"enfermedad_id\": 1, \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-29\"}', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"0\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-30T21:04:45.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": \"5\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-29\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:04:45', '2026-05-30 21:04:45', '2026-05-30 21:04:45'),
(59, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 3, \"codigo\": \"CE-2026-00003\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": 20, \"gravedad\": \"MODERADO\", \"centro_id\": 2, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:52:20.000000Z\", \"updated_at\": \"2026-05-29T20:14:25.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 3, \"comunidad_id\": 2, \"enfermedad_id\": 6, \"observaciones\": null, \"fecha_registro\": \"2026-05-26\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-26\"}', '{\"id\": 3, \"codigo\": \"CE-2026-00003\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": \"20\", \"gravedad\": \"MODERADO\", \"centro_id\": \"2\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:52:20.000000Z\", \"updated_at\": \"2026-05-30T21:04:52.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"3\", \"comunidad_id\": \"2\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-26\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-26\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:04:52', '2026-05-30 21:04:52', '2026-05-30 21:04:52'),
(60, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 2, \"codigo\": \"CE-2026-00002\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": 10, \"gravedad\": \"MODERADO\", \"centro_id\": 1, \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:25:12.000000Z\", \"updated_at\": \"2026-05-26T20:51:45.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 2, \"comunidad_id\": 1, \"enfermedad_id\": 4, \"observaciones\": null, \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25\"}', '{\"id\": 2, \"codigo\": \"CE-2026-00002\", \"estado\": \"ACTIVO\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:25:12.000000Z\", \"updated_at\": \"2026-05-30T21:04:59.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"2\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:04:59', '2026-05-30 21:04:59', '2026-05-30 21:04:59'),
(61, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ENFERMEDAD', '{\"id\": 5, \"nombre\": \"COVI-19\", \"created_at\": \"2026-05-17T20:19:17.000000Z\", \"updated_at\": \"2026-05-17T20:19:17.000000Z\", \"descripcion\": \"ENFERMEDAD RESPIRATORIA CAUSADA POR CORONAVIRUS.\", \"tipo_transmision_id\": 1, \"categoria_enfermedad_id\": 1}', '{\"id\": 5, \"nombre\": \"COVID-19\", \"created_at\": \"2026-05-17T20:19:17.000000Z\", \"updated_at\": \"2026-05-30T21:05:12.000000Z\", \"descripcion\": \"ENFERMEDAD RESPIRATORIA CAUSADA POR CORONAVIRUS.\", \"tipo_transmision_id\": \"1\", \"categoria_enfermedad_id\": \"1\"}', 'ENFERMDADES', '2026-05-30', '17:05:12', '2026-05-30 21:05:12', '2026-05-30 21:05:12'),
(62, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 5, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-26T21:53:16.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 1, \"comunidad_id\": 1, \"enfermedad_id\": 1, \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25\"}', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-30T21:07:01.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"1\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:07:01', '2026-05-30 21:07:01', '2026-05-30 21:07:01'),
(63, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 4, \"codigo\": \"CE-2026-00004\", \"estado\": \"FALLECIDO\", \"user_id\": 1, \"contacto\": 5, \"gravedad\": \"CRITICO\", \"centro_id\": 1, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:54:39.000000Z\", \"updated_at\": \"2026-05-26T21:54:39.000000Z\", \"fi_sintomas\": \"2026-05-04\", \"paciente_id\": 4, \"comunidad_id\": 1, \"enfermedad_id\": 6, \"observaciones\": null, \"fecha_registro\": \"2026-05-26\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-26\"}', '{\"id\": 4, \"codigo\": \"CE-2026-00004\", \"estado\": \"FALLECIDO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"CRITICO\", \"centro_id\": \"1\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-26T21:54:39.000000Z\", \"updated_at\": \"2026-05-30T21:07:11.000000Z\", \"fi_sintomas\": \"2026-05-04\", \"paciente_id\": \"4\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-26\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-26\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:07:11', '2026-05-30 21:07:11', '2026-05-30 21:07:11'),
(64, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA REGLA DE ALERTA', '{\"id\": 3, \"umbral\": \"3\", \"created_at\": \"2026-05-30T21:07:36.000000Z\", \"updated_at\": \"2026-05-30T21:07:36.000000Z\", \"enfermedad_id\": \"5\"}', NULL, 'REGLAS DE ALERTA', '2026-05-30', '17:07:36', '2026-05-30 21:07:36', '2026-05-30 21:07:36'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 0, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"SOSPECHOSO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-30T21:04:45.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": 5, \"comunidad_id\": 1, \"enfermedad_id\": 5, \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-29\"}', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"0\", \"gravedad\": \"LEVE\", \"centro_id\": \"1\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-30T21:16:04.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": \"5\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-29\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:16:04', '2026-05-30 21:16:04', '2026-05-30 21:16:04'),
(66, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 5, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-30T21:07:01.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": 1, \"comunidad_id\": 1, \"enfermedad_id\": 5, \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-25\"}', '{\"id\": 1, \"codigo\": \"CE-2026-00001\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"5\", \"gravedad\": \"MODERADO\", \"centro_id\": \"1\", \"tipo_caso\": \"PROBABLE\", \"created_at\": \"2026-05-25T16:12:07.000000Z\", \"updated_at\": \"2026-05-30T21:18:58.000000Z\", \"fi_sintomas\": \"2026-05-01\", \"paciente_id\": \"1\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": \"observaciones\", \"fecha_registro\": \"2026-05-25\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-25\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:18:58', '2026-05-30 21:18:58', '2026-05-30 21:18:58'),
(67, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": 0, \"gravedad\": \"LEVE\", \"centro_id\": 1, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-30T21:16:04.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": 5, \"comunidad_id\": 1, \"enfermedad_id\": 5, \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": 0, \"fecha_diagnostico\": \"2026-05-29\"}', '{\"id\": 5, \"codigo\": \"CE-2026-00005\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"contacto\": \"0\", \"gravedad\": \"GRAVE\", \"centro_id\": \"1\", \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-05-29T20:17:29.000000Z\", \"updated_at\": \"2026-05-30T21:19:07.000000Z\", \"fi_sintomas\": \"2026-05-20\", \"paciente_id\": \"5\", \"comunidad_id\": \"1\", \"enfermedad_id\": \"5\", \"observaciones\": null, \"fecha_registro\": \"2026-05-29\", \"hospitalizacion\": \"0\", \"fecha_diagnostico\": \"2026-05-29\"}', 'CASOS EPIDEMIOLOGICOS', '2026-05-30', '17:19:07', '2026-05-30 21:19:07', '2026-05-30 21:19:07'),
(68, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 3, \"status\": 1, \"umbral\": 3, \"created_at\": \"2026-05-30T21:07:36.000000Z\", \"updated_at\": \"2026-05-30T21:07:36.000000Z\", \"enfermedad_id\": 5}', '{\"id\": 3, \"status\": 1, \"umbral\": \"20\", \"created_at\": \"2026-05-30T21:07:36.000000Z\", \"updated_at\": \"2026-05-30T21:28:03.000000Z\", \"enfermedad_id\": \"5\"}', 'REGLAS DE ALERTA', '2026-05-30', '17:28:03', '2026-05-30 21:28:03', '2026-05-30 21:28:03'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 2, \"status\": 1, \"umbral\": 12, \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-26T22:09:27.000000Z\", \"enfermedad_id\": 4}', '{\"id\": 2, \"status\": 1, \"umbral\": \"20\", \"created_at\": \"2026-05-22T19:26:35.000000Z\", \"updated_at\": \"2026-05-30T21:28:08.000000Z\", \"enfermedad_id\": \"4\"}', 'REGLAS DE ALERTA', '2026-05-30', '17:28:08', '2026-05-30 21:28:08', '2026-05-30 21:28:08'),
(70, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA REGLA DE ALERTA', '{\"id\": 1, \"status\": 1, \"umbral\": 6, \"created_at\": \"2026-05-22T19:26:08.000000Z\", \"updated_at\": \"2026-05-22T19:26:08.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 1, \"status\": 1, \"umbral\": \"20\", \"created_at\": \"2026-05-22T19:26:08.000000Z\", \"updated_at\": \"2026-05-30T21:28:14.000000Z\", \"enfermedad_id\": \"1\"}', 'REGLAS DE ALERTA', '2026-05-30', '17:28:14', '2026-05-30 21:28:14', '2026-05-30 21:28:14');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(71, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA ALERTA EPIDEMIOLOGICA', '{\"id\": 1, \"fecha\": \"2026-05-30\", \"estado\": \"CONTROLADO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": \"2026-05-30\", \"created_at\": \"2026-05-30T21:28:51.000000Z\", \"fallecidos\": 1, \"indice_fin\": null, \"prediccion\": 10, \"updated_at\": \"2026-05-30T21:29:02.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 1, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 5}', '{\"id\": 1, \"fecha\": \"2026-05-30\", \"estado\": \"ACTIVO\", \"graves\": 3, \"indice\": 46, \"activos\": 8, \"fecha_fin\": \"2026-05-30\", \"created_at\": \"2026-05-30T21:28:51.000000Z\", \"fallecidos\": 1, \"indice_fin\": null, \"prediccion\": 10, \"updated_at\": \"2026-05-30T21:40:20.000000Z\", \"confirmados\": 10, \"crecimiento\": 3, \"comunidad_id\": 1, \"nivel_alerta\": \"CRITICO\", \"enfermedad_id\": 5}', 'ALERTAS EPIDEMIOLOGICAS', '2026-05-30', '17:40:20', '2026-05-30 21:40:20', '2026-05-30 21:40:20'),
(72, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"FEMENINO\", \"zona\": \"zona\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"juan martinez\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"asunta\", \"ocupacion\": \"estudiante\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T13:52:13.000000Z\", \"comunidad_id\": \"1\", \"departamento\": \"la paz\", \"fecha_registro\": \"2026-06-22\"}', NULL, 'PACIENTES', '2026-06-22', '09:52:13', '2026-06-22 13:52:13', '2026-06-22 13:52:13'),
(73, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"FEMENINO\", \"zona\": \"zona\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"juan martinez\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"asunta\", \"ocupacion\": \"estudiante\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T13:52:13.000000Z\", \"comunidad_id\": 1, \"departamento\": \"la paz\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"FEMENINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T13:52:49.000000Z\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-06-22', '09:52:49', '2026-06-22 13:52:49', '2026-06-22 13:52:49'),
(74, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CENTRO', '{\"id\": 2, \"nombre\": \"CENTRO 2\", \"direccion\": \"\", \"created_at\": \"2026-05-15T21:20:25.000000Z\", \"updated_at\": \"2026-05-15T21:20:25.000000Z\", \"fono_correo\": null, \"fecha_registro\": null}', '{\"id\": 2, \"nombre\": \"CENTRO 2\", \"direccion\": \"DIRECCION\", \"created_at\": \"2026-05-15T21:20:25.000000Z\", \"updated_at\": \"2026-06-22T14:12:33.000000Z\", \"fono_correo\": \"2222222\", \"fecha_registro\": null}', 'CENTROS', '2026-06-22', '10:12:33', '2026-06-22 14:12:33', '2026-06-22 14:12:33'),
(75, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CENTRO', '{\"id\": 3, \"nombre\": \"CENTRO 3\", \"direccion\": \"\", \"created_at\": \"2026-06-22T14:12:48.000000Z\", \"updated_at\": \"2026-06-22T14:12:48.000000Z\", \"fono_correo\": \"correo3@gmail.com\"}', NULL, 'CENTROS', '2026-06-22', '10:12:48', '2026-06-22 14:12:48', '2026-06-22 14:12:48'),
(76, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 1, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Fiebre aguda\", \"created_at\": \"2026-06-22T15:01:55.000000Z\", \"updated_at\": \"2026-06-22T15:01:55.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:01:55', '2026-06-22 15:01:55', '2026-06-22 15:01:55'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SINTOMA DE ENFERMEDAD', '{\"id\": 1, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": 0, \"nombre\": \"Fiebre aguda\", \"created_at\": \"2026-06-22T15:01:55.000000Z\", \"updated_at\": \"2026-06-22T15:01:55.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 1, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"1\", \"nombre\": \"Fiebre aguda\", \"created_at\": \"2026-06-22T15:01:55.000000Z\", \"updated_at\": \"2026-06-22T15:03:54.000000Z\", \"enfermedad_id\": \"1\"}', 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:03:54', '2026-06-22 15:03:54', '2026-06-22 15:03:54'),
(78, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SINTOMA DE ENFERMEDAD', '{\"id\": 1, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": 1, \"nombre\": \"Fiebre aguda\", \"created_at\": \"2026-06-22T15:01:55.000000Z\", \"updated_at\": \"2026-06-22T15:03:54.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 1, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Fiebre aguda\", \"created_at\": \"2026-06-22T15:01:55.000000Z\", \"updated_at\": \"2026-06-22T15:03:59.000000Z\", \"enfermedad_id\": \"1\"}', 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:03:59', '2026-06-22 15:03:59', '2026-06-22 15:03:59'),
(79, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 2, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Nauseas/Vomito\", \"created_at\": \"2026-06-22T15:04:15.000000Z\", \"updated_at\": \"2026-06-22T15:04:15.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:04:15', '2026-06-22 15:04:15', '2026-06-22 15:04:15'),
(80, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 3, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Céfalea\", \"created_at\": \"2026-06-22T15:04:27.000000Z\", \"updated_at\": \"2026-06-22T15:04:27.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:04:27', '2026-06-22 15:04:27', '2026-06-22 15:04:27'),
(81, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 4, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Dolor Retro-Orbitario\", \"created_at\": \"2026-06-22T15:04:44.000000Z\", \"updated_at\": \"2026-06-22T15:04:44.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:04:44', '2026-06-22 15:04:44', '2026-06-22 15:04:44'),
(82, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 5, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Malgias\", \"created_at\": \"2026-06-22T15:04:56.000000Z\", \"updated_at\": \"2026-06-22T15:04:56.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:04:56', '2026-06-22 15:04:56', '2026-06-22 15:04:56'),
(83, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 6, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Petequias Prueba Torniquete +\", \"created_at\": \"2026-06-22T15:06:26.000000Z\", \"updated_at\": \"2026-06-22T15:06:26.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:06:26', '2026-06-22 15:06:26', '2026-06-22 15:06:26'),
(84, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 7, \"tipo\": \"SIN SIGNOS DE ALARMA\", \"input\": \"1\", \"nombre\": \"Otro (especificar)\", \"created_at\": \"2026-06-22T15:06:41.000000Z\", \"updated_at\": \"2026-06-22T15:06:41.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:06:41', '2026-06-22 15:06:41', '2026-06-22 15:06:41'),
(85, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 8, \"tipo\": \"CON SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Dolor abdominal\", \"created_at\": \"2026-06-22T15:06:57.000000Z\", \"updated_at\": \"2026-06-22T15:06:57.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:06:57', '2026-06-22 15:06:57', '2026-06-22 15:06:57'),
(86, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 9, \"tipo\": \"CON SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Vomitos Persistentes\", \"created_at\": \"2026-06-22T15:07:09.000000Z\", \"updated_at\": \"2026-06-22T15:07:09.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:07:09', '2026-06-22 15:07:09', '2026-06-22 15:07:09'),
(87, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 10, \"tipo\": \"CON SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Letargia o Irratibilidad\", \"created_at\": \"2026-06-22T15:07:23.000000Z\", \"updated_at\": \"2026-06-22T15:07:23.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:07:23', '2026-06-22 15:07:23', '2026-06-22 15:07:23'),
(88, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 11, \"tipo\": \"CON SIGNOS DE ALARMA\", \"input\": \"0\", \"nombre\": \"Sangrado de Mucosas\", \"created_at\": \"2026-06-22T15:07:33.000000Z\", \"updated_at\": \"2026-06-22T15:07:33.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:07:33', '2026-06-22 15:07:33', '2026-06-22 15:07:33'),
(89, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 12, \"tipo\": \"CON SIGNOS DE ALARMA\", \"input\": \"1\", \"nombre\": \"Otros (especificar)\", \"created_at\": \"2026-06-22T15:07:48.000000Z\", \"updated_at\": \"2026-06-22T15:07:48.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:07:48', '2026-06-22 15:07:48', '2026-06-22 15:07:48'),
(90, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 13, \"tipo\": \"LABORATORIO\", \"input\": \"0\", \"nombre\": \"Resultado RT-PCR\", \"created_at\": \"2026-06-22T15:08:32.000000Z\", \"updated_at\": \"2026-06-22T15:08:32.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:08:32', '2026-06-22 15:08:32', '2026-06-22 15:08:32'),
(91, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 14, \"tipo\": \"LABORATORIO\", \"input\": \"0\", \"nombre\": \"Resulado Serológico\", \"created_at\": \"2026-06-22T15:09:28.000000Z\", \"updated_at\": \"2026-06-22T15:09:28.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:09:28', '2026-06-22 15:09:28', '2026-06-22 15:09:28'),
(92, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SINTOMA DE ENFERMEDAD', '{\"id\": 13, \"tipo\": \"LABORATORIO\", \"input\": 0, \"nombre\": \"Resultado RT-PCR\", \"created_at\": \"2026-06-22T15:08:32.000000Z\", \"updated_at\": \"2026-06-22T15:08:32.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 13, \"tipo\": \"GRAVE\", \"input\": \"0\", \"nombre\": \"Distres Respiratorio\", \"created_at\": \"2026-06-22T15:08:32.000000Z\", \"updated_at\": \"2026-06-22T15:22:35.000000Z\", \"enfermedad_id\": \"1\"}', 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:22:35', '2026-06-22 15:22:35', '2026-06-22 15:22:35'),
(93, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SINTOMA DE ENFERMEDAD', '{\"id\": 14, \"tipo\": \"LABORATORIO\", \"input\": 0, \"nombre\": \"Resulado Serológico\", \"created_at\": \"2026-06-22T15:09:28.000000Z\", \"updated_at\": \"2026-06-22T15:09:28.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 14, \"tipo\": \"GRAVE\", \"input\": \"0\", \"nombre\": \"Choque\", \"created_at\": \"2026-06-22T15:09:28.000000Z\", \"updated_at\": \"2026-06-22T15:22:49.000000Z\", \"enfermedad_id\": \"1\"}', 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:22:49', '2026-06-22 15:22:49', '2026-06-22 15:22:49'),
(94, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 15, \"tipo\": \"GRAVE\", \"input\": \"0\", \"nombre\": \"Sangrado Grave\", \"created_at\": \"2026-06-22T15:23:01.000000Z\", \"updated_at\": \"2026-06-22T15:23:01.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:23:01', '2026-06-22 15:23:01', '2026-06-22 15:23:01'),
(95, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 16, \"tipo\": \"GRAVE\", \"input\": \"0\", \"nombre\": \"Compromiso Grave de Organos\", \"created_at\": \"2026-06-22T15:23:14.000000Z\", \"updated_at\": \"2026-06-22T15:23:14.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:23:14', '2026-06-22 15:23:14', '2026-06-22 15:23:14'),
(96, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SINTOMA DE ENFERMEDAD', '{\"id\": 17, \"tipo\": \"GRAVE\", \"input\": \"0\", \"nombre\": \"Otros\", \"created_at\": \"2026-06-22T15:23:25.000000Z\", \"updated_at\": \"2026-06-22T15:23:25.000000Z\", \"enfermedad_id\": \"1\"}', NULL, 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '11:23:25', '2026-06-22 15:23:25', '2026-06-22 15:23:25'),
(97, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN SINTOMA DE ENFERMEDAD', '{\"id\": 17, \"tipo\": \"GRAVE\", \"input\": 0, \"nombre\": \"Otros\", \"created_at\": \"2026-06-22T15:23:25.000000Z\", \"updated_at\": \"2026-06-22T15:23:25.000000Z\", \"enfermedad_id\": 1}', '{\"id\": 17, \"tipo\": \"GRAVE\", \"input\": \"1\", \"nombre\": \"Otros\", \"created_at\": \"2026-06-22T15:23:25.000000Z\", \"updated_at\": \"2026-06-22T18:05:30.000000Z\", \"enfermedad_id\": \"1\"}', 'SINTOMAS DE ENFERMEDADS', '2026-06-22', '14:05:30', '2026-06-22 18:05:30', '2026-06-22 18:05:30'),
(98, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"FEMENINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T13:52:49.000000Z\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T18:43:37.000000Z\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-06-22', '14:43:37', '2026-06-22 18:43:37', '2026-06-22 18:43:37'),
(99, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SEGUIMIENTO', '{\"id\": 6, \"fecha\": \"2026-06-22T04:00:00.000000Z\", \"estado\": \"EN SEGUIMIENTO\", \"user_id\": 1, \"gravedad\": \"MODERADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"updated_at\": \"2026-06-22T18:51:59.000000Z\", \"observaciones\": \"\", \"caso_epidemiologico\": {\"id\": 11, \"igg\": 0, \"igm\": 0, \"fuma\": null, \"nexo\": 0, \"tipo\": \"PÚBLICO\", \"codigo\": \"CE-2026-00011\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": 0, \"igm_nc\": 0, \"rt_pcr\": 0, \"semana\": 18, \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": 0, \"user_id\": 1, \"contacto\": 10, \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": 1, \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:51:59.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": 0, \"paciente_id\": 7, \"captado_desc\": null, \"comunidad_id\": 1, \"departamento\": \"la paz\", \"tipo_muestra\": null, \"enfermedad_id\": 1, \"fecha_muestra\": null, \"fi_sintomas_t\": \"01/05/2026\", \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": null, \"hospitalizacion\": 0, \"observacion_lab\": null, \"comunidad_id_lis\": 1, \"comunidad_id_lpi\": 1, \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"fecha_diagnostico_t\": \"22/06/2026\", \"hospitalizacion_uti\": 0, \"fecha_hospitalizacion\": null, \"fecha_hospitalizacion_uti\": null}, \"caso_epidemiologico_id\": \"11\"}', NULL, 'SEGUIMIENTO', '2026-06-22', '14:51:59', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(100, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CASO EPIDEMIOLOGICO', '{\"id\": 11, \"igg\": \"0\", \"igm\": \"0\", \"fuma\": null, \"nexo\": \"0\", \"tipo\": \"PÚBLICO\", \"codigo\": \"CE-2026-00011\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": 0, \"igm_nc\": 0, \"rt_pcr\": \"0\", \"semana\": \"18\", \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": \"0\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": \"1\", \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:51:59.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": \"0\", \"paciente_id\": \"7\", \"captado_desc\": null, \"comunidad_id\": \"1\", \"departamento\": \"la paz\", \"tipo_muestra\": null, \"enfermedad_id\": \"1\", \"fecha_muestra\": null, \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": null, \"hospitalizacion\": \"0\", \"observacion_lab\": null, \"comunidad_id_lis\": \"1\", \"comunidad_id_lpi\": \"1\", \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"hospitalizacion_uti\": \"0\", \"fecha_hospitalizacion\": null, \"fecha_hospitalizacion_uti\": null}', NULL, 'CASOS EPIDEMIOLOGICOS', '2026-06-22', '14:51:59', '2026-06-22 18:51:59', '2026-06-22 18:51:59'),
(101, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 11, \"igg\": 0, \"igm\": 0, \"fuma\": null, \"nexo\": 0, \"tipo\": \"PÚBLICO\", \"codigo\": \"CE-2026-00011\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": 0, \"igm_nc\": 0, \"rt_pcr\": 0, \"semana\": 18, \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": 0, \"user_id\": 1, \"contacto\": 10, \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": 1, \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:51:59.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": 0, \"paciente_id\": 7, \"captado_desc\": null, \"comunidad_id\": 1, \"departamento\": \"la paz\", \"tipo_muestra\": null, \"enfermedad_id\": 1, \"fecha_muestra\": null, \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": null, \"hospitalizacion\": 0, \"observacion_lab\": null, \"comunidad_id_lis\": 1, \"comunidad_id_lpi\": 1, \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"hospitalizacion_uti\": 0, \"fecha_hospitalizacion\": null, \"fecha_hospitalizacion_uti\": null}', '{\"id\": 11, \"igg\": \"0\", \"igm\": \"1\", \"fuma\": null, \"nexo\": \"1\", \"tipo\": \"PÚBLICO\", \"codigo\": \"\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": \"0\", \"igm_nc\": \"1\", \"rt_pcr\": \"1\", \"semana\": \"18\", \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": \"1\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": \"1\", \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:54:15.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": \"1\", \"paciente_id\": \"7\", \"captado_desc\": null, \"comunidad_id\": \"1\", \"departamento\": \"la paz\", \"tipo_muestra\": \"ORINA\", \"enfermedad_id\": \"1\", \"fecha_muestra\": \"2026-06-22\", \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": null, \"hospitalizacion\": \"0\", \"observacion_lab\": null, \"comunidad_id_lis\": \"1\", \"comunidad_id_lpi\": \"1\", \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"hospitalizacion_uti\": \"0\", \"fecha_hospitalizacion\": null, \"fecha_hospitalizacion_uti\": null}', 'CASOS EPIDEMIOLOGICOS', '2026-06-22', '14:54:15', '2026-06-22 18:54:15', '2026-06-22 18:54:15'),
(102, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CASO EPIDEMIOLOGICO', '{\"id\": 11, \"igg\": 0, \"igm\": 1, \"fuma\": null, \"nexo\": 1, \"tipo\": \"PÚBLICO\", \"codigo\": \"\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": 0, \"igm_nc\": 1, \"rt_pcr\": 1, \"semana\": 18, \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": 1, \"user_id\": 1, \"contacto\": 10, \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": 1, \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:54:15.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": 1, \"paciente_id\": 7, \"captado_desc\": null, \"comunidad_id\": 1, \"departamento\": \"la paz\", \"tipo_muestra\": \"ORINA\", \"enfermedad_id\": 1, \"fecha_muestra\": \"2026-06-22\", \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": null, \"hospitalizacion\": 0, \"observacion_lab\": null, \"comunidad_id_lis\": 1, \"comunidad_id_lpi\": 1, \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"hospitalizacion_uti\": 0, \"fecha_hospitalizacion\": null, \"fecha_hospitalizacion_uti\": null}', '{\"id\": 11, \"igg\": \"0\", \"igm\": \"1\", \"fuma\": null, \"nexo\": \"1\", \"tipo\": \"PÚBLICO\", \"codigo\": \"\", \"estado\": \"EN SEGUIMIENTO\", \"igg_nc\": \"0\", \"igm_nc\": \"1\", \"rt_pcr\": \"1\", \"semana\": \"18\", \"captado\": \"CASO CAPTADO EN BUSQUEDA ACTUAL\", \"muestra\": \"1\", \"user_id\": 1, \"contacto\": \"10\", \"gravedad\": \"MODERADO\", \"pais_lis\": \"bolivia\", \"pais_lpi\": \"bolivia\", \"zona_lis\": \"zona\", \"zona_lpi\": \"zona\", \"centro_id\": \"1\", \"municipio\": \"asunta\", \"red_salud\": \"red\", \"tipo_alta\": null, \"tipo_caso\": \"CONFIRMADO\", \"created_at\": \"2026-06-22T18:51:59.000000Z\", \"embarazada\": null, \"updated_at\": \"2026-06-22T18:54:37.000000Z\", \"fecha_falle\": null, \"fecha_parto\": null, \"fi_sintomas\": \"2026-05-01\", \"laboratorio\": \"1\", \"paciente_id\": \"7\", \"captado_desc\": null, \"comunidad_id\": \"1\", \"departamento\": \"la paz\", \"tipo_muestra\": \"ORINA\", \"enfermedad_id\": \"1\", \"fecha_muestra\": \"2026-06-22\", \"municipio_lis\": \"asunta\", \"municipio_lpi\": \"asunta\", \"observaciones\": null, \"fecha_registro\": \"2026-06-22\", \"establecimiento\": \"Establecimiento\", \"hospitalizacion\": \"1\", \"observacion_lab\": null, \"comunidad_id_lis\": \"1\", \"comunidad_id_lpi\": \"1\", \"departamento_lis\": \"la paz\", \"departamento_lpi\": \"la paz\", \"fecha_diagnostico\": \"2026-06-22\", \"establecimiento_uti\": null, \"hospitalizacion_uti\": \"0\", \"fecha_hospitalizacion\": \"2026-06-01\", \"fecha_hospitalizacion_uti\": null}', 'CASOS EPIDEMIOLOGICOS', '2026-06-22', '14:54:37', '2026-06-22 18:54:37', '2026-06-22 18:54:37'),
(103, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.127017450889603\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19455151824543\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-06-22T18:43:37.000000Z\", \"capturaMapa\": null, \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:33:24.000000Z\", \"capturaMapa\": \"7f539a167-8e7e-47d0-8668-e61196ccc0db.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:33:24', '2026-07-01 15:33:24', '2026-07-01 15:33:24'),
(104, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"54645645\", \"id\": 5, \"dir\": \"ASUNTA #2323\", \"fono\": null, \"sexo\": \"FEMENINO\", \"zona\": null, \"ci_exp\": \"CB\", \"nombre\": \"SANDRA\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"CACERES\", \"longitud\": \"-67.196268\", \"apoderado\": null, \"fecha_nac\": \"2000-01-01\", \"municipio\": null, \"ocupacion\": null, \"created_at\": \"2026-05-29T20:16:57.000000Z\", \"updated_at\": \"2026-05-29T20:16:57.000000Z\", \"capturaMapa\": null, \"comunidad_id\": 1, \"departamento\": null, \"fecha_registro\": \"2026-05-29\"}', '{\"ci\": \"54645645\", \"id\": 5, \"dir\": \"ASUNTA #2323\", \"fono\": null, \"sexo\": \"FEMENINO\", \"zona\": \"\", \"ci_exp\": \"CB\", \"nombre\": \"SANDRA\", \"latitud\": \"-16.125102\", \"materno\": \"\", \"paterno\": \"CACERES\", \"longitud\": \"-67.196268\", \"apoderado\": \"\", \"fecha_nac\": \"2000-01-01\", \"municipio\": \"\", \"ocupacion\": \"\", \"created_at\": \"2026-05-29T20:16:57.000000Z\", \"updated_at\": \"2026-07-01T15:34:07.000000Z\", \"capturaMapa\": \"5d0f531a0-d664-459b-91dc-7d377cd0c176.png\", \"comunidad_id\": \"1\", \"departamento\": \"\", \"fecha_registro\": \"2026-05-29\"}', 'PACIENTES', '2026-07-01', '11:34:07', '2026-07-01 15:34:07', '2026-07-01 15:34:07'),
(105, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:33:24.000000Z\", \"capturaMapa\": \"7f539a167-8e7e-47d0-8668-e61196ccc0db.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:36:12.000000Z\", \"capturaMapa\": \"717239ae7-0c8e-48f2-b988-5646a9a59ed9.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:36:12', '2026-07-01 15:36:12', '2026-07-01 15:36:12'),
(106, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:36:12.000000Z\", \"capturaMapa\": \"717239ae7-0c8e-48f2-b988-5646a9a59ed9.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:39:39.000000Z\", \"capturaMapa\": \"7ffb3f4e9-0eed-4ef8-ac1c-cdec4c9216dd.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:39:39', '2026-07-01 15:39:39', '2026-07-01 15:39:39'),
(107, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:39:39.000000Z\", \"capturaMapa\": \"7ffb3f4e9-0eed-4ef8-ac1c-cdec4c9216dd.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:44:12.000000Z\", \"capturaMapa\": \"7f2d7bcd3-e09d-486c-ba5f-ae2a14f7d67f.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:44:12', '2026-07-01 15:44:12', '2026-07-01 15:44:12'),
(108, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12184588525519\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19619234034047\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:44:12.000000Z\", \"capturaMapa\": \"7f2d7bcd3-e09d-486c-ba5f-ae2a14f7d67f.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.122927606698756\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19642300279553\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:48:29.000000Z\", \"capturaMapa\": \"7d0860c1b-45bf-491c-8798-4a6da0fe9c2a.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:48:29', '2026-07-01 15:48:29', '2026-07-01 15:48:29'),
(109, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.122927606698756\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19642300279553\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:48:29.000000Z\", \"capturaMapa\": \"7d0860c1b-45bf-491c-8798-4a6da0fe9c2a.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.124868720601967\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19689524027756\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:49:12.000000Z\", \"capturaMapa\": \"731b36210-6e38-4007-838d-5d474054f301.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:49:12', '2026-07-01 15:49:12', '2026-07-01 15:49:12'),
(110, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.124868720601967\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19689524027756\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:49:12.000000Z\", \"capturaMapa\": \"731b36210-6e38-4007-838d-5d474054f301.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126730797733263\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19561795209162\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:51:53.000000Z\", \"capturaMapa\": \"7c166bedf-a6f5-452d-a4ba-61182e80a330.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:51:53', '2026-07-01 15:51:53', '2026-07-01 15:51:53'),
(111, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126730797733263\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19561795209162\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:51:53.000000Z\", \"capturaMapa\": \"7c166bedf-a6f5-452d-a4ba-61182e80a330.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126687030469427\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19555085514966\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:54:39.000000Z\", \"capturaMapa\": \"76e59c407-ed24-4b65-af12-cc8727fbf43d.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:54:39', '2026-07-01 15:54:39', '2026-07-01 15:54:39'),
(112, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126687030469427\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19555085514966\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:54:39.000000Z\", \"capturaMapa\": \"76e59c407-ed24-4b65-af12-cc8727fbf43d.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126877131012613\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19570124441944\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:55:05.000000Z\", \"capturaMapa\": \"72c81919e-f50e-4706-b46e-46d0f0fa3146.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:55:05', '2026-07-01 15:55:05', '2026-07-01 15:55:05'),
(113, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126877131012613\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19570124441944\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:55:05.000000Z\", \"capturaMapa\": \"72c81919e-f50e-4706-b46e-46d0f0fa3146.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126877131012613\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19570124441944\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:58:20.000000Z\", \"capturaMapa\": \"759e2643b-be07-4bd7-981d-c80684f0eaf3.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:58:20', '2026-07-01 15:58:20', '2026-07-01 15:58:20'),
(114, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PACIENTE', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.126877131012613\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19570124441944\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:58:20.000000Z\", \"capturaMapa\": \"759e2643b-be07-4bd7-981d-c80684f0eaf3.png\", \"comunidad_id\": 1, \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', '{\"ci\": \"1323131\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"fono\": \"67676767\", \"sexo\": \"MASCULINO\", \"zona\": \"ZONA\", \"ci_exp\": \"LP\", \"nombre\": \"JOSE\", \"latitud\": \"-16.12674224970019\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"longitud\": \"-67.19530324430777\", \"apoderado\": \"JUAN MARTINEZ\", \"fecha_nac\": \"2012-01-01\", \"municipio\": \"ASUNTA\", \"ocupacion\": \"ESTUDIANTE\", \"created_at\": \"2026-06-22T13:52:13.000000Z\", \"updated_at\": \"2026-07-01T15:59:22.000000Z\", \"capturaMapa\": \"73a4b7f1c-d2c7-4dea-898d-6857d84821af.png\", \"comunidad_id\": \"1\", \"departamento\": \"LA PAZ\", \"fecha_registro\": \"2026-06-22\"}', 'PACIENTES', '2026-07-01', '11:59:22', '2026-07-01 15:59:22', '2026-07-01 15:59:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(19, '2026_05_14_161623_create_comunidad_enfermedads_table', 5),
(20, '2026_05_29_171716_create_enfermedad_contingencias_table', 6),
(21, '2026_06_22_102934_create_enfermedad_sintomas_table', 7),
(22, '2026_06_22_105251_create_caso_sintomas_table', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` bigint UNSIGNED NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id`, `modulo`, `nombre`, `accion`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'Gestión de usuarios', 'usuarios.index', 'VER', 'VER LA LISTA DE USUARIOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(2, 'Gestión de usuarios', 'usuarios.create', 'CREAR', 'CREAR USUARIOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(3, 'Gestión de usuarios', 'usuarios.edit', 'EDITAR', 'EDITAR USUARIOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(4, 'Gestión de usuarios', 'usuarios.destroy', 'ELIMINAR', 'ELIMINAR USUARIOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(5, 'Roles y Permisos', 'roles.index', 'VER', 'VER LA LISTA DE ROLES Y PERMISOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(6, 'Roles y Permisos', 'roles.create', 'CREAR', 'CREAR ROLES Y PERMISOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(7, 'Roles y Permisos', 'roles.edit', 'EDITAR', 'EDITAR ROLES Y PERMISOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(8, 'Roles y Permisos', 'roles.destroy', 'ELIMINAR', 'ELIMINAR ROLES Y PERMISOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(9, 'Configuración', 'configuracions.index', 'VER', 'VER INFORMACIÓN DE LA CONFIGURACIÓN DEL SISTEMA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(10, 'Configuración', 'configuracions.edit', 'EDITAR', 'EDITAR LA CONFIGURACIÓN DEL SISTEMA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(11, 'Gestión de centros', 'centros.index', 'VER', 'VER LA LISTA DE CENTROS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(12, 'Gestión de centros', 'centros.create', 'CREAR', 'CREAR CENTROS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(13, 'Gestión de centros', 'centros.edit', 'EDITAR', 'EDITAR CENTROS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(14, 'Gestión de centros', 'centros.destroy', 'ELIMINAR', 'ELIMINAR CENTROS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(15, 'Gestión de enfermedades', 'enfermedads.index', 'VER', 'VER LA LISTA DE ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(16, 'Gestión de enfermedades', 'enfermedads.create', 'CREAR', 'CREAR ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(17, 'Gestión de enfermedades', 'enfermedads.edit', 'EDITAR', 'EDITAR ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(18, 'Gestión de enfermedades', 'enfermedads.destroy', 'ELIMINAR', 'ELIMINAR ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(19, 'Gestión de contingencias', 'enfermedad_contingencias.index', 'VER', 'VER LA LISTA DE CONTINGENCIAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(20, 'Gestión de contingencias', 'enfermedad_contingencias.create', 'CREAR', 'CREAR CONTINGENCIAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(21, 'Gestión de contingencias', 'enfermedad_contingencias.edit', 'EDITAR', 'EDITAR CONTINGENCIAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(22, 'Gestión de contingencias', 'enfermedad_contingencias.destroy', 'ELIMINAR', 'ELIMINAR CONTINGENCIAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(23, 'Gestión de reglas de alerta', 'reglas_alertas.index', 'VER', 'VER LA LISTA DE REGLAS DE ALERTA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(24, 'Gestión de reglas de alerta', 'reglas_alertas.create', 'CREAR', 'CREAR REGLAS DE ALERTA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(25, 'Gestión de reglas de alerta', 'reglas_alertas.edit', 'EDITAR', 'EDITAR REGLAS DE ALERTA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(26, 'Gestión de reglas de alerta', 'reglas_alertas.destroy', 'ELIMINAR', 'ELIMINAR REGLAS DE ALERTA', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(27, 'Gestión de categoría de enfermedades', 'categoria_enfermedads.index', 'VER', 'VER LA LISTA DE CATEGORÍA DE ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(28, 'Gestión de categoría de enfermedades', 'categoria_enfermedads.create', 'CREAR', 'CREAR CATEGORÍA DE ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(29, 'Gestión de categoría de enfermedades', 'categoria_enfermedads.edit', 'EDITAR', 'EDITAR CATEGORÍA DE ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(30, 'Gestión de categoría de enfermedades', 'categoria_enfermedads.destroy', 'ELIMINAR', 'ELIMINAR CATEGORÍA DE ENFERMEDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(31, 'Gestión de tipo de transmisiones', 'tipo_transmisions.index', 'VER', 'VER LA LISTA DE TIPO DE TRANSMISIONES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(32, 'Gestión de tipo de transmisiones', 'tipo_transmisions.create', 'CREAR', 'CREAR TIPO DE TRANSMISIONES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(33, 'Gestión de tipo de transmisiones', 'tipo_transmisions.edit', 'EDITAR', 'EDITAR TIPO DE TRANSMISIONES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(34, 'Gestión de tipo de transmisiones', 'tipo_transmisions.destroy', 'ELIMINAR', 'ELIMINAR TIPO DE TRANSMISIONES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(35, 'Gestión de comunidades', 'comunidads.index', 'VER', 'VER LA LISTA DE COMUNIDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(36, 'Gestión de comunidades', 'comunidads.create', 'CREAR', 'CREAR COMUNIDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(37, 'Gestión de comunidades', 'comunidads.edit', 'EDITAR', 'EDITAR COMUNIDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(38, 'Gestión de comunidades', 'comunidads.destroy', 'ELIMINAR', 'ELIMINAR COMUNIDADES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(39, 'Gestión de pacientes', 'pacientes.index', 'VER', 'VER LA LISTA DE PACIENTES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(40, 'Gestión de pacientes', 'pacientes.create', 'CREAR', 'CREAR PACIENTES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(41, 'Gestión de pacientes', 'pacientes.edit', 'EDITAR', 'EDITAR PACIENTES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(42, 'Gestión de pacientes', 'pacientes.destroy', 'ELIMINAR', 'ELIMINAR PACIENTES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(43, 'Gestión de notificaciones', 'notificacions.index', 'RECIBIR Y VER NOTIFICACIONES', 'RECIBIR Y VER NOTIFICACIONES', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(44, 'Gestión de predicciones epidemiológicas', 'prediccions.index', 'VER Y GENERAR PREDICCONES', 'VER Y GENERAR PREDICCIONES EPIDEMIOLÓGICAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(45, 'Gestión de casos epidemiológicos', 'caso_epidemiologicos.index', 'VER', 'VER LA LISTA DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(46, 'Gestión de casos epidemiológicos', 'caso_epidemiologicos.create', 'CREAR', 'CREAR CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(47, 'Gestión de casos epidemiológicos', 'caso_epidemiologicos.edit', 'EDITAR', 'EDITAR CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(48, 'Gestión de casos epidemiológicos', 'caso_epidemiologicos.destroy', 'ELIMINAR', 'ELIMINAR CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(49, 'Gestión de seguimientos', 'seguimientos.index', 'VER', 'VER LA LISTA DE SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(50, 'Gestión de seguimientos', 'seguimientos.create', 'CREAR', 'CREAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(51, 'Gestión de seguimientos', 'seguimientos.edit', 'EDITAR', 'EDITAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(52, 'Gestión de seguimientos', 'seguimientos.destroy', 'ELIMINAR', 'ELIMINAR SEGUIMIENTOS DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(53, 'Gestión de alertas epidemiológicas', 'alerta_epidemiologicas.index', 'VER', 'VER LA LISTA DE ALERTAS EPIDEMIOLÓGICAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(54, 'Gestión de alertas epidemiológicas', 'alerta_epidemiologicas.edit', 'EDITAR', 'EDITAR ALERTAS EPIDEMIOLÓGICAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(55, 'Gestión de alertas epidemiológicas', 'alerta_epidemiologicas.destroy', 'ELIMINAR', 'ELIMINAR ALERTAS EPIDEMIOLÓGICAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(56, 'Reportes', 'reportes.usuarios', 'REPORTE LISTA DE USUARIOS', 'GENERAR REPORTES DE LISTA DE USUARIOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(57, 'Reportes', 'reportes.casos_epidemiologicos', 'REPORTE CASOS EPIDEMIOLÓGICOS', 'GENERAR REPORTES DE CASOS EPIDEMIOLÓGICOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(58, 'Reportes', 'reportes.alerta_epidemiologicas', 'REPORTE ALERTAS EPIDEMIOLÓGICAS', 'GENERAR REPORTES DE ALERTAS EPIDEMIOLÓGICAS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(59, 'Reportes', 'reportes.seguimientos', 'REPORTE SEGUIMIENTO POR CASOS', 'GENERAR REPORTES DE SEGUIMIENTO POR CASOS', '2026-05-30 19:48:25', '2026-05-30 19:48:25'),
(60, 'Gestión de sintomas', 'enfermedad_sintomas.index', 'VER', 'VER LA LISTA DE SINTOMAS', '2026-06-22 14:36:20', '2026-06-22 14:36:20'),
(61, 'Gestión de sintomas', 'enfermedad_sintomas.create', 'CREAR', 'CREAR SINTOMAS', '2026-06-22 14:36:20', '2026-06-22 14:36:20'),
(62, 'Gestión de sintomas', 'enfermedad_sintomas.edit', 'EDITAR', 'EDITAR SINTOMAS', '2026-06-22 14:36:20', '2026-06-22 14:36:20'),
(63, 'Gestión de sintomas', 'enfermedad_sintomas.destroy', 'ELIMINAR', 'ELIMINAR SINTOMAS', '2026-06-22 14:36:20', '2026-06-22 14:36:20'),
(64, 'Reportes', 'reportes.fichas', 'REPORTE FICHAS DE CASOS EPIDEMIOLÓGICOS', 'GENERAR REPORTES DE FICHAS DE CASOS EPIDEMIOLÓGICOS', '2026-06-22 19:02:29', '2026-06-22 19:02:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacions`
--

CREATE TABLE `notificacions` (
  `id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacions`
--

INSERT INTO `notificacions` (`id`, `descripcion`, `modulo`, `registro_id`, `tipo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 'CRITICO: Se detectó incremento de casos de COVID-19', 'AlertaEpidemiologica', 1, 'ALERTA', '2026-05-30', '17:28:00', '2026-05-30 21:28:51', '2026-05-30 21:28:51');

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
(1, 1, 1, 1, '2026-05-30 21:28:51', '2026-05-30 21:28:53'),
(2, 2, 1, 0, '2026-05-30 21:28:51', '2026-05-30 21:28:51'),
(3, 3, 1, 0, '2026-05-30 21:28:51', '2026-05-30 21:28:51'),
(4, 4, 1, 0, '2026-05-30 21:28:51', '2026-05-30 21:28:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nac` date NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitud` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitud` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ocupacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zona` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apoderado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comunidad_id` bigint UNSIGNED NOT NULL,
  `capturaMapa` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `nombre`, `paterno`, `materno`, `sexo`, `ci`, `ci_exp`, `fecha_nac`, `dir`, `latitud`, `longitud`, `fono`, `ocupacion`, `departamento`, `municipio`, `zona`, `apoderado`, `comunidad_id`, `capturaMapa`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'JUAN', 'MONRROY', 'SOLIZ', 'MASCULINO', '456546654', 'LP', '2000-01-01', 'ASUNTA #3223', '-16.123665761985627', '-67.19748973381918', '67676767', NULL, NULL, NULL, NULL, NULL, 1, NULL, '2026-05-25', '2026-05-25 14:29:57', '2026-05-25 14:29:57'),
(2, 'MARIA', 'GONZALES', '', 'FEMENINO', '56565656', 'LP', '2003-01-01', 'ASUNTA #2323', '-16.125283924900813', '-67.19494719477096', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2026-05-25', '2026-05-25 14:44:57', '2026-05-25 14:44:57'),
(3, 'MAX', 'PONZE', '', 'MASCULINO', '345345', 'CB', '2005-01-01', 'ASUNTA #3232', '-16.122441502163745', '-67.19580530036424', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '2026-05-26', '2026-05-26 21:51:52', '2026-05-26 21:51:52'),
(4, 'MARIA', 'MARTINEZ', '', 'FEMENINO', '24234', 'LP', '1970-01-01', 'ASUNTA #$43345', '-16.125102', '-67.196268', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2026-05-26', '2026-05-26 21:54:08', '2026-05-26 21:54:08'),
(5, 'SANDRA', 'CACERES', '', 'FEMENINO', '54645645', 'CB', '2000-01-01', 'ASUNTA #2323', '-16.125102', '-67.196268', NULL, '', '', '', '', '', 1, '5d0f531a0-d664-459b-91dc-7d377cd0c176.png', '2026-05-29', '2026-05-29 20:16:57', '2026-07-01 15:34:07'),
(6, 'JUAN', 'GONZALES', '', 'FEMENINO', '123123', 'LP', '2000-01-01', 'LOSOLIVOS #2323', '-16.125102', '-67.196268', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, '2026-05-30', '2026-05-30 20:19:21', '2026-05-30 20:19:34'),
(7, 'JOSE', 'MARTINEZ', '', 'MASCULINO', '1323131', 'LP', '2012-01-01', 'LOS PEDREGALES', '-16.12674224970019', '-67.19530324430777', '67676767', 'ESTUDIANTE', 'LA PAZ', 'ASUNTA', 'ZONA', 'JUAN MARTINEZ', 1, '73a4b7f1c-d2c7-4dea-898d-6857d84821af.png', '2026-06-22', '2026-06-22 13:52:13', '2026-07-01 15:59:22');

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

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `role_id`, `modulo_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2026-05-30 19:51:27', '2026-05-30 19:51:27'),
(2, 2, 2, '2026-05-30 19:51:28', '2026-05-30 19:51:28'),
(3, 2, 3, '2026-05-30 19:51:28', '2026-05-30 19:51:28'),
(4, 2, 4, '2026-05-30 19:51:30', '2026-05-30 19:51:30'),
(5, 2, 5, '2026-05-30 19:51:33', '2026-05-30 19:51:33'),
(6, 2, 6, '2026-05-30 19:51:34', '2026-05-30 19:51:34'),
(7, 2, 7, '2026-05-30 19:51:35', '2026-05-30 19:51:35'),
(8, 2, 8, '2026-05-30 19:51:35', '2026-05-30 19:51:35'),
(9, 2, 9, '2026-05-30 19:51:36', '2026-05-30 19:51:36'),
(10, 2, 10, '2026-05-30 19:51:37', '2026-05-30 19:51:37'),
(11, 2, 11, '2026-05-30 19:51:37', '2026-05-30 19:51:37'),
(12, 2, 12, '2026-05-30 19:51:38', '2026-05-30 19:51:38'),
(13, 2, 13, '2026-05-30 19:51:39', '2026-05-30 19:51:39'),
(14, 2, 14, '2026-05-30 19:51:43', '2026-05-30 19:51:43'),
(15, 2, 15, '2026-05-30 19:51:45', '2026-05-30 19:51:45'),
(16, 2, 16, '2026-05-30 19:51:46', '2026-05-30 19:51:46'),
(17, 2, 17, '2026-05-30 19:51:46', '2026-05-30 19:51:46'),
(18, 2, 18, '2026-05-30 19:51:46', '2026-05-30 19:51:46'),
(19, 2, 19, '2026-05-30 19:51:47', '2026-05-30 19:51:47'),
(20, 2, 20, '2026-05-30 19:51:47', '2026-05-30 19:51:47'),
(21, 2, 21, '2026-05-30 19:51:48', '2026-05-30 19:51:48'),
(22, 2, 22, '2026-05-30 19:51:54', '2026-05-30 19:51:54'),
(23, 2, 23, '2026-05-30 19:51:55', '2026-05-30 19:51:55'),
(24, 2, 24, '2026-05-30 19:51:56', '2026-05-30 19:51:56'),
(25, 2, 25, '2026-05-30 19:51:56', '2026-05-30 19:51:56'),
(26, 2, 26, '2026-05-30 19:51:57', '2026-05-30 19:51:57'),
(27, 2, 27, '2026-05-30 19:51:57', '2026-05-30 19:51:57'),
(28, 2, 28, '2026-05-30 19:51:58', '2026-05-30 19:51:58'),
(29, 2, 29, '2026-05-30 19:51:58', '2026-05-30 19:51:58'),
(30, 2, 30, '2026-05-30 19:52:00', '2026-05-30 19:52:00'),
(31, 2, 31, '2026-05-30 19:52:01', '2026-05-30 19:52:01'),
(32, 2, 32, '2026-05-30 19:52:01', '2026-05-30 19:52:01'),
(33, 2, 34, '2026-05-30 19:52:03', '2026-05-30 19:52:03'),
(34, 2, 33, '2026-05-30 19:52:04', '2026-05-30 19:52:04'),
(35, 2, 35, '2026-05-30 19:52:04', '2026-05-30 19:52:04'),
(36, 2, 36, '2026-05-30 19:52:05', '2026-05-30 19:52:05'),
(37, 2, 37, '2026-05-30 19:52:05', '2026-05-30 19:52:05'),
(38, 2, 38, '2026-05-30 19:52:06', '2026-05-30 19:52:06'),
(39, 2, 39, '2026-05-30 19:52:06', '2026-05-30 19:52:06'),
(40, 2, 40, '2026-05-30 19:52:07', '2026-05-30 19:52:07'),
(41, 2, 41, '2026-05-30 19:52:07', '2026-05-30 19:52:07'),
(42, 2, 42, '2026-05-30 19:52:09', '2026-05-30 19:52:09'),
(43, 2, 43, '2026-05-30 19:52:10', '2026-05-30 19:52:10'),
(44, 2, 44, '2026-05-30 19:52:12', '2026-05-30 19:52:12'),
(45, 2, 45, '2026-05-30 19:52:14', '2026-05-30 19:52:14'),
(46, 2, 46, '2026-05-30 19:52:14', '2026-05-30 19:52:14'),
(47, 2, 47, '2026-05-30 19:52:15', '2026-05-30 19:52:15'),
(48, 2, 48, '2026-05-30 19:52:15', '2026-05-30 19:52:15'),
(49, 2, 49, '2026-05-30 19:52:16', '2026-05-30 19:52:16'),
(50, 2, 50, '2026-05-30 19:52:17', '2026-05-30 19:52:17'),
(51, 2, 51, '2026-05-30 19:52:17', '2026-05-30 19:52:17'),
(52, 2, 52, '2026-05-30 19:52:20', '2026-05-30 19:52:20'),
(53, 2, 53, '2026-05-30 19:52:20', '2026-05-30 19:52:20'),
(54, 2, 54, '2026-05-30 19:52:21', '2026-05-30 19:52:21'),
(55, 2, 55, '2026-05-30 19:52:21', '2026-05-30 19:52:21'),
(56, 2, 56, '2026-05-30 19:52:22', '2026-05-30 19:52:22'),
(57, 2, 57, '2026-05-30 19:52:22', '2026-05-30 19:52:22'),
(58, 2, 58, '2026-05-30 19:52:23', '2026-05-30 19:52:23'),
(59, 2, 59, '2026-05-30 19:52:23', '2026-05-30 19:52:23'),
(60, 3, 11, '2026-05-30 19:57:51', '2026-05-30 19:57:51'),
(61, 3, 15, '2026-05-30 19:57:52', '2026-05-30 19:57:52'),
(62, 3, 16, '2026-05-30 19:57:54', '2026-05-30 19:57:54'),
(63, 3, 17, '2026-05-30 19:57:55', '2026-05-30 19:57:55'),
(64, 3, 18, '2026-05-30 19:57:57', '2026-05-30 19:57:57'),
(65, 3, 19, '2026-05-30 19:58:00', '2026-05-30 19:58:00'),
(66, 3, 20, '2026-05-30 19:58:00', '2026-05-30 19:58:00'),
(67, 3, 21, '2026-05-30 19:58:01', '2026-05-30 19:58:01'),
(68, 3, 22, '2026-05-30 19:58:04', '2026-05-30 19:58:04'),
(69, 3, 23, '2026-05-30 19:58:06', '2026-05-30 19:58:06'),
(70, 3, 24, '2026-05-30 19:58:07', '2026-05-30 19:58:07'),
(71, 3, 25, '2026-05-30 19:58:07', '2026-05-30 19:58:07'),
(72, 3, 26, '2026-05-30 19:58:10', '2026-05-30 19:58:10'),
(73, 3, 27, '2026-05-30 19:58:11', '2026-05-30 19:58:11'),
(74, 3, 28, '2026-05-30 19:58:11', '2026-05-30 19:58:11'),
(75, 3, 29, '2026-05-30 19:58:12', '2026-05-30 19:58:12'),
(76, 3, 30, '2026-05-30 19:58:14', '2026-05-30 19:58:14'),
(77, 3, 31, '2026-05-30 19:58:14', '2026-05-30 19:58:14'),
(78, 3, 32, '2026-05-30 19:58:15', '2026-05-30 19:58:15'),
(79, 3, 33, '2026-05-30 19:58:15', '2026-05-30 19:58:15'),
(80, 3, 34, '2026-05-30 19:58:17', '2026-05-30 19:58:17'),
(81, 3, 35, '2026-05-30 19:58:19', '2026-05-30 19:58:19'),
(82, 3, 39, '2026-05-30 19:58:22', '2026-05-30 19:58:22'),
(83, 3, 40, '2026-05-30 19:58:23', '2026-05-30 19:58:23'),
(84, 3, 41, '2026-05-30 19:58:23', '2026-05-30 19:58:23'),
(85, 3, 42, '2026-05-30 19:58:24', '2026-05-30 19:58:24'),
(86, 3, 43, '2026-05-30 19:58:26', '2026-05-30 19:58:26'),
(87, 3, 45, '2026-05-30 19:58:36', '2026-05-30 19:58:36'),
(88, 3, 46, '2026-05-30 19:58:37', '2026-05-30 19:58:37'),
(89, 3, 47, '2026-05-30 19:58:38', '2026-05-30 19:58:38'),
(90, 3, 48, '2026-05-30 19:58:38', '2026-05-30 19:58:38'),
(91, 3, 49, '2026-05-30 19:58:40', '2026-05-30 19:58:40'),
(92, 3, 50, '2026-05-30 19:58:40', '2026-05-30 19:58:40'),
(93, 3, 51, '2026-05-30 19:58:40', '2026-05-30 19:58:40'),
(94, 3, 52, '2026-05-30 19:58:43', '2026-05-30 19:58:43'),
(95, 3, 53, '2026-05-30 19:58:45', '2026-05-30 19:58:45'),
(96, 3, 57, '2026-05-30 19:58:52', '2026-05-30 19:58:52'),
(97, 3, 59, '2026-05-30 20:29:47', '2026-05-30 20:29:47'),
(99, 4, 11, '2026-05-30 20:33:30', '2026-05-30 20:33:30'),
(100, 4, 15, '2026-05-30 20:33:32', '2026-05-30 20:33:32'),
(101, 4, 19, '2026-05-30 20:33:33', '2026-05-30 20:33:33'),
(102, 4, 35, '2026-05-30 20:33:38', '2026-05-30 20:33:38'),
(103, 4, 39, '2026-05-30 20:33:39', '2026-05-30 20:33:39'),
(104, 4, 45, '2026-05-30 20:33:46', '2026-05-30 20:33:46'),
(105, 4, 49, '2026-05-30 20:33:49', '2026-05-30 20:33:49'),
(106, 4, 53, '2026-05-30 20:33:54', '2026-05-30 20:33:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reglas_alertas`
--

CREATE TABLE `reglas_alertas` (
  `id` bigint UNSIGNED NOT NULL,
  `enfermedad_id` bigint UNSIGNED NOT NULL,
  `umbral` double NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reglas_alertas`
--

INSERT INTO `reglas_alertas` (`id`, `enfermedad_id`, `umbral`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 20, 1, '2026-05-22 19:26:08', '2026-05-30 21:28:14'),
(2, 4, 20, 1, '2026-05-22 19:26:35', '2026-05-30 21:28:08'),
(3, 5, 20, 1, '2026-05-30 21:07:36', '2026-05-30 21:28:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `gravedad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimientos`
--

INSERT INTO `seguimientos` (`id`, `caso_epidemiologico_id`, `fecha`, `gravedad`, `estado`, `observaciones`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2026-05-26', 'MODERADO', 'ACTIVO', 'OBSERVACION 1', 1, '2026-05-26 20:47:57', '2026-05-26 20:47:57'),
(2, 2, '2026-05-26', 'MODERADO', 'ACTIVO', 'OBSERVACION 2', 1, '2026-05-26 20:48:40', '2026-05-26 20:51:45'),
(3, 3, '2026-05-29', 'MODERADO', 'ACTIVO', '', 1, '2026-05-29 20:14:25', '2026-05-29 20:14:25'),
(4, 5, '2026-05-29', 'LEVE', 'EN SEGUIMIENTO', '', 1, '2026-05-29 20:17:29', '2026-05-29 20:17:29'),
(5, 6, '2026-05-30', 'MODERADO', 'ACTIVO', '', 3, '2026-05-30 20:23:26', '2026-05-30 20:23:26'),
(6, 11, '2026-06-22', 'MODERADO', 'EN SEGUIMIENTO', '', 1, '2026-06-22 18:51:59', '2026-06-22 18:51:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_transmisions`
--

CREATE TABLE `tipo_transmisions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_transmisions`
--

INSERT INTO `tipo_transmisions` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'RESPIRATORIA', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(2, 'CONTACTO DIRECTO', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(3, 'AGUA CONTAMINADA', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(4, 'ALIMENTOS CONTAMINADOS', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(5, 'VECTORIAL', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(6, 'SEXUAL', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(7, 'SANGRE', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(8, 'ANIMAL-HUMANO', NULL, '2026-05-17 20:19:10', '2026-05-17 20:19:10'),
(9, 'FECAL-ORAL', 'DESCRIPCION', '2026-05-17 20:19:10', '2026-05-29 21:00:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', 'ZONA LOS PEDREGALES #22', 'juan@gmail.com', '78787878', '$2y$12$WhRqwyGeh2fKg3sTPTBntulHC4UGJwdEVEAJxoTiyt87GwoNHYkpC', '21778880973.jpg', 2, 1, 'ADMINISTRACIÓN', NULL, 1, '2026-05-15', 1, '2026-05-15 21:36:13', '2026-05-30 19:52:43'),
(3, 'MGONZALES', 'MARIO', 'GONZALES', '', '56765756', 'LP', '', NULL, '67676767', '$2y$12$4wzNi8P8J1X73GIGjBfWVOn1nZMc8Re3OUGM0dC8Y0hP2oZyeiBZ.', NULL, 3, 1, 'CENTRO MÉDICO', 1, 0, '2026-05-15', 1, '2026-05-15 21:39:19', '2026-05-15 21:39:19'),
(4, 'MMARTINEZ', 'MARIA', 'MARTINEZ', '', '2342342', 'LP', '', NULL, '676767676', '$2y$12$QeiUnywEqyFD/QquYvWLrexe0zRR2DFUNHJzk7Sbc9JlpebWOWuBm', NULL, 4, 1, 'ADMINISTRACIÓN', NULL, 1, '2026-05-30', 1, '2026-05-30 20:33:07', '2026-05-30 20:39:49');

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
-- Indices de la tabla `caso_sintomas`
--
ALTER TABLE `caso_sintomas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `caso_sintomas_caso_epidemiologico_id` (`caso_epidemiologico_id`),
  ADD KEY `caso_sintomas_caso_enfermedad_sintoma_id` (`enfermedad_sintoma_id`);

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
-- Indices de la tabla `enfermedad_contingencias`
--
ALTER TABLE `enfermedad_contingencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enfermedad_contingencias_enfermedad_id_foreign` (`enfermedad_id`);

--
-- Indices de la tabla `enfermedad_sintomas`
--
ALTER TABLE `enfermedad_sintomas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enfermedad_sintomas_enfermedad_id` (`enfermedad_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `caso_epidemiologicos`
--
ALTER TABLE `caso_epidemiologicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `caso_sintomas`
--
ALTER TABLE `caso_sintomas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `categoria_enfermedads`
--
ALTER TABLE `categoria_enfermedads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `centros`
--
ALTER TABLE `centros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- AUTO_INCREMENT de la tabla `enfermedad_contingencias`
--
ALTER TABLE `enfermedad_contingencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `enfermedad_sintomas`
--
ALTER TABLE `enfermedad_sintomas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT de la tabla `reglas_alertas`
--
ALTER TABLE `reglas_alertas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `seguimientos`
--
ALTER TABLE `seguimientos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipo_transmisions`
--
ALTER TABLE `tipo_transmisions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Filtros para la tabla `caso_sintomas`
--
ALTER TABLE `caso_sintomas`
  ADD CONSTRAINT `caso_sintomas_caso_enfermedad_sintoma_id` FOREIGN KEY (`enfermedad_sintoma_id`) REFERENCES `enfermedad_sintomas` (`id`),
  ADD CONSTRAINT `caso_sintomas_caso_epidemiologico_id` FOREIGN KEY (`caso_epidemiologico_id`) REFERENCES `caso_epidemiologicos` (`id`);

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
-- Filtros para la tabla `enfermedad_contingencias`
--
ALTER TABLE `enfermedad_contingencias`
  ADD CONSTRAINT `enfermedad_contingencias_enfermedad_id_foreign` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`);

--
-- Filtros para la tabla `enfermedad_sintomas`
--
ALTER TABLE `enfermedad_sintomas`
  ADD CONSTRAINT `enfermedad_sintomas_enfermedad_id` FOREIGN KEY (`enfermedad_id`) REFERENCES `enfermedads` (`id`);

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
