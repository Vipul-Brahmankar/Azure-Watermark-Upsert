CREATE TABLE MARA (
    MATNR VARCHAR(18) PRIMARY KEY, -- Material Number
    ERSDA VARCHAR(8),              -- Created On (YYYYMMDD)
    ERNAM NVARCHAR(12),            -- Created By
    LAEDA VARCHAR(8),              -- Last Changed
    AENAM NVARCHAR(12),            -- Changed By
    MTART VARCHAR(4),              -- Material Type
    MBRSH VARCHAR(1),              -- Industry Sector
    MATKL VARCHAR(9),              -- Material Group
    MEINS VARCHAR(3),              -- Base Unit of Measure
    BSTME VARCHAR(3),              -- Order Unit
    ZEINR NVARCHAR(22),            -- Document Number
    ZEIVR NVARCHAR(2),             -- Document Version
    BLANZ INT,                     -- Number of Sheets
    BRGEW DECIMAL(15, 3),          -- Gross Weight
    NTGEW DECIMAL(15, 3),          -- Net Weight
    GEWEI VARCHAR(3),              -- Weight Unit
    VOLUM DECIMAL(15, 3),          -- Volume
    VOLEH VARCHAR(3),              -- Volume Unit
    GROES NVARCHAR(32),            -- Size/Dimensions
    TRAGR VARCHAR(4),              -- Transportation Group
    LAST_UPDATED DATETIME2         -- Custom Timestamp
);

CREATE TABLE VBRK (
    VBELN VARCHAR(10) PRIMARY KEY, -- Billing Document Number
    FKART VARCHAR(4),              -- Billing Type
    WAERK VARCHAR(5),              -- Document Currency
    VKORG VARCHAR(4),              -- Sales Organization
    VTWEG VARCHAR(2),              -- Distribution Channel
    SPART VARCHAR(2),              -- Division
    KNUMV VARCHAR(10),             -- Document Condition Number
    VGBEL VARCHAR(10),             -- Reference Document
    KUNRG VARCHAR(10),             -- Payer
    KUNAG VARCHAR(10),             -- Sold-to Party
    FKDAT VARCHAR(8),              -- Billing Date (YYYYMMDD)
    BUDAT VARCHAR(8),              -- Posting Date
    NETWR DECIMAL(15, 2),          -- Net Value
    ZLSCH VARCHAR(1),              -- Payment Method
    ZTERM VARCHAR(4),              -- Terms of Payment
    KDGRP VARCHAR(2),              -- Customer Group
    BZIRK VARCHAR(6),              -- Sales District
    PLTYP VARCHAR(2),              -- Price List Type
    INCO1 VARCHAR(3),              -- Incoterms 1
    INCO2 NVARCHAR(28),            -- Incoterms 2
    LAST_UPDATED DATETIME2         -- Custom Timestamp
);

CREATE TABLE VBAP (
    VBELN VARCHAR(10),             -- Sales Document
    POSNR VARCHAR(6),              -- Item Number
    MATNR VARCHAR(18),             -- Material Number
    MATWA VARCHAR(18),             -- Material Entered
    PMATN VARCHAR(18),             -- Pricing Reference Material
    CHARG VARCHAR(10),             -- Batch Number
    MATKL VARCHAR(9),              -- Material Group
    ARKTX NVARCHAR(40),            -- Short Text for Item
    PSTYV VARCHAR(4),              -- Item Category
    POSAR VARCHAR(1),              -- Item Type
    LFREL VARCHAR(1),              -- Relevant for Delivery
    FKREL VARCHAR(1),              -- Relevant for Billing
    KWMENG DECIMAL(15, 3),         -- Cumulative Order Quantity
    VRKME VARCHAR(3),              -- Sales Unit
    NTGEW DECIMAL(15, 3),          -- Net Weight
    BRGEW DECIMAL(15, 3),          -- Gross Weight
    GEWEI VARCHAR(3),              -- Weight Unit
    VOLUM DECIMAL(15, 3),          -- Volume
    VOLEH VARCHAR(3),              -- Volume Unit
    NETPR DECIMAL(15, 2),          -- Net Price
    LAST_UPDATED DATETIME2,        -- Custom Timestamp
    PRIMARY KEY (VBELN, POSNR)     -- Composite Primary Key
);

CREATE TABLE VBRK_SPPAYM (
    VBELN VARCHAR(10),             -- Billing Document
    PAYM_ID VARCHAR(20),           -- Payment ID
    PAYM_TYPE VARCHAR(10),         -- Payment Type
    BETRW DECIMAL(15, 2),          -- Payment Amount
    WAERS VARCHAR(5),              -- Currency
    ZLSCH VARCHAR(1),              -- Payment Method
    ZTERM VARCHAR(4),              -- Payment Terms
    KUNNR VARCHAR(10),             -- Customer
    BUKRS VARCHAR(4),              -- Company Code
    GJAHR VARCHAR(4),              -- Fiscal Year
    MONAT VARCHAR(2),              -- Fiscal Period
    VALUT VARCHAR(8),              -- Value Date (YYYYMMDD)
    BUDAT VARCHAR(8),              -- Posting Date
    BLDAT VARCHAR(8),              -- Document Date
    STATUS VARCHAR(20),            -- Payment Status
    ERDAT VARCHAR(8),              -- Created On
    ERNAM NVARCHAR(12),            -- Created By
    SGTXT NVARCHAR(50),            -- Item Text
    CLEAR_DOC VARCHAR(10),         -- Clearing Document
    AUGDT VARCHAR(8),              -- Clearing Date
    LAST_UPDATED DATETIME2,        -- Custom Timestamp
    PRIMARY KEY (VBELN, PAYM_ID)   -- Composite Primary Key
);

CREATE TABLE SR01A (
    SR_DOC VARCHAR(50),            -- Service Record Document
    SR_ITEM VARCHAR(50),            -- Service Item
    EQUNR VARCHAR(50),             -- Equipment Number
    TPLNR VARCHAR(50),             -- Functional Location
    SERNR VARCHAR(50),             -- Serial Number
    MATNR VARCHAR(50),             -- Material Number
    KUNUM VARCHAR(50),             -- Customer Number
    SR_TYPE VARCHAR(50),           -- Service Type
    SR_STAT VARCHAR(50),           -- Status
    PRIOK INT,                     -- Priority
    ERDAT VARCHAR(50),              -- Created On (YYYYMMDD)
    ERNAM NVARCHAR(50),            -- Created By
    STRMN VARCHAR(50),              -- Start Date
    ETRMN VARCHAR(50),              -- End Date
    ARBPL VARCHAR(50),              -- Work Center
    WERKS VARCHAR(50),              -- Plant
    GEWRK VARCHAR(50),              -- Main Work Center
    ILART VARCHAR(50),              -- Maintenance Activity Type
    QMNUM VARCHAR(50),             -- Notification No
    AUFNR VARCHAR(50),             -- Order Number
    LAST_UPDATED DATETIME2,        -- Custom Timestamp
    PRIMARY KEY (SR_DOC, SR_ITEM)  -- Composite Primary Key
);
