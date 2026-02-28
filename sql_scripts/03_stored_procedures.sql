CREATE PROCEDURE [dbo].[usp_write_watermark] 
    @last_updated DATETIME,
    @tableName VARCHAR(100)
AS
BEGIN
    -- Update the control table with the newest delta timestamp
    UPDATE [dbo].[watermarktable]
    SET [WatermarkValue] = @last_updated
    WHERE [TableName] = @tableName;
END
GO
