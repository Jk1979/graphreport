-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 17 2020 г., 10:27
-- Версия сервера: 10.4.7-MariaDB
-- Версия PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `graphreport`
--

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `client`, `created_at`, `updated_at`) VALUES
(1, 'Acme', '2020-04-15 11:29:43', '2020-04-15 11:29:43'),
(2, 'Apple', '2020-04-15 11:29:43', '2020-04-15 11:29:43'),
(3, 'Microsoft', '2020-04-15 11:29:43', '2020-04-15 11:29:43');

-- --------------------------------------------------------

--
-- Структура таблицы `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2020_04_15_133822_create_clients_table', 1),
(4, '2020_04_15_134110_create_products_table', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `product`, `total`, `client_id`, `date`, `created_at`, `updated_at`) VALUES
(2, 'The Matrix Trilogy 2', 31, 1, '2015-02-02', '2020-04-15 11:45:45', '2020-04-15 11:45:45'),
(3, 'The Matrix Trilogy 3', 32, 1, '2015-03-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(4, 'The Matrix Trilogy 4', 33, 1, '2015-04-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(5, 'The Matrix Trilogy 5', 34, 1, '2015-05-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(6, 'The Matrix Trilogy 6', 35, 1, '2015-06-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(7, 'The Matrix Trilogy 7', 36, 1, '2015-07-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(8, 'The Matrix Trilogy 8', 37, 1, '2015-08-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(9, 'The Matrix Trilogy 9', 38, 1, '2015-09-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(10, 'The Matrix Trilogy 10', 39, 1, '2015-10-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(11, 'The Matrix Trilogy 11', 40, 1, '2015-11-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(12, 'The Matrix Trilogy 12', 41, 1, '2015-12-02', '2020-04-15 11:45:46', '2020-04-15 11:45:46'),
(13, 'The Matrix Trilogy 1', 30, 1, '2015-02-01', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(14, 'The Matrix Trilogy 2', 31, 1, '2015-02-02', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(15, 'The Matrix Trilogy 3', 32, 1, '2015-02-03', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(16, 'The Matrix Trilogy 4', 33, 1, '2015-02-04', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(17, 'The Matrix Trilogy 5', 34, 1, '2015-02-05', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(18, 'The Matrix Trilogy 6', 35, 1, '2015-02-06', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(19, 'The Matrix Trilogy 7', 36, 1, '2015-02-07', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(20, 'The Matrix Trilogy 8', 37, 1, '2015-02-08', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(22, 'The Matrix Trilogy 10', 39, 1, '2015-02-10', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(23, 'The Matrix Trilogy 11', 40, 1, '2015-02-11', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(24, 'The Matrix Trilogy 12', 41, 1, '2015-02-12', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(25, 'The Matrix Trilogy 13', 42, 1, '2015-02-13', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(26, 'The Matrix Trilogy 14', 43, 1, '2015-02-14', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(27, 'The Matrix Trilogy 15', 44, 1, '2015-02-15', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(28, 'The Matrix Trilogy 16', 45, 1, '2015-02-16', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(29, 'The Matrix Trilogy 17', 46, 1, '2015-02-17', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(30, 'The Matrix Trilogy 18', 47, 1, '2015-02-18', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(31, 'The Matrix Trilogy 19', 48, 1, '2015-02-19', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(32, 'Macbook Air 1', 1200, 3, '2015-02-19', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(33, 'Macbook Air 2', 1201, 3, '2015-02-20', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(34, 'Macbook Air 3', 1202, 3, '2015-02-21', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(35, 'Macbook Air 4', 1203, 3, '2015-02-22', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(36, 'Macbook Air 5', 1204, 3, '2015-02-23', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(37, 'Macbook Air 6', 1205, 3, '2015-02-24', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(38, 'Macbook Air 7', 1206, 3, '2015-02-25', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(39, 'Macbook Air 8', 1207, 3, '2015-02-26', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(40, 'Macbook Air 9', 1208, 3, '2015-02-27', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(41, 'Macbook Air 10', 1209, 3, '2015-02-28', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(42, 'Macbook Air 11', 1210, 3, '2015-03-01', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(43, 'Macbook Air 12', 1211, 3, '2015-03-02', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(44, 'Macbook Air 13', 1212, 3, '2015-03-03', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(45, 'Macbook Air 14', 1213, 3, '2015-03-04', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(46, 'Macbook Air 15', 1214, 3, '2015-03-05', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(47, 'Macbook Air 16', 1215, 3, '2015-03-06', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(48, 'Macbook Air 17', 1216, 3, '2015-03-07', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(49, 'Macbook Air 18', 1217, 3, '2015-03-08', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(50, 'Macbook Air 19', 1218, 3, '2015-03-09', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(51, 'Server Rack', 10000, 2, '2015-02-10', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(52, 'Server Farm', 100000, 2, '2015-02-28', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(53, 'Watch', 399, 2, '2015-03-09', '2020-04-15 11:53:11', '2020-04-15 11:53:11'),
(55, 'The Matrix Trilogy 1', 500, 1, '2015-01-23', NULL, '2020-04-17 04:54:21');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
