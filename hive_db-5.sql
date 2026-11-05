-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2026 at 11:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hive_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `recipient_name` varchar(200) NOT NULL,
  `recipient_contact_number` varchar(30) NOT NULL,
  `delivery_address` text NOT NULL,
  `location_directions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`address_id`, `customer_id`, `recipient_name`, `recipient_contact_number`, `delivery_address`, `location_directions`) VALUES
(1, 1, 'Angela Lopez', '09514359638', 'Purok 2, Brgy. 3 (Poblacion), Talakag, Bukidnon 8708', 'Near the Brgy. 3 plaza; call upon arrival'),
(2, 2, 'Miguel Castillo', '09606550087', 'Purok 1, Brgy. 1 (Poblacion), Talakag, Bukidnon 8708', 'Beside the Poblacion church; blue gate'),
(3, 3, 'Sofia Navarro', '09281594059', 'Purok 3, Brgy. 2 (Poblacion), Talakag, Bukidnon 8708', 'Across the public market entrance'),
(4, 4, 'Rafael Sumagaysay', '09632061512', 'Purok 5, Brgy. Sinuda, Talakag, Bukidnon 8708', 'Near the barangay hall; call upon arrival');

-- --------------------------------------------------------

--
-- Table structure for table `add_ons`
--

CREATE TABLE `add_ons` (
  `add_on_id` int(11) NOT NULL,
  `add_on_name` varchar(100) NOT NULL,
  `add_on_description` varchar(255) DEFAULT NULL,
  `add_on_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `add_on_availability` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `add_ons`
--

INSERT INTO `add_ons` (`add_on_id`, `add_on_name`, `add_on_description`, `add_on_price`, `add_on_availability`) VALUES
(1, 'Rice', 'Extra serving of rice', 20.00, 'Available'),
(2, 'Fried Egg', 'Add a fried egg', 20.00, 'Available'),
(3, 'Mixed Veggies', 'Add mixed vegetables', 15.00, 'Available'),
(4, 'Espresso Shot', 'Add an espresso shot', 50.00, 'Available'),
(5, 'Slice Cheese', 'Add a slice of cheese', 15.00, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `archive_records`
--

CREATE TABLE `archive_records` (
  `archive_record_id` bigint(20) UNSIGNED NOT NULL,
  `archived_by_user_id` int(11) NOT NULL,
  `source_table_name` varchar(100) NOT NULL,
  `source_record_id` varchar(100) NOT NULL,
  `archived_record_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`archived_record_data`)),
  `archive_reason` varchar(255) DEFAULT NULL,
  `archive_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `audit_log_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_type` enum('CREATE','UPDATE','DELETE','LOGIN','LOGOUT','VIEW','ARCHIVE','RESTORE','OTHER') NOT NULL DEFAULT 'OTHER',
  `affected_table_name` varchar(100) DEFAULT NULL,
  `affected_record_id` varchar(100) DEFAULT NULL,
  `previous_record_values` longtext DEFAULT NULL,
  `revised_record_values` longtext DEFAULT NULL,
  `action_description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `action_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_payments`
--

CREATE TABLE `bank_payments` (
  `payment_id` int(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_transaction_number` varchar(150) DEFAULT NULL,
  `bank_account_name` varchar(150) DEFAULT NULL,
  `bank_verification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank_payments`
--

INSERT INTO `bank_payments` (`payment_id`, `bank_name`, `bank_transaction_number`, `bank_account_name`, `bank_verification_date`) VALUES
(4, 'BPI', 'TRX2902086881', 'Patricia Gonzales', '2026-06-06 10:18:00'),
(5, 'BDO', 'TRX9386503443', 'Sofia Sumagaysay', '2026-06-06 13:45:00'),
(14, 'BDO', 'TRX3592953295', 'Isabel Gonzales', '2026-07-25 16:24:00'),
(19, 'BDO', 'TRX3337113627', 'Isabel Lopez', '2026-08-22 13:56:00'),
(20, 'BPI', 'TRX2347791594', 'Angela Navarro', '2026-08-22 15:09:00');

-- --------------------------------------------------------

--
-- Table structure for table `business_forecast`
--

CREATE TABLE `business_forecast` (
  `business_forecast_id` int(11) NOT NULL,
  `forecast_model_run_id` int(11) NOT NULL,
  `menu_item_id` int(11) DEFAULT NULL,
  `ingredient_id` int(11) DEFAULT NULL,
  `forecast_target_type` varchar(40) NOT NULL,
  `forecast_target_date` date NOT NULL,
  `predicted_quantity` decimal(12,3) DEFAULT NULL,
  `predicted_sales_amount` decimal(12,2) DEFAULT NULL,
  `predicted_ingredient_cost_amount` decimal(12,2) DEFAULT NULL,
  `predicted_operating_expense_amount` decimal(12,2) DEFAULT NULL,
  `actual_quantity` decimal(12,3) DEFAULT NULL,
  `actual_sales_amount` decimal(12,2) DEFAULT NULL,
  `actual_ingredient_cost_amount` decimal(12,2) DEFAULT NULL,
  `actual_operating_expense_amount` decimal(12,2) DEFAULT NULL,
  `predicted_gross_profit_amount` decimal(12,2) DEFAULT NULL,
  `actual_gross_profit_amount` decimal(12,2) DEFAULT NULL,
  `predicted_net_profit_amount` decimal(12,2) DEFAULT NULL,
  `actual_net_profit_amount` decimal(12,2) DEFAULT NULL,
  `forecast_variance_quantity` decimal(12,3) DEFAULT NULL,
  `forecast_variance_amount` decimal(12,2) DEFAULT NULL,
  `procurement_recommendation_quantity` decimal(12,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `business_forecast`
--

INSERT INTO `business_forecast` (`business_forecast_id`, `forecast_model_run_id`, `menu_item_id`, `ingredient_id`, `forecast_target_type`, `forecast_target_date`, `predicted_quantity`, `predicted_sales_amount`, `predicted_ingredient_cost_amount`, `predicted_operating_expense_amount`, `actual_quantity`, `actual_sales_amount`, `actual_ingredient_cost_amount`, `actual_operating_expense_amount`, `predicted_gross_profit_amount`, `actual_gross_profit_amount`, `predicted_net_profit_amount`, `actual_net_profit_amount`, `forecast_variance_quantity`, `forecast_variance_amount`, `procurement_recommendation_quantity`) VALUES
(1, 2, 1, NULL, 'Menu Item Sales', '2026-09-26', 1.000, 70.00, NULL, NULL, 2.000, 140.00, NULL, NULL, NULL, NULL, NULL, NULL, 1.000, 70.00, 2.000),
(2, 2, 30, NULL, 'Menu Item Sales', '2026-09-26', 1.000, 50.00, NULL, NULL, 2.000, 100.00, NULL, NULL, NULL, NULL, NULL, NULL, 1.000, 50.00, 2.000);

-- --------------------------------------------------------

--
-- Table structure for table `business_insights`
--

CREATE TABLE `business_insights` (
  `business_insight_id` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `forecast_model_run_id` int(11) DEFAULT NULL,
  `insight_type` varchar(80) NOT NULL,
  `insight_title` varchar(150) NOT NULL,
  `insight_description` text NOT NULL,
  `related_metric_name` varchar(120) DEFAULT NULL,
  `related_metric_value` decimal(14,3) DEFAULT NULL,
  `related_metric_unit` varchar(40) DEFAULT NULL,
  `insight_generation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `recommended_action` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `business_insights`
--

INSERT INTO `business_insights` (`business_insight_id`, `report_id`, `forecast_model_run_id`, `insight_type`, `insight_title`, `insight_description`, `related_metric_name`, `related_metric_value`, `related_metric_unit`, `insight_generation_date`, `recommended_action`) VALUES
(1, 2, NULL, 'Sales', 'Fries Solo is the top seller', 'Fries Solo had the highest units sold since opening.', 'Units Sold', 8.000, 'units', '2026-10-01 08:05:00', 'Keep related ingredients above minimum stock'),
(2, 3, NULL, 'Inventory', 'Milk spoilage detected', 'Milk had spoilage adjustments.', 'Spoilage', 2.000, 'l', '2026-10-02 08:05:00', 'Order smaller, more frequent batches'),
(3, NULL, 2, 'Forecast', 'Low forecast error', 'The latest forecast run kept its error low.', 'MAE', 3.900, 'units', '2026-09-25 07:10:00', 'Keep the current staffing schedule');

-- --------------------------------------------------------

--
-- Table structure for table `cash_payments`
--

CREATE TABLE `cash_payments` (
  `payment_id` int(11) NOT NULL,
  `amount_tendered` decimal(12,2) NOT NULL,
  `change_given` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash_payments`
--

INSERT INTO `cash_payments` (`payment_id`, `amount_tendered`, `change_given`) VALUES
(1, 150.00, 30.00),
(2, 150.00, 28.50),
(3, 100.00, 40.00),
(6, 150.00, 30.00),
(7, 200.00, 2.00),
(9, 300.00, 22.00),
(11, 250.00, 18.00),
(12, 150.00, 15.00),
(15, 150.00, 11.00),
(17, 150.00, 30.00),
(21, 200.00, 5.00),
(26, 200.00, 4.00);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `category_description`) VALUES
(1, 'Coffee', 'Hot and iced espresso drinks'),
(2, 'Flavored Coffee', 'Hot and iced espresso drinks with flavors'),
(3, 'Non Coffee', 'Chocolate, strawberry and matcha drinks'),
(4, 'Refreshers', 'Fruit and citrus coolers'),
(5, 'Shake/Blended', 'Shakes and iced blended drinks'),
(6, 'Meals', 'Rice meals and silogs'),
(7, 'Snacks', 'Snacks, sandwiches and light bites');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  `customer_registration_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `contact_number`, `email_address`, `customer_registration_date`) VALUES
(1, 'Angela', 'Lopez', '09514359638', 'angela.lopez@example.com', '2026-05-20 10:15:00'),
(2, 'Miguel', 'Castillo', '09606550087', 'miguel.castillo@example.com', '2026-05-27 10:15:00'),
(4, 'Rafael', 'Sumagaysay', '09632061512', 'rafael.sumagaysay@example.com', '2026-06-10 10:15:00'),
(5, 'Isabel', 'Soriano', '09681918347', 'isabel.soriano@example.com', '2026-07-01 10:15:00'),
(6, 'Daniel', 'Labadan', '09756240508', 'daniel.labadan@example.com', '2026-07-15 10:15:00'),
(7, 'Patricia', 'Valdez', '09740553836', 'patricia.valdez@example.com', '2026-07-29 10:15:00'),
(8, 'Carlo', 'Gonzales', '09162862562', 'carlo.gonzales@example.com', '2026-08-12 10:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `customer_loyalty`
--

CREATE TABLE `customer_loyalty` (
  `customer_loyalty_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `loyalty_membership_number` varchar(50) NOT NULL,
  `loyalty_enrollment_date` date NOT NULL,
  `loyalty_tier_name` varchar(50) NOT NULL DEFAULT 'Standard',
  `available_loyalty_points` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_loyalty`
--

INSERT INTO `customer_loyalty` (`customer_loyalty_id`, `customer_id`, `loyalty_membership_number`, `loyalty_enrollment_date`, `loyalty_tier_name`, `available_loyalty_points`) VALUES
(1, 1, 'HIVE-2026001', '2026-05-20', 'Standard', 68),
(2, 2, 'HIVE-2026002', '2026-05-27', 'Standard', 0),
(3, 3, 'HIVE-2026003', '2026-06-03', 'Standard', 0),
(4, 4, 'HIVE-2026004', '2026-06-10', 'Standard', 0),
(5, 5, 'HIVE-2026005', '2026-07-01', 'Standard', 36),
(6, 6, 'HIVE-2026006', '2026-07-15', 'Standard', 0),
(7, 7, 'HIVE-2026007', '2026-07-29', 'Standard', 0),
(8, 8, 'HIVE-2026008', '2026-08-12', 'Standard', 0);

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `rider_id` int(11) DEFAULT NULL,
  `delivery_fee` decimal(10,2) NOT NULL DEFAULT 0.00,
  `delivery_status` varchar(25) NOT NULL DEFAULT 'Pending',
  `delivery_dispatch_date` datetime DEFAULT NULL,
  `delivery_completion_date` datetime DEFAULT NULL,
  `delivery_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`delivery_id`, `order_id`, `address_id`, `rider_id`, `delivery_fee`, `delivery_status`, `delivery_dispatch_date`, `delivery_completion_date`, `delivery_notes`) VALUES
(1, 8, 1, 1, 30.00, 'Delivered', '2026-06-20 13:06:00', '2026-06-20 13:36:00', 'Handed to customer at Poblacion plaza'),
(2, 13, 2, 2, 30.00, 'Delivered', '2026-07-25 10:44:00', '2026-07-25 11:14:00', 'Left at gate'),
(3, 19, 3, 1, 30.00, 'Delivered', '2026-08-22 14:01:00', '2026-08-22 14:31:00', NULL),
(4, 26, 4, 2, 30.00, 'Delivered', '2026-09-26 12:08:00', '2026-09-26 12:38:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `discount_id` int(11) NOT NULL,
  `discount_name` varchar(100) NOT NULL,
  `discount_description` varchar(255) DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `discount_start_date` datetime NOT NULL,
  `discount_end_date` datetime NOT NULL,
  `discount_created_by_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`discount_id`, `discount_name`, `discount_description`, `discount_type`, `discount_value`, `discount_start_date`, `discount_end_date`, `discount_created_by_user_id`) VALUES
(1, 'Senior/PWD Discount', '20% discount for senior citizens and PWD', 'Percentage', 20.00, '2026-05-19 00:00:00', '2026-12-31 23:59:59', 1),
(2, 'Loyalty PHP 25 Off', 'Redeemed loyalty reward', 'Fixed', 25.00, '2026-05-19 00:00:00', '2026-12-31 23:59:59', 2),
(3, 'Grand Opening Promo 10%', '10% off during the first month', 'Percentage', 10.00, '2026-05-19 00:00:00', '2026-06-19 23:59:59', 2);

-- --------------------------------------------------------

--
-- Table structure for table `forecast_model_runs`
--

CREATE TABLE `forecast_model_runs` (
  `forecast_model_run_id` int(11) NOT NULL,
  `executed_by_user_id` int(11) NOT NULL,
  `model_name` varchar(120) NOT NULL,
  `model_version` varchar(50) NOT NULL,
  `forecasting_method` varchar(100) NOT NULL,
  `training_period_start` date NOT NULL,
  `training_period_end` date NOT NULL,
  `forecast_execution_date` datetime NOT NULL DEFAULT current_timestamp(),
  `forecast_period_start` date NOT NULL,
  `forecast_period_end` date NOT NULL,
  `model_mean_absolute_error` decimal(12,4) DEFAULT NULL,
  `model_root_mean_squared_error` decimal(12,4) DEFAULT NULL,
  `model_parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`model_parameters`)),
  `model_run_status` varchar(20) NOT NULL DEFAULT 'Completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forecast_model_runs`
--

INSERT INTO `forecast_model_runs` (`forecast_model_run_id`, `executed_by_user_id`, `model_name`, `model_version`, `forecasting_method`, `training_period_start`, `training_period_end`, `forecast_execution_date`, `forecast_period_start`, `forecast_period_end`, `model_mean_absolute_error`, `model_root_mean_squared_error`, `model_parameters`, `model_run_status`) VALUES
(1, 1, 'Hive Sales Forecaster', '1.0', 'Moving Average', '2026-05-19', '2026-09-05', '2026-09-06 07:00:00', '2026-09-07', '2026-09-20', 4.2500, 5.8000, '{\"window\": 7}', 'Completed'),
(2, 2, 'Hive Sales Forecaster', '1.1', 'Exponential Smoothing', '2026-05-19', '2026-09-24', '2026-09-25 07:00:00', '2026-09-26', '2026-10-09', 3.9000, 5.1000, '{\"alpha\": 0.4}', 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `gcash_payments`
--

CREATE TABLE `gcash_payments` (
  `payment_id` int(11) NOT NULL,
  `gcash_reference_number` varchar(150) DEFAULT NULL,
  `gcash_account_name` varchar(150) DEFAULT NULL,
  `gcash_verification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gcash_payments`
--

INSERT INTO `gcash_payments` (`payment_id`, `gcash_reference_number`, `gcash_account_name`, `gcash_verification_date`) VALUES
(8, 'GC9705485607', 'Angela Castillo', '2026-06-20 13:01:00'),
(10, 'GC4445648603', 'Carlo Sumagaysay', '2026-07-11 12:45:00'),
(16, 'GC5656977700', 'Daniel Lopez', '2026-08-08 16:41:00'),
(23, 'GC5767100215', 'Patricia Navarro', '2026-09-12 14:59:00'),
(24, 'GC4138633804', 'Isabel Navarro', '2026-09-26 15:38:00'),
(25, 'GC2543268479', 'Rafael Gonzales', '2026-09-26 12:03:00'),
(28, 'GC6890807713', 'Rafael Valdez', '2026-10-17 17:00:00'),
(29, 'GC1227381032', 'Sofia Lopez', '2026-10-17 11:31:00');

-- --------------------------------------------------------

--
-- Table structure for table `history_logs`
--

CREATE TABLE `history_logs` (
  `history_log_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `affected_table_name` varchar(100) NOT NULL,
  `affected_record_id` varchar(100) NOT NULL,
  `action_type` varchar(30) NOT NULL,
  `previous_record_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`previous_record_values`)),
  `revised_record_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`revised_record_values`)),
  `action_description` text DEFAULT NULL,
  `action_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history_logs`
--

INSERT INTO `history_logs` (`history_log_id`, `user_id`, `affected_table_name`, `affected_record_id`, `action_type`, `previous_record_values`, `revised_record_values`, `action_description`, `action_date`) VALUES
(1, 2, 'menu_item_variants', '1', 'UPDATE', '{\"selling_price\": \"65.00\"}', '{\"selling_price\": \"70.00\"}', 'Bean cost increase', '2026-07-01 09:00:00'),
(2, 2, 'menu_item_variants', '6', 'UPDATE', '{\"selling_price\": \"115.00\"}', '{\"selling_price\": \"120.00\"}', 'Milk cost increase', '2026-08-03 09:00:00'),
(3, 1, 'menu_item_variants', '13', 'UPDATE', '{\"selling_price\": \"110.00\"}', '{\"selling_price\": \"120.00\"}', 'Menu repricing', '2026-09-01 09:00:00'),
(4, 1, 'discounts', '3', 'INSERT', NULL, '{\"discount_name\": \"Grand Opening Promo 10%\"}', 'Created opening promo', '2026-05-19 07:45:00'),
(5, 2, 'inventory_adjustments', '1', 'INSERT', NULL, '{\"ingredient_id\": 4, \"adjustment_quantity\": \"-2.000\"}', 'Recorded milk spoilage', '2026-06-23 18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL,
  `ingredient_category_id` int(11) NOT NULL,
  `ingredient_name` varchar(150) NOT NULL,
  `ingredient_unit` varchar(30) NOT NULL,
  `ingredient_stock_quantity` decimal(12,3) NOT NULL DEFAULT 0.000,
  `minimum_stock_quantity` decimal(12,3) NOT NULL DEFAULT 0.000,
  `ingredient_unit_cost` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `ingredient_storage_location` varchar(150) DEFAULT NULL,
  `ingredient_status` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `ingredient_category_id`, `ingredient_name`, `ingredient_unit`, `ingredient_stock_quantity`, `minimum_stock_quantity`, `ingredient_unit_cost`, `ingredient_storage_location`, `ingredient_status`) VALUES
(1, 1, 'Espresso Beans', 'kg', 18.500, 5.000, 950.0000, 'Dry storage', 'Available'),
(2, 1, 'Matcha Powder', 'kg', 1.500, 0.500, 3200.0000, 'Dry storage', 'Available'),
(3, 1, 'Cocoa Powder', 'kg', 4.000, 1.000, 520.0000, 'Dry storage', 'Available'),
(4, 2, 'Fresh Milk', 'l', 40.000, 10.000, 95.0000, 'Chiller', 'Available'),
(5, 2, 'Eggs', 'tray', 10.000, 3.000, 210.0000, 'Chiller', 'Available'),
(6, 2, 'Slice Cheese', 'pack', 12.000, 4.000, 180.0000, 'Chiller', 'Available'),
(7, 3, 'Hotdog', 'kg', 6.000, 2.000, 220.0000, 'Freezer', 'Available'),
(8, 3, 'Cornbeef', 'can', 24.000, 6.000, 85.0000, 'Dry storage', 'Available'),
(9, 3, 'Spam', 'can', 18.000, 6.000, 160.0000, 'Dry storage', 'Available'),
(10, 3, 'Pork Chop', 'kg', 8.000, 3.000, 330.0000, 'Freezer', 'Available'),
(11, 4, 'Rice', 'kg', 50.000, 15.000, 55.0000, 'Dry storage', 'Available'),
(12, 1, 'Strawberry Syrup', 'l', 4.000, 1.000, 380.0000, 'Dry storage', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_categories`
--

CREATE TABLE `ingredient_categories` (
  `ingredient_category_id` int(11) NOT NULL,
  `ingredient_category_name` varchar(100) NOT NULL,
  `ingredient_category_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredient_categories`
--

INSERT INTO `ingredient_categories` (`ingredient_category_id`, `ingredient_category_name`, `ingredient_category_description`) VALUES
(1, 'Coffee & Drink Mixes', 'Beans, matcha, cocoa and syrups'),
(2, 'Dairy & Eggs', 'Milk, eggs and cheese'),
(3, 'Meat & Frozen', 'Hotdog, cornbeef, spam and pork'),
(4, 'Rice & Pantry', 'Rice and dry goods');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_stock_batches`
--

CREATE TABLE `ingredient_stock_batches` (
  `ingredient_stock_batch_id` int(11) NOT NULL,
  `receiving_item_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `supplier_batch_number` varchar(100) DEFAULT NULL,
  `batch_quantity_received` decimal(12,3) NOT NULL,
  `batch_quantity_remaining` decimal(12,3) NOT NULL,
  `batch_receiving_date` date NOT NULL,
  `batch_expiration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredient_stock_batches`
--

INSERT INTO `ingredient_stock_batches` (`ingredient_stock_batch_id`, `receiving_item_id`, `ingredient_id`, `supplier_batch_number`, `batch_quantity_received`, `batch_quantity_remaining`, `batch_receiving_date`, `batch_expiration_date`) VALUES
(1, 1, 1, 'HC-0521', 10.000, 2.500, '2026-05-21', '2026-11-21'),
(2, 3, 4, 'BD-0521', 30.000, 0.000, '2026-05-21', '2026-06-21'),
(3, 5, 7, 'MF-0712', 5.000, 2.000, '2026-07-12', '2026-10-12'),
(4, 7, 11, 'TR-0812', 50.000, 28.000, '2026-08-12', '2027-02-12');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_adjustments`
--

CREATE TABLE `inventory_adjustments` (
  `inventory_adjustment_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `adjusted_by_user_id` int(11) NOT NULL,
  `adjustment_quantity` decimal(12,3) NOT NULL,
  `adjustment_reason` varchar(40) NOT NULL,
  `adjustment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `adjustment_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_adjustments`
--

INSERT INTO `inventory_adjustments` (`inventory_adjustment_id`, `ingredient_id`, `adjusted_by_user_id`, `adjustment_quantity`, `adjustment_reason`, `adjustment_date`, `adjustment_notes`) VALUES
(1, 4, 7, -2.000, 'Spoilage', '2026-06-23 18:00:00', 'Milk expired'),
(2, 5, 8, -1.000, 'Damaged', '2026-07-22 14:00:00', 'Cracked eggs in the tray');

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_transactions`
--

CREATE TABLE `loyalty_transactions` (
  `loyalty_transaction_id` int(11) NOT NULL,
  `customer_loyalty_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `reward_id` int(11) DEFAULT NULL,
  `recorded_by_user_id` int(11) NOT NULL,
  `loyalty_transaction_type` varchar(20) NOT NULL,
  `loyalty_points_changed` int(11) NOT NULL,
  `loyalty_transaction_date` datetime NOT NULL DEFAULT current_timestamp(),
  `loyalty_transaction_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loyalty_transactions`
--

INSERT INTO `loyalty_transactions` (`loyalty_transaction_id`, `customer_loyalty_id`, `order_id`, `reward_id`, `recorded_by_user_id`, `loyalty_transaction_type`, `loyalty_points_changed`, `loyalty_transaction_date`, `loyalty_transaction_notes`) VALUES
(1, 1, 3, NULL, 4, 'Earn', 6, '2026-05-23 12:38:00', 'Points earned from order'),
(2, 1, 7, NULL, 4, 'Earn', 19, '2026-06-20 12:40:00', 'Points earned from order'),
(3, 1, 8, NULL, 4, 'Earn', 19, '2026-06-20 12:56:00', 'Points earned from order'),
(4, 1, 10, NULL, 4, 'Earn', 21, '2026-07-11 12:40:00', 'Points earned from order'),
(5, 5, 11, NULL, 4, 'Earn', 23, '2026-07-11 16:27:00', 'Points earned from order'),
(6, 5, 12, NULL, 4, 'Earn', 13, '2026-07-11 14:18:00', 'Points earned from order'),
(7, 1, 14, NULL, 4, 'Earn', 24, '2026-07-25 16:19:00', 'Points earned from order'),
(8, 1, 18, 1, 4, 'Redeem', -30, '2026-08-08 11:53:00', 'Redeemed PHP 25 Off reward'),
(9, 1, 18, NULL, 4, 'Earn', 9, '2026-08-08 11:53:00', 'Points earned from order');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `menu_item_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `menu_item_name` varchar(150) NOT NULL,
  `menu_item_description` text DEFAULT NULL,
  `menu_item_availability` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`menu_item_id`, `category_id`, `menu_item_name`, `menu_item_description`, `menu_item_availability`) VALUES
(1, 1, 'Americano', 'Espresso shot with water', 'Available'),
(2, 1, 'Cappucino', 'Espresso, steamed milk and foam', 'Available'),
(3, 1, 'Cafe Latte', 'Unsweetened coffee and milk', 'Available'),
(4, 2, 'Spanish Latte', 'Espresso with milk and sweetened condensed milk', 'Available'),
(5, 2, 'Caramel Macchiato', 'Vanilla syrup, milk, a shot of espresso and a drizzle of caramel sauce', 'Available'),
(6, 2, 'Dark Mocha', 'Cocoa powder, milk and freshly brewed espresso', 'Available'),
(7, 3, 'Dark Choco', 'Cocoa powder, milk and sugar syrup', 'Available'),
(8, 3, 'Strawberry Fusion', 'Strawberry milk and cream', 'Available'),
(9, 3, 'Ichigo Matcha', 'Matcha based drink mixed with milk and strawberry syrup', 'Available'),
(10, 4, 'Cucumber Lemonade', 'Cucumber juice, lemon juice and Yakult', 'Available'),
(11, 4, 'Green Apple Fizz', 'Green apple, lemon and soda', 'Available'),
(12, 5, 'Mango Shake', 'Ripe mango pieces, milk and white sauce', 'Available'),
(13, 5, 'Chocolate Iced Blended', 'Chocolate iced blended drink', 'Available'),
(14, 5, 'Strawberry Iced Blended', 'Strawberry iced blended drink', 'Available'),
(15, 6, 'Hotdog Meal', 'Hotdog and rice only', 'Available'),
(16, 6, 'Hotsilog', 'Hotdog, fried egg and mixed vegetables', 'Available'),
(17, 6, 'Cornbeef Meal', 'Cornbeef and rice only', 'Available'),
(18, 6, 'Cornsilog', 'Cornbeef, fried egg and mixed vegetables', 'Available'),
(19, 6, 'Lumpia Meal', 'Lumpia and rice only', 'Available'),
(20, 6, 'Lumpiasilog', 'Lumpia, fried egg and mixed vegetables', 'Available'),
(21, 6, 'Spam Meal', 'Spam and rice only', 'Available'),
(22, 6, 'Spamsilog', 'Spam, fried egg and mixed vegetables', 'Available'),
(23, 6, 'Porkchop', 'Porkchop and stirred fried green bean', 'Available'),
(24, 6, 'Bangsilog', 'Bangus, rice, egg with cucumber and tomato', 'Available'),
(25, 6, 'Sisig', 'Pork sisig, rice and egg', 'Available'),
(26, 7, 'Ramen', 'Chashu pork and soft-boiled mayak egg', 'Available'),
(27, 7, 'Ham Overload Sandwich', 'Ham, egg, cheese, lettuce, cucumber, tomato and dressing', 'Available'),
(28, 7, 'Fries Solo', 'BBQ, sour cream or cheese flavor', 'Available'),
(29, 7, 'Barkadahan Combo', 'Fries with your choice of flavored powder and tempura', 'Available'),
(30, 7, 'Siomai', 'Available in chicken, japanese or beef flavors', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_add_ons`
--

CREATE TABLE `menu_item_add_ons` (
  `menu_item_id` int(11) NOT NULL,
  `add_on_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item_add_ons`
--

INSERT INTO `menu_item_add_ons` (`menu_item_id`, `add_on_id`) VALUES
(1, 4),
(2, 4),
(3, 4),
(15, 2),
(17, 2),
(23, 1),
(23, 2),
(27, 5);

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_price_history`
--

CREATE TABLE `menu_item_price_history` (
  `menu_item_price_history_id` int(11) NOT NULL,
  `menu_item_variant_id` int(11) NOT NULL,
  `previous_selling_price` decimal(10,2) NOT NULL,
  `revised_selling_price` decimal(10,2) NOT NULL,
  `price_change_date` datetime NOT NULL DEFAULT current_timestamp(),
  `revised_by_user_id` int(11) NOT NULL,
  `price_change_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item_price_history`
--

INSERT INTO `menu_item_price_history` (`menu_item_price_history_id`, `menu_item_variant_id`, `previous_selling_price`, `revised_selling_price`, `price_change_date`, `revised_by_user_id`, `price_change_reason`) VALUES
(1, 1, 65.00, 70.00, '2026-07-01 09:00:00', 2, 'Bean cost increase'),
(2, 6, 115.00, 120.00, '2026-08-03 09:00:00', 2, 'Milk cost increase'),
(3, 13, 110.00, 120.00, '2026-09-01 09:00:00', 1, 'Menu repricing');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_variants`
--

CREATE TABLE `menu_item_variants` (
  `menu_item_variant_id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `serving_size_description` varchar(100) DEFAULT NULL,
  `variant_availability` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item_variants`
--

INSERT INTO `menu_item_variants` (`menu_item_variant_id`, `menu_item_id`, `variant_id`, `selling_price`, `serving_size_description`, `variant_availability`) VALUES
(1, 1, 1, 70.00, 'Hot cup', 'Available'),
(2, 1, 2, 79.00, 'Iced cup', 'Available'),
(3, 2, 1, 100.00, 'Hot cup', 'Available'),
(4, 2, 2, 110.00, 'Iced cup', 'Available'),
(5, 3, 1, 110.00, 'Hot cup', 'Available'),
(6, 3, 2, 120.00, 'Iced cup', 'Available'),
(7, 4, 1, 125.00, 'Hot cup', 'Available'),
(8, 4, 2, 139.00, 'Iced cup', 'Available'),
(9, 5, 1, 139.00, 'Hot cup', 'Available'),
(10, 5, 2, 145.00, 'Iced cup', 'Available'),
(11, 6, 1, 139.00, 'Hot cup', 'Available'),
(12, 6, 2, 145.00, 'Iced cup', 'Available'),
(13, 7, 3, 120.00, 'Cup', 'Available'),
(14, 8, 3, 120.00, 'Cup', 'Available'),
(15, 9, 3, 120.00, 'Cup', 'Available'),
(16, 10, 3, 99.00, 'Cup', 'Available'),
(17, 11, 3, 99.00, 'Cup', 'Available'),
(18, 12, 3, 120.00, 'Cup', 'Available'),
(19, 13, 3, 149.00, 'Cup', 'Available'),
(20, 14, 3, 149.00, 'Cup', 'Available'),
(21, 15, 3, 60.00, 'Plate', 'Available'),
(22, 16, 3, 90.00, 'Plate', 'Available'),
(23, 17, 3, 60.00, 'Plate', 'Available'),
(24, 18, 3, 90.00, 'Plate', 'Available'),
(25, 19, 3, 60.00, 'Plate', 'Available'),
(26, 20, 3, 90.00, 'Plate', 'Available'),
(27, 21, 3, 60.00, 'Plate', 'Available'),
(28, 22, 3, 90.00, 'Plate', 'Available'),
(29, 23, 3, 100.00, 'Plate', 'Available'),
(30, 24, 3, 135.00, 'Plate', 'Available'),
(31, 25, 3, 150.00, 'Plate', 'Available'),
(32, 26, 3, 180.00, 'Serving', 'Available'),
(33, 27, 3, 130.00, 'Serving', 'Available'),
(34, 28, 3, 60.00, 'Serving', 'Available'),
(35, 29, 3, 150.00, 'Serving', 'Available'),
(36, 30, 4, 50.00, 'Serving', 'Available'),
(37, 30, 5, 50.00, 'Serving', 'Available'),
(38, 30, 6, 50.00, 'Serving', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `operating_expenses`
--

CREATE TABLE `operating_expenses` (
  `expense_id` int(11) NOT NULL,
  `recorded_by_user_id` int(11) NOT NULL,
  `expense_category` varchar(80) NOT NULL,
  `expense_name` varchar(150) NOT NULL,
  `expense_description` text DEFAULT NULL,
  `expense_amount` decimal(12,2) NOT NULL,
  `expense_date` date NOT NULL,
  `expense_payment_method` varchar(50) DEFAULT NULL,
  `expense_reference_number` varchar(150) DEFAULT NULL,
  `expense_status` varchar(20) NOT NULL DEFAULT 'Paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `operating_expenses`
--

INSERT INTO `operating_expenses` (`expense_id`, `recorded_by_user_id`, `expense_category`, `expense_name`, `expense_description`, `expense_amount`, `expense_date`, `expense_payment_method`, `expense_reference_number`, `expense_status`) VALUES
(1, 2, 'Salaries', 'May Staff Payroll', 'May payroll for cafe staff', 24000.00, '2026-05-31', 'GCash', 'EXP-0001', 'Paid'),
(2, 2, 'Rent', 'June Rent', 'Monthly rent, Abello St. store', 15000.00, '2026-06-01', 'Cash', 'EXP-0002', 'Paid'),
(3, 2, 'Utilities', 'May Electricity Bill', 'May electricity, Talakag store', 4600.00, '2026-06-05', 'GCash', 'EXP-0003', 'Paid'),
(4, 2, 'Salaries', 'June Staff Payroll', 'June payroll for cafe staff', 24000.00, '2026-06-30', 'GCash', 'EXP-0004', 'Paid'),
(5, 2, 'Rent', 'July Rent', 'Monthly rent, Abello St. store', 15000.00, '2026-07-01', 'Cash', 'EXP-0005', 'Paid'),
(6, 2, 'Utilities', 'June Electricity Bill', 'June electricity, Talakag store', 5100.00, '2026-07-05', 'GCash', 'EXP-0006', 'Paid'),
(7, 2, 'Salaries', 'July Staff Payroll', 'July payroll for cafe staff', 24000.00, '2026-07-31', 'GCash', 'EXP-0007', 'Paid'),
(8, 2, 'Rent', 'August Rent', 'Monthly rent, Abello St. store', 15000.00, '2026-08-01', 'Cash', 'EXP-0008', 'Paid'),
(9, 2, 'Utilities', 'July Electricity Bill', 'July electricity, Talakag store', 5300.00, '2026-08-05', 'GCash', 'EXP-0009', 'Paid'),
(10, 2, 'Salaries', 'August Staff Payroll', 'August payroll for cafe staff', 24000.00, '2026-08-31', 'GCash', 'EXP-0010', 'Paid'),
(11, 2, 'Rent', 'September Rent', 'Monthly rent, Abello St. store', 15000.00, '2026-09-01', 'Cash', 'EXP-0011', 'Paid'),
(12, 2, 'Utilities', 'August Electricity Bill', 'August electricity, Talakag store', 5250.00, '2026-09-05', 'GCash', 'EXP-0012', 'Paid'),
(13, 2, 'Salaries', 'September Staff Payroll', 'September payroll for cafe staff', 24000.00, '2026-09-30', 'GCash', 'EXP-0013', 'Paid'),
(14, 2, 'Rent', 'October Rent', 'Monthly rent, Abello St. store', 15000.00, '2026-10-01', 'Cash', 'EXP-0014', 'Paid'),
(15, 2, 'Utilities', 'September Electricity Bill', 'September electricity, Talakag store', 5200.00, '2026-10-05', 'GCash', 'EXP-0015', 'Paid');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `processed_by_staff_id` int(11) NOT NULL,
  `pos_id` int(11) NOT NULL,
  `pos_session_id` int(11) NOT NULL,
  `order_channel` varchar(30) NOT NULL,
  `order_type` varchar(20) NOT NULL,
  `order_status` varchar(25) NOT NULL DEFAULT 'Pending',
  `order_placement_date` datetime NOT NULL DEFAULT current_timestamp(),
  `order_subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `order_discount_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `order_delivery_fee` decimal(10,2) NOT NULL DEFAULT 0.00,
  `order_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `order_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `processed_by_staff_id`, `pos_id`, `pos_session_id`, `order_channel`, `order_type`, `order_status`, `order_placement_date`, `order_subtotal`, `order_discount_total`, `order_delivery_fee`, `order_total`, `order_notes`) VALUES
(1, NULL, 6, 1, 1, 'POS', 'Take-out', 'Completed', '2026-05-23 15:03:00', 120.00, 0.00, 0.00, 120.00, NULL),
(2, NULL, 4, 2, 1, 'POS', 'Dine-in', 'Completed', '2026-05-23 16:16:00', 135.00, 13.50, 0.00, 121.50, NULL),
(3, 1, 6, 1, 1, 'POS', 'Dine-in', 'Completed', '2026-05-23 12:38:00', 60.00, 0.00, 0.00, 60.00, NULL),
(4, NULL, 4, 2, 2, 'POS', 'Take-out', 'Completed', '2026-06-06 10:13:00', 139.00, 0.00, 0.00, 139.00, NULL),
(5, NULL, 6, 1, 2, 'POS', 'Take-out', 'Completed', '2026-06-06 13:40:00', 60.00, 6.00, 0.00, 54.00, NULL),
(6, NULL, 6, 2, 2, 'POS', 'Take-out', 'Completed', '2026-06-06 16:07:00', 120.00, 0.00, 0.00, 120.00, NULL),
(7, 1, 5, 1, 3, 'POS', 'Dine-in', 'Completed', '2026-06-20 12:40:00', 198.00, 0.00, 0.00, 198.00, NULL),
(8, 1, 6, 2, 3, 'Phone', 'Delivery', 'Completed', '2026-06-20 12:56:00', 160.00, 0.00, 30.00, 190.00, NULL),
(9, NULL, 5, 1, 3, 'POS', 'Dine-in', 'Completed', '2026-06-20 12:34:00', 278.00, 0.00, 0.00, 278.00, NULL),
(10, 1, 5, 2, 4, 'POS', 'Take-out', 'Completed', '2026-07-11 12:40:00', 219.00, 0.00, 0.00, 219.00, NULL),
(11, 5, 6, 1, 4, 'POS', 'Take-out', 'Completed', '2026-07-11 16:27:00', 290.00, 58.00, 0.00, 232.00, NULL),
(12, 5, 6, 2, 4, 'POS', 'Dine-in', 'Completed', '2026-07-11 14:18:00', 135.00, 0.00, 0.00, 135.00, NULL),
(13, 2, 4, 1, 5, 'Phone', 'Delivery', 'Completed', '2026-07-25 10:34:00', 460.00, 0.00, 30.00, 490.00, NULL),
(14, 1, 4, 2, 5, 'POS', 'Dine-in', 'Completed', '2026-07-25 16:19:00', 240.00, 0.00, 0.00, 240.00, NULL),
(15, 6, 4, 1, 5, 'POS', 'Dine-in', 'Completed', '2026-07-25 14:18:00', 139.00, 0.00, 0.00, 139.00, NULL),
(16, 6, 6, 2, 6, 'POS', 'Take-out', 'Completed', '2026-08-08 16:36:00', 120.00, 0.00, 0.00, 120.00, NULL),
(17, NULL, 5, 1, 6, 'POS', 'Take-out', 'Completed', '2026-08-08 14:43:00', 120.00, 0.00, 0.00, 120.00, NULL),
(18, 1, 6, 2, 6, 'POS', 'Dine-in', 'Completed', '2026-08-08 11:53:00', 120.00, 25.00, 0.00, 95.00, NULL),
(19, 3, 4, 1, 7, 'Phone', 'Delivery', 'Completed', '2026-08-22 13:51:00', 60.00, 0.00, 30.00, 90.00, NULL),
(20, NULL, 6, 2, 7, 'POS', 'Take-out', 'Completed', '2026-08-22 15:04:00', 90.00, 0.00, 0.00, 90.00, NULL),
(21, 6, 6, 1, 7, 'POS', 'Take-out', 'Completed', '2026-08-22 10:47:00', 195.00, 0.00, 0.00, 195.00, NULL),
(22, 5, 5, 2, 8, 'POS', 'Dine-in', 'Completed', '2026-09-12 14:21:00', 120.00, 24.00, 0.00, 96.00, NULL),
(23, NULL, 4, 1, 8, 'POS', 'Take-out', 'Completed', '2026-09-12 14:54:00', 458.00, 0.00, 0.00, 458.00, NULL),
(24, NULL, 4, 2, 8, 'POS', 'Take-out', 'Cancelled', '2026-09-12 12:47:00', 120.00, 0.00, 0.00, 120.00, 'Customer cancelled before payment'),
(25, NULL, 5, 1, 9, 'POS', 'Take-out', 'Completed', '2026-09-26 15:33:00', 150.00, 0.00, 0.00, 150.00, NULL),
(26, 4, 4, 2, 9, 'Phone', 'Delivery', 'Completed', '2026-09-26 11:58:00', 308.00, 0.00, 30.00, 338.00, NULL),
(27, NULL, 5, 1, 9, 'POS', 'Dine-in', 'Completed', '2026-09-26 17:14:00', 245.00, 49.00, 0.00, 196.00, NULL),
(28, NULL, 5, 2, 10, 'POS', 'Take-out', 'Completed', '2026-10-17 16:54:00', 50.00, 0.00, 0.00, 50.00, NULL),
(29, 6, 4, 1, 10, 'POS', 'Take-out', 'Completed', '2026-10-17 16:55:00', 240.00, 0.00, 0.00, 240.00, NULL),
(30, 6, 4, 2, 10, 'POS', 'Take-out', 'Completed', '2026-10-17 11:26:00', 120.00, 0.00, 0.00, 120.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_discounts`
--

CREATE TABLE `order_discounts` (
  `order_discount_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `applied_by_user_id` int(11) NOT NULL,
  `applied_discount_amount` decimal(12,2) NOT NULL,
  `discount_application_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_discounts`
--

INSERT INTO `order_discounts` (`order_discount_id`, `order_id`, `discount_id`, `applied_by_user_id`, `applied_discount_amount`, `discount_application_date`) VALUES
(1, 2, 3, 4, 13.50, '2026-05-23 16:16:00'),
(2, 5, 3, 6, 6.00, '2026-06-06 13:40:00'),
(3, 11, 1, 6, 58.00, '2026-07-11 16:27:00'),
(4, 18, 2, 6, 25.00, '2026-08-08 11:53:00'),
(5, 22, 1, 5, 24.00, '2026-09-12 14:21:00'),
(6, 27, 1, 5, 49.00, '2026-09-26 17:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `menu_item_variant_id` int(11) NOT NULL,
  `ordered_item_name` varchar(150) NOT NULL,
  `ordered_variant_name` varchar(80) NOT NULL,
  `ordered_quantity` int(11) NOT NULL,
  `ordered_unit_price` decimal(10,2) NOT NULL,
  `ordered_line_total` decimal(12,2) NOT NULL,
  `item_special_instructions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `menu_item_variant_id`, `ordered_item_name`, `ordered_variant_name`, `ordered_quantity`, `ordered_unit_price`, `ordered_line_total`, `item_special_instructions`) VALUES
(1, 1, 15, 'Ichigo Matcha', 'Regular', 1, 120.00, 120.00, NULL),
(2, 2, 30, 'Bangsilog', 'Regular', 1, 135.00, 135.00, NULL),
(3, 3, 27, 'Spam Meal', 'Regular', 1, 60.00, 60.00, NULL),
(4, 4, 8, 'Spanish Latte', 'Cold', 1, 139.00, 139.00, NULL),
(5, 5, 34, 'Fries Solo', 'Regular', 1, 60.00, 60.00, NULL),
(6, 6, 18, 'Mango Shake', 'Regular', 1, 120.00, 120.00, NULL),
(7, 7, 16, 'Cucumber Lemonade', 'Regular', 2, 99.00, 198.00, NULL),
(8, 8, 4, 'Cappucino', 'Cold', 1, 110.00, 110.00, NULL),
(9, 9, 11, 'Dark Mocha', 'Hot', 2, 139.00, 278.00, NULL),
(10, 10, 23, 'Cornbeef Meal', 'Regular', 1, 60.00, 60.00, NULL),
(11, 10, 9, 'Caramel Macchiato', 'Hot', 1, 139.00, 139.00, NULL),
(12, 11, 10, 'Caramel Macchiato', 'Cold', 2, 145.00, 290.00, NULL),
(13, 12, 30, 'Bangsilog', 'Regular', 1, 135.00, 135.00, NULL),
(14, 13, 37, 'Siomai', 'Japanese', 2, 50.00, 100.00, NULL),
(15, 13, 32, 'Ramen', 'Regular', 2, 180.00, 360.00, NULL),
(16, 14, 14, 'Strawberry Fusion', 'Regular', 2, 120.00, 240.00, NULL),
(17, 15, 8, 'Spanish Latte', 'Cold', 1, 139.00, 139.00, NULL),
(18, 16, 21, 'Hotdog Meal', 'Regular', 1, 60.00, 60.00, NULL),
(19, 16, 34, 'Fries Solo', 'Regular', 1, 60.00, 60.00, NULL),
(20, 17, 25, 'Lumpia Meal', 'Regular', 2, 60.00, 120.00, NULL),
(21, 18, 6, 'Cafe Latte', 'Cold', 1, 120.00, 120.00, NULL),
(22, 19, 34, 'Fries Solo', 'Regular', 1, 60.00, 60.00, NULL),
(23, 20, 22, 'Hotsilog', 'Regular', 1, 90.00, 90.00, NULL),
(24, 21, 34, 'Fries Solo', 'Regular', 1, 60.00, 60.00, NULL),
(25, 21, 30, 'Bangsilog', 'Regular', 1, 135.00, 135.00, NULL),
(26, 22, 27, 'Spam Meal', 'Regular', 2, 60.00, 120.00, NULL),
(27, 23, 35, 'Barkadahan Combo', 'Regular', 2, 150.00, 300.00, NULL),
(28, 23, 2, 'Americano', 'Cold', 2, 79.00, 158.00, NULL),
(29, 24, 14, 'Strawberry Fusion', 'Regular', 1, 120.00, 120.00, NULL),
(30, 25, 31, 'Sisig', 'Regular', 1, 150.00, 150.00, NULL),
(31, 26, 2, 'Americano', 'Cold', 2, 79.00, 158.00, NULL),
(32, 26, 3, 'Cappucino', 'Hot', 1, 100.00, 100.00, NULL),
(33, 27, 12, 'Dark Mocha', 'Cold', 1, 145.00, 145.00, NULL),
(34, 27, 36, 'Siomai', 'Chicken', 2, 50.00, 100.00, NULL),
(35, 28, 36, 'Siomai', 'Chicken', 1, 50.00, 50.00, NULL),
(36, 29, 34, 'Fries Solo', 'Regular', 2, 60.00, 120.00, NULL),
(37, 29, 18, 'Mango Shake', 'Regular', 1, 120.00, 120.00, NULL),
(38, 30, 34, 'Fries Solo', 'Regular', 2, 60.00, 120.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_item_add_ons`
--

CREATE TABLE `order_item_add_ons` (
  `order_item_add_on_id` int(11) NOT NULL,
  `order_item_id` int(11) NOT NULL,
  `add_on_id` int(11) NOT NULL,
  `ordered_add_on_name` varchar(100) NOT NULL,
  `ordered_add_on_quantity` int(11) NOT NULL DEFAULT 1,
  `ordered_add_on_unit_price` decimal(10,2) NOT NULL,
  `ordered_add_on_total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_item_add_ons`
--

INSERT INTO `order_item_add_ons` (`order_item_add_on_id`, `order_item_id`, `add_on_id`, `ordered_add_on_name`, `ordered_add_on_quantity`, `ordered_add_on_unit_price`, `ordered_add_on_total`) VALUES
(1, 8, 4, 'Espresso Shot', 1, 50.00, 50.00),
(2, 10, 2, 'Fried Egg', 1, 20.00, 20.00),
(3, 32, 4, 'Espresso Shot', 1, 50.00, 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `recorded_by_user_id` int(11) NOT NULL,
  `payment_amount` decimal(12,2) NOT NULL,
  `payment_status` varchar(25) NOT NULL DEFAULT 'Pending Verification',
  `payment_recording_date` datetime NOT NULL DEFAULT current_timestamp(),
  `payment_verification_date` datetime DEFAULT NULL,
  `verified_by_user_id` int(11) DEFAULT NULL,
  `payment_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_method_id`, `recorded_by_user_id`, `payment_amount`, `payment_status`, `payment_recording_date`, `payment_verification_date`, `verified_by_user_id`, `payment_notes`) VALUES
(1, 1, 1, 6, 120.00, 'Paid', '2026-05-23 15:05:00', NULL, NULL, NULL),
(2, 2, 1, 4, 121.50, 'Paid', '2026-05-23 16:18:00', NULL, NULL, NULL),
(3, 3, 1, 6, 60.00, 'Paid', '2026-05-23 12:40:00', NULL, NULL, NULL),
(4, 4, 4, 4, 139.00, 'Verified', '2026-06-06 10:15:00', '2026-06-06 10:18:00', 2, NULL),
(5, 5, 3, 6, 54.00, 'Verified', '2026-06-06 13:42:00', '2026-06-06 13:45:00', 2, NULL),
(6, 6, 1, 6, 120.00, 'Paid', '2026-06-06 16:09:00', NULL, NULL, NULL),
(7, 7, 1, 5, 198.00, 'Paid', '2026-06-20 12:42:00', NULL, NULL, NULL),
(8, 8, 2, 6, 190.00, 'Verified', '2026-06-20 12:58:00', '2026-06-20 13:01:00', 2, NULL),
(9, 9, 1, 5, 278.00, 'Paid', '2026-06-20 12:36:00', NULL, NULL, NULL),
(10, 10, 2, 5, 219.00, 'Verified', '2026-07-11 12:42:00', '2026-07-11 12:45:00', 2, NULL),
(11, 11, 1, 6, 232.00, 'Paid', '2026-07-11 16:29:00', NULL, NULL, NULL),
(12, 12, 1, 6, 135.00, 'Paid', '2026-07-11 14:20:00', NULL, NULL, NULL),
(13, 13, 5, 4, 490.00, 'Verified', '2026-07-25 10:36:00', '2026-07-25 10:39:00', 2, NULL),
(14, 14, 3, 4, 240.00, 'Verified', '2026-07-25 16:21:00', '2026-07-25 16:24:00', 2, NULL),
(15, 15, 1, 4, 139.00, 'Paid', '2026-07-25 14:20:00', NULL, NULL, NULL),
(16, 16, 2, 6, 120.00, 'Verified', '2026-08-08 16:38:00', '2026-08-08 16:41:00', 2, NULL),
(17, 17, 1, 5, 120.00, 'Paid', '2026-08-08 14:45:00', NULL, NULL, NULL),
(18, 18, 5, 6, 95.00, 'Verified', '2026-08-08 11:55:00', '2026-08-08 11:58:00', 2, NULL),
(19, 19, 3, 4, 90.00, 'Verified', '2026-08-22 13:53:00', '2026-08-22 13:56:00', 2, NULL),
(20, 20, 4, 6, 90.00, 'Verified', '2026-08-22 15:06:00', '2026-08-22 15:09:00', 2, NULL),
(21, 21, 1, 6, 195.00, 'Paid', '2026-08-22 10:49:00', NULL, NULL, NULL),
(22, 22, 5, 5, 96.00, 'Verified', '2026-09-12 14:23:00', '2026-09-12 14:26:00', 2, NULL),
(23, 23, 2, 4, 458.00, 'Verified', '2026-09-12 14:56:00', '2026-09-12 14:59:00', 2, NULL),
(24, 25, 2, 5, 150.00, 'Verified', '2026-09-26 15:35:00', '2026-09-26 15:38:00', 2, NULL),
(25, 26, 2, 4, 338.00, 'Verified', '2026-09-26 12:00:00', '2026-09-26 12:03:00', 2, NULL),
(26, 27, 1, 5, 196.00, 'Paid', '2026-09-26 17:16:00', NULL, NULL, NULL),
(27, 28, 5, 5, 50.00, 'Verified', '2026-10-17 16:56:00', '2026-10-17 16:59:00', 2, NULL),
(28, 29, 2, 4, 240.00, 'Verified', '2026-10-17 16:57:00', '2026-10-17 17:00:00', 2, NULL),
(29, 30, 2, 4, 120.00, 'Verified', '2026-10-17 11:28:00', '2026-10-17 11:31:00', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `payment_id` int(11) NOT NULL,
  `payment_verification_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`payment_id`, `payment_verification_notes`) VALUES
(4, 'Reference number matched with statement'),
(5, 'Reference number matched with statement'),
(8, 'Reference number matched with statement');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `payment_method_name` varchar(80) NOT NULL,
  `payment_channel_type` varchar(30) NOT NULL,
  `payment_method_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`payment_method_id`, `payment_method_name`, `payment_channel_type`, `payment_method_description`) VALUES
(1, 'Cash', 'Cash', 'Physical cash payment at the cafe'),
(2, 'GCash', 'E-Wallet', 'Manually recorded GCash payment with reference verification'),
(3, 'BDO Bank Transfer', 'Bank Transfer', 'Manually recorded online transfer through BDO'),
(4, 'BPI Bank Transfer', 'Bank Transfer', 'Manually recorded online transfer through BPI'),
(5, 'Card', 'Card', 'Card payment recorded by authorized staff');

-- --------------------------------------------------------

--
-- Table structure for table `pos`
--

CREATE TABLE `pos` (
  `pos_id` int(11) NOT NULL,
  `pos_name` varchar(100) NOT NULL,
  `pos_location` varchar(150) NOT NULL,
  `terminal_status` varchar(20) NOT NULL DEFAULT 'Operational'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pos`
--

INSERT INTO `pos` (`pos_id`, `pos_name`, `pos_location`, `terminal_status`) VALUES
(1, 'POS Counter 1', 'The Hive Cafe, Abello St., Brgy. 3, Talakag, Bukidnon - main counter', 'Operational'),
(2, 'POS Counter 2', 'The Hive Cafe, Abello St., Brgy. 3, Talakag, Bukidnon - takeout window', 'Operational');

-- --------------------------------------------------------

--
-- Table structure for table `pos_sessions`
--

CREATE TABLE `pos_sessions` (
  `pos_session_id` int(11) NOT NULL,
  `pos_id` int(11) NOT NULL,
  `opened_by_user_id` int(11) NOT NULL,
  `closed_by_user_id` int(11) DEFAULT NULL,
  `session_opening_date` datetime NOT NULL DEFAULT current_timestamp(),
  `session_closing_date` datetime DEFAULT NULL,
  `opening_cash_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `expected_closing_cash_amount` decimal(12,2) DEFAULT NULL,
  `actual_closing_cash_amount` decimal(12,2) DEFAULT NULL,
  `cash_variance_amount` decimal(12,2) DEFAULT NULL,
  `session_status` varchar(20) NOT NULL DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pos_sessions`
--

INSERT INTO `pos_sessions` (`pos_session_id`, `pos_id`, `opened_by_user_id`, `closed_by_user_id`, `session_opening_date`, `session_closing_date`, `opening_cash_amount`, `expected_closing_cash_amount`, `actual_closing_cash_amount`, `cash_variance_amount`, `session_status`) VALUES
(1, 1, 5, 5, '2026-05-23 08:00:00', '2026-05-23 19:00:00', 2000.00, 2301.50, 2301.50, 0.00, 'Closed'),
(2, 2, 6, 6, '2026-06-06 08:00:00', '2026-06-06 19:00:00', 2000.00, 2120.00, 2120.00, 0.00, 'Closed'),
(3, 1, 4, 4, '2026-06-20 08:00:00', '2026-06-20 19:00:00', 2000.00, 2476.00, 2456.00, -20.00, 'Closed'),
(4, 2, 5, 5, '2026-07-11 08:00:00', '2026-07-11 19:00:00', 2000.00, 2367.00, 2367.00, 0.00, 'Closed'),
(5, 1, 6, 6, '2026-07-25 08:00:00', '2026-07-25 19:00:00', 2000.00, 2139.00, 2139.00, 0.00, 'Closed'),
(6, 2, 4, 4, '2026-08-08 08:00:00', '2026-08-08 19:00:00', 2000.00, 2120.00, 2130.00, 10.00, 'Closed'),
(7, 1, 5, 5, '2026-08-22 08:00:00', '2026-08-22 19:00:00', 2000.00, 2195.00, 2195.00, 0.00, 'Closed'),
(8, 2, 6, 6, '2026-09-12 08:00:00', '2026-09-12 19:00:00', 2000.00, 2000.00, 2000.00, 0.00, 'Closed'),
(9, 1, 4, 4, '2026-09-26 08:00:00', '2026-09-26 19:00:00', 2000.00, 2196.00, 2186.00, -10.00, 'Closed'),
(10, 2, 5, 5, '2026-10-17 08:00:00', '2026-10-17 19:00:00', 2000.00, 2000.00, 2000.00, 0.00, 'Closed');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `purchase_item_id` int(11) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `ordered_quantity` decimal(12,3) NOT NULL,
  `agreed_unit_cost` decimal(12,4) NOT NULL,
  `ordered_line_cost` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`purchase_item_id`, `purchase_order_id`, `ingredient_id`, `ordered_quantity`, `agreed_unit_cost`, `ordered_line_cost`) VALUES
(1, 1, 1, 10.000, 950.0000, 9500.00),
(2, 1, 2, 1.000, 3200.0000, 3200.00),
(3, 2, 4, 30.000, 95.0000, 2850.00),
(4, 2, 5, 6.000, 210.0000, 1260.00),
(5, 3, 7, 5.000, 220.0000, 1100.00),
(6, 3, 10, 10.000, 330.0000, 3300.00),
(7, 4, 11, 50.000, 55.0000, 2750.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `purchase_order_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `prepared_by_user_id` int(11) NOT NULL,
  `purchase_order_date` date NOT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `purchase_order_status` varchar(25) NOT NULL DEFAULT 'Draft',
  `purchase_order_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `supplier_invoice_number` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`purchase_order_id`, `supplier_id`, `prepared_by_user_id`, `purchase_order_date`, `expected_delivery_date`, `purchase_order_status`, `purchase_order_total`, `supplier_invoice_number`) VALUES
(1, 1, 2, '2026-05-19', '2026-05-21', 'Received', 12700.00, 'INV-HC-1001'),
(2, 2, 2, '2026-05-19', '2026-05-21', 'Received', 4110.00, 'INV-BD-2044'),
(3, 3, 3, '2026-07-10', '2026-07-12', 'Received', 4400.00, 'INV-MF-3310'),
(4, 4, 2, '2026-08-12', '2026-08-12', 'Received', 2750.00, 'INV-TR-0872');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receipt_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `receipt_issue_date` datetime NOT NULL DEFAULT current_timestamp(),
  `receipt_print_date` datetime DEFAULT NULL,
  `receipt_total` decimal(12,2) NOT NULL,
  `receipt_file_reference` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`receipt_id`, `order_id`, `receipt_issue_date`, `receipt_print_date`, `receipt_total`, `receipt_file_reference`) VALUES
(1, 1, '2026-05-23 15:06:00', '2026-05-23 15:06:00', 120.00, 'receipts/RCP-00001.pdf'),
(2, 2, '2026-05-23 16:19:00', '2026-05-23 16:19:00', 121.50, 'receipts/RCP-00002.pdf'),
(3, 3, '2026-05-23 12:41:00', '2026-05-23 12:41:00', 60.00, 'receipts/RCP-00003.pdf'),
(4, 4, '2026-06-06 10:16:00', '2026-06-06 10:16:00', 139.00, 'receipts/RCP-00004.pdf'),
(5, 5, '2026-06-06 13:43:00', '2026-06-06 13:43:00', 54.00, 'receipts/RCP-00005.pdf'),
(6, 6, '2026-06-06 16:10:00', '2026-06-06 16:10:00', 120.00, 'receipts/RCP-00006.pdf'),
(7, 7, '2026-06-20 12:43:00', '2026-06-20 12:43:00', 198.00, 'receipts/RCP-00007.pdf'),
(8, 8, '2026-06-20 12:59:00', '2026-06-20 12:59:00', 190.00, 'receipts/RCP-00008.pdf'),
(9, 9, '2026-06-20 12:37:00', '2026-06-20 12:37:00', 278.00, 'receipts/RCP-00009.pdf'),
(10, 10, '2026-07-11 12:43:00', '2026-07-11 12:43:00', 219.00, 'receipts/RCP-00010.pdf'),
(11, 11, '2026-07-11 16:30:00', '2026-07-11 16:30:00', 232.00, 'receipts/RCP-00011.pdf'),
(12, 12, '2026-07-11 14:21:00', '2026-07-11 14:21:00', 135.00, 'receipts/RCP-00012.pdf'),
(13, 13, '2026-07-25 10:37:00', '2026-07-25 10:37:00', 490.00, 'receipts/RCP-00013.pdf'),
(14, 14, '2026-07-25 16:22:00', '2026-07-25 16:22:00', 240.00, 'receipts/RCP-00014.pdf'),
(15, 15, '2026-07-25 14:21:00', '2026-07-25 14:21:00', 139.00, 'receipts/RCP-00015.pdf'),
(16, 16, '2026-08-08 16:39:00', '2026-08-08 16:39:00', 120.00, 'receipts/RCP-00016.pdf'),
(17, 17, '2026-08-08 14:46:00', '2026-08-08 14:46:00', 120.00, 'receipts/RCP-00017.pdf'),
(18, 18, '2026-08-08 11:56:00', '2026-08-08 11:56:00', 95.00, 'receipts/RCP-00018.pdf'),
(19, 19, '2026-08-22 13:54:00', '2026-08-22 13:54:00', 90.00, 'receipts/RCP-00019.pdf'),
(20, 20, '2026-08-22 15:07:00', '2026-08-22 15:07:00', 90.00, 'receipts/RCP-00020.pdf'),
(21, 21, '2026-08-22 10:50:00', '2026-08-22 10:50:00', 195.00, 'receipts/RCP-00021.pdf'),
(22, 22, '2026-09-12 14:24:00', '2026-09-12 14:24:00', 96.00, 'receipts/RCP-00022.pdf'),
(23, 23, '2026-09-12 14:57:00', '2026-09-12 14:57:00', 458.00, 'receipts/RCP-00023.pdf'),
(24, 25, '2026-09-26 15:36:00', '2026-09-26 15:36:00', 150.00, 'receipts/RCP-00025.pdf'),
(25, 26, '2026-09-26 12:01:00', '2026-09-26 12:01:00', 338.00, 'receipts/RCP-00026.pdf'),
(26, 27, '2026-09-26 17:17:00', '2026-09-26 17:17:00', 196.00, 'receipts/RCP-00027.pdf'),
(27, 28, '2026-10-17 16:57:00', '2026-10-17 16:57:00', 50.00, 'receipts/RCP-00028.pdf'),
(28, 29, '2026-10-17 16:58:00', '2026-10-17 16:58:00', 240.00, 'receipts/RCP-00029.pdf'),
(29, 30, '2026-10-17 11:29:00', '2026-10-17 11:29:00', 120.00, 'receipts/RCP-00030.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `receiving`
--

CREATE TABLE `receiving` (
  `receiving_id` int(11) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `received_by_user_id` int(11) NOT NULL,
  `shipment_receiving_date` datetime NOT NULL DEFAULT current_timestamp(),
  `receiving_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receiving`
--

INSERT INTO `receiving` (`receiving_id`, `purchase_order_id`, `received_by_user_id`, `shipment_receiving_date`, `receiving_notes`) VALUES
(1, 1, 7, '2026-05-21 10:00:00', 'Complete delivery'),
(2, 2, 7, '2026-05-21 11:30:00', 'Complete delivery'),
(3, 3, 8, '2026-07-12 11:15:00', 'Complete delivery'),
(4, 4, 8, '2026-08-12 14:00:00', 'Picked up at the public market');

-- --------------------------------------------------------

--
-- Table structure for table `receiving_items`
--

CREATE TABLE `receiving_items` (
  `receiving_item_id` int(11) NOT NULL,
  `receiving_id` int(11) NOT NULL,
  `purchase_item_id` int(11) NOT NULL,
  `received_quantity` decimal(12,3) NOT NULL,
  `actual_unit_cost` decimal(12,4) NOT NULL,
  `receiving_item_condition` varchar(30) NOT NULL DEFAULT 'Accepted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receiving_items`
--

INSERT INTO `receiving_items` (`receiving_item_id`, `receiving_id`, `purchase_item_id`, `received_quantity`, `actual_unit_cost`, `receiving_item_condition`) VALUES
(1, 1, 1, 10.000, 950.0000, 'Accepted'),
(2, 1, 2, 1.000, 3200.0000, 'Accepted'),
(3, 2, 3, 30.000, 95.0000, 'Accepted'),
(4, 2, 4, 6.000, 210.0000, 'Accepted'),
(5, 3, 5, 5.000, 220.0000, 'Accepted'),
(6, 3, 6, 10.000, 330.0000, 'Accepted'),
(7, 4, 7, 50.000, 55.0000, 'Accepted');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipe_id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  `recipe_name` varchar(150) NOT NULL,
  `preparation_instructions` text DEFAULT NULL,
  `recipe_revision_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipe_id`, `menu_item_id`, `recipe_name`, `preparation_instructions`, `recipe_revision_date`) VALUES
(1, 3, 'Cafe Latte Recipe', 'Pull a double shot and add steamed milk.', '2026-05-19'),
(2, 7, 'Dark Choco Recipe', 'Mix cocoa powder with milk and sugar syrup.', '2026-05-19'),
(3, 16, 'Hotsilog Recipe', 'Fry the hotdog and egg, serve with rice and mixed vegetables.', '2026-05-19'),
(4, 23, 'Porkchop Recipe', 'Fry the porkchop, serve with rice and stirred green beans.', '2026-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredients`
--

CREATE TABLE `recipe_ingredients` (
  `recipe_ingredient_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `ingredient_quantity_required` decimal(12,3) NOT NULL,
  `ingredient_measurement_unit` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipe_ingredients`
--

INSERT INTO `recipe_ingredients` (`recipe_ingredient_id`, `recipe_id`, `ingredient_id`, `ingredient_quantity_required`, `ingredient_measurement_unit`) VALUES
(1, 1, 1, 0.018, 'kg'),
(2, 1, 4, 0.200, 'l'),
(3, 2, 3, 0.030, 'kg'),
(4, 2, 4, 0.200, 'l'),
(5, 3, 7, 0.100, 'kg'),
(6, 3, 5, 0.033, 'tray'),
(7, 3, 11, 0.150, 'kg'),
(8, 4, 10, 0.200, 'kg'),
(9, 4, 11, 0.150, 'kg');

-- --------------------------------------------------------

--
-- Table structure for table `redeem_rewards`
--

CREATE TABLE `redeem_rewards` (
  `reward_id` int(11) NOT NULL,
  `reward_name` varchar(120) NOT NULL,
  `reward_description` varchar(255) DEFAULT NULL,
  `reward_points_required` int(11) NOT NULL,
  `reward_discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reward_availability` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `redeem_rewards`
--

INSERT INTO `redeem_rewards` (`reward_id`, `reward_name`, `reward_description`, `reward_points_required`, `reward_discount_amount`, `reward_availability`) VALUES
(1, 'PHP 25 Off', 'Get PHP 25 off any order', 30, 25.00, 'Available'),
(2, 'PHP 50 Off', 'Get PHP 50 off any order', 100, 50.00, 'Available'),
(3, 'Free Fries Solo', 'Redeem one Fries Solo', 150, 60.00, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `generated_by_user_id` int(11) NOT NULL,
  `report_name` varchar(150) NOT NULL,
  `report_type` varchar(60) NOT NULL,
  `report_start_date` date NOT NULL,
  `report_end_date` date NOT NULL,
  `report_generation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `report_file_reference` varchar(255) DEFAULT NULL,
  `report_summary` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`report_id`, `generated_by_user_id`, `report_name`, `report_type`, `report_start_date`, `report_end_date`, `report_generation_date`, `report_file_reference`, `report_summary`) VALUES
(1, 1, 'August Sales Report', 'Sales', '2026-08-01', '2026-08-31', '2026-09-01 08:00:00', 'reports/sales-2026-08.pdf', 'Net sales PHP 680.00 from 6 completed orders.'),
(2, 1, 'September Sales Report', 'Sales', '2026-09-01', '2026-09-30', '2026-10-01 08:00:00', 'reports/sales-2026-09.pdf', 'Net sales PHP 1,208.00 from 5 completed orders.'),
(3, 2, 'Inventory Report May-Sep', 'Inventory', '2026-05-19', '2026-09-30', '2026-10-02 08:00:00', 'reports/inventory-2026-05-09.pdf', 'Stock levels and adjustments since opening.');

-- --------------------------------------------------------

--
-- Table structure for table `returns_refunds`
--

CREATE TABLE `returns_refunds` (
  `return_refund_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `approved_by_user_id` int(11) NOT NULL,
  `return_refund_reason` varchar(255) NOT NULL,
  `return_refund_amount` decimal(12,2) NOT NULL,
  `return_refund_status` varchar(25) NOT NULL DEFAULT 'Pending',
  `return_refund_reference_number` varchar(150) DEFAULT NULL,
  `return_refund_request_date` datetime NOT NULL DEFAULT current_timestamp(),
  `return_refund_resolution_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `returns_refunds`
--

INSERT INTO `returns_refunds` (`return_refund_id`, `order_id`, `payment_id`, `approved_by_user_id`, `return_refund_reason`, `return_refund_amount`, `return_refund_status`, `return_refund_reference_number`, `return_refund_request_date`, `return_refund_resolution_date`) VALUES
(1, 6, 6, 2, 'Wrong item prepared', 120.00, 'Approved', 'RF-0001', '2026-06-06 16:27:00', '2026-06-06 17:07:00'),
(2, 25, 24, 2, 'Drink spilled during handover', 150.00, 'Approved', 'RF-0002', '2026-09-26 15:53:00', '2026-09-26 16:33:00');

-- --------------------------------------------------------

--
-- Table structure for table `riders`
--

CREATE TABLE `riders` (
  `rider_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `vehicle_type` varchar(50) NOT NULL,
  `vehicle_license_plate` varchar(30) DEFAULT NULL,
  `rider_availability` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riders`
--

INSERT INTO `riders` (`rider_id`, `staff_id`, `vehicle_type`, `vehicle_license_plate`, `rider_availability`) VALUES
(1, 9, 'Motorcycle', 'NBA 1234', 'Available'),
(2, 10, 'Motorcycle', 'NCD 5678', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_description`) VALUES
(1, 'Owner', 'Full access to system configuration, reports, forecasting, and operations'),
(2, 'Manager', 'Manages daily operations, purchasing, inventory, reports, and forecasting'),
(3, 'Cashier', 'Processes orders and records payments'),
(4, 'Staff', 'Supports order preparation and inventory operations'),
(5, 'Rider', 'Handles assigned delivery orders');

-- --------------------------------------------------------

--
-- Table structure for table `sales_history`
--

CREATE TABLE `sales_history` (
  `sales_history_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `recorded_by_user_id` int(11) NOT NULL,
  `gross_sales_amount` decimal(12,2) NOT NULL,
  `sales_discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `net_sales_amount` decimal(12,2) NOT NULL,
  `sales_completion_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales_history`
--

INSERT INTO `sales_history` (`sales_history_id`, `order_id`, `recorded_by_user_id`, `gross_sales_amount`, `sales_discount_amount`, `net_sales_amount`, `sales_completion_date`) VALUES
(1, 1, 6, 120.00, 0.00, 120.00, '2026-05-23 15:06:00'),
(2, 2, 4, 135.00, 13.50, 121.50, '2026-05-23 16:19:00'),
(3, 3, 6, 60.00, 0.00, 60.00, '2026-05-23 12:41:00'),
(4, 4, 4, 139.00, 0.00, 139.00, '2026-06-06 10:16:00'),
(5, 5, 6, 60.00, 6.00, 54.00, '2026-06-06 13:43:00'),
(6, 6, 6, 120.00, 0.00, 120.00, '2026-06-06 16:10:00'),
(7, 7, 5, 198.00, 0.00, 198.00, '2026-06-20 12:43:00'),
(8, 8, 6, 160.00, 0.00, 160.00, '2026-06-20 12:59:00'),
(9, 9, 5, 278.00, 0.00, 278.00, '2026-06-20 12:37:00'),
(10, 10, 5, 219.00, 0.00, 219.00, '2026-07-11 12:43:00'),
(11, 11, 6, 290.00, 58.00, 232.00, '2026-07-11 16:30:00'),
(12, 12, 6, 135.00, 0.00, 135.00, '2026-07-11 14:21:00'),
(13, 13, 4, 460.00, 0.00, 460.00, '2026-07-25 10:37:00'),
(14, 14, 4, 240.00, 0.00, 240.00, '2026-07-25 16:22:00'),
(15, 15, 4, 139.00, 0.00, 139.00, '2026-07-25 14:21:00'),
(16, 16, 6, 120.00, 0.00, 120.00, '2026-08-08 16:39:00'),
(17, 17, 5, 120.00, 0.00, 120.00, '2026-08-08 14:46:00'),
(18, 18, 6, 120.00, 25.00, 95.00, '2026-08-08 11:56:00'),
(19, 19, 4, 60.00, 0.00, 60.00, '2026-08-22 13:54:00'),
(20, 20, 6, 90.00, 0.00, 90.00, '2026-08-22 15:07:00'),
(21, 21, 6, 195.00, 0.00, 195.00, '2026-08-22 10:50:00'),
(22, 22, 5, 120.00, 24.00, 96.00, '2026-09-12 14:24:00'),
(23, 23, 4, 458.00, 0.00, 458.00, '2026-09-12 14:57:00'),
(24, 25, 5, 150.00, 0.00, 150.00, '2026-09-26 15:36:00'),
(25, 26, 4, 308.00, 0.00, 308.00, '2026-09-26 12:01:00'),
(26, 27, 5, 245.00, 49.00, 196.00, '2026-09-26 17:17:00'),
(27, 28, 5, 50.00, 0.00, 50.00, '2026-10-17 16:57:00'),
(28, 29, 4, 240.00, 0.00, 240.00, '2026-10-17 16:58:00'),
(29, 30, 4, 120.00, 0.00, 120.00, '2026-10-17 11:29:00');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `contact_number` varchar(30) NOT NULL,
  `employment_start_date` date NOT NULL,
  `employment_status` varchar(20) NOT NULL DEFAULT 'Employed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `user_id`, `first_name`, `middle_name`, `last_name`, `contact_number`, `employment_start_date`, `employment_status`) VALUES
(1, 1, 'Maria', NULL, 'Pabillore', '09604644994', '2026-05-19', 'Employed'),
(2, 2, 'Jose', NULL, 'Tabamo', '09773499061', '2026-05-19', 'Employed'),
(3, 3, 'Ana', NULL, 'Cabahug', '09617796670', '2026-05-19', 'Employed'),
(4, 4, 'Mark', NULL, 'Lagumbay', '09359291153', '2026-05-19', 'Employed'),
(5, 5, 'Liza', NULL, 'Dumalagan', '09291862735', '2026-05-19', 'Employed'),
(6, 6, 'Paolo', NULL, 'Ybanez', '09837213360', '2026-05-19', 'Employed'),
(7, 7, 'Carla', NULL, 'Mendoza', '09305569716', '2026-05-19', 'Employed'),
(8, 8, 'Ken', NULL, 'Tumulak', '09711925517', '2026-05-19', 'Employed'),
(9, 9, 'Rico', NULL, 'Dela Cruz', '09224848285', '2026-05-19', 'Employed'),
(10, 10, 'Jun', NULL, 'Caballero', '09271725222', '2026-05-19', 'Employed');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(150) NOT NULL,
  `supplier_contact_person` varchar(150) DEFAULT NULL,
  `supplier_contact_number` varchar(30) NOT NULL,
  `supplier_email_address` varchar(150) DEFAULT NULL,
  `supplier_business_address` text NOT NULL,
  `supplier_status` varchar(20) NOT NULL DEFAULT 'Approved'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `supplier_contact_person`, `supplier_contact_number`, `supplier_email_address`, `supplier_business_address`, `supplier_status`) VALUES
(1, 'Talakag Highlands Coffee Growers', 'Elena Pabillore', '09171234501', 'sales@highlandscoffee.example.com', 'Purok 4, Brgy. Lantud, Talakag, Bukidnon 8708', 'Approved'),
(2, 'Bukidnon Dairy Trading', 'Ramon Ocampo', '09171234502', 'orders@bukidnondairy.example.com', 'Fortich St., Brgy. 9, Malaybalay City, Bukidnon 8700', 'Approved'),
(3, 'Malaybalay Frozen Goods Supply', 'Teresa Lim', '09171234503', 'teresa@malaybalayfrozen.example.com', 'Sayre Highway, Brgy. 5, Malaybalay City, Bukidnon 8700', 'Approved'),
(4, 'Talakag Public Market Rice Dealer', 'Noel Abad', '09171234504', 'noel@talakagrice.example.com', 'Public Market, Brgy. 3, Talakag, Bukidnon 8708', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_price_history`
--

CREATE TABLE `supplier_price_history` (
  `supplier_price_history_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `previous_supplier_unit_cost` decimal(12,4) DEFAULT NULL,
  `revised_supplier_unit_cost` decimal(12,4) NOT NULL,
  `price_revision_date` datetime NOT NULL DEFAULT current_timestamp(),
  `revised_by_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier_price_history`
--

INSERT INTO `supplier_price_history` (`supplier_price_history_id`, `supplier_id`, `ingredient_id`, `previous_supplier_unit_cost`, `revised_supplier_unit_cost`, `price_revision_date`, `revised_by_user_id`) VALUES
(1, 1, 1, 900.0000, 950.0000, '2026-06-05 09:00:00', 2),
(2, 2, 4, 90.0000, 95.0000, '2026-06-20 09:00:00', 2),
(3, 3, 10, 310.0000, 330.0000, '2026-07-08 09:00:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `account_status` varchar(20) NOT NULL DEFAULT 'Active',
  `account_creation_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `role_id`, `username`, `password_hash`, `account_status`, `account_creation_date`) VALUES
(1, 1, 'maria.pabillore', '$2y$10$CJ7DGLlGOYgtfZSc.9PNkaHdmpbDC1HOFQDr//1TuoseXz2y92an6', 'Active', '2026-05-19 07:30:00'),
(2, 2, 'jose.tabamo', '$2y$10$yTAKmRvtaA7iTaDFRmG/XAyz/a3.L/bl/MKcjCaN1yenOaxNiL1iy', 'Active', '2026-05-19 07:30:00'),
(3, 2, 'ana.cabahug', '$2y$10$j60pmV8m84MAgc9pTq0MslUeoJ2Nr6nbrCdlxKix5.QSLicb6S9bO', 'Active', '2026-05-19 07:30:00'),
(4, 3, 'mark.lagumbay', '$2y$10$etieCxc7Vi9vfEe28bFaQyaefhqAv7SDDIHGtfb9hXQF5xjNHWv7F', 'Active', '2026-05-19 07:30:00'),
(5, 3, 'liza.dumalagan', '$2y$10$uQmBZ64yLuiF12T8rkCrnAOFu1.Cec3cTKtYbiDb1pjdOCOPZ9RmE', 'Active', '2026-05-19 07:30:00'),
(6, 3, 'paolo.ybanez', '$2y$10$TWIcoXI8G/k2SoA5yCm4aJPG0vu.g3Z7hpyft.7qTbGcvAr6n3BcI', 'Active', '2026-05-19 07:30:00'),
(7, 4, 'carla.mendoza', '$2y$10$YijHU1S8F8foHsUOH1Jty25n29HKmIGMb.HzZKFSeIA97rEiB05Eu', 'Active', '2026-05-19 07:30:00'),
(8, 4, 'ken.tumulak', '$2y$10$AbqS.cjasUpFFL2NTS4bO0NI3InnILi6OwlM5mXmg4ifyB8ITmOZg', 'Active', '2026-05-19 07:30:00'),
(9, 5, 'rico.delacruz', '$2y$10$R69hGWGRmegcJGKjln1/7gd8DWuDGBMaS2lDVzmkGa5ZT3OzMG.Zq', 'Active', '2026-05-19 07:30:00'),
(10, 5, 'jun.caballero', '$2y$10$VX0z54SXWzUevEawONo8QvQKIy/PSW.bNVqzdmygq5JG9K/OZeMWc', 'Active', '2026-05-19 07:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_login_history`
--

CREATE TABLE `user_login_history` (
  `user_login_history_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_date` datetime NOT NULL DEFAULT current_timestamp(),
  `login_result` varchar(20) NOT NULL,
  `login_ip_address` varchar(45) DEFAULT NULL,
  `login_device_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_login_history`
--

INSERT INTO `user_login_history` (`user_login_history_id`, `user_id`, `login_date`, `login_result`, `login_ip_address`, `login_device_description`) VALUES
(1, 2, '2026-05-23 08:07:00', 'Success', '192.168.1.12', 'Back-office PC'),
(2, 3, '2026-05-28 09:14:00', 'Success', '192.168.1.13', 'Back-office PC'),
(3, 4, '2026-06-02 10:21:00', 'Success', '192.168.1.14', 'POS Terminal'),
(4, 5, '2026-06-07 11:28:00', 'Success', '192.168.1.15', 'POS Terminal'),
(5, 6, '2026-06-11 07:35:00', 'Success', '192.168.1.16', 'POS Terminal'),
(6, 7, '2026-06-16 08:42:00', 'Success', '192.168.1.17', 'Back-office PC'),
(7, 8, '2026-06-21 09:49:00', 'Success', '192.168.1.18', 'Back-office PC'),
(8, 9, '2026-06-26 10:56:00', 'Success', '192.168.1.19', 'Back-office PC'),
(9, 10, '2026-07-01 11:03:00', 'Failed', '192.168.1.20', 'Back-office PC'),
(10, 1, '2026-07-05 07:10:00', 'Success', '192.168.1.11', 'Back-office PC'),
(11, 2, '2026-07-10 08:17:00', 'Success', '192.168.1.12', 'Back-office PC'),
(12, 3, '2026-07-15 09:24:00', 'Success', '192.168.1.13', 'Back-office PC'),
(13, 4, '2026-07-20 10:31:00', 'Success', '192.168.1.14', 'POS Terminal'),
(14, 5, '2026-07-24 11:38:00', 'Success', '192.168.1.15', 'POS Terminal'),
(15, 6, '2026-07-29 07:45:00', 'Success', '192.168.1.16', 'POS Terminal'),
(16, 7, '2026-08-03 08:52:00', 'Success', '192.168.1.17', 'Back-office PC'),
(17, 8, '2026-08-08 09:59:00', 'Success', '192.168.1.18', 'Back-office PC'),
(18, 9, '2026-08-13 10:06:00', 'Failed', '192.168.1.19', 'Back-office PC'),
(19, 10, '2026-08-17 11:13:00', 'Success', '192.168.1.20', 'Back-office PC'),
(20, 1, '2026-08-22 07:20:00', 'Success', '192.168.1.11', 'Back-office PC'),
(21, 2, '2026-08-27 08:27:00', 'Success', '192.168.1.12', 'Back-office PC'),
(22, 3, '2026-09-01 09:34:00', 'Success', '192.168.1.13', 'Back-office PC'),
(23, 4, '2026-09-05 10:41:00', 'Success', '192.168.1.14', 'POS Terminal'),
(24, 5, '2026-09-10 11:48:00', 'Success', '192.168.1.15', 'POS Terminal'),
(25, 6, '2026-09-15 07:55:00', 'Success', '192.168.1.16', 'POS Terminal'),
(26, 7, '2026-09-20 08:02:00', 'Success', '192.168.1.17', 'Back-office PC'),
(27, 8, '2026-09-25 09:09:00', 'Failed', '192.168.1.18', 'Back-office PC'),
(28, 9, '2026-09-29 10:16:00', 'Success', '192.168.1.19', 'Back-office PC'),
(29, 10, '2026-10-04 11:23:00', 'Success', '192.168.1.20', 'Back-office PC'),
(30, 1, '2026-10-09 07:30:00', 'Success', '192.168.1.11', 'Back-office PC'),
(31, 2, '2026-10-14 08:37:00', 'Success', '192.168.1.12', 'Back-office PC'),
(32, 3, '2026-10-19 09:44:00', 'Success', '192.168.1.13', 'Back-office PC');

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `variant_id` int(11) NOT NULL,
  `variant_name` varchar(80) NOT NULL,
  `variant_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `variants`
--

INSERT INTO `variants` (`variant_id`, `variant_name`, `variant_description`) VALUES
(1, 'Hot', 'Served hot'),
(2, 'Cold', 'Served iced'),
(3, 'Regular', 'Standard single serving'),
(4, 'Chicken', 'Chicken siomai flavor'),
(5, 'Japanese', 'Japanese siomai flavor'),
(6, 'Beef', 'Beef siomai flavor');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `fk_addresses_customer` (`customer_id`);

--
-- Indexes for table `add_ons`
--
ALTER TABLE `add_ons`
  ADD PRIMARY KEY (`add_on_id`),
  ADD UNIQUE KEY `add_on_name` (`add_on_name`);

--
-- Indexes for table `archive_records`
--
ALTER TABLE `archive_records`
  ADD PRIMARY KEY (`archive_record_id`),
  ADD KEY `idx_archive_source` (`source_table_name`,`source_record_id`),
  ADD KEY `idx_archive_user` (`archived_by_user_id`),
  ADD KEY `idx_archive_date` (`archive_date`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`audit_log_id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_action` (`action_type`),
  ADD KEY `idx_audit_table_record` (`affected_table_name`,`affected_record_id`),
  ADD KEY `idx_audit_date` (`action_date`);

--
-- Indexes for table `bank_payments`
--
ALTER TABLE `bank_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `bank_transaction_number` (`bank_transaction_number`);

--
-- Indexes for table `business_forecast`
--
ALTER TABLE `business_forecast`
  ADD PRIMARY KEY (`business_forecast_id`),
  ADD KEY `fk_business_forecast_run` (`forecast_model_run_id`),
  ADD KEY `fk_business_forecast_menu_item` (`menu_item_id`),
  ADD KEY `fk_business_forecast_ingredient` (`ingredient_id`);

--
-- Indexes for table `business_insights`
--
ALTER TABLE `business_insights`
  ADD PRIMARY KEY (`business_insight_id`),
  ADD KEY `fk_business_insights_report` (`report_id`),
  ADD KEY `fk_business_insights_forecast_run` (`forecast_model_run_id`);

--
-- Indexes for table `cash_payments`
--
ALTER TABLE `cash_payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email_address` (`email_address`);

--
-- Indexes for table `customer_loyalty`
--
ALTER TABLE `customer_loyalty`
  ADD PRIMARY KEY (`customer_loyalty_id`),
  ADD UNIQUE KEY `customer_id` (`customer_id`),
  ADD UNIQUE KEY `loyalty_membership_number` (`loyalty_membership_number`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`delivery_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `fk_deliveries_address` (`address_id`),
  ADD KEY `fk_deliveries_rider` (`rider_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`discount_id`),
  ADD KEY `fk_discounts_user` (`discount_created_by_user_id`);

--
-- Indexes for table `forecast_model_runs`
--
ALTER TABLE `forecast_model_runs`
  ADD PRIMARY KEY (`forecast_model_run_id`),
  ADD KEY `fk_forecast_run_user` (`executed_by_user_id`);

--
-- Indexes for table `gcash_payments`
--
ALTER TABLE `gcash_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `gcash_reference_number` (`gcash_reference_number`);

--
-- Indexes for table `history_logs`
--
ALTER TABLE `history_logs`
  ADD PRIMARY KEY (`history_log_id`),
  ADD KEY `fk_history_logs_user` (`user_id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `ingredient_name` (`ingredient_name`),
  ADD KEY `fk_ingredients_category` (`ingredient_category_id`);

--
-- Indexes for table `ingredient_categories`
--
ALTER TABLE `ingredient_categories`
  ADD PRIMARY KEY (`ingredient_category_id`),
  ADD UNIQUE KEY `ingredient_category_name` (`ingredient_category_name`);

--
-- Indexes for table `ingredient_stock_batches`
--
ALTER TABLE `ingredient_stock_batches`
  ADD PRIMARY KEY (`ingredient_stock_batch_id`),
  ADD KEY `fk_stock_batch_receiving_item` (`receiving_item_id`),
  ADD KEY `fk_stock_batch_ingredient` (`ingredient_id`);

--
-- Indexes for table `inventory_adjustments`
--
ALTER TABLE `inventory_adjustments`
  ADD PRIMARY KEY (`inventory_adjustment_id`),
  ADD KEY `fk_adjustment_ingredient` (`ingredient_id`),
  ADD KEY `fk_adjustment_user` (`adjusted_by_user_id`);

--
-- Indexes for table `loyalty_transactions`
--
ALTER TABLE `loyalty_transactions`
  ADD PRIMARY KEY (`loyalty_transaction_id`),
  ADD KEY `fk_loyalty_transactions_account` (`customer_loyalty_id`),
  ADD KEY `fk_loyalty_transactions_order` (`order_id`),
  ADD KEY `fk_loyalty_transactions_reward` (`reward_id`),
  ADD KEY `fk_loyalty_transactions_user` (`recorded_by_user_id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`menu_item_id`),
  ADD KEY `fk_menu_items_category` (`category_id`);

--
-- Indexes for table `menu_item_add_ons`
--
ALTER TABLE `menu_item_add_ons`
  ADD PRIMARY KEY (`menu_item_id`,`add_on_id`),
  ADD KEY `fk_miao_add_on` (`add_on_id`);

--
-- Indexes for table `menu_item_price_history`
--
ALTER TABLE `menu_item_price_history`
  ADD PRIMARY KEY (`menu_item_price_history_id`),
  ADD KEY `fk_price_history_variant` (`menu_item_variant_id`),
  ADD KEY `fk_price_history_user` (`revised_by_user_id`);

--
-- Indexes for table `menu_item_variants`
--
ALTER TABLE `menu_item_variants`
  ADD PRIMARY KEY (`menu_item_variant_id`),
  ADD UNIQUE KEY `uq_menu_variant` (`menu_item_id`,`variant_id`),
  ADD KEY `fk_miv_variant` (`variant_id`);

--
-- Indexes for table `operating_expenses`
--
ALTER TABLE `operating_expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `fk_operating_expenses_user` (`recorded_by_user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_staff` (`processed_by_staff_id`),
  ADD KEY `fk_orders_pos` (`pos_id`),
  ADD KEY `fk_orders_session` (`pos_session_id`);

--
-- Indexes for table `order_discounts`
--
ALTER TABLE `order_discounts`
  ADD PRIMARY KEY (`order_discount_id`),
  ADD UNIQUE KEY `uq_order_discount` (`order_id`,`discount_id`),
  ADD KEY `fk_order_discounts_discount` (`discount_id`),
  ADD KEY `fk_order_discounts_user` (`applied_by_user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `fk_order_items_variant` (`menu_item_variant_id`);

--
-- Indexes for table `order_item_add_ons`
--
ALTER TABLE `order_item_add_ons`
  ADD PRIMARY KEY (`order_item_add_on_id`),
  ADD KEY `fk_order_addon_order_item` (`order_item_id`),
  ADD KEY `fk_order_addon_addon` (`add_on_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payments_order` (`order_id`),
  ADD KEY `fk_payments_method` (`payment_method_id`),
  ADD KEY `fk_payments_recorded_user` (`recorded_by_user_id`),
  ADD KEY `fk_payments_verified_user` (`verified_by_user_id`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD UNIQUE KEY `payment_method_name` (`payment_method_name`);

--
-- Indexes for table `pos`
--
ALTER TABLE `pos`
  ADD PRIMARY KEY (`pos_id`),
  ADD UNIQUE KEY `pos_name` (`pos_name`);

--
-- Indexes for table `pos_sessions`
--
ALTER TABLE `pos_sessions`
  ADD PRIMARY KEY (`pos_session_id`),
  ADD KEY `fk_sessions_pos` (`pos_id`),
  ADD KEY `fk_sessions_open_user` (`opened_by_user_id`),
  ADD KEY `fk_sessions_close_user` (`closed_by_user_id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`purchase_item_id`),
  ADD UNIQUE KEY `uq_purchase_ingredient` (`purchase_order_id`,`ingredient_id`),
  ADD KEY `fk_purchase_items_ingredient` (`ingredient_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`purchase_order_id`),
  ADD KEY `fk_purchase_orders_supplier` (`supplier_id`),
  ADD KEY `fk_purchase_orders_user` (`prepared_by_user_id`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `receiving`
--
ALTER TABLE `receiving`
  ADD PRIMARY KEY (`receiving_id`),
  ADD KEY `fk_receiving_purchase_order` (`purchase_order_id`),
  ADD KEY `fk_receiving_user` (`received_by_user_id`);

--
-- Indexes for table `receiving_items`
--
ALTER TABLE `receiving_items`
  ADD PRIMARY KEY (`receiving_item_id`),
  ADD KEY `fk_receiving_items_receiving` (`receiving_id`),
  ADD KEY `fk_receiving_items_purchase_item` (`purchase_item_id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipe_id`),
  ADD UNIQUE KEY `menu_item_id` (`menu_item_id`);

--
-- Indexes for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD PRIMARY KEY (`recipe_ingredient_id`),
  ADD UNIQUE KEY `uq_recipe_ingredient` (`recipe_id`,`ingredient_id`),
  ADD KEY `fk_recipe_ingredients_ingredient` (`ingredient_id`);

--
-- Indexes for table `redeem_rewards`
--
ALTER TABLE `redeem_rewards`
  ADD PRIMARY KEY (`reward_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_reports_user` (`generated_by_user_id`);

--
-- Indexes for table `returns_refunds`
--
ALTER TABLE `returns_refunds`
  ADD PRIMARY KEY (`return_refund_id`),
  ADD KEY `fk_returns_order` (`order_id`),
  ADD KEY `fk_returns_payment` (`payment_id`),
  ADD KEY `fk_returns_user` (`approved_by_user_id`);

--
-- Indexes for table `riders`
--
ALTER TABLE `riders`
  ADD PRIMARY KEY (`rider_id`),
  ADD UNIQUE KEY `staff_id` (`staff_id`),
  ADD UNIQUE KEY `vehicle_license_plate` (`vehicle_license_plate`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `sales_history`
--
ALTER TABLE `sales_history`
  ADD PRIMARY KEY (`sales_history_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `fk_sales_history_user` (`recorded_by_user_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `supplier_price_history`
--
ALTER TABLE `supplier_price_history`
  ADD PRIMARY KEY (`supplier_price_history_id`),
  ADD KEY `fk_supplier_price_supplier` (`supplier_id`),
  ADD KEY `fk_supplier_price_ingredient` (`ingredient_id`),
  ADD KEY `fk_supplier_price_user` (`revised_by_user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indexes for table `user_login_history`
--
ALTER TABLE `user_login_history`
  ADD PRIMARY KEY (`user_login_history_id`),
  ADD KEY `fk_login_history_user` (`user_id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`variant_id`),
  ADD UNIQUE KEY `variant_name` (`variant_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `add_ons`
--
ALTER TABLE `add_ons`
  MODIFY `add_on_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `archive_records`
--
ALTER TABLE `archive_records`
  MODIFY `archive_record_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `audit_log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_forecast`
--
ALTER TABLE `business_forecast`
  MODIFY `business_forecast_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `business_insights`
--
ALTER TABLE `business_insights`
  MODIFY `business_insight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customer_loyalty`
--
ALTER TABLE `customer_loyalty`
  MODIFY `customer_loyalty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `forecast_model_runs`
--
ALTER TABLE `forecast_model_runs`
  MODIFY `forecast_model_run_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `history_logs`
--
ALTER TABLE `history_logs`
  MODIFY `history_log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ingredient_categories`
--
ALTER TABLE `ingredient_categories`
  MODIFY `ingredient_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ingredient_stock_batches`
--
ALTER TABLE `ingredient_stock_batches`
  MODIFY `ingredient_stock_batch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory_adjustments`
--
ALTER TABLE `inventory_adjustments`
  MODIFY `inventory_adjustment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loyalty_transactions`
--
ALTER TABLE `loyalty_transactions`
  MODIFY `loyalty_transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `menu_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `menu_item_price_history`
--
ALTER TABLE `menu_item_price_history`
  MODIFY `menu_item_price_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu_item_variants`
--
ALTER TABLE `menu_item_variants`
  MODIFY `menu_item_variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `operating_expenses`
--
ALTER TABLE `operating_expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `order_discounts`
--
ALTER TABLE `order_discounts`
  MODIFY `order_discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `order_item_add_ons`
--
ALTER TABLE `order_item_add_ons`
  MODIFY `order_item_add_on_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pos`
--
ALTER TABLE `pos`
  MODIFY `pos_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pos_sessions`
--
ALTER TABLE `pos_sessions`
  MODIFY `pos_session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `purchase_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `purchase_order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `receiving`
--
ALTER TABLE `receiving`
  MODIFY `receiving_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `receiving_items`
--
ALTER TABLE `receiving_items`
  MODIFY `receiving_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  MODIFY `recipe_ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `redeem_rewards`
--
ALTER TABLE `redeem_rewards`
  MODIFY `reward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `returns_refunds`
--
ALTER TABLE `returns_refunds`
  MODIFY `return_refund_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `riders`
--
ALTER TABLE `riders`
  MODIFY `rider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sales_history`
--
ALTER TABLE `sales_history`
  MODIFY `sales_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `supplier_price_history`
--
ALTER TABLE `supplier_price_history`
  MODIFY `supplier_price_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_login_history`
--
ALTER TABLE `user_login_history`
  MODIFY `user_login_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `fk_addresses_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `archive_records`
--
ALTER TABLE `archive_records`
  ADD CONSTRAINT `fk_archive_records_user` FOREIGN KEY (`archived_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `bank_payments`
--
ALTER TABLE `bank_payments`
  ADD CONSTRAINT `fk_bank_payments_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`) ON DELETE CASCADE;

--
-- Constraints for table `business_forecast`
--
ALTER TABLE `business_forecast`
  ADD CONSTRAINT `fk_business_forecast_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_business_forecast_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`),
  ADD CONSTRAINT `fk_business_forecast_run` FOREIGN KEY (`forecast_model_run_id`) REFERENCES `forecast_model_runs` (`forecast_model_run_id`);

--
-- Constraints for table `business_insights`
--
ALTER TABLE `business_insights`
  ADD CONSTRAINT `fk_business_insights_forecast_run` FOREIGN KEY (`forecast_model_run_id`) REFERENCES `forecast_model_runs` (`forecast_model_run_id`),
  ADD CONSTRAINT `fk_business_insights_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`);

--
-- Constraints for table `cash_payments`
--
ALTER TABLE `cash_payments`
  ADD CONSTRAINT `fk_cash_payments_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_loyalty`
--
ALTER TABLE `customer_loyalty`
  ADD CONSTRAINT `fk_loyalty_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `fk_deliveries_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `fk_deliveries_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_deliveries_rider` FOREIGN KEY (`rider_id`) REFERENCES `riders` (`rider_id`);

--
-- Constraints for table `discounts`
--
ALTER TABLE `discounts`
  ADD CONSTRAINT `fk_discounts_user` FOREIGN KEY (`discount_created_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `forecast_model_runs`
--
ALTER TABLE `forecast_model_runs`
  ADD CONSTRAINT `fk_forecast_run_user` FOREIGN KEY (`executed_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `gcash_payments`
--
ALTER TABLE `gcash_payments`
  ADD CONSTRAINT `fk_gcash_payments_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`) ON DELETE CASCADE;

--
-- Constraints for table `history_logs`
--
ALTER TABLE `history_logs`
  ADD CONSTRAINT `fk_history_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `fk_ingredients_category` FOREIGN KEY (`ingredient_category_id`) REFERENCES `ingredient_categories` (`ingredient_category_id`);

--
-- Constraints for table `ingredient_stock_batches`
--
ALTER TABLE `ingredient_stock_batches`
  ADD CONSTRAINT `fk_stock_batch_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_stock_batch_receiving_item` FOREIGN KEY (`receiving_item_id`) REFERENCES `receiving_items` (`receiving_item_id`);

--
-- Constraints for table `inventory_adjustments`
--
ALTER TABLE `inventory_adjustments`
  ADD CONSTRAINT `fk_adjustment_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_adjustment_user` FOREIGN KEY (`adjusted_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `loyalty_transactions`
--
ALTER TABLE `loyalty_transactions`
  ADD CONSTRAINT `fk_loyalty_transactions_account` FOREIGN KEY (`customer_loyalty_id`) REFERENCES `customer_loyalty` (`customer_loyalty_id`),
  ADD CONSTRAINT `fk_loyalty_transactions_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_loyalty_transactions_reward` FOREIGN KEY (`reward_id`) REFERENCES `redeem_rewards` (`reward_id`),
  ADD CONSTRAINT `fk_loyalty_transactions_user` FOREIGN KEY (`recorded_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_menu_items_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `menu_item_add_ons`
--
ALTER TABLE `menu_item_add_ons`
  ADD CONSTRAINT `fk_miao_add_on` FOREIGN KEY (`add_on_id`) REFERENCES `add_ons` (`add_on_id`),
  ADD CONSTRAINT `fk_miao_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`);

--
-- Constraints for table `menu_item_price_history`
--
ALTER TABLE `menu_item_price_history`
  ADD CONSTRAINT `fk_price_history_user` FOREIGN KEY (`revised_by_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_price_history_variant` FOREIGN KEY (`menu_item_variant_id`) REFERENCES `menu_item_variants` (`menu_item_variant_id`);

--
-- Constraints for table `menu_item_variants`
--
ALTER TABLE `menu_item_variants`
  ADD CONSTRAINT `fk_miv_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`),
  ADD CONSTRAINT `fk_miv_variant` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`variant_id`);

--
-- Constraints for table `operating_expenses`
--
ALTER TABLE `operating_expenses`
  ADD CONSTRAINT `fk_operating_expenses_user` FOREIGN KEY (`recorded_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_orders_pos` FOREIGN KEY (`pos_id`) REFERENCES `pos` (`pos_id`),
  ADD CONSTRAINT `fk_orders_session` FOREIGN KEY (`pos_session_id`) REFERENCES `pos_sessions` (`pos_session_id`),
  ADD CONSTRAINT `fk_orders_staff` FOREIGN KEY (`processed_by_staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `order_discounts`
--
ALTER TABLE `order_discounts`
  ADD CONSTRAINT `fk_order_discounts_discount` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`discount_id`),
  ADD CONSTRAINT `fk_order_discounts_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_discounts_user` FOREIGN KEY (`applied_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_items_variant` FOREIGN KEY (`menu_item_variant_id`) REFERENCES `menu_item_variants` (`menu_item_variant_id`);

--
-- Constraints for table `order_item_add_ons`
--
ALTER TABLE `order_item_add_ons`
  ADD CONSTRAINT `fk_order_addon_addon` FOREIGN KEY (`add_on_id`) REFERENCES `add_ons` (`add_on_id`),
  ADD CONSTRAINT `fk_order_addon_order_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`),
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_payments_recorded_user` FOREIGN KEY (`recorded_by_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_payments_verified_user` FOREIGN KEY (`verified_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD CONSTRAINT `fk_payment_details_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`) ON DELETE CASCADE;

--
-- Constraints for table `pos_sessions`
--
ALTER TABLE `pos_sessions`
  ADD CONSTRAINT `fk_sessions_close_user` FOREIGN KEY (`closed_by_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_sessions_open_user` FOREIGN KEY (`opened_by_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_sessions_pos` FOREIGN KEY (`pos_id`) REFERENCES `pos` (`pos_id`);

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `fk_purchase_items_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_purchase_items_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`);

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `fk_purchase_orders_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `fk_purchase_orders_user` FOREIGN KEY (`prepared_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `fk_receipts_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `receiving`
--
ALTER TABLE `receiving`
  ADD CONSTRAINT `fk_receiving_purchase_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`),
  ADD CONSTRAINT `fk_receiving_user` FOREIGN KEY (`received_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `receiving_items`
--
ALTER TABLE `receiving_items`
  ADD CONSTRAINT `fk_receiving_items_purchase_item` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`purchase_item_id`),
  ADD CONSTRAINT `fk_receiving_items_receiving` FOREIGN KEY (`receiving_id`) REFERENCES `receiving` (`receiving_id`);

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `fk_recipes_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`);

--
-- Constraints for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD CONSTRAINT `fk_recipe_ingredients_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_recipe_ingredients_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_user` FOREIGN KEY (`generated_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `returns_refunds`
--
ALTER TABLE `returns_refunds`
  ADD CONSTRAINT `fk_returns_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_returns_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `fk_returns_user` FOREIGN KEY (`approved_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `riders`
--
ALTER TABLE `riders`
  ADD CONSTRAINT `fk_riders_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `sales_history`
--
ALTER TABLE `sales_history`
  ADD CONSTRAINT `fk_sales_history_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_sales_history_user` FOREIGN KEY (`recorded_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `fk_staff_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `supplier_price_history`
--
ALTER TABLE `supplier_price_history`
  ADD CONSTRAINT `fk_supplier_price_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`),
  ADD CONSTRAINT `fk_supplier_price_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `fk_supplier_price_user` FOREIGN KEY (`revised_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- Constraints for table `user_login_history`
--
ALTER TABLE `user_login_history`
  ADD CONSTRAINT `fk_login_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
