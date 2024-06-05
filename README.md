# Procedure Bases ONLINE e OFFLINE

## Stored Procedure USP_StatusBases

A stored procedure `USP_StatusBases` é utilizada para monitorar e relatar o status das bases de dados em um servidor SQL. Veja como ela funciona:

1. **Criação da Tabela Temporária**: Uma tabela temporária `#Resultado` é criada para armazenar os nomes e o status de cada base de dados.
2. **Consulta de Estado**:
   - A procedure consulta todas as bases de dados que estão ONLINE ou OFFLINE e insere os resultados na tabela temporária.
3. **Geração de Relatório**:
   - Se todas as bases de dados estiverem ONLINE, um relatório HTML simples é gerado, indicando que todas as bases estão funcionando corretamente.
   - Se houver bases de dados OFFLINE, um relatório HTML detalhado é gerado, mostrando quais bases estão OFFLINE e seu nome.
4. **Envio de Email**:
   - Um email é enviado para o destinatário especificado, contendo o relatório HTML como corpo da mensagem. O conteúdo do email varia dependendo da situação das bases de dados.
5. **Limpeza**:
   - A tabela temporária é descartada ao final do processo.

Esta procedure é essencial para a administração de bancos de dados, pois permite aos administradores de sistemas terem ciência imediata do estado das bases de dados, podendo tomar medidas rápidas em caso de bases de dados OFFLINE.
