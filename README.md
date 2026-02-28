# Azure-Watermark-Upsert


## 📌 Project Overview
This repository contains the infrastructure-as-code (JSON) and SQL scripts for a robust, metadata-driven data pipeline built in Azure Data Factory (ADF). It implements a **Medallion Architecture (Raw -> Bronze -> Silver)** to ingest, stage, and upsert enterprise data (such as SAP ERP tables) into Azure SQL Database using a dynamic high-watermark delta load pattern.

## 🏗️ Architecture & Workflow

The solution is divided into three primary orchestration layers:

### 1. Ingestion Layer (`pl_ingest_source_to_raw`)
* **Purpose:** Dynamically fetches source files from the source Azure Data Lake Storage (ADLS Gen2) and copies them to a `raw` storage zone.
* **Mechanism:** Uses a `GetMetadata` activity to list files, filters them based on naming conventions (e.g., files starting with "VBRK"), and iterates through them to copy to the raw container while preserving folder hierarchies.
* **Handoff:** Dynamically constructs a JSON array of processed tables and triggers the Bronze pipeline.

### 2. Staging Layer (`pl_load_raw_to_bronze`)
* **Purpose:** Loads the raw CSV files into Azure SQL Database staging tables (Bronze Layer).
* **Mechanism:**
  * Evaluates the pipeline execution context using an `IfCondition` to determine if data should be loaded from the `raw` container or directly from the `source-manual` container.
  * Dynamically maps source files to target SQL tables by stripping file extensions (`@substring(item().tableName, 0, lastIndexOf(item().tableName, '.'))`).
  * Executes a Pre-Copy script to `TRUNCATE` the target staging table before performing a bulk insert.

### 3. Delta & Upsert Layer (`pl_upsert_bronze_to_silver`)

* **Purpose:** Merges newly inserted or updated records from the Bronze staging tables into the Silver presentation tables.
* **Mechanism:**
  * **Watermark Retrieval:** Queries the `watermarktable` to get the last processed timestamp (`WatermarkValue`).
  * **New High-Watermark:** Queries the Bronze table for the `MAX(LAST_UPDATED)` timestamp.
  * **Dynamic Primary Keys:** Queries `INFORMATION_SCHEMA.KEY_COLUMN_USAGE` to dynamically build a comma-separated list of primary keys for the current table using `STRING_AGG`.
  * **Upsert Execution:** Extracts records from Bronze where `LAST_UPDATED` falls between the old and new watermarks, restricting the pull to a 3-week rolling window. Writes to Silver using ADF's native `upsert` write behavior mapped to the dynamic primary keys.
  * **Data Purge:** A pre-copy script cleans up the Silver table by hard-deleting records older than 3 weeks.
  * **State Update:** Executes a Stored Procedure (`usp_write_watermark`) to log the new high-watermark timestamp back into the control table.

## 📊 Database Schema
The accompanying SQL scripts (`sql_scripts/`) provide the DDL for the underlying architecture:
* **Source Tables:** SAP data structures including `MARA` (Materials), `VBRK` (Billing Header), `VBAP` (Billing Items), `VBRK_SPPAYM` (Payments), and `SR01A` (Service Records).
* **Control Table:** `watermarktable` to track incremental load state.

## 💡 Key Technical Skills Demonstrated
* **Metadata-Driven Pipelines:** Heavy use of dynamic content and expressions to parameterize Linked Services and Datasets, keeping the ADF environment DRY (Don't Repeat Yourself).
* **Incremental Loading:** Custom delta load mechanism minimizing compute by only processing new records based on timestamp boundaries.
* **Dynamic SQL Execution:** Automated primary key discovery at runtime for scalable `UPSERT` operations across multiple distinct schemas.

## 🔐 Security Notice
All connection strings, tenant IDs, and `encryptedCredential` values have been sanitized from the repository code. To deploy this to your own Azure tenant, it is recommended to configure the Linked Services to use **Azure Key Vault** backed by the Data Factory's **System Assigned Managed Identity (SAMI)**.
