CREATE PROCEDURE [dbo].[USP_StatusBases]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @HTML VARCHAR(MAX);


    CREATE TABLE #Resultado(
        Nome NVARCHAR(256),
        Status NVARCHAR(20)
    );


    INSERT INTO #Resultado (Nome, Status)
    SELECT 
        name, 
        CASE state_desc 
            WHEN 'ONLINE' THEN 'ONLINE'
            WHEN 'OFFLINE' THEN 'OFFLINE'
            ELSE 'Estado Desconhecido'
        END
    FROM sys.databases
    WHERE state_desc IN ('ONLINE', 'OFFLINE');

 
    IF EXISTS (SELECT 1 FROM #Resultado WHERE Status = 'ONLINE')
    BEGIN
        SET @HTML = '<html>
<head>
    <title>Status das Bases</title>
    <style type="text/css">
        body { font-family: Arial, sans-serif; }
        img { width: 100%; height: auto; }
		.online{ color: green}
    </style>
</head>
<body>
    <img src="caminho para a imagem.png" alt="Imagem de cabeçalho">
	<h4>Verificação do Status das Bases</h4>
	<br></br>
    <p>Todas as bases estão <span class="online">ONLINE</span>.</p>
	<br></br>
	 <img src="caminho para a imagem.png">
</body>
</html>';
    END
    ELSE
    BEGIN
        SET @HTML = '<html>
<head>
    <title>Status das Bases</title>
    <style type="text/css">
        body { font-family: Arial, sans-serif; }
        table { width: 30%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 5px; text-align: left; }
        th { background-color: #f2f2f2; }
        img { width: 100%; height: auto; }
		.offline{ color: red}

    </style>
</head>
<body>
    <img src="caminho para a imagem.png" alt="Imagem de cabeçalho">
    <p>Bases <span class="offline">OFFLINE</span>:</>
    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>' + 
        CAST((SELECT td = Nome, '', td = Status, '' FROM #Resultado WHERE Status = 'OFFLINE' FOR XML PATH('tr'), TYPE) AS NVARCHAR(MAX)) +
        '</tbody>
    </table>
	<br></br>
		<img src="caminho para a imagem.png">
</body>
</html>';
    END


    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = '', -- perfil de email
        @recipients = '', -- email 
        @subject = N'assunto',
        @body = @HTML,
        @body_format = 'HTML';

    DROP TABLE #Resultado;
END;
