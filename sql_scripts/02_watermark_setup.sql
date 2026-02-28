CREATE TABLE watermarktable (
    TableName VARCHAR(100),
    WatermarkValue DATETIME
);

INSERT INTO watermarktable (TableName, WatermarkValue)
VALUES 
    ('MARA', '2000-01-01 11:10:00'),
    ('VBRK', '2000-01-01 11:10:00'),
    ('VBAP', '2000-01-01 11:10:00'),
	('VBRK_SPPAYM', '2000-01-01 11:10:00'),
	('SR01A', '2000-01-01 11:10:00');
