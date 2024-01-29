# Google_Data_Analytics_Case_Study
Repositório contendo um estudo de caso do curso de análise de dados da Google, ministrado pelo Coursera.

## Introdução
O estudo de caso é sobre a Cyclistic, uma empresa fictícia de compartilhamento de bicicletas em Chicago, EUA. Como suposto analista de dados júnior, seguirei as etapas do processo de análise de dados para responder às principais perguntas de negócios. As etapas incluem perguntar, preparar, processar, analisar, compartilhar e agir.

## Cenário
A Cyclistic, desde seu lançamento em 2016, expandiu-se para 5.824 bicicletas em 692 estações em Chicago, promovendo flexibilidade com passes de viagem única, diários e anuais. Com foco em conscientização geral, a estratégia destaca a lucratividade dos membros anuais, impulsionando a iniciativa de converter passageiros casuais em membros. Lily Moreno, Diretora de Marketing, busca entender as diferenças entre os grupos, motivos para os casuais aderirem a planos anuais e como a mídia digital pode influenciar. O objetivo é otimizar a estratégia, aproveitando dados históricos de trajetos de bicicleta para identificar tendências.

## Perguntar
Lily, a diretora de marketing, propôs a primeira pergunta-chave:  Como os membros anuais e os ciclistas casuais usam as bicicletas da Cyclistic de forma diferente?
Vamos analisar dados históricos para entender essas distinções e orientar a criação de estratégias de marketing com base nos insights obtidos com os dados.

## Preparar
Usarei dados históricos dos trajetos realizados entre janeiro e dezembro de 2023. Os dados foram disponibilizados pela Motivate International Inc. sob a seguinte [licença](https://www.divvybikes.com/data-license-agreement). Os dados são públicos e podem ser usados livremente para essa análise.

Os dados estão organizados em 12 diferentes arquivos csv, nomeados por mês e ano, contendo informações de cada corrida, como origem, destino, data, hora, id do usuário dentre outras.

## Processar
Devido ao tamanho dos arquivos, que ultrapassam 6 milhões de linhas, optei por manipular os dados utilizando a linguagem R junto com o software RStudio. A utilização de planilhas nesse caso seria inviável devido ao grande número de linhas. Poderia também utilizar o BigQuery ou Python, visto que já tenho mais afinidade, mas escolhi o RStudio pelo desafio de uma nova linguagem.

Segue um resumo de todo tratamento feito com os dados obtidos. <br>
Também está disponível o script com o código em R nesse [link](https://github.com/rafalemke/Google_Data_Analytics_Case_Study/edit/main/data_extraction.R).

**1. Carregamento dos Pacotes:**
   - tidyverse, ggplot2, lubridate, e tidyr são pacotes essenciais para análise e manipulação.

**2. Carregamento dos Dados:**
   - Carregamento de dados mensais (jan-dez/2023) de arquivos CSV para dataframes.

**3. Verificação da Consistência dos Datasets:**
   - Utilização de uma função para verificar consistência nas colunas.

**4. Concatenação dos Datasets:**
   - Uso de bind_rows para unir os datasets em um único dataframe (trips2023).

**5. Limpeza e Seleção de Colunas:**
   - Remoção de colunas desnecessárias.
   - Utilização de drop_na para remover linhas com dados em branco.

**6. Análise Exploratória de Dados:**
   - Criação de variáveis de data, mês, ano, dia da semana, e cálculo da duração da corrida.

**7. Manipulação de Dados Temporais:**
   - Transformação da duração em numérica.
   - Exclusão de dados com duração fora do intervalo desejado.

**8. Análise Estatística:**
   - Verificação e remoção de dados faltantes.
   - Exibição dos 100 menores tempos de corrida.
   - Cálculo de médias e medianas de duração por tipo de cliente.

**9. Limpeza Adicional:**
   - Remoção de linhas com nomes de estações em branco.

**10. Transformação e Salvamento:**
   - Conversão dos horários para apenas a hora.
   - Seleção final de colunas e salvamento do dataframe limpo em CSV.
